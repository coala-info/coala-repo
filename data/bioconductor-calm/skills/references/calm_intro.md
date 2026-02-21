# Introduction to calm

#### Kun Liang

#### 2025-10-29

* [Introduction](#introduction)
* [Installation](#installation)
* [Conditional local FDR](#conditional-local-fdr)
* [Session Information](#session-information)
* [References](#references)

## Introduction

Multiple testing procedures are commonly used in the analyses of genomic data, where thousands of tests are conducted simultaneously. As in many other scientific research areas, new knowledge is discovered on the top of existing ones, which can appear as various auxiliary/contextual information. Calm is an R package for multiple testing methods with auxiliary covariate information.

The auxiliary information is almost ubiquitous in scientific research. In genomic experiments, each test corresponds to a genetic entity, such as a gene or single nucleotide polymorphisms (SNP). Suppose that we try to find which genes are differentially expressed between two conditions (e.g., disease status). Each gene has many (physical) properties, such as the location and length of its coding region. Furthermore, the summary statistics from a related study (similar experimental condition or related disease) can be highly informative. Calm provides the ability to perform the multiple testing while utilizing the existing auxiliary covariate information to improve power.

## Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("calm")
```

## Conditional local FDR

In multiple testing applications with covariate information, the ranking and the significance of the test statistics become non-trivial. We will estimate the conditional local FDR, which is the posterior probability of being null given the test statistic and the covariate information.

Consider the RNA sequencing (RNA-seq) study of psoriasis vulgaris disease in Jabbari et al. (2012), where the expression levels of genes were measured on three pairs of lesional and nonlesional skin samples collected from three patients. The RNA-seq read count data can be obtained from the recount2 project (Collado-Torres et al. 2017) with accession number SRP016583. We focus on the 18151 protein coding genes with at least one non-zero read from any patient. To find the differentially expressed (DE) genes between lesional and nonlesional skin samples, we compute \(t\)-statistics using the limma-voom method (Law et al. 2014). Then we could easily compute \(p\)-values from the \(t\)-statistics and use the linear step-up procedure of Benjamini and Hochberg (1995), the BH procedure, to control the FDR at a certain target level.

However, the signs of the \(t\)-statistics suggest whether the corresponding genes are potentially up- or down-regulated, and the use of \(p\)-values leads to loss of such directional information. For modeling convenience, we work with \(z\)-values, which can be transformed from the \(t\)-statistics as follows: `z <- qnorm(pt(t,df))`, where `df` is the degrees of freedom.

Furthermore, scientific research is rarely done from scratch each time, and it is almost always possible to find relevant information to improve the power of the current study. In our psoriasis example, each hypothesis is associated with a human gene, whose coding region has a certain length. For each gene, the length of the coding region in the number of nucleotides can also be obtained from the recount2 project.

```
library(calm)
data("pso")
dim(pso)
```

```
## [1] 18151     3
```

```
head(pso)
```

```
##               zval len_gene   tval_mic
## A1BG    -0.4550995     4006  3.3145543
## A1CF    -0.7702155     9603 -1.0323351
## A2M     -1.6760701     6384 -0.2625656
## A2ML1    4.7265616     7303 22.4756616
## A3GALT2  1.5265343     1023         NA
## A4GALT  -0.3958471     2943 -2.1659572
```

```
summary(pso$len_gene)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##     117    2687    4443    5292    6902  118976
```

```
hist(pso$len_gene, main="")
```

![](data:image/png;base64...)

We can see that the longest gene is almost 119K nucleotides long and is far longer than other genes. For this reason, we will use a normalized gene length in later analyses to improve estimation stability.

For any specific genetic study, there could be previous studies conducted under similar experimental conditions or on related diseases.
Gudjonsson et al. (2010) used microarray to study the gene expression differences between 58 pairs of lesional and nonlesional skin samples from psoriasis patients. Among the 18151 genes measured in the psoriasis RNA-seq study (Jabbari et al. 2012), only 16493 genes can be found in the microarray study of Gudjonsson et al. (2010) due to the differences between the microarray and RNA-seq platforms.

```
# number of genes with matching microarray data
sum(!is.na(pso$tval_mic))
```

```
## [1] 16493
```

Naturally, we divide the total of 18,151 genes into two groups: one group contains the 16,493 genes with matching microarray data and another group of 1,658 genes without matches. We will start from the smaller group of 1,658 genes with only the gene length covariate.

```
# indicator for RNA-seq genes without matching microarray data
ind.nm <- is.na(pso$tval_mic)
x <- pso$len_gene[ind.nm]
# normalize covariate
x <- rank(x)/length(x)
y <- pso$zval[ind.nm]
names(y) <- row.names(pso)[ind.nm]

fit.nm <- CLfdr(x=x, y=y)
```

```
## Overall pi0:  0.5971049 Wed Oct 29 22:55:02 2025
```

```
## Warning in density.default(y, n = 1000, weights = W/sum(W)): Selecting
## bandwidth *not* using 'weights'
```

```
## Initial bandwidth:  0.088971 0.4551709
## Bandwidth:  0.1074827 0.1782413 Wed Oct 29 22:55:27 2025
```

```
fit.nm$fdr[1:5]
```

```
##      A3GALT2      AADACL3         AARD       AARSD1       ABCA10
## 0.6145018406 0.0009943109 0.7155822142 0.8995035135 0.0685796408
```

Here we use the normalized ranks of `len_gene` as our covariate.
Similarly, we analyze the larger group of 16,493 genes with both microarray \(t\)-statistic and gene length as covariates.

```
# indicator for RNA-seq genes with matching microarray data
ind.m <- !ind.nm
# normalize covariate
m <- sum(ind.m)
x1 <- rank(pso$tval_mic[ind.m])/m
x2 <- rank(pso$len_gene[ind.m])/m

xmat <- cbind(x1, x2)
colnames(xmat) <- c("tval", "len")
y <- pso$zval[ind.m]
names(y) <- row.names(pso)[ind.m]

fit.m <- CLfdr(x=xmat, y=y, bw=c(0.028, 0.246, 0.253))
```

```
## Overall pi0:  0.6005578 Wed Oct 29 22:55:30 2025
```

```
## Warning in density.default(y, n = 1000, weights = W/sum(W)): Selecting
## bandwidth *not* using 'weights'
```

For time consideration, we specify the bandwidth here. Without the explicit specification of the bandwidth, the `CLfdr` function will find the optimal bandwidth, and it would take 20-30 minutes. Finally, we combine the results from two groups.

```
fdr <- c(fit.m$fdr, fit.nm$fdr)
FDR <- EstFDR(fdr)
o <- order(FDR)
FDR[o][1:5]
```

```
##        KRT6A         GJB2     SERPINB3     SERPINB4        KRT16
## 8.126023e-09 1.265281e-08 1.482169e-08 2.082357e-08 2.848828e-08
```

```
sum(FDR<0.01)
```

```
## [1] 1866
```

## Session Information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] calm_1.24.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     Matrix_1.7-4
##  [5] mgcv_1.9-3        xfun_0.53         lattice_0.22-7    splines_4.5.1
##  [9] cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1 rmarkdown_2.30
## [13] lifecycle_1.0.4   cli_3.6.5         grid_4.5.1        sass_0.4.10
## [17] jquerylib_0.1.4   compiler_4.5.1    tools_4.5.1       nlme_3.1-168
## [21] evaluate_1.0.5    bslib_0.9.0       yaml_2.3.10       rlang_1.1.6
## [25] jsonlite_2.0.0
```

## References

Benjamini, Y., and Y. Hochberg. 1995. “Controlling the false discovery rate: a practical and powerful approach to multiple testing.” *Journal of the Royal Statistical Society. Series B* 57 (1): 289–300.

Collado-Torres, Leonardo, Abhinav Nellore, Kai Kammers, Shannon E Ellis, Margaret A Taub, Kasper D Hansen, Andrew E Jaffe, Ben Langmead, and Jeffrey T Leek. 2017. “Reproducible RNA-seq Analysis Using Recount2.” *Nature Biotechnology* 35 (4): 319–21.

Gudjonsson, Johann E, Jun Ding, Andrew Johnston, Trilokraj Tejasvi, Andrew M Guzman, Rajan P Nair, John J Voorhees, Goncalo R Abecasis, and James T Elder. 2010. “Assessment of the Psoriatic Transcriptome in a Large Sample: Additional Regulated Genes and Comparisons with in Vitro Models.” *Journal of Investigative Dermatology* 130 (7): 1829–40.

Jabbari, Ali, Mayte Suárez-Fariñas, Scott Dewell, and James G Krueger. 2012. “Transcriptional Profiling of Psoriasis Using RNA-seq Reveals Previously Unidentified Differentially Expressed Genes.” *Journal of Investigative Dermatology* 132 (1): 246–49.

Law, Charity W, Yunshun Chen, Wei Shi, and Gordon K Smyth. 2014. “Voom: Precision Weights Unlock Linear Model Analysis Tools for RNA-seq Read Counts.” *Genome Biology* 15 (2): R29.
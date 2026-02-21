* [reconsi package: vignette](#reconsi-package-vignette)
* [Introduction](#introduction)
* [Installation](#installation)
  + [General use](#general-use)
  + [Case study](#case-study)
* [Session info](#session-info)

# reconsi package: vignette

# Introduction

The aim of this package is to improve simultaneous inference for correlated hypotheses using collapsed null distributions. These collapsed null distributions are estimated in an empirical Bayes framework through resampling. Wilcoxon rank sum test and two sample t-test are natively implemented, but any other test can be used.

# Installation

```
library(BiocManager)
BiocManager::install("reconsi")
```

```
library(devtools)
install_github("CenterForStatistics-UGent/reconsi")
```

```
suppressPackageStartupMessages(library(reconsi))
cat("reconsi package version", as.character(packageVersion("reconsi")), "\n")
```

```
## reconsi package version 1.22.0
```

## General use

We illustrate the general use of the package on a synthetic dataset. The default Wilcoxon rank-sum test is used.

```
#Create some synthetic data with 90% true null hypothesis
 p = 200; n = 50
x = rep(c(0,1), each = n/2)
 mat = cbind(
 matrix(rnorm(n*p/10, mean = 5+x),n,p/10), #DA
 matrix(rnorm(n*p*9/10, mean = 5),n,p*9/10) #Non DA
 )
 #Provide just the matrix and grouping factor, and test using the collapsed null
 fdrRes = reconsi(mat, x)
  #The estimated tail-area false discovery rates.
  estFdr = fdrRes$Fdr
```

The method provides an estimate of the proportion of true null hypothesis, which is close to the true 90%.

```
fdrRes$p0
```

```
## [1] 0.9591587
```

The result of the procedure can be represented graphically as follows:

```
plotNull(fdrRes)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the reconsi package.
##   Please report the issue at
##   <https://github.com/CenterForStatistics-UGent/reconsi/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The dot-dot notation (`..density..`) was deprecated in ggplot2 3.4.0.
## ℹ Please use `after_stat(density)` instead.
## ℹ The deprecated feature was likely used in the reconsi package.
##   Please report the issue at
##   <https://github.com/CenterForStatistics-UGent/reconsi/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `guide` argument in `scale_*()` cannot be `FALSE`. This was deprecated in
## ggplot2 3.3.4.
## ℹ Please use "none" instead.
## ℹ The deprecated feature was likely used in the reconsi package.
##   Please report the issue at
##   <https://github.com/CenterForStatistics-UGent/reconsi/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

![](data:image/png;base64...)

The approximate correlation matrix of test statistic in the univariate \(h\) distribution can be visualized as follows:

```
plotApproxCovar(fdrRes)
```

![](data:image/png;base64...)

On the other hand, one can also view the full variance-covariance matrix of the test statistics as found by the resamples. Here we demonstrate how it can recover a block correlation structure in the data.

```
matBlock = mat
matBlock[x==0,] = matBlock[x==0,] + rep(c(-1,2), each = n*p/4)
fdrResBlock = reconsi(matBlock, x)
plotCovar(fdrResBlock)
```

![](data:image/png;base64...)

It is also possible to provide a custom test function, which must accept at least a ‘y’ response variable and a ‘x’ grouping factor. Additionally, quantile, distribution and density functions should be supplied for transformation through quantiles to z-values.

```
 #With a custom function, here linear regression
fdrResLm = reconsi(mat, x, B = 5e1,
                      test = function(x, y){
fit = lm(y~x)
c(summary(fit)$coef["x","t value"], fit$df.residual)},
distFun = function(q){pt(q = q[1], df = q[2])})
```

This framework also accepts more than 2 groups, and additional covariates through the “argList” argument.

```
 #3 groups
 p = 100; n = 60
x = rep(c(0,1,2), each = n/3)
mu0 = 5
 mat = cbind(
 matrix(rnorm(n*p/10, mean = mu0+x),n,p/10), #DA
 matrix(rnorm(n*p*9/10, mean = mu0),n,p*9/10) #Non DA
 )
 #Provide an additional covariate through the 'argList' argument
 z = rpois(n , lambda = 2)
 fdrResLmZ = reconsi(mat, x, B = 5e1,
 test = function(x, y, z){
 fit = lm(y~x+z)
 c(summary(fit)$coef["x","t value"], fit$df.residual)},
distFun = function(q){pt(q = q[1], df = q[2])},
 argList = list(z = z))
```

If the null distribution of the test statistic is not known, it is also possbile to execute the procedure on the scale of the original test statistics, rather than z-values by setting zValues = FALSE. This may be numerically less stable.

```
fdrResKruskal = reconsi(mat, x, B = 5e1,
test = function(x, y){kruskal.test(y~x)$statistic}, zValues = FALSE)
```

Alternatively, the same resampling instances may be used to determine the marginal null distributions as to estimate the collapsed null distribution, by setting the “resamZvals” flag to true.

```
fdrResKruskalPerm = reconsi(mat, x, B = 5e1,
test = function(x, y){
 kruskal.test(y~x)$statistic}, resamZvals = TRUE)
```

When no grouping variable is available, one can perform a bootstrap as resampling procedure. This is achieved by simply not supplying a grouping variable “x”. Here we perform a one sample Wilcoxon rank sum test for equality of the means to 0.

```
fdrResBootstrap = reconsi(Y = mat, B = 5e1, test = function(y, x, mu){
                                      testRes = t.test(y, mu = mu)
                                      c(testRes$statistic, testRes$parameter)}, argList = list(mu = mu0),
                                  distFun = function(q){pt(q = q[1],
                                                           df = q[2])})
```

## Case study

We illustrate the package using an application from microbiology. The species composition of a community of microorganisms can be determined through sequencing. However, this only yields compositional information, and knowledge of the population size can be acquired by cell counting through flow cytometry. Next, the obtained species compositions can multiplied by the total population size to yield approximate absolute cell counts per species. Evidently, this introduces strong correlation between the tests due to the common factor. In other words: random noise in the estimation of the total cell counts will affect all hypotheses. Therefore, we employ resampling to estimate the collapsed null distribution, that will account for this dependence.

The dataset used is taken from Vandeputte *et al.*, 2017 (see [manuscript](https://www.ncbi.nlm.nih.gov/pubmed/29143816)), a study on gut microbiome in healthy and Crohn’s disease patients. The test looks for differences in absolute abundance between healthy and diseased patients. It relies on the *phyloseq* package, which is the preferred way to interact with our machinery for microbiome data.

```
#The grouping and flow cytometry variables are present in the phyloseq object, they only need to be called by their name.
data("VandeputteData")
testVanDePutte = testDAA(Vandeputte, groupName = "Health.status", FCname = "absCountFrozen", B = 1e2L)
```

The estimated tail-area false discovery rates can then simply be extracted as

```
FdrVDP = testVanDePutte$Fdr
quantile(FdrVDP)
```

```
##           0%          25%          50%          75%         100%
## 7.468699e-16 3.508674e-01 1.000000e+00 1.000000e+00 1.000000e+00
```

# Session info

Finally all info on R and package version is shown

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
## [1] reconsi_1.22.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] ggplot2_4.0.0       ks_1.15.1           rhdf5_2.54.0
##  [7] Biobase_2.70.0      lattice_0.22-7      rhdf5filters_1.22.0
## [10] vctrs_0.6.5         tools_4.5.1         generics_0.1.4
## [13] biomformat_1.38.0   stats4_4.5.1        parallel_4.5.1
## [16] tibble_3.3.0        cluster_2.1.8.1     pkgconfig_2.0.3
## [19] KernSmooth_2.23-26  Matrix_1.7-4        data.table_1.17.8
## [22] RColorBrewer_1.1-3  S7_0.2.0            S4Vectors_0.48.0
## [25] lifecycle_1.0.4     compiler_4.5.1      farver_2.1.2
## [28] stringr_1.5.2       Biostrings_2.78.0   Seqinfo_1.0.0
## [31] codetools_0.2-20    permute_0.9-8       htmltools_0.5.8.1
## [34] sass_0.4.10         yaml_2.3.10         pracma_2.4.6
## [37] pillar_1.11.1       crayon_1.5.3        jquerylib_0.1.4
## [40] MASS_7.3-65         cachem_1.1.0        vegan_2.7-2
## [43] iterators_1.0.14    mclust_6.1.1        foreach_1.5.2
## [46] nlme_3.1-168        tidyselect_1.2.1    digest_0.6.37
## [49] mvtnorm_1.3-3       stringi_1.8.7       dplyr_1.1.4
## [52] reshape2_1.4.4      labeling_0.4.3      splines_4.5.1
## [55] ade4_1.7-23         fastmap_1.2.0       grid_4.5.1
## [58] cli_3.6.5           magrittr_2.0.4      dichromat_2.0-0.1
## [61] survival_3.8-3      ape_5.8-1           withr_3.0.2
## [64] scales_1.4.0        rmarkdown_2.30      XVector_0.50.0
## [67] matrixStats_1.5.0   igraph_2.2.1        multtest_2.66.0
## [70] phyloseq_1.54.0     evaluate_1.0.5      knitr_1.50
## [73] IRanges_2.44.0      mgcv_1.9-3          rlang_1.1.6
## [76] Rcpp_1.1.0          glue_1.8.0          BiocGenerics_0.56.0
## [79] jsonlite_2.0.0      R6_2.6.1            Rhdf5lib_1.32.0
## [82] plyr_1.8.9
```
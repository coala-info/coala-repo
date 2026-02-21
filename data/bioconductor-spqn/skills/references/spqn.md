# Spatial quantile normalization for co-expression analysis

Yi Wang and Kasper D. Hansen

#### 30 October 2025

#### Abstract

A guide to using spqn for co-expression analysis

#### Package

spqn 1.22.0

# 1 Introduction

The spqn package contains an implementation of spatial quantile normalization (SpQN) as described in (Wang, Hicks, and Hansen [2020](#ref-spqnPreprint)). In this work we describe how correlation matrices estimated from gene expression data exhibits a *mean-correlation* relationship, in which highly expressed genes appear more correlated than lowly expressed genes. This relationship is not observed in protein-protein interaction networks, which suggests it is technical rather than biological. To correct for this bias in estimation, we developed SpQN, a method for normalizing the correlation matrix. In our work, we show how correcting for this relationship increases the correlations involving transcription factors, an important class of gene regulators.

We believe spatial quantile normalization has applications outside of co-expression analysis including beyond correlation matrices. However, the *implementation* in this package is currently focused on correlation matrices.

The package contains various plotting functions for assessing the mean-correlation relationship, mirroring plots in (Wang, Hicks, and Hansen [2020](#ref-spqnPreprint)).

# 2 Preliminaries

Let’s load the package and some example data.

```
library(spqn)
library(spqnData)
library(SummarizedExperiment)
```

This dataset contains 4,000 genes from the GTEx tissue “Adipose Subcutaneous” which we use as exemplar tissue in our preprint (Wang, Hicks, and Hansen [2020](#ref-spqnPreprint)). The data is from GTEx v6p. The genes have been restricted to a random sample of 4,000 genes from genes which are

* either protein-coding or lincRNAs
* expressed (median expression greater than 0 on the \(\log\_2(\text{RPKM})\) scale

The data is counts (from the GTEx website) of bulk RNA-seq data which has been transformed to the expression matrix in the \(\log\_2(\text{RPKM})\) scale. Each gene has been scaled to have mean 0 and variance 1, and 4 principal components have been removed from the data matrix. For SpQN we need access to the gene expression level, which we take as the mean or median expression level across samples. So this quantity needs to be computed (and stored) prior to removing principal components. For this example data, we have stored the average expression value on the log-RPKM scale in `rowData(gtex.4k)$ave_logrpkm`.

To compare the distribution of correlation across different expression levels, we get the correlation matrix and average gene expression level (\(\log\_2(\text{RPKM})\)) for each gene.

```
data(gtex.4k)
cor_m <- cor(t(assay(gtex.4k)))
ave_logrpkm <- rowData(gtex.4k)$ave_logrpkm
```

# 3 Preparing your own data

**Note**: code in this section is not being evaluated.

We assume you have counts (or something similar) stored in a `SummarizedExperiment`. In our case, we have downloaded the GTEx v6p counts from the GTEx portal website (code is available in the `spqnData` package inside `scripts`).

It makes sense to do some correction for library size. In this data we have simply divided by the number of reads in millions. There are multiple normalization strategies for estimating a library size correction factor. The literature shows that using such methods are *essential* when comparing expression across different tissues / cell types / conditions. However, here we are looking at correlation patterns **within** tissue.

We also need to remove genes which are not expressed. The threshold we have been using for GTEx is fairly liberal as it removes less than 50% of protein-coding codes. We apply this cutoff on the log2RPKM scale as it is necessary to consider gene length when applying a cutoff across genes. However, the exact way of doing this is probably not too important.

Finally, following (Parsana et al. [2019](#ref-Parsana2019)) we strongly recommend removing principal components from the data matrix prior to analysis. A fast convenience function for this is `removePrincipalComponents()` from the WGCNA package. How many principal components to remove is an open question. In (Freytag et al. [2015](#ref-Freytag2015)) the authors recommend looking at control genes to assess this, under the hypothesis that random genes should be uncorrelated and we have existing groups of genes which are believe to be highly correlated in all tissues, such as the PRC2 complex (Freytag et al. [2015](#ref-Freytag2015)) or the ribosomal RNA genes (Boukas et al. [2019](#ref-Boukas2019)). Another approach is to use the `num.sv()` function from the SVA package. In our experience, this yields a substantially higher number of PCs than the graphical methods. Finally, as we shown (Wang, Hicks, and Hansen [2020](#ref-spqnPreprint)), the QC plots we present below might also help making this decision. At the end of the day, it is still an open problem.

Example code is as follows, the starting point is a `SummarizedExperiment` called `gtex` with the relevant data. It has two relevant columns in `rowData(gtex)`. One column is `gene_length` and another is `gene_type`.

```
# only keep coding genes and lincRNA in the counts matrix
gtex <- gtex[rowData(gtex)$gene_type %in%
                          c("lincRNA", "protein_coding"), ]

# normalize the counts matrix by log2rpkm
cSums <- colSums(assay(gtex))
logrpkm <- sweep(log2(assay(gtex) + 0.5), 2, FUN = "-",
                 STATS = log2(cSums / 10^6))
logrpkm <- logrpkm - log2(rowData(gtex)$gene_length / 1000)

# only keep those genes with median log2rpkm above 0
wh.expressed  <- which(rowMedians(logrpkm) > 0)

gtex.0pcs <- gtex[wh.expressed,]
logrpkm.0pcs <- logrpkm[wh.expressed,]
ave_logrpkm <- rowMeans(logrpkm.0pcs)
logrpkm <- logrpkm - ave_logrpkm # mean centering
logrpkm  <- logrpkm / matrixStats::rowSds(logrpkm) # variance scaling
assays(gtex.0pcs) <- SimpleList(logrpkm = logrpkm.0pcs)
rowData(gtex.0pcs)$ave_logrpkm <- ave_logrpkm

# remove PCs from the gene expression matrix after scaling each gene to have mean=0 and variance=1
gtex.4pcs <- gtex.0pcs
assay(gtex.4pcs) <- removePrincipalComponents(t(scale(t(logrpkm.0pcs))), n = 4)
```

# 4 Examine the mean-correlation relationship

We now recreate a number of diagnostic plots which illustrate the mean-correlation relationship. These plots are similar to that is being presented in (Wang, Hicks, and Hansen [2020](#ref-spqnPreprint)).

To compare the distribution of correlation across different expression levels, we re-arrrange the correlation matrix by sortng the row and column by the expression level, and partitioned the correlation matrix into same-size bins, then used each bin to estimate the distribution of correlation for genes with that expression level. Here we use 10 by 10 bins. Each bin corresponds to two groups of genes that correspodnd to two expression levels.

We first looked into the bins on the diagnal, where the two groups of genes have the same expression level. We looked at the distribution of the correlations within each of these bins. We find that the correlations of highly expressed genes are more variant than those of lowly expressed genes. We call such relationship between gene expression level and the distribution of correlation as mean-correlation relationship.

```
plot_signal_condition_exp(cor_m, ave_logrpkm, signal=0)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the spqn package.
##   Please report the issue at <https://github.com/hansenlab/spqn/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the spqn package.
##   Please report the issue at <https://github.com/hansenlab/spqn/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Next, we examine the impact of this mean-correlation relationship on the downstream analysis.
A number of studies predict the co-expressed genes by setting a threshold. We therefore examine how the mean-correlation relationship would bias such prediction. We set 0.1% highest correlations as predicted signals in each bin. We compare the distibution of signals for bins on the diagonal. We find that the the predicted signals are stronger for high expressed genes and weaker for low expressed genes. Because of such bias, the true signals among low expressed genes could be hidden and may not be detected.

```
plot_signal_condition_exp(cor_m, ave_logrpkm, signal=0.001)
```

```
## Warning in scale_y_discrete(limits = seq_len(10)): Continuous limits supplied to discrete scale.
## ℹ Did you mean `limits = factor(...)` or `scale_*_continuous()`?
```

![](data:image/png;base64...)

Next we looked further into the bins across the entire correlation matrix. We quantify the variance inside a bin using inter-quantile range (IQR), which is the distance from the 1st and 3rd quantile. We use the width of box in the plot to denote IQR. We observe that the IQR would increase with the increase of expression level for either gene.

```
IQR_list <- get_IQR_condition_exp(cor_m, rowData(gtex.4k)$ave_logrpkm)
plot_IQR_condition_exp(IQR_list)
```

```
## Warning in scale_y_discrete(limits = c(seq_len(10)) + c(0:9) * min(IQR_cor_mat)/10, : Continuous limits supplied to discrete scale.
## ℹ Did you mean `limits = factor(...)` or `scale_*_continuous()`?
```

```
## Warning in scale_x_discrete(limits = c(seq_len(10)) + c(0:9) * min(IQR_cor_mat)/10, : Continuous limits supplied to discrete scale.
## ℹ Did you mean `limits = factor(...)` or `scale_*_continuous()`?
```

![](data:image/png;base64...)

We next plot the marginal relationship between IQR of correlation and the expression level of the lower expression group for each bin, and we also see a positive relationship.

```
IQR_unlist <- unlist(lapply(1:10, function(ii) IQR_list$IQR_cor_mat[ii, ii:10]))
plot(rep(IQR_list$grp_mean, times = 1:10),
     IQR_unlist,
     xlab="min(average(log2RPKM))", ylab="IQR", cex.lab=1.5, cex.axis=1.2, col="blue")
```

![](data:image/png;base64...)

We further examined the difference of the distributions using Q-Q plot. We used the bins with the second highest expression level on the diagonal as reference, and compared the distribution with other bins in the diagonal. We observe both scale and shape difference in the distributions.

```
par(mfrow = c(3,3))
for(j in c(1:8,10)){
    qqplot_condition_exp(cor_m, ave_logrpkm, j, j)
}
```

![](data:image/png;base64...)

# 5 Using SpQN to remove mean-correlation relationship

To remove the mean-correlation relationship and avoid the bias in the co-expression analysis, we develop a normalization method for correlation matrix, named as spatial quantile normalization (SpQN). The main idea is to use bins to partition the correlation matrix with genes sorted by exp level, and then apply quantile normalization for each bin. To smooth the normalization, we used a larger bin to approximate the empirical distribution of the inner bin. And we applied 1-dimension quantile normalization on the inner bins using its approximated distribution. The target distribution we used here is the bin with the second highest expression level on the diagonal.

Using SpQN is relatively easy. In the function *normalize\_correlation*, imput matrix *cor\_m* is the correlation matrix. Imput vector *ave\_exp* is the average expression level for the genes for the normalized expression matrix, corresponding to the row/column of *cor\_m*. For other types of data, *ave\_exp* can be the vector corresponding to the row/column of the correlation matrix, whose dependency with the distribution of correlations need to be removed. Parameter *ngrp* is an integer, denoting the number of bins in each row/column to be used to partition the correlation matrix in the process of SpQN. For example, setting *ngrp*=20 means to partition the correlation matrix into 20 by 20 bins. Parameter *size\_grp* is an integer, denoting the size of the outter bins to be used to appriximate the distribution of the inner bins, in order to smooth the normalization. Note that the product of *size\_grp* and *ngrp* must be equal or larger than than the row/column number of *cor\_m*, and there is no smoothness in the normalization when they are equal. Parameter *ref\_grp* is the location of the reference bin on the diagonal, whose distribution will be used as target distribution in the normalization.

```
cor_m_spqn <- normalize_correlation(cor_m, ave_exp=ave_logrpkm, ngrp=20, size_grp=300, ref_grp=18)
```

# 6 Assess the impact of normalization

To evaluate the performance of SpQN, we make the same plots as before, but using the normalized correlation matrix.

Compare distributions of correlations for bins on the diagonal of the correlation matrix.

```
plot_signal_condition_exp(cor_m_spqn, ave_logrpkm, signal=0)
```

![](data:image/png;base64...)

Distribution of predicted signals and background correlations for bins on the diagonal of the correlation matrix.

```
plot_signal_condition_exp(cor_m_spqn, ave_logrpkm, signal=0.001)
```

```
## Warning in scale_y_discrete(limits = seq_len(10)): Continuous limits supplied to discrete scale.
## ℹ Did you mean `limits = factor(...)` or `scale_*_continuous()`?
```

![](data:image/png;base64...)

Compare IQRs of bins across the entire correlation matrix.

```
IQR_spqn_list <- get_IQR_condition_exp(cor_m_spqn, rowData(gtex.4k)$ave_logrpkm)
plot_IQR_condition_exp(IQR_spqn_list)
```

```
## Warning in scale_y_discrete(limits = c(seq_len(10)) + c(0:9) * min(IQR_cor_mat)/10, : Continuous limits supplied to discrete scale.
## ℹ Did you mean `limits = factor(...)` or `scale_*_continuous()`?
```

```
## Warning in scale_x_discrete(limits = c(seq_len(10)) + c(0:9) * min(IQR_cor_mat)/10, : Continuous limits supplied to discrete scale.
## ℹ Did you mean `limits = factor(...)` or `scale_*_continuous()`?
```

![](data:image/png;base64...)

Q-Q plot to compare the distribution for the bin with the 2nd highest expression level on the diagonal with other bins on the diagonal.

```
par(mfrow = c(3,3))
for(j in c(1:8,10)){
    qqplot_condition_exp(cor_m_spqn, ave_logrpkm, j, j)
}
```

![](data:image/png;base64...)

Marginal relationship between IQR and the expression level of the lower expressed group for each bin.

```
IQR_unlist <- unlist(lapply(1:10, function(ii) IQR_spqn_list$IQR_cor_mat[ii, ii:10]))
plot(rep(IQR_spqn_list$grp_mean, times = 1:10),
     IQR_unlist,
     xlab="min(average(log2RPKM))", ylab="IQR", cex.lab=1.5, cex.axis=1.2, col="blue")
```

![](data:image/png;base64...)

# 7 SessionInfo

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] spqnData_1.21.0             spqn_1.22.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] ggridges_0.5.7              ggplot2_4.0.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         SparseArray_1.10.0  lattice_0.22-7
##  [4] digest_0.6.37       magrittr_2.0.4      evaluate_1.0.5
##  [7] grid_4.5.1          RColorBrewer_1.1-3  bookdown_0.45
## [10] fastmap_1.2.0       jsonlite_2.0.0      Matrix_1.7-4
## [13] tinytex_0.57        BiocManager_1.30.26 scales_1.4.0
## [16] jquerylib_0.1.4     abind_1.4-8         cli_3.6.5
## [19] crayon_1.5.3        rlang_1.1.6         XVector_0.50.0
## [22] withr_3.0.2         cachem_1.1.0        DelayedArray_0.36.0
## [25] yaml_2.3.10         S4Arrays_1.10.0     tools_4.5.1
## [28] dplyr_1.1.4         vctrs_0.6.5         R6_2.6.1
## [31] magick_2.9.0        lifecycle_1.0.4     pkgconfig_2.0.3
## [34] pillar_1.11.1       bslib_0.9.0         gtable_0.3.6
## [37] Rcpp_1.1.0          glue_1.8.0          xfun_0.53
## [40] tibble_3.3.0        tidyselect_1.2.1    knitr_1.50
## [43] dichromat_2.0-0.1   farver_2.1.2        htmltools_0.5.8.1
## [46] labeling_0.4.3      rmarkdown_2.30      compiler_4.5.1
## [49] S7_0.2.0
```

# References

Boukas, Leandros, James M Havrilla, Peter F Hickey, Aaron R Quinlan, Hans T Bjornsson, and Kasper D Hansen. 2019. “Coexpression Patterns Define Epigenetic Regulators Associated with Neurological Dysfunction.” *Genome Research* 29 (4): 532–42. <https://doi.org/10.1101/gr.239442.118>.

Freytag, Saskia, Johann Gagnon-Bartsch, Terence P Speed, and Melanie Bahlo. 2015. “Systematic Noise Degrades Gene Co-Expression Signals but Can Be Corrected.” *BMC Bioinformatics* 16: 309. <https://doi.org/10.1186/s12859-015-0745-3>.

Parsana, Princy, Claire Ruberman, Andrew E Jaffe, Michael C Schatz, Alexis Battle, and Jeffrey T Leek. 2019. “Addressing Confounding Artifacts in Reconstruction of Gene Co-Expression Networks.” *Genome Biology* 20 (1): 94. <https://doi.org/10.1186/s13059-019-1700-9>.

Wang, Yi, Stephanie C Hicks, and Kasper D Hansen. 2020. “Co-Expression Analysis Is Biased by a Mean-Correlation Relationship.” *bioRxiv*, 2020.02.13.944777. <https://doi.org/10.1101/2020.02.13.944777>.
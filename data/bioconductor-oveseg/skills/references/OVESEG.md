# OVESEG User Manual

Lulu Chen

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Quick Start](#quick-start)
* [3 OVESEG-test](#oveseg-test)
  + [3.1 Datatypes and Input Format](#datatypes-and-input-format)
  + [3.2 Microarray data](#microarray-data)
  + [3.3 RNAseq count data](#rnaseq-count-data)
  + [3.4 p-values](#p-values)
* [4 Useful intermediate results](#useful-intermediate-results)
  + [4.1 Test statistics](#test-statistics)
  + [4.2 Posterior probabilities of null hypothesis components](#posterior-probabilities-of-null-hypothesis-components)
* [5 Notes](#notes)
* [6 sessionInfo](#sessioninfo)
* [References](#references)

# 1 Introduction

OVESEG-test (One Versus Everyone Subtype Exclusively-expressed Genes test) is a statistically-principled multiple-group comparison method that can detect tissue/cell-specific marker genes (MGs) among many subtypes (e.g. tissue/cell types) (Chen et al. [2019](#ref-oveseg)). To assess the statistical significance of MGs, OVESEG-test uses a specifically designed test statistics that mathematically matches the definition of MGs, and employs a novel permutation scheme to estimate the corresponding distribution under null hypothesis where the expression patterns of non-MGs can be highly complex.

`OVESEG` package provides functions to compute OVESEG-test statistics, derive component weights in the mixture null distribution model and estimate p-values from weightedly aggregated permutations. While OVESEG-test p-values can be used to detect MGs, component weights of hypotheses also help portrait all kinds of upregulation patterns among tissue/cell types.

# 2 Quick Start

The function `OVESEGtest()` includes all necessary steps to obtain OVESEG-test p-values. You need to specify the expression matrix, tissue/cell type labels, number of permutations, and parallel option. For microarray data, the expressions need to be log2-transformed prior to the test. For RNAseq count data, the counts need to be transformed to logCPM (log2-counts per million) prior to the test and use `limma::voom()` to incorporate the mean-variance relationship. Parallel option is set according to *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* package.

```
#Microarray
rtest <- OVESEGtest(y, group, NumPerm=999,
                    BPPARAM=BiocParallel::SnowParam())

#RNAseq
yvoom <- limma::voom(count, model.matrix(~0+factor(group)))
rtest <- OVESEGtest(yvoom$E, group, weights=yvoom$weights, NumPerm = 999,
                    BPPARAM=BiocParallel::SnowParam())
```

# 3 OVESEG-test

## 3.1 Datatypes and Input Format

Theoretically, OVESEG-test can be applied to any molecular expression data types as long as they can be modeled by normal distribution after a transformation, such as log2-transformation for microarray and proteomics data, logCPM for RNAseq counts, logit2-transformation for DNA methylation beta values. If mean-variance relationship exists after transformation, `limma::vooma()/voom()` need to be performed firstly and the resulted weight matrix is used as the input of `OVESEG`.

Requirements for the input expression data:

* be transformed (log2/logCPM/logit2).
* be already processed by normalization and batch effect removal.
* no missing values; the molecules containing missing values should be removed prior to OVESEG-test.
* no low-expressed molecules; otherwise, the results will be affected.

The input expression data should be stored in a matrix. Data frame, or SummarizedExperiment object is also accepted and will be internally coerced into a matrix format before analysis. Rows correspond to probes and columns to samples. Tissue/cell labels must match each column in expression matrix. Weight matrix, if provided, must match each spot in expression matrix.

## 3.2 Microarray data

We use a data set of purified B cells, CD4+ T cells and CD8+ T cells (downsampled from [GSE28490](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE28490)) as an example to show OVESEG-test on microarray data.

```
library(OVESEG)
#Import data
data(RocheBT)
y <- RocheBT$y #5000*15 matrix
group <- RocheBT$group #15 labels

#filter low-expressed probes
groupMean <- sapply(levels(group), function(x) rowMeans(y[,group == x]))
groupMeanMax <- apply(groupMean, 1, max)
keep <- (groupMeanMax > log2(64))
y <- y[keep,]

#OVESEG-test
rtest1 <- OVESEGtest(y, group, NumPerm = 999,
                     BPPARAM=BiocParallel::SnowParam())
#> Calculating posterior probabilities of null hypotheses
#> Permuting top 2 groups
#> Permuting top 3 groups
#> Calculating p-values
#> Calculating p-values for each group specifically
```

Note there are many low-expressed probe filtering methods. Here we filtered the probes whose mean expression is less than a threshold even in the highest expressed group. If mean-variance relationship is obvious, we can consider to apply `limma::vooma()` firstly.

```
#OVESEG-test
yvooma <- limma::vooma(y, model.matrix(~0+factor(group)))
rtest2 <- OVESEGtest(yvooma$E, group, weights=yvooma$weights, NumPerm = 999,
                     BPPARAM=BiocParallel::SnowParam())
#> Calculating posterior probabilities of null hypotheses
#> Permuting top 2 groups
#> Permuting top 3 groups
#> Calculating p-values
#> Calculating p-values for each group specifically
```

## 3.3 RNAseq count data

We use a data set of purified B cells, CD4+ T cells and CD8+ T cells (downsampled from [GSE60424](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE60424)) as an example to show OVESEG-test on RNAseq count data.

```
library(OVESEG)
#Import data
data(countBT)
count <- countBT$count #10000*60 matrix
group <- countBT$group #60 labels

#filter low-expressed probes
groupMean <- sapply(levels(group), function(x) rowMeans(count[,group == x]))
groupMeanMax <- apply(groupMean, 1, max)
keep <- (groupMeanMax > 2)
count <- count[keep,]

#OVESEG-test
lib.size <- max(colSums(count))
yvoom <- limma::voom(count, model.matrix(~0+factor(group)),
                     lib.size = lib.size)
rtest3 <- OVESEGtest(yvoom$E, group, weights=yvoom$weights, NumPerm = 999,
                     BPPARAM=BiocParallel::SnowParam())
#> Calculating posterior probabilities of null hypotheses
#> Permuting top 2 groups
#> Permuting top 3 groups
#> Calculating p-values
#> Calculating p-values for each group specifically
```

Note there are many low-expressed probe filtering methods. Here we filtered the probes whose mean count is less than a threshold even in the highest expressed group. `lib.size` and other parameters in `limma::voom()` can be set manually according to *[limma](https://bioconductor.org/packages/3.22/limma)* package.

## 3.4 p-values

`OVESEGtest` returns three p-values: `pv.overall`, `pv.oneside` and `pv.multiside`. `pv.overall` is calculated by all permutations regardless of upregulated subtypes. `pv.oneside` is subtype-specific p-values calculated specifically for the upregulated subtype of each probe. `pv.multiside` is `pv.oneside` multiplied by K (K comparison correction) and truncated at 1. More details can be found in the paper (Chen et al. [2019](#ref-oveseg)).

# 4 Useful intermediate results

## 4.1 Test statistics

OVESEG-test statistics are defined as \[\mathbf{\max\_{k=1,...,K}\left\{min\_{l \neq k}\left\{ \frac{\mu\_k(j)-\mu\_l(j)}{\sigma(j)\sqrt{\frac{1}{N\_k}+\frac{1}{N\_l}}} \right\}\right\}}\] where \(\mathbf{\mu\_k(j)}\) is the mean of logarithmic expressions of gene j in subtype k. While it takes a long time to execute permutations for p-value estimation, `OVESEGtstat()` is useful if users only need test statistics for ranking genes:

```
#OVESEG-test statistics
rtstat1 <- OVESEGtstat(y, RocheBT$group)
rtstat2 <- OVESEGtstat(yvooma$E, RocheBT$group, weights=yvooma$weights)
rtstat3 <- OVESEGtstat(yvoom$E, countBT$group, weights=yvoom$weights)
```

## 4.2 Posterior probabilities of null hypothesis components

Null hypothesis of OVESEG-test is modeled as a mixture of multiple components, where the weights of components are estimated from posterior probabilities over all probes. Those posterior probabilities are also returned by `OVESEGtest()`. If users only want to observe probewise posterior probabilities, `postProbNull()` is helpful.

```
ppnull1 <- postProbNull(y, RocheBT$group)
ppnull2 <- postProbNull(yvooma$E, RocheBT$group, weights=yvooma$weights)
ppnull3 <- postProbNull(yvoom$E, countBT$group, weights=yvoom$weights)
```

By accumulating and normalizing probewise posterior probability with the function `nullDistri()`, we can also obtain the probability of one subtype being upregulated conditioned on null hypotheses. The subtype with higher probability tends to get more False Positive MGs.

```
nullDistri(ppnull1)
#>         B       CD4       CD8
#> 0.2544406 0.3699904 0.3755690
nullDistri(ppnull2)
#>         B       CD4       CD8
#> 0.2425585 0.3695814 0.3878601
nullDistri(ppnull3)
#>         B       CD4       CD8
#> 0.2555767 0.3664505 0.3779728
```

There are totally \(\mathbf{2^K-1}\) types of expression patterns in a real dataset: probes exclusively expressed in 1,2,…, or K of subtypes. Probe unexpressed in any of subtypes should have been filtered during pre-processing. Accumulating and normalizing probewise posterior probability of null hypotheses and of alternative hypotheses using the function `patternDistri()` can present us the ratios of all possible upregulation patterns among subtypes:

```
patterns <- patternDistri(ppnull1)
#or
patterns <- patternDistri(rtest1)
```

The ratios of patterns can be illustrated as following.

```
library(gridExtra)
library(grid)
library(reshape2)
library(ggplot2)

gridpatterns <- function (ppnull) {
    K <- length(ppnull$label)
    cellcomp <- patternDistri(ppnull)
    cellcomp <- cellcomp[order(cellcomp[,K+1], decreasing = TRUE),]

    #Bar Chart to show pattern percentage
    DF1 <- data.frame(Rank = seq_len(2^K - 1), cellcomp)
    p1 <- ggplot(DF1, aes(x = Rank, y = Wpattern)) +
        geom_bar(stat = "identity") +
        scale_y_continuous(labels=scales::percent) +
        theme_bw(base_size = 16) +
        theme(axis.text.x = element_blank(),
              axis.title.x = element_blank(),
              plot.margin=unit(c(1,1,-0.2,1), "cm"),
              panel.grid.minor = element_line(size = 1),
              panel.grid.major = element_line(size = 1),
              panel.border = element_blank(),
              axis.ticks.x = element_blank()) +
        ylab("Percentage of up in certain subtype(s)")

    #patterns as X-axis
    DF2 <- data.frame(Rank = seq_len(2^K-1), cellcomp[,-(K+1)])
    DF2 <- melt(DF2, id.var="Rank")
    p2 <- ggplot(DF2, aes(x = Rank, y = value, fill = variable)) +
        geom_bar(stat = "identity") +
        scale_fill_brewer(palette="Set2") +
        theme(line = element_blank(),
              axis.text.x = element_blank(),
              axis.text.y = element_blank(),
              title = element_blank(),
              panel.background = element_rect(fill = "white"),
              legend.position="bottom",
              legend.key.size = unit(1.2,"line"),
              plot.margin=unit(c(-0.2,1,1,1), "cm")) +
        scale_y_reverse() +
        guides(fill = guide_legend(nrow = 1, byrow = TRUE))

    g1 <- ggplotGrob(p1)
    g2 <- ggplotGrob(p2)
    colnames(g1) <- paste0(seq_len(ncol(g1)))
    colnames(g2) <- paste0(seq_len(ncol(g2)))
    g <- gtable_combine(g1, g2, along=2)
    panels <- g$layout$t[grepl("panel", g$layout$name)]
    n1 <- length(g$heights[panels[1]])
    n2 <- length(g$heights[panels[2]])
    # assign new (relative) heights to the panels
    # notice the *4 here to get different heights
    g$heights[panels[1]] <- unit(n1*4,"null")
    g$heights[panels[2]] <- unit(n2,"null")
    return(g)
}

grid.newpage()
grid.draw(gridpatterns(ppnull1))
#> Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#or grid.draw(gridpatterns(rtest1))
```

![](data:image/png;base64...)

# 5 Notes

Default variance estimator in `OVESEG` is empirical Bayes moderated variance estimator used in *[limma](https://bioconductor.org/packages/3.22/limma)* (argument `alpha="moderated"`). Another option is adding a constant \(\alpha\) to pooled variance estimator (argument `alpha=`\(\alpha\)). Setting argument `alpha=NULL` will treat all variances as the same constant.

Before MG detection, OVESEG-test p-values still need multiple comparison correction or false discovery rate control.

```
##multiple comparison correction
pv.overall.adj <- stats::p.adjust(rtest1$pv.overall, method="bonferroni")
pv.multiside.adj <- stats::p.adjust(rtest1$pv.multiside, method="bonferroni")

##fdr control
qv.overall <- fdrtool::fdrtool(rtest1$pv.overall, statistic="pvalue",
                               plot=FALSE, verbose=FALSE)$qval
qv.multiside <- fdrtool::fdrtool(rtest1$pv.multiside, statistic="pvalue",
                                 plot=FALSE, verbose=FALSE)$qval
```

# 6 sessionInfo

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] grid      stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] ggplot2_4.0.0    reshape2_1.4.4   gridExtra_2.3    OVESEG_1.26.0
#> [5] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         generics_0.1.4      stringi_1.8.7
#>  [4] digest_0.6.37       magrittr_2.0.4      evaluate_1.0.5
#>  [7] RColorBrewer_1.1-3  bookdown_0.45       fastmap_1.2.0
#> [10] plyr_1.8.9          jsonlite_2.0.0      limma_3.66.0
#> [13] tinytex_0.57        BiocManager_1.30.26 scales_1.4.0
#> [16] codetools_0.2-20    jquerylib_0.1.4     cli_3.6.5
#> [19] crayon_1.5.3        rlang_1.1.6         withr_3.0.2
#> [22] cachem_1.1.0        yaml_2.3.10         tools_4.5.1
#> [25] parallel_4.5.1      BiocParallel_1.44.0 dplyr_1.1.4
#> [28] vctrs_0.6.5         fdrtool_1.2.18      R6_2.6.1
#> [31] magick_2.9.0        lifecycle_1.0.4     stringr_1.5.2
#> [34] pkgconfig_2.0.3     bslib_0.9.0         pillar_1.11.1
#> [37] gtable_0.3.6        glue_1.8.0          Rcpp_1.1.0
#> [40] statmod_1.5.1       xfun_0.53           tibble_3.3.0
#> [43] tidyselect_1.2.1    knitr_1.50          dichromat_2.0-0.1
#> [46] farver_2.1.2        htmltools_0.5.8.1   snow_0.4-4
#> [49] rmarkdown_2.30      labeling_0.4.3      compiler_4.5.1
#> [52] S7_0.2.0
```

# References

Chen, Lulu, David Herrington, Robert Clarke, Guoqiang Yu, and Yue Wang. 2019. “Data-Driven Robust Detection of Tissue/Cell-Specific Markers.” *bioRxiv*. <https://doi.org/10.1101/517961>.
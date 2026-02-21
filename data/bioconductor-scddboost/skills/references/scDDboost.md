# scDDboost

Xiuyu Ma\*

\*watsonforfun@gmail.com

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 Posterior probability of a gene being DD](#posterior-probability-of-a-gene-being-dd)
  + [3.1 clustering of cells](#clustering-of-cells)
* [Session Information](#session-information)

# 1 Installation

The package can be installed from bioconductor

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scDDboost")
```

Issue can be reported at “<https://github.com/wiscstatman/scDDboost/issues>”

# 2 Introduction

scDDboost scores evidence of a gene being differentially distributed(DD) across two conditions for single cell RNA-seq data. Higher resolution brings several chanllenges for analyzing the data, specifically, the distribution of gene expression tends to have high prevalence of zero and multi-modes.
To account for those characteristics and utilizing some biological intuition,
we view the expression values sampled from a pool of cells mixed by distinct cellular subtypes blind to condition label. Consequently, the distributional change can be fully determined by the
the change of subtype proportions. One tricky part is that not any change of proportions will lead to a distributional change. Given that some genes could be equivalent expressed across several subtypes, even the individual subytpe proportion may differ between conditions but as long as the aggregated proportions over those subtypes remain the same between conditions, it will not introduce different distribution.
For example

![](data:image/png;base64...)

Proportions of subtypes 1 and 2 changed between the 2 conditions.
The gene is not DD if subtype 1 and 2 have the same expression level

![](data:image/png;base64...)

For subtype 1 and 2 have different expression level, there is different distribution
![](data:image/png;base64...)

# 3 Posterior probability of a gene being DD

`pdd` is the core function developed to quantify the
posterior probabilities of DD for input genes.
Let’s look at an example,

```
suppressMessages(library(scDDboost))
```

Next, we load the toy simulated example a object that we will use for
identifying and classifying DD genes.

```
data(sim_dat)
```

Verify that this object is a member of the SingleCellExperiment class and that it contains 200
cells and 1000 genes. The colData slot (which contains a dataframe of metadata for the
cells) should have a column that contains the biological condition or grouping of interest. In
this example data, that variable is the `condition` variable. Note that the input gene set needs
to be a matrix of normalized counts.
We run the function `pdd`

```
data_counts <- SummarizedExperiment::assays(sim_dat)$counts
conditions <- SummarizedExperiment::colData(sim_dat)$conditions
rownames(data_counts) <- seq_len(1000)

##here we use 2 cores to compute the distance matrix
bp <- BiocParallel::MulticoreParam(2)
D_c <- calD(data_counts,bp)

ProbDD <- pdd(data = data_counts,cd = conditions, bp = bp, D = D_c)
```

There are 4 input parameters needed to be specified by user, the dataset, the condition label, number of cpu cores used for computation and a distance matrix
of cells. Other input parameters have default settings.

## 3.1 clustering of cells

We provide a default method of getting the distance matrix, archived by `calD`, in general `pdd` accept all valid distance matrix. User can also input a cluster label rather than distance matrix for the argument `D`, but the random distancing mechanism which relies on distance matrix will be disabled and `random` should be set to false.

For the number of sutypes, we provide a default function `detK`, which consider the smallest number of sutypes such that the ratio of difference within cluster between difference between clusters become smaller than a threshold (default setting is 1).

If user have other ways to determine \(K\), \(K\) should be specified in `pdd`.

```
## determine the number of subtypes
K <- detK(D_c)
```

If we set threshold to be 5% then we have estimated DD genes

```
EDD <- which(ProbDD > 0.95)
```

Notice that, pdd is actually local false discovery rate, this is a conservative estimation of DD genes.
We could gain further power,
let index gene by \(g = 1,2,...,G\) and let \(p\_g = P(DD\_g | \text{data})\), \(p\_{(1)},...,p\_{(G)}\) be ranked local false discovery rate from small to large.
To control the false discovery rate at 5%, our positive set is those genes with the \(s^\*\) smallest lFDR, where
\[s^\* = \text{argmax}\_s\{s,\frac{\Sigma\_{i = 1}^s p\_{(i)}}{s} \leq 0.05\}\]

```
EDD <- getDD(ProbDD,0.05)
```

Function `getDD` extracts the estimated DD genes using the above transformation.

# Session Information

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
## [1] scDDboost_1.12.0 ggplot2_4.0.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] caTools_1.18.3              Biobase_2.70.0
##  [7] lattice_0.22-7              vctrs_0.6.5
##  [9] tools_4.5.1                 bitops_1.0-9
## [11] generics_0.1.4              stats4_4.5.1
## [13] parallel_4.5.1              tibble_3.3.0
## [15] cluster_2.1.8.1             pkgconfig_2.0.3
## [17] blockmodeling_1.1.8         KernSmooth_2.23-26
## [19] Matrix_1.7-4                EBSeq_2.8.0
## [21] RColorBrewer_1.1-3          desc_1.4.3
## [23] S7_0.2.0                    S4Vectors_0.48.0
## [25] lifecycle_1.0.4             compiler_4.5.1
## [27] farver_2.1.2                brio_1.1.5
## [29] gplots_3.2.0                tinytex_0.57
## [31] Seqinfo_1.0.0               codetools_0.2-20
## [33] htmltools_0.5.8.1           sass_0.4.10
## [35] yaml_2.3.10                 pillar_1.11.1
## [37] jquerylib_0.1.4             BiocParallel_1.44.0
## [39] SingleCellExperiment_1.32.0 cachem_1.1.0
## [41] DelayedArray_0.36.0         magick_2.9.0
## [43] abind_1.4-8                 mclust_6.1.1
## [45] gtools_3.9.5                tidyselect_1.2.1
## [47] digest_0.6.37               dplyr_1.1.4
## [49] bookdown_0.45               labeling_0.4.3
## [51] rprojroot_2.1.1             fastmap_1.2.0
## [53] grid_4.5.1                  cli_3.6.5
## [55] SparseArray_1.10.0          magrittr_2.0.4
## [57] S4Arrays_1.10.0             dichromat_2.0-0.1
## [59] withr_3.0.2                 scales_1.4.0
## [61] rmarkdown_2.30              XVector_0.50.0
## [63] matrixStats_1.5.0           RcppEigen_0.3.4.0.2
## [65] evaluate_1.0.5              knitr_1.50
## [67] GenomicRanges_1.62.0        IRanges_2.44.0
## [69] testthat_3.2.3              Oscope_1.40.0
## [71] rlang_1.1.6                 Rcpp_1.1.0
## [73] glue_1.8.0                  BiocManager_1.30.26
## [75] BiocGenerics_0.56.0         pkgload_1.4.1
## [77] jsonlite_2.0.0              R6_2.6.1
## [79] MatrixGenerics_1.22.0
```
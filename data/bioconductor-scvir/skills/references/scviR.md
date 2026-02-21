# scviR: an R package interfacing Bioconductor and scvi-tools

Vince Carey stvjc at channing.harvard.edu

#### October 30, 2025

# Contents

* [1 Overview](#overview)
* [2 Installation and use](#installation-and-use)
* [3 Session information](#session-information)

# 1 Overview

[scvi-tools](https://scvi-tools.org/) is
an element of the [scverse](https://scverse.org/) toolchest for
single-cell omics data analysis.

The scviR package is a very elementary approach to interfacing
between R, Bioconductor and scvi-tools. The long-term plan is to
illustrate several aspects of variational inference (VI) applied to single
cell genomics in a way
that is convenient for Bioconductor users.

The package makes use of SingleCellExperiment and anndata
representations of single-cell genomic assays.

Several points should be kept in mind when using this package:

* scvi-tools components develop rapidly; we are
  using [basilisk](https://bioconductor.org/packages/basilisk)
  to manage R/python interoperation, and as of current
  writing we work with version 1.3.0 of scvi-tools. Specific
  versions of python components are enumerated in the file R/basilisk.R.
* Code presented in the cite-seq tutorial
  vignette follows [the colab notebook
  for scvi-tools 0.18.0](https://colab.research.google.com/github/scverse/scvi-tutorials/blob/0.18.0/totalVI.ipynb). *We will check for modifications in the scvi-tools 0.20.0 notebook*.
* Additional work on this package will facilitate comparisons between
  outcomes of Bioconductor, scVI, and other VI-oriented analytic toolkits in the
  single-cell domain.

# 2 Installation and use

As of May 2025, use BiocManager to install scviR in R 4.5.0 or above:

```
BiocManager::install("vjcitn/scviR")
```

Be sure the `remotes` package has been installed. If you are working at a slow
internet connection, it may be useful to set `options(timeout=3600)` when running
functions

* `getCh12AllSce()` (74 MB will be retrieved and cached)
* `getCh12Sce()` (58 MB will be retrieved and cached)
* `getTotalVINormalized5k10k()` (191 MB will be retrieved and cached)

# 3 Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88803)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /media/volume/biocgpu2/biocbuild/bbs-3.22-bioc-gpu/R/lib/libRblas.so
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
##  [1] scviR_1.10.0                shiny_1.11.1
##  [3] basilisk_1.21.5             reticulate_1.44.0
##  [5] scater_1.37.0               ggplot2_4.0.0
##  [7] scuttle_1.19.0              SingleCellExperiment_1.31.1
##  [9] SummarizedExperiment_1.39.2 Biobase_2.69.1
## [11] GenomicRanges_1.61.8        Seqinfo_0.99.4
## [13] IRanges_2.43.8              S4Vectors_0.47.6
## [15] BiocGenerics_0.55.4         generics_0.1.4
## [17] MatrixGenerics_1.21.0       matrixStats_1.5.0
## [19] BiocStyle_2.37.1
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3            gridExtra_2.3        httr2_1.2.1
##  [4] rlang_1.1.6          magrittr_2.0.4       otel_0.2.0
##  [7] compiler_4.5.1       RSQLite_2.4.3        mgcv_1.9-3
## [10] dir.expiry_1.17.0    png_0.1-8            vctrs_0.6.5
## [13] pkgconfig_2.0.3      fastmap_1.2.0        dbplyr_2.5.1
## [16] XVector_0.49.3       labeling_0.4.3       promises_1.4.0
## [19] rmarkdown_2.30       ggbeeswarm_0.7.2     tinytex_0.57
## [22] purrr_1.1.0          bit_4.6.0            xfun_0.53
## [25] cachem_1.1.0         beachmat_2.25.5      jsonlite_2.0.0
## [28] blob_1.2.4           later_1.4.4          DelayedArray_0.35.4
## [31] BiocParallel_1.43.4  irlba_2.3.5.1        parallel_4.5.1
## [34] R6_2.6.1             bslib_0.9.0          RColorBrewer_1.1-3
## [37] limma_3.65.7         jquerylib_0.1.4      Rcpp_1.1.0
## [40] bookdown_0.45        knitr_1.50           splines_4.5.1
## [43] httpuv_1.6.16        Matrix_1.7-4         tidyselect_1.2.1
## [46] abind_1.4-8          yaml_2.3.10          viridis_0.6.5
## [49] codetools_0.2-20     curl_7.0.0           lattice_0.22-7
## [52] tibble_3.3.0         withr_3.0.2          S7_0.2.0
## [55] evaluate_1.0.5       BiocFileCache_2.99.6 pillar_1.11.1
## [58] BiocManager_1.30.26  filelock_1.0.3       rprojroot_2.1.1
## [61] scales_1.4.0         xtable_1.8-4         glue_1.8.0
## [64] pheatmap_1.0.13      tools_4.5.1          BiocNeighbors_2.3.1
## [67] ScaledMatrix_1.17.0  cowplot_1.2.0        grid_4.5.1
## [70] nlme_3.1-168         beeswarm_0.4.0       BiocSingular_1.25.1
## [73] vipor_0.4.7          cli_3.6.5            rsvd_1.0.5
## [76] rappdirs_0.3.3       S4Arrays_1.9.2       viridisLite_0.4.2
## [79] dplyr_1.1.4          gtable_0.3.6         sass_0.4.10
## [82] digest_0.6.37        SparseArray_1.9.1    ggrepel_0.9.6
## [85] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
## [88] lifecycle_1.0.4      here_1.0.2           statmod_1.5.1
## [91] mime_0.13            bit64_4.6.0-1
```
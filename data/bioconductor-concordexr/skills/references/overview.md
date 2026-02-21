# Overview of concordexR

Lambda Moses, Kayla Jackson

#### Oct 29, 2025

The goal of concordexR is to identify spatial homogeneous regions (SHRs) as defined in the recent manuscrpt[“Identification of spatial homogenous regions in tissues with concordex”](https://doi.org/10.1101/2023.06.28.546949). Briefly, SHRs are are domains that are homogeneous with respect to cell type composition. concordex relies on the the k-nearest-neighbor (kNN) graph to representing similarities between cells and uses common clustering algorithms to identify SHRs.

## 0.1 Installation

This package is under active development will be available in the Bioconductor version 3.20 release.

Until then, please install the package from Github or from the Bioconductor devel branch.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")

#BiocManager::install("concordexR", version="devel")
devtools::install_github("pachterlab/concordexR")
```

## 0.2 Example of main functionality

This is a basic example which shows you how to solve a common problem:

```
library(concordexR)
library(SFEData)

sfe <- McKellarMuscleData("small")
#> see ?SFEData and browseVignettes('SFEData') for documentation
#> loading from cache
#> require("SpatialFeatureExperiment")
```

```
res <- calculateConcordex(sfe, labels=colData(sfe)[["in_tissue"]])
```

## 0.3 SessionInfo

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] SpatialFeatureExperiment_1.12.0 SFEData_1.11.0
#>  [3] patchwork_1.3.2                 scater_1.38.0
#>  [5] ggplot2_4.0.0                   scuttle_1.20.0
#>  [7] bluster_1.20.0                  BiocNeighbors_2.4.0
#>  [9] TENxPBMCData_1.27.0             HDF5Array_1.38.0
#> [11] h5mread_1.2.0                   rhdf5_2.54.0
#> [13] DelayedArray_0.36.0             SparseArray_1.10.0
#> [15] S4Arrays_1.10.0                 abind_1.4-8
#> [17] Matrix_1.7-4                    SingleCellExperiment_1.32.0
#> [19] SummarizedExperiment_1.40.0     Biobase_2.70.0
#> [21] GenomicRanges_1.62.0            Seqinfo_1.0.0
#> [23] IRanges_2.44.0                  S4Vectors_0.48.0
#> [25] BiocGenerics_0.56.0             generics_0.1.4
#> [27] MatrixGenerics_1.22.0           matrixStats_1.5.0
#> [29] concordexR_1.10.0               BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1             bitops_1.0-9
#>   [3] filelock_1.0.3            tibble_3.3.0
#>   [5] R.oo_1.27.1               lifecycle_1.0.4
#>   [7] httr2_1.2.1               sf_1.0-21
#>   [9] edgeR_4.8.0               lattice_0.22-7
#>  [11] MASS_7.3-65               magrittr_2.0.4
#>  [13] limma_3.66.0              sass_0.4.10
#>  [15] rmarkdown_2.30            jquerylib_0.1.4
#>  [17] yaml_2.3.10               sp_2.2-0
#>  [19] cowplot_1.2.0             DBI_1.2.3
#>  [21] RColorBrewer_1.1-3        multcomp_1.4-29
#>  [23] spatialreg_1.4-2          purrr_1.1.0
#>  [25] R.utils_2.13.0            RCurl_1.98-1.17
#>  [27] TH.data_1.1-4             sandwich_3.1-1
#>  [29] rappdirs_0.3.3            ggrepel_0.9.6
#>  [31] irlba_2.3.5.1             terra_1.8-70
#>  [33] units_1.0-0               dqrng_0.4.1
#>  [35] DelayedMatrixStats_1.32.0 codetools_0.2-20
#>  [37] DropletUtils_1.30.0       tidyselect_1.2.1
#>  [39] farver_2.1.2              ScaledMatrix_1.18.0
#>  [41] viridis_0.6.5             BiocFileCache_3.0.0
#>  [43] jsonlite_2.0.0            e1071_1.7-16
#>  [45] survival_3.8-3            tools_4.5.1
#>  [47] Rcpp_1.1.0                glue_1.8.0
#>  [49] gridExtra_2.3             xfun_0.53
#>  [51] EBImage_4.52.0            dplyr_1.1.4
#>  [53] withr_3.0.2               BiocManager_1.30.26
#>  [55] fastmap_1.2.0             boot_1.3-32
#>  [57] rhdf5filters_1.22.0       spData_2.3.4
#>  [59] digest_0.6.37             rsvd_1.0.5
#>  [61] R6_2.6.1                  wk_0.9.4
#>  [63] LearnBayes_2.15.1         jpeg_0.1-11
#>  [65] dichromat_2.0-0.1         RSQLite_2.4.3
#>  [67] R.methodsS3_1.8.2         data.table_1.17.8
#>  [69] FNN_1.1.4.1               class_7.3-23
#>  [71] httr_1.4.7                htmlwidgets_1.6.4
#>  [73] spdep_1.4-1               uwot_0.2.3
#>  [75] pkgconfig_2.0.3           gtable_0.3.6
#>  [77] blob_1.2.4                S7_0.2.0
#>  [79] XVector_0.50.0            htmltools_0.5.8.1
#>  [81] bookdown_0.45             fftwtools_0.9-11
#>  [83] scales_1.4.0              png_0.1-8
#>  [85] SpatialExperiment_1.20.0  knitr_1.50
#>  [87] rjson_0.2.23              nlme_3.1-168
#>  [89] coda_0.19-4.1             curl_7.0.0
#>  [91] zoo_1.8-14                proxy_0.4-27
#>  [93] cachem_1.1.0              BiocVersion_3.22.0
#>  [95] KernSmooth_2.23-26        parallel_4.5.1
#>  [97] vipor_0.4.7               AnnotationDbi_1.72.0
#>  [99] s2_1.1.9                  pillar_1.11.1
#> [101] grid_4.5.1                vctrs_0.6.5
#> [103] BiocSingular_1.26.0       dbplyr_2.5.1
#> [105] beachmat_2.26.0           sfheaders_0.4.4
#> [107] cluster_2.1.8.1           beeswarm_0.4.0
#> [109] evaluate_1.0.5            zeallot_0.2.0
#> [111] isoband_0.2.7             tinytex_0.57
#> [113] magick_2.9.0              mvtnorm_1.3-3
#> [115] cli_3.6.5                 locfit_1.5-9.12
#> [117] compiler_4.5.1            rlang_1.1.6
#> [119] crayon_1.5.3              labeling_0.4.3
#> [121] classInt_0.4-11           ggbeeswarm_0.7.2
#> [123] viridisLite_0.4.2         deldir_2.0-4
#> [125] BiocParallel_1.44.0       Biostrings_2.78.0
#> [127] tiff_0.1-12               ExperimentHub_3.0.0
#> [129] sparseMatrixStats_1.22.0  bit64_4.6.0-1
#> [131] Rhdf5lib_1.32.0           KEGGREST_1.50.0
#> [133] statmod_1.5.1             AnnotationHub_4.0.0
#> [135] igraph_2.2.1              memoise_2.0.1
#> [137] bslib_0.9.0               bit_4.6.0
```
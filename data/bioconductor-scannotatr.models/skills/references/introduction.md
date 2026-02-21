# Introduction to scAnnotatR.models

#### Johannes Griss

#### 2021-09-23

## Introduction

The **scAnnotatR.models** packages contains a set of pre-trained models to classify various (immune) cell types in human data to be used by the `scAnnotatR` package.

`scAnnotatR` is an R package for cell type prediction on single cell RNA-sequencing data. Currently, this package supports data in the forms of a `Seurat` object or a `SingleCellExperiment` object.

If you are interested in directly applying these models to your data, please refer to the vignettes of the `scAnnotatR` package.

## Installation

The `scAnnotatR.models` package is a `AnnotationHub` package. Normally, it is automatically loaded by the `scAnnotatR` package.

To load the package manually into your R session, please use the Bioconductor `AnnotationHub` package:

```
# use the AnnotationHub to load the scAnnotatR.models package
eh <- AnnotationHub::AnnotationHub()
#> snapshotDate(): 2021-09-10
# load the stored models
query <- AnnotationHub::query(eh, "scAnnotatR.models")
models <- query[["AH95906"]]
#> loading from cache
```

## Data Structure

The `models` object is a named list containing the cell type's name as key and the respective classifier as value:

```
# print the available cell types
names(models)
#>  [1] "B cells"           "Plasma cells"      "NK"
#>  [4] "CD16 NK"           "CD56 NK"           "T cells"
#>  [7] "CD4 T cells"       "CD8 T cells"       "Treg"
#> [10] "NKT"               "ILC"               "Monocytes"
#> [13] "CD14 Mono"         "CD16 Mono"         "DC"
#> [16] "pDC"               "Endothelial cells" "LEC"
#> [19] "VEC"               "Platelets"         "RBC"
#> [22] "Melanocyte"        "Schwann cells"     "Pericytes"
#> [25] "Mast cells"        "Keratinocytes"     "alpha"
#> [28] "beta"              "delta"             "gamma"
#> [31] "acinar"            "ductal"            "Fibroblasts"
```

Each classifier is an instance of the `scAnnotatR S4 class`. For example:

```
models[['B cells']]
#> Loading required package: scAnnotatR
#> Loading required package: Seurat
#> Attaching SeuratObject
#> Loading required package: SingleCellExperiment
#> Loading required package: SummarizedExperiment
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,
#>     lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,
#>     pmin.int, rank, rbind, rownames, sapply, setdiff, sort, table,
#>     tapply, union, unique, unsplit, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: GenomeInfoDb
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians
#>
#> Attaching package: 'SummarizedExperiment'
#> The following object is masked from 'package:SeuratObject':
#>
#>     Assays
#> The following object is masked from 'package:Seurat':
#>
#>     Assays
#> An object of class scAnnotatR for B cells
#> * 31 marker genes applied: CD38, CD79B, CD74, CD84, RASGRP2, TCF3, SP140, MEF2C, DERL3, CD37, CD79A, POU2AF1, MVK, CD83, BACH2, LY86, CD86, SDC1, CR2, LRMP, VPREB3, IL2RA, BLK, IRF8, FLI1, MS4A1, CD14, MZB1, PTEN, CD19, MME
#> * Predicting probability threshold: 0.5
#> * No parent model
```

## Included models

The `scAnnotatR` package comes with several pre-trained models to classify cell types.

```
# Load the scAnnotatR package to view the models
library(scAnnotatR)
```

The models are stored in the `default_models` object:

```
default_models <- load_models("default")
#> snapshotDate(): 2021-09-10
#> loading from cache
names(default_models)
#>  [1] "B cells"           "Plasma cells"      "NK"
#>  [4] "CD16 NK"           "CD56 NK"           "T cells"
#>  [7] "CD4 T cells"       "CD8 T cells"       "Treg"
#> [10] "NKT"               "ILC"               "Monocytes"
#> [13] "CD14 Mono"         "CD16 Mono"         "DC"
#> [16] "pDC"               "Endothelial cells" "LEC"
#> [19] "VEC"               "Platelets"         "RBC"
#> [22] "Melanocyte"        "Schwann cells"     "Pericytes"
#> [25] "Mast cells"        "Keratinocytes"     "alpha"
#> [28] "beta"              "delta"             "gamma"
#> [31] "acinar"            "ductal"            "Fibroblasts"
```

The `default_models` object is named a list of classifiers. Each classifier is an instance of the `scAnnotatR S4 class`. For example:

```
default_models[['B cells']]
#> An object of class scAnnotatR for B cells
#> * 31 marker genes applied: CD38, CD79B, CD74, CD84, RASGRP2, TCF3, SP140, MEF2C, DERL3, CD37, CD79A, POU2AF1, MVK, CD83, BACH2, LY86, CD86, SDC1, CR2, LRMP, VPREB3, IL2RA, BLK, IRF8, FLI1, MS4A1, CD14, MZB1, PTEN, CD19, MME
#> * Predicting probability threshold: 0.5
#> * No parent model
```

Please refer to the `scAnnotatR` package documentation for detailed information about how to use these classifiers.

## Session Info

```
sessionInfo()
#> R version 4.1.1 Patched (2021-09-10 r80880)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.5 LTS
#>
#> Matrix products: default
#> BLAS:   /home/shepherd/R-Installs/bin/R-4-1-branch/lib/libRblas.so
#> LAPACK: /home/shepherd/R-Installs/bin/R-4-1-branch/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] scAnnotatR_0.99.7           SingleCellExperiment_1.15.2
#>  [3] SummarizedExperiment_1.23.4 Biobase_2.53.0
#>  [5] GenomicRanges_1.45.0        GenomeInfoDb_1.29.8
#>  [7] IRanges_2.27.2              S4Vectors_0.31.3
#>  [9] BiocGenerics_0.39.2         MatrixGenerics_1.5.4
#> [11] matrixStats_0.61.0          SeuratObject_4.0.2
#> [13] Seurat_4.0.4
#>
#> loaded via a namespace (and not attached):
#>   [1] AnnotationHub_3.1.5           BiocFileCache_2.1.1
#>   [3] plyr_1.8.6                    igraph_1.2.6
#>   [5] lazyeval_0.2.2                splines_4.1.1
#>   [7] listenv_0.8.0                 scattermore_0.7
#>   [9] ggplot2_3.3.5                 digest_0.6.27
#>  [11] foreach_1.5.1                 htmltools_0.5.2
#>  [13] fansi_0.5.0                   magrittr_2.0.1
#>  [15] memoise_2.0.0                 tensor_1.5
#>  [17] cluster_2.1.2                 ROCR_1.0-11
#>  [19] recipes_0.1.16                globals_0.14.0
#>  [21] Biostrings_2.61.2             gower_0.2.2
#>  [23] spatstat.sparse_2.0-0         colorspace_2.0-2
#>  [25] blob_1.2.2                    rappdirs_0.3.3
#>  [27] ggrepel_0.9.1                 xfun_0.26
#>  [29] dplyr_1.0.7                   crayon_1.4.1
#>  [31] RCurl_1.98-1.5                jsonlite_1.7.2
#>  [33] spatstat.data_2.1-0           ape_5.5
#>  [35] survival_3.2-13               zoo_1.8-9
#>  [37] iterators_1.0.13              glue_1.4.2
#>  [39] polyclip_1.10-0               gtable_0.3.0
#>  [41] ipred_0.9-12                  zlibbioc_1.39.0
#>  [43] XVector_0.33.0                leiden_0.3.9
#>  [45] DelayedArray_0.19.3           kernlab_0.9-29
#>  [47] future.apply_1.8.1            abind_1.4-5
#>  [49] scales_1.1.1                  data.tree_1.0.0
#>  [51] DBI_1.1.1                     miniUI_0.1.1.1
#>  [53] Rcpp_1.0.7                    viridisLite_0.4.0
#>  [55] xtable_1.8-4                  spatstat.core_2.3-0
#>  [57] reticulate_1.22               proxy_0.4-26
#>  [59] bit_4.0.4                     lava_1.6.10
#>  [61] prodlim_2019.11.13            htmlwidgets_1.5.4
#>  [63] httr_1.4.2                    RColorBrewer_1.1-2
#>  [65] ellipsis_0.3.2                ica_1.0-2
#>  [67] pkgconfig_2.0.3               uwot_0.1.10
#>  [69] deldir_0.2-10                 nnet_7.3-16
#>  [71] sass_0.4.0                    dbplyr_2.1.1
#>  [73] utf8_1.2.2                    caret_6.0-88
#>  [75] tidyselect_1.1.1              rlang_0.4.11
#>  [77] reshape2_1.4.4                later_1.3.0
#>  [79] AnnotationDbi_1.55.1          munsell_0.5.0
#>  [81] BiocVersion_3.14.0            tools_4.1.1
#>  [83] cachem_1.0.6                  generics_0.1.0
#>  [85] RSQLite_2.2.8                 ggridges_0.5.3
#>  [87] evaluate_0.14                 stringr_1.4.0
#>  [89] fastmap_1.1.0                 goftest_1.2-2
#>  [91] yaml_2.2.1                    ModelMetrics_1.2.2.2
#>  [93] knitr_1.34                    bit64_4.0.5
#>  [95] fitdistrplus_1.1-5            purrr_0.3.4
#>  [97] RANN_2.6.1                    KEGGREST_1.33.0
#>  [99] pbapply_1.5-0                 future_1.22.1
#> [101] nlme_3.1-153                  mime_0.11
#> [103] compiler_4.1.1                plotly_4.9.4.1
#> [105] filelock_1.0.2                curl_4.3.2
#> [107] png_0.1-7                     interactiveDisplayBase_1.31.2
#> [109] e1071_1.7-9                   spatstat.utils_2.2-0
#> [111] tibble_3.1.4                  bslib_0.3.0
#> [113] stringi_1.7.4                 lattice_0.20-45
#> [115] Matrix_1.3-4                  vctrs_0.3.8
#> [117] pillar_1.6.2                  lifecycle_1.0.0
#> [119] BiocManager_1.30.16           spatstat.geom_2.2-2
#> [121] lmtest_0.9-38                 jquerylib_0.1.4
#> [123] RcppAnnoy_0.0.19              data.table_1.14.0
#> [125] cowplot_1.1.1                 bitops_1.0-7
#> [127] irlba_2.3.3                   httpuv_1.6.3
#> [129] patchwork_1.1.1               R6_2.5.1
#> [131] promises_1.2.0.1              gridExtra_2.3
#> [133] KernSmooth_2.23-20            parallelly_1.28.1
#> [135] codetools_0.2-18              MASS_7.3-54
#> [137] assertthat_0.2.1              withr_2.4.2
#> [139] sctransform_0.3.2             GenomeInfoDbData_1.2.6
#> [141] mgcv_1.8-37                   parallel_4.1.1
#> [143] grid_4.1.1                    rpart_4.1-15
#> [145] timeDate_3043.102             tidyr_1.1.3
#> [147] class_7.3-19                  rmarkdown_2.11
#> [149] Rtsne_0.15                    pROC_1.18.0
#> [151] shiny_1.7.0                   lubridate_1.7.10
```
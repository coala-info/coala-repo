# Introduction to stJoincount

Jiarong Song1\*

1Department of Translational genomics, University of Southern California

\*songjiar@usc.edu

#### 30 October 2025

# Contents

* [Introduction](#introduction)
* [Installation](#installation)
* [Preprocessing](#preprocessing)
* [Raster processing](#raster-processing)
* [Visualization](#visualization)
* [Join count analysis](#join-count-analysis)

```
library(stJoincount)
library(pheatmap)
library(ggplot2)
```

v1.1.1

stJoincount: Quantification tool for spatial correlation between clusters in spatial transcriptomics preprocessed data using join count statistic approach.

# Introduction

Spatial dependency is the relationship between location and attribute similarity. The measure reflects whether an attribute of a variable observed at one location is independent of values observed at neighboring locations. Positive spatial dependency exists when neighboring attributes are more similar than what could be explained by chance. Likewise, a negative spatial dependency is reflected by a dissimilarity of neighboring attributes. Join count analysis allows for quantification of the spatial dependencies of nominal data in an arrangement of spatially adjacent polygons.

This tool requires data produced with the 10X Genomics Visium Spatial Gene Expression platform with customized clusters. The purpose of this R package is to perform join count analysis for spatial correlation between clusters.

# Installation

Users can install `stJoincount` with:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }
BiocManager::install("stJoincount")
```

Examples of how to run this tool are below:

# Preprocessing

In this vignette, we are going to use an human breast cancer spatial transcriptomics sample.

```
fpath <- system.file("extdata", "dataframe.rda", package="stJoincount")
load(fpath)
head(humanBC)
#>                    imagecol imagerow Cluster
#> AATTGCAGCAATCGAC-1 431.2129 476.8069       4
#> ACCAGGAGTGTGATCT-1 273.0446 117.8218       9
#> ACCTCCGCCCTCGCTG-1 448.2178 423.9109       7
#> AGGTGTATCGCCATGA-1 144.2822 317.5000       1
#> ATAGTTCCACCCACTC-1 431.5099 323.9109       7
#> CCGTATTAGCGCAGTT-1 462.1535 200.4950       2
```

Within the ‘extdata’ user can find a dataframe “humanBC.rda”. This example data is a `data.frame` that comes from a `Seurat` object of a human breast cancer sample. It contains the following information that is essential to this algorithm - barcode (index), cluster (they could either be categorical or numerical labels), central pixel location (imagerow and imagecol). This dataframe is simplified after combining metadata with spatial coordinates.
The index contains barcodes, and at least three other columns that have these information are required and the column names should be the same as following:
`imagerow`: The row pixel coordinate of the center of the spot
`imagecol`: The column pixel coordinate of the center of the spot
`Cluster`: The label that corresponding to this barcode

The following codes demonstrate how to generate the described `data.frame` from `Seurat`/`spatialExperiment` Objects.

An example data preparation from Seurat:

```
fpath <- system.file("extdata", "SeuratBC.rda", package="stJoincount")
load(fpath)
df <- dataPrepFromSeurat(seuratBC, "label")
```

An example data preparation from SpatialExperiment object:

```
fpath <- system.file("extdata", "SpeBC.rda", package="stJoincount")
load(fpath)
df2 <- dataPrepFromSpE(SpeObjBC, "label")
```

# Raster processing

This tool first converts a labeled spatial tissue map into a raster object, in which each spatial feature is represented by a pixel coded by label assignment. This process includes automatic calculation of optimal raster resolution and extent for the sample.

```
resolutionList <- resolutionCalc(humanBC)
resolutionList
#> [1] 152.89604  64.20792
```

```
mosaicIntegration <- rasterizeEachCluster(humanBC)
#> No optimal number found, using n = 110 instead.
#> In this case, there may be minor deviations in the subsequent calculation process.
#>         The results are for reference only
```

# Visualization

After the labeled spatial sample being converted, the raster map can be visualized by:

```
mosaicIntPlot(humanBC, mosaicIntegration)
```

![](data:image/png;base64...)

# Join count analysis

A neighbors list is then created from the rasterized sample, in which adjacent and diagonal neighbors for each pixel are identified. After adding binary spatial weights to the neighbors list, a multi-categorical join count analysis is performed to tabulate “joins” between all possible combinations of label pairs. The function returns the observed join counts, the expected count under conditions of spatial randomness, and the variance calculated under non-free sampling.

```
joincount.result <- joincountAnalysis(mosaicIntegration)
#> Warning in subset.nb(nbList, !(seq_len(length(nbList)) %in% emptyPos)):
#> subsetting caused increase in subgraph count
```

The z-score is then calculated as the difference between observed and expected counts, divided by the square root of the variance. A heatmap of z-scores represents the result from the join count analysis for all possible label pairs.

```
matrix <- zscoreMatrix(humanBC, joincount.result)
zscorePlot(matrix)
```

![](data:image/png;base64...)

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] ggplot2_4.0.0      pheatmap_1.0.13    stJoincount_1.12.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.22            splines_4.5.1
#>   [3] later_1.4.4                 tibble_3.3.0
#>   [5] polyclip_1.10-7             fastDummies_1.7.5
#>   [7] lifecycle_1.0.4             sf_1.0-21
#>   [9] globals_0.18.0              lattice_0.22-7
#>  [11] MASS_7.3-65                 magrittr_2.0.4
#>  [13] plotly_4.11.0               sass_0.4.10
#>  [15] rmarkdown_2.30              jquerylib_0.1.4
#>  [17] yaml_2.3.10                 httpuv_1.6.16
#>  [19] otel_0.2.0                  Seurat_5.3.1
#>  [21] sctransform_0.4.2           spam_2.11-1
#>  [23] sp_2.2-0                    spatstat.sparse_3.1-0
#>  [25] reticulate_1.44.0           cowplot_1.2.0
#>  [27] pbapply_1.7-4               DBI_1.2.3
#>  [29] RColorBrewer_1.1-3          multcomp_1.4-29
#>  [31] abind_1.4-8                 spatialreg_1.4-2
#>  [33] Rtsne_0.17                  GenomicRanges_1.62.0
#>  [35] purrr_1.1.0                 BiocGenerics_0.56.0
#>  [37] TH.data_1.1-4               sandwich_3.1-1
#>  [39] IRanges_2.44.0              S4Vectors_0.48.0
#>  [41] ggrepel_0.9.6               irlba_2.3.5.1
#>  [43] listenv_0.9.1               spatstat.utils_3.2-0
#>  [45] terra_1.8-70                units_1.0-0
#>  [47] goftest_1.2-3               RSpectra_0.16-2
#>  [49] spatstat.random_3.4-2       fitdistrplus_1.2-4
#>  [51] parallelly_1.45.1           codetools_0.2-20
#>  [53] DelayedArray_0.36.0         tidyselect_1.2.1
#>  [55] raster_3.6-32               farver_2.1.2
#>  [57] matrixStats_1.5.0           stats4_4.5.1
#>  [59] spatstat.explore_3.5-3      Seqinfo_1.0.0
#>  [61] jsonlite_2.0.0              e1071_1.7-16
#>  [63] progressr_0.17.0            ggridges_0.5.7
#>  [65] survival_3.8-3              tools_4.5.1
#>  [67] ica_1.0-3                   Rcpp_1.1.0
#>  [69] glue_1.8.0                  gridExtra_2.3
#>  [71] SparseArray_1.10.0          xfun_0.53
#>  [73] MatrixGenerics_1.22.0       dplyr_1.1.4
#>  [75] withr_3.0.2                 BiocManager_1.30.26
#>  [77] fastmap_1.2.0               boot_1.3-32
#>  [79] spData_2.3.4                digest_0.6.37
#>  [81] R6_2.6.1                    mime_0.13
#>  [83] wk_0.9.4                    LearnBayes_2.15.1
#>  [85] scattermore_1.2             tensor_1.5.1
#>  [87] dichromat_2.0-0.1           spatstat.data_3.1-9
#>  [89] tidyr_1.3.1                 generics_0.1.4
#>  [91] data.table_1.17.8           class_7.3-23
#>  [93] httr_1.4.7                  htmlwidgets_1.6.4
#>  [95] S4Arrays_1.10.0             spdep_1.4-1
#>  [97] uwot_0.2.3                  pkgconfig_2.0.3
#>  [99] gtable_0.3.6                lmtest_0.9-40
#> [101] S7_0.2.0                    SingleCellExperiment_1.32.0
#> [103] XVector_0.50.0              htmltools_0.5.8.1
#> [105] dotCall64_1.2               bookdown_0.45
#> [107] SeuratObject_5.2.0          scales_1.4.0
#> [109] Biobase_2.70.0              png_0.1-8
#> [111] SpatialExperiment_1.20.0    spatstat.univar_3.1-4
#> [113] knitr_1.50                  reshape2_1.4.4
#> [115] rjson_0.2.23                coda_0.19-4.1
#> [117] nlme_3.1-168                proxy_0.4-27
#> [119] cachem_1.1.0                zoo_1.8-14
#> [121] stringr_1.5.2               KernSmooth_2.23-26
#> [123] parallel_4.5.1              miniUI_0.1.2
#> [125] s2_1.1.9                    pillar_1.11.1
#> [127] grid_4.5.1                  vctrs_0.6.5
#> [129] RANN_2.6.2                  promises_1.4.0
#> [131] xtable_1.8-4                cluster_2.1.8.1
#> [133] evaluate_1.0.5              tinytex_0.57
#> [135] magick_2.9.0                mvtnorm_1.3-3
#> [137] cli_3.6.5                   compiler_4.5.1
#> [139] rlang_1.1.6                 future.apply_1.20.0
#> [141] labeling_0.4.3              classInt_0.4-11
#> [143] plyr_1.8.9                  stringi_1.8.7
#> [145] viridisLite_0.4.2           deldir_2.0-4
#> [147] lazyeval_0.2.2              spatstat.geom_3.6-0
#> [149] Matrix_1.7-4                RcppHNSW_0.6.0
#> [151] patchwork_1.3.2             future_1.67.0
#> [153] shiny_1.11.1                SummarizedExperiment_1.40.0
#> [155] ROCR_1.0-11                 igraph_2.2.1
#> [157] bslib_0.9.0
```
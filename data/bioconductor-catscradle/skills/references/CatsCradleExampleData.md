# CatsCradle Example Data

#### Anna Laddach and Michael Shapiro

#### 2025-12-25

*[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)*

![](data:image/png;base64...)

## CatsCradle Example Data

CatsCradle has a slightly unusual way of delivering example data. In order to save space we have tried to minimise the number and size of the .rda data. We have limited these to objects which are necessary to compute other objects (e.g., certain Seurat objects), objects which are necessary to the functioning of the package (e.g., human and mouse ligand receptor networks), and objects which take a long time to compute (e.g., ligandReceptorResults). These package variables are documented in the usual way and are loaded when invoked with data(variable name).

Other variables are computed from these as needed. The function which computes these additional objects also stores them internally for quick retrieval when they are subsequently requested. The retrieval function must be created before it can be used. It only needs to be created once in each session.

On the first invocation this computes STranspose:

```
library(CatsCradle,quietly=TRUE)
library(tictoc)
getExample = make.getExample()
tic()
STranspose = getExample('STranspose')
toc()
#> 9.608 sec elapsed
```

On subsequent invocations it retrieves it:

```
tic()
STranspose = getExample('STranspose')
toc()
#> 0.002 sec elapsed
```

getExample() also retrieves package variables.

```
smallXenium = getExample('smallXenium')
```

getExample() also supports the option toy, which is FALSE by default. Setting toy=TRUE will result in the initial Seurat objects being subset to smaller copies of themselves and all further computations being performed using these smaller objects. This is done to speed up the running of the code examples.

```
exSeuratObj = getExample('exSeuratObj')
toySeurat = getExample('exSeuratObj',toy=TRUE)
dim(exSeuratObj)
#> [1] 2000  540
dim(toySeurat)
#> [1] 100 270
toyXenium = getExample('smallXenium',toy=TRUE)
#> Warning: Not validating Centroids objects
#> Not validating Centroids objects
#> Warning: Not validating FOV objects
#> Not validating FOV objects
#> Not validating FOV objects
#> Warning: Not validating Seurat objects
dim(smallXenium)
#> [1]  248 4261
dim(toyXenium)
#> [1]  248 1001
```

A complete list of the example objects available via the function exampleObjects(). Here we document some of the more prominent of these.

* **exSeuratObj** - A Seurat object of cells. It includes a UMAP of the cells and annotated clustering into cell types. This is a package variable.
* **STranpose** - A Seurat object of genes. This is created from S by transposeObject().
* **S\_sce** - S as a SingleCellExperiment
* **STranspose\_sce** - STranspose as a SingleCellExperiment
* **NN** - A nearest neighbours graph from STranspose. This is a data frame with columns nodeA, nodeB, and weight, where nodeA and nodeB are genes.
* **smallXenium** - A spatial Seurat object subset from the Xenium object used in <https://satijalab.org/seurat/articles/seurat5_spatial_vignette_2>. This is a package variable.
* **clusters** - Annotated cell type clustering for the cells of smallXenium.
* **centroids** - The centroids of the cells of smallXenium
* **delaunayNeighbours** - A data frame giving neighbour-neighbour relations for the cells of smallXenium as estimated by Delaunay triangulation with columns nodeA and nodeB.
* **extendedNeighours** - A data frame giving extended neighbour-neighbour relations for the cells of smallXenium. Here cells are “neighbours” if they are within four edges of each other in the Delaunay triangulation.
* **euclideanNeighbours** - Neighbour-neighbour relations between the cells of smallXenium based on the Euclidean distance of their centroids.
* **NBHDByCTMatrix** - For each neighbourhood, we count the number of cells it contains of each cell type. Neighbourhoods “express” cell types.
* **NBHDByCTSeurat** - A Seurat object whose underlying counts are NBHDByCTMatrix.
* **cellTypesPerCellTypeMatrix** - A matrix which reports on the Delaunay neighbourhoods. For each cell type, it examines the neighbourhoods around cells of that type and reports their average composition as to the cell types they contain.
* **cellTypesPerCellTypePValues** This gives the statistical significance for the enrichment of cell types in the neighbourhoods of each cell type, computed using randomiseBy = ‘cells’.

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#> [1] tictoc_1.2.1       pheatmap_1.0.13    ggplot2_4.0.1      Seurat_5.4.0
#> [5] SeuratObject_5.3.0 sp_2.2-0           future_1.68.0      CatsCradle_1.4.2
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.22            splines_4.5.2
#>   [3] later_1.4.4                 bitops_1.0-9
#>   [5] tibble_3.3.0                polyclip_1.10-7
#>   [7] fastDummies_1.7.5           lifecycle_1.0.4
#>   [9] globals_0.18.0              lattice_0.22-7
#>  [11] MASS_7.3-65                 magrittr_2.0.4
#>  [13] plotly_4.11.0               sass_0.4.10
#>  [15] rmarkdown_2.30              jquerylib_0.1.4
#>  [17] yaml_2.3.12                 httpuv_1.6.16
#>  [19] otel_0.2.0                  sctransform_0.4.2
#>  [21] spam_2.11-1                 spatstat.sparse_3.1-0
#>  [23] reticulate_1.44.1           cowplot_1.2.0
#>  [25] pbapply_1.7-4               RColorBrewer_1.1-3
#>  [27] abind_1.4-8                 Rtsne_0.17
#>  [29] GenomicRanges_1.62.1        purrr_1.2.0
#>  [31] BiocGenerics_0.56.0         msigdbr_25.1.1
#>  [33] RCurl_1.98-1.17             pracma_2.4.6
#>  [35] IRanges_2.44.0              S4Vectors_0.48.0
#>  [37] data.tree_1.2.0             ggrepel_0.9.6
#>  [39] irlba_2.3.5.1               listenv_0.10.0
#>  [41] spatstat.utils_3.2-0        BiocStyle_2.38.0
#>  [43] goftest_1.2-3               RSpectra_0.16-2
#>  [45] spatstat.random_3.4-3       fitdistrplus_1.2-4
#>  [47] parallelly_1.46.0           codetools_0.2-20
#>  [49] DelayedArray_0.36.0         tidyselect_1.2.1
#>  [51] farver_2.1.2                matrixStats_1.5.0
#>  [53] stats4_4.5.2                spatstat.explore_3.6-0
#>  [55] Seqinfo_1.0.0               jsonlite_2.0.0
#>  [57] progressr_0.18.0            ggridges_0.5.7
#>  [59] survival_3.8-3              tools_4.5.2
#>  [61] ica_1.0-3                   Rcpp_1.1.0
#>  [63] glue_1.8.0                  gridExtra_2.3
#>  [65] SparseArray_1.10.8          xfun_0.55
#>  [67] MatrixGenerics_1.22.0       EBImage_4.52.0
#>  [69] dplyr_1.1.4                 withr_3.0.2
#>  [71] BiocManager_1.30.27         fastmap_1.2.0
#>  [73] digest_0.6.39               R6_2.6.1
#>  [75] mime_0.13                   networkD3_0.4.1
#>  [77] scattermore_1.2             tensor_1.5.1
#>  [79] jpeg_0.1-11                 dichromat_2.0-0.1
#>  [81] spatstat.data_3.1-9         tidyr_1.3.2
#>  [83] generics_0.1.4              data.table_1.18.0
#>  [85] httr_1.4.7                  htmlwidgets_1.6.4
#>  [87] S4Arrays_1.10.1             uwot_0.2.4
#>  [89] pkgconfig_2.0.3             gtable_0.3.6
#>  [91] rdist_0.0.5                 lmtest_0.9-40
#>  [93] S7_0.2.1                    SingleCellExperiment_1.32.0
#>  [95] XVector_0.50.0              htmltools_0.5.9
#>  [97] dotCall64_1.2               fftwtools_0.9-11
#>  [99] zigg_0.0.2                  scales_1.4.0
#> [101] Biobase_2.70.0              png_0.1-8
#> [103] SpatialExperiment_1.20.0    spatstat.univar_3.1-5
#> [105] geometry_0.5.2              knitr_1.51
#> [107] reshape2_1.4.5              rjson_0.2.23
#> [109] nlme_3.1-168                magic_1.6-1
#> [111] curl_7.0.0                  cachem_1.1.0
#> [113] zoo_1.8-15                  stringr_1.6.0
#> [115] KernSmooth_2.23-26          parallel_4.5.2
#> [117] miniUI_0.1.2                pillar_1.11.1
#> [119] grid_4.5.2                  vctrs_0.6.5
#> [121] RANN_2.6.2                  promises_1.5.0
#> [123] xtable_1.8-4                cluster_2.1.8.1
#> [125] evaluate_1.0.5              magick_2.9.0
#> [127] cli_3.6.5                   locfit_1.5-9.12
#> [129] compiler_4.5.2              crayon_1.5.3
#> [131] rlang_1.1.6                 future.apply_1.20.1
#> [133] labeling_0.4.3              plyr_1.8.9
#> [135] stringi_1.8.7               viridisLite_0.4.2
#> [137] deldir_2.0-4                assertthat_0.2.1
#> [139] babelgene_22.9              lazyeval_0.2.2
#> [141] tiff_0.1-12                 spatstat.geom_3.6-1
#> [143] Matrix_1.7-4                RcppHNSW_0.6.0
#> [145] patchwork_1.3.2             shiny_1.12.1
#> [147] SummarizedExperiment_1.40.0 ROCR_1.0-11
#> [149] Rfast_2.1.5.2               igraph_2.2.1
#> [151] RcppParallel_5.1.11-1       bslib_0.9.0
```
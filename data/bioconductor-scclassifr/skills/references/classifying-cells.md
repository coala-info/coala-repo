# Introduction to scClassifR

#### Vy Nguyen

#### 2021-05-19

## Introduction

scClassifR is an R package for cell type prediction on single cell RNA-sequencing data. Currently, this package supports data in the forms of a Seurat object or a SingleCellExperiment object.

More information about Seurat object can be found here: <https://satijalab.org/seurat/> More information about SingleCellExperiment object can be found here: <https://osca.bioconductor.org/>

scClassifR provides 2 main features:

* A set of pretrained and robust classifiers for basic immune cells. See the section below.
* A user-friendly and fully customizable framework to train new classification models. These models can then be easily saved and reused in the future. Details usage of this framework is explained in vignettes 2 and 3.

## Installation

The `scClassifR` package can be directly installed from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")

if (!require(scClassifR))
BiocManager::install("scClassifR")
```

For more information, see <https://bioconductor.org/install/>.

## Included models

The `scClassifR` package comes with several pre-trained models to classify cell types.

```
# load scClassifR into working space
library(scClassifR)
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
#> Loading required package: parallel
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:parallel':
#>
#>     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
#>     clusterExport, clusterMap, parApply, parCapply, parLapply,
#>     parLapplyLB, parRapply, parSapply, parSapplyLB
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
```

The models are stored in the `default_models` object:

```
data("default_models")
names(default_models)
#>  [1] "B cells"      "NK"           "Plasma cells" "T cells"      "CD4 T cells"
#>  [6] "CD8 T cells"  "Monocytes"    "DC"           "alpha"        "beta"
#> [11] "delta"        "gamma"        "ductal"       "acinar"
```

The `default_models` object is named a list of classifiers. Each classifier is an instance of the `scClassifR S4 class`. For example:

```
default_models[['B cells']]
#> An object of class scClassifR for B cells
#> *  31 features applied:  CD19, MS4A1, SDC1, CD79A, CD79B, CD38, CD37, CD83, CR2, MVK, MME, IL2RA, PTEN, POU2AF1, MEF2C, IRF8, TCF3, BACH2, MZB1, VPREB3, RASGRP2, CD86, CD84, LY86, CD74, SP140, BLK, FLI1, CD14, DERL3, LRMP
#> * Predicting probability threshold: 0.5
#> * No parent model
```

## Basic pipeline to identify cell types in a scRNA-seq dataset using scClassifR

### Preparing the data

To identify cell types available in a dataset, we need to load the dataset as [Seurat](https://satijalab.org/seurat/) or [SingleCellExperiment](https://osca.bioconductor.org/) object.

For this vignette, we use a small sample datasets that is available as a `Seurat` object as part of the package.

```
# load the example dataset
data("tirosh_mel80_example")
tirosh_mel80_example
#> An object of class Seurat
#> 78 features across 480 samples within 1 assay
#> Active assay: RNA (78 features, 34 variable features)
#>  1 dimensional reduction calculated: umap
```

The example dataset already contains the clustering results as part of the metadata. This is **not** necessary for the classification process.

```
head(tirosh_mel80_example[[]])
#>                               orig.ident nCount_RNA nFeature_RNA percent.mt
#> Cy80_II_CD45_B07_S883_comb SeuratProject   42.46011            8          0
#> Cy80_II_CD45_C09_S897_comb SeuratProject   74.35907           14          0
#> Cy80_II_CD45_H07_S955_comb SeuratProject   42.45392            8          0
#> Cy80_II_CD45_H09_S957_comb SeuratProject   63.47043           12          0
#> Cy80_II_CD45_B11_S887_comb SeuratProject   47.26798            9          0
#> Cy80_II_CD45_D11_S911_comb SeuratProject   69.12167           13          0
#>                            RNA_snn_res.0.8 seurat_clusters RNA_snn_res.0.5
#> Cy80_II_CD45_B07_S883_comb               4               4               2
#> Cy80_II_CD45_C09_S897_comb               4               4               2
#> Cy80_II_CD45_H07_S955_comb               4               4               2
#> Cy80_II_CD45_H09_S957_comb               4               4               2
#> Cy80_II_CD45_B11_S887_comb               4               4               2
#> Cy80_II_CD45_D11_S911_comb               1               1               1
```

### Cell classification

To launch cell type identification, we simply call the `classify_cells` function. A detailed description of all parameters can be found through the function’s help page `?classify_cells`.

```
seurat.obj <- classify_cells(classify_obj = tirosh_mel80_example,
cell_types = 'all', path_to_models = 'default')
```

#### Parameters

* The option **cell\_types = ‘all’** tells the function to use all available cell classification models. Alternatively, we can limit the identifiable cell types:
  + by specifying: `cell_types = c('B cells', 'T cells')`
  + or by indicating the applicable classifier using the **classifiers** option: `classifiers = c(default_models[['B cells']], default_models[['T cells']])`
* The option **path\_to\_models = ‘default’** is to automatically use the package-integrated pretrained models (without loading the models into the current working space). This option can be used to load a local database instead. For more details see the vignettes on training your own classifiers.

## Result interpretation

The `classify_cells` function returns the input object but with additional columns in the metadata table.

```
# display the additional metadata fields
seurat.obj[[]][c(20:30), c(8:21)]
#>                              B_cells_p B_cells_class      NK_p NK_class
#> Cy80_II_CD45_D04_S904_comb 0.007983681            no 0.3836233       no
#> Cy80_II_CD45_C12_S900_comb 0.007668953            no 0.5054545      yes
#> Cy80_II_CD45_C02_S890_comb 0.026575995            no 0.3231831       no
#> Cy80_II_CD45_F01_S925_comb 0.029493459            no 0.3658388       no
#> Cy80_II_CD45_G10_S946_comb 0.024490415            no 0.3791378       no
#> Cy80_II_CD45_F08_S932_comb 0.010955256            no 0.4696540       no
#> Cy80_II_CD45_E01_S913_comb 0.008845469            no 0.3526443       no
#> Cy80_II_CD45_H11_S959_comb 0.009423056            no 0.4397574       no
#> Cy80_II_CD45_A01_S865_comb 0.045843008            no 0.3768446       no
#> Cy80_II_CD45_E11_S923_comb 0.014868335            no 0.3850901       no
#> Cy80_II_CD45_E08_S920_comb 0.012824167            no 0.3892861       no
#>                            Plasma_cells_p Plasma_cells_class  T_cells_p
#> Cy80_II_CD45_D04_S904_comb             NA               <NA> 0.10912289
#> Cy80_II_CD45_C12_S900_comb             NA               <NA> 0.10356344
#> Cy80_II_CD45_C02_S890_comb             NA               <NA> 0.09935477
#> Cy80_II_CD45_F01_S925_comb             NA               <NA> 0.52573389
#> Cy80_II_CD45_G10_S946_comb             NA               <NA> 0.19678523
#> Cy80_II_CD45_F08_S932_comb             NA               <NA> 0.10993410
#> Cy80_II_CD45_E01_S913_comb             NA               <NA> 0.07988881
#> Cy80_II_CD45_H11_S959_comb             NA               <NA> 0.11294201
#> Cy80_II_CD45_A01_S865_comb             NA               <NA> 0.01969278
#> Cy80_II_CD45_E11_S923_comb             NA               <NA> 0.11678435
#> Cy80_II_CD45_E08_S920_comb             NA               <NA> 0.24587206
#>                            T_cells_class CD4_T_cells_p CD4_T_cells_class
#> Cy80_II_CD45_D04_S904_comb            no            NA              <NA>
#> Cy80_II_CD45_C12_S900_comb            no            NA              <NA>
#> Cy80_II_CD45_C02_S890_comb            no            NA              <NA>
#> Cy80_II_CD45_F01_S925_comb           yes     0.4909765                no
#> Cy80_II_CD45_G10_S946_comb            no            NA              <NA>
#> Cy80_II_CD45_F08_S932_comb            no            NA              <NA>
#> Cy80_II_CD45_E01_S913_comb            no            NA              <NA>
#> Cy80_II_CD45_H11_S959_comb            no            NA              <NA>
#> Cy80_II_CD45_A01_S865_comb            no            NA              <NA>
#> Cy80_II_CD45_E11_S923_comb            no            NA              <NA>
#> Cy80_II_CD45_E08_S920_comb            no            NA              <NA>
#>                            CD8_T_cells_p CD8_T_cells_class Monocytes_p
#> Cy80_II_CD45_D04_S904_comb            NA              <NA>    0.215263
#> Cy80_II_CD45_C12_S900_comb            NA              <NA>    0.215263
#> Cy80_II_CD45_C02_S890_comb            NA              <NA>    0.215263
#> Cy80_II_CD45_F01_S925_comb     0.3240697                no    0.215263
#> Cy80_II_CD45_G10_S946_comb            NA              <NA>    0.215263
#> Cy80_II_CD45_F08_S932_comb            NA              <NA>    0.215263
#> Cy80_II_CD45_E01_S913_comb            NA              <NA>    0.215263
#> Cy80_II_CD45_H11_S959_comb            NA              <NA>    0.215263
#> Cy80_II_CD45_A01_S865_comb            NA              <NA>    0.215263
#> Cy80_II_CD45_E11_S923_comb            NA              <NA>    0.215263
#> Cy80_II_CD45_E08_S920_comb            NA              <NA>    0.215263
#>                            Monocytes_class
#> Cy80_II_CD45_D04_S904_comb              no
#> Cy80_II_CD45_C12_S900_comb              no
#> Cy80_II_CD45_C02_S890_comb              no
#> Cy80_II_CD45_F01_S925_comb              no
#> Cy80_II_CD45_G10_S946_comb              no
#> Cy80_II_CD45_F08_S932_comb              no
#> Cy80_II_CD45_E01_S913_comb              no
#> Cy80_II_CD45_H11_S959_comb              no
#> Cy80_II_CD45_A01_S865_comb              no
#> Cy80_II_CD45_E11_S923_comb              no
#> Cy80_II_CD45_E08_S920_comb              no
```

New columns are:

* **predicted\_cell\_type**: The predicted cell type, also containing any ambiguous assignments. In these cases, the possible cell types are separated by a “/”
* **most\_probable\_cell\_type**: Present only if `simplified_result` was set to `TRUE`. Contains the most probably cell type ignoring any ambiguous assignments.
* columns with syntax `[celltype]_p`: probability of a cell to belong to a cell type. Unknown cell types are marked as NAs.

### Result visualization

The predicted cell types can now simply be visualized using the matching plotting functions. In this example, we use Seurat’s `DimPlot` function:

```
# Visualize the cell types
Seurat::DimPlot(seurat.obj, group.by = "most_probable_cell_type")
```

![](data:image/png;base64...)

With the current number of cell classifiers, we identify cells belonging to 2 cell types (B cells and T cells) and to 2 subtypes of T cells (CD4+ T cells and CD8+ T cells). The other cells (red points) are not among the cell types that can be classified by the predefined classifiers. Hence, they have an empty label.

For a certain cell type, users can also view the prediction probability. Here we show an example of B cell prediction probability:

```
# Visualize the cell types
Seurat::FeaturePlot(seurat.obj, features = "B_cells_p")
```

![](data:image/png;base64...)

Cells predicted to be B cells with higher probability have darker color, while the lighter color shows lower or even zero probability of a cell to be B cells. For B cell classifier, the threshold for prediction probability is currently at 0.5, which means cells having prediction probability at 0.5 or above will be predicted as B cells.

The automatic cell identification by scClassifR matches the traditional cell assignment, ie. the approach based on cell canonical marker expression. Taking a simple example, we use CD19 and CD20 (MS4A1) to identify B cells:

```
# Visualize the cell types
Seurat::FeaturePlot(seurat.obj, features = c("CD19", "MS4A1"), ncol = 2)
```

![](data:image/png;base64...)

We see that the marker expression of B cells exactly overlaps the B cell prediction made by scClassifR.

## Session Info

```
sessionInfo()
#> R version 4.1.0 (2021-05-18)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 20.04.2 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.13-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.13-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] scClassifR_1.0.0            SingleCellExperiment_1.14.0
#>  [3] SummarizedExperiment_1.22.0 Biobase_2.52.0
#>  [5] GenomicRanges_1.44.0        GenomeInfoDb_1.28.0
#>  [7] IRanges_2.26.0              S4Vectors_0.30.0
#>  [9] BiocGenerics_0.38.0         MatrixGenerics_1.4.0
#> [11] matrixStats_0.58.0          SeuratObject_4.0.1
#> [13] Seurat_4.0.1
#>
#> loaded via a namespace (and not attached):
#>   [1] plyr_1.8.6             igraph_1.2.6           lazyeval_0.2.2
#>   [4] splines_4.1.0          listenv_0.8.0          scattermore_0.7
#>   [7] ggplot2_3.3.3          digest_0.6.27          foreach_1.5.1
#>  [10] htmltools_0.5.1.1      fansi_0.4.2            magrittr_2.0.1
#>  [13] tensor_1.5             cluster_2.1.2          ROCR_1.0-11
#>  [16] recipes_0.1.16         globals_0.14.0         gower_0.2.2
#>  [19] spatstat.sparse_2.0-0  colorspace_2.0-1       ggrepel_0.9.1
#>  [22] xfun_0.23              dplyr_1.0.6            crayon_1.4.1
#>  [25] RCurl_1.98-1.3         jsonlite_1.7.2         spatstat.data_2.1-0
#>  [28] survival_3.2-11        zoo_1.8-9              iterators_1.0.13
#>  [31] ape_5.5                glue_1.4.2             polyclip_1.10-0
#>  [34] gtable_0.3.0           ipred_0.9-11           zlibbioc_1.38.0
#>  [37] XVector_0.32.0         leiden_0.3.7           DelayedArray_0.18.0
#>  [40] kernlab_0.9-29         future.apply_1.7.0     abind_1.4-5
#>  [43] scales_1.1.1           data.tree_1.0.0        DBI_1.1.1
#>  [46] miniUI_0.1.1.1         Rcpp_1.0.6             viridisLite_0.4.0
#>  [49] xtable_1.8-4           reticulate_1.20        spatstat.core_2.1-2
#>  [52] proxy_0.4-25           lava_1.6.9             prodlim_2019.11.13
#>  [55] htmlwidgets_1.5.3      httr_1.4.2             RColorBrewer_1.1-2
#>  [58] ellipsis_0.3.2         ica_1.0-2              farver_2.1.0
#>  [61] pkgconfig_2.0.3        nnet_7.3-16            sass_0.4.0
#>  [64] uwot_0.1.10            deldir_0.2-10          utf8_1.2.1
#>  [67] caret_6.0-88           labeling_0.4.2         tidyselect_1.1.1
#>  [70] rlang_0.4.11           reshape2_1.4.4         later_1.2.0
#>  [73] munsell_0.5.0          tools_4.1.0            generics_0.1.0
#>  [76] ggridges_0.5.3         evaluate_0.14          stringr_1.4.0
#>  [79] fastmap_1.1.0          yaml_2.2.1             goftest_1.2-2
#>  [82] ModelMetrics_1.2.2.2   knitr_1.33             fitdistrplus_1.1-3
#>  [85] purrr_0.3.4            RANN_2.6.1             pbapply_1.4-3
#>  [88] future_1.21.0          nlme_3.1-152           mime_0.10
#>  [91] compiler_4.1.0         plotly_4.9.3           png_0.1-7
#>  [94] e1071_1.7-6            spatstat.utils_2.1-0   tibble_3.1.2
#>  [97] bslib_0.2.5.1          stringi_1.6.2          highr_0.9
#> [100] lattice_0.20-44        Matrix_1.3-3           vctrs_0.3.8
#> [103] pillar_1.6.1           lifecycle_1.0.0        spatstat.geom_2.1-0
#> [106] lmtest_0.9-38          jquerylib_0.1.4        RcppAnnoy_0.0.18
#> [109] data.table_1.14.0      cowplot_1.1.1          bitops_1.0-7
#> [112] irlba_2.3.3            httpuv_1.6.1           patchwork_1.1.1
#> [115] R6_2.5.0               promises_1.2.0.1       KernSmooth_2.23-20
#> [118] gridExtra_2.3          parallelly_1.25.0      codetools_0.2-18
#> [121] MASS_7.3-54            assertthat_0.2.1       withr_2.4.2
#> [124] sctransform_0.3.2      GenomeInfoDbData_1.2.6 mgcv_1.8-35
#> [127] grid_4.1.0             rpart_4.1-15           timeDate_3043.102
#> [130] tidyr_1.1.3            class_7.3-19           rmarkdown_2.8
#> [133] Rtsne_0.15             pROC_1.17.0.1          lubridate_1.7.10
#> [136] shiny_1.6.0
```
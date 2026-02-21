# Introduction to scAnnotatR

#### Vy Nguyen

#### 2026-02-05

## Introduction

scAnnotatR is an R package for cell type prediction on single cell RNA-sequencing data. Currently, this package supports data in the forms of a Seurat object or a SingleCellExperiment object.

More information about Seurat object can be found here: <https://satijalab.org/seurat/> More information about SingleCellExperiment object can be found here: <https://osca.bioconductor.org/>

scAnnotatR provides 2 main features:

* A set of pretrained and robust classifiers for basic immune cells. See the section below.
* A user-friendly and fully customizable framework to train new classification models. These models can then be easily saved and reused in the future. Details usage of this framework is explained in vignettes 2 and 3.

## Installation

The `scAnnotatR` package can be directly installed from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

if (!require(scAnnotatR))
  BiocManager::install("scAnnotatR")
```

For more information, see <https://bioconductor.org/install/>.

## Included models

The `scAnnotatR` package comes with several pre-trained models to classify cell types.

```
# load scAnnotatR into working space
library(scAnnotatR)
#> Loading required package: Seurat
#> Loading required package: SeuratObject
#> Loading required package: sp
#>
#> Attaching package: 'SeuratObject'
#> The following objects are masked from 'package:base':
#>
#>     intersect, t
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
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#>
#> Attaching package: 'IRanges'
#> The following object is masked from 'package:sp':
#>
#>     %over%
#> Loading required package: Seqinfo
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
#> The following object is masked from 'package:Seurat':
#>
#>     Assays
#> The following object is masked from 'package:SeuratObject':
#>
#>     Assays
#> Registered S3 method overwritten by 'pROC':
#>   method   from
#>   plot.roc spatstat.explore
#> Warning: replacing previous import 'ape::where' by 'dplyr::where' when loading
#> 'scAnnotatR'
#> Warning: replacing previous import 'e1071::element' by 'ggplot2::element' when
#> loading 'scAnnotatR'
```

The models are stored in the `default_models` object:

```
default_models <- load_models("default")
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

## Basic pipeline to identify cell types in a scRNA-seq dataset using scAnnotatR

### Preparing the data

To identify cell types available in a dataset, we need to load the dataset as [Seurat](https://satijalab.org/seurat/) or [SingleCellExperiment](https://osca.bioconductor.org/) object.

For this vignette, we use a small sample datasets that is available as a `Seurat` object as part of the package.

```
# load the example dataset
data("tirosh_mel80_example")
tirosh_mel80_example
#> An object of class Seurat
#> 91 features across 480 samples within 1 assay
#> Active assay: RNA (91 features, 0 variable features)
#>  2 layers present: counts, data
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

Here we use only 3 classifiers for B cells, T cells and NK cells to reduce computational cost of this vignette. If users want to use all pretrained classifiers on their dataset, `cell_types = 'all'` can be used.

```
seurat.obj <- classify_cells(classify_obj = tirosh_mel80_example,
                             assay = 'RNA', layer = 'counts',
                             cell_types = c('B cells', 'NK', 'T cells'),
                             path_to_models = 'default')
#> loading from cache
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
seurat.obj[[]][c(50:60), c(8:ncol(seurat.obj[[]]))]
#>                                            B_cells_p B_cells_class      NK_p
#> cy80.Cd45.pos.PD1.pos.B09.S45.comb       0.007754246            no 0.4881285
#> cy80.Cd45.pos.Pd1.neg.S366.H06.S366.comb 0.999385770           yes 0.4440553
#> cy80.Cd45.pos.Pd1.neg.S202.A10.S202.comb 0.998317662           yes 0.4416114
#> cy80.Cd45.pos.Pd1.neg.S201.A09.S201.comb 0.997774856           yes 0.4398997
#> cy80.Cd45.pos.Pd1.neg.S221.B05.S221.comb 0.998874031           yes 0.4541005
#> cy80.Cd45.pos.PD1.pos.A03.S15.comb       0.999944282           yes 0.4511450
#> cy80.Cd45.pos.PD1.pos.B11.S47.comb       0.015978230            no 0.4841041
#> cy80.Cd45.pos.PD1.pos.S189.H09.S189.comb 0.099311534            no 0.4858084
#> cy80.Cd45.pos.PD1.pos.A05.S17.comb       0.055754074            no 0.4924746
#> cy80.Cd45.pos.PD1.pos.C02.S62.comb       0.048558881            no 0.5002238
#> cy80.Cd45.pos.PD1.pos.D12.S96.comb       0.996979702           yes 0.4994867
#>                                          NK_class  T_cells_p T_cells_class
#> cy80.Cd45.pos.PD1.pos.B09.S45.comb             no 0.94205232           yes
#> cy80.Cd45.pos.Pd1.neg.S366.H06.S366.comb       no 0.11269306            no
#> cy80.Cd45.pos.Pd1.neg.S202.A10.S202.comb       no 0.09834696            no
#> cy80.Cd45.pos.Pd1.neg.S201.A09.S201.comb       no 0.22256938            no
#> cy80.Cd45.pos.Pd1.neg.S221.B05.S221.comb       no 0.12903487            no
#> cy80.Cd45.pos.PD1.pos.A03.S15.comb             no 0.27242536            no
#> cy80.Cd45.pos.PD1.pos.B11.S47.comb             no 0.94929624           yes
#> cy80.Cd45.pos.PD1.pos.S189.H09.S189.comb       no 0.93390248           yes
#> cy80.Cd45.pos.PD1.pos.A05.S17.comb             no 0.98161289           yes
#> cy80.Cd45.pos.PD1.pos.C02.S62.comb            yes 0.96436674           yes
#> cy80.Cd45.pos.PD1.pos.D12.S96.comb             no 0.94848597           yes
#>                                          predicted_cell_type
#> cy80.Cd45.pos.PD1.pos.B09.S45.comb                   T cells
#> cy80.Cd45.pos.Pd1.neg.S366.H06.S366.comb             B cells
#> cy80.Cd45.pos.Pd1.neg.S202.A10.S202.comb             B cells
#> cy80.Cd45.pos.Pd1.neg.S201.A09.S201.comb             B cells
#> cy80.Cd45.pos.Pd1.neg.S221.B05.S221.comb             B cells
#> cy80.Cd45.pos.PD1.pos.A03.S15.comb                   B cells
#> cy80.Cd45.pos.PD1.pos.B11.S47.comb                   T cells
#> cy80.Cd45.pos.PD1.pos.S189.H09.S189.comb             T cells
#> cy80.Cd45.pos.PD1.pos.A05.S17.comb                   T cells
#> cy80.Cd45.pos.PD1.pos.C02.S62.comb                NK/T cells
#> cy80.Cd45.pos.PD1.pos.D12.S96.comb           B cells/T cells
#>                                          most_probable_cell_type
#> cy80.Cd45.pos.PD1.pos.B09.S45.comb                       T cells
#> cy80.Cd45.pos.Pd1.neg.S366.H06.S366.comb                 B cells
#> cy80.Cd45.pos.Pd1.neg.S202.A10.S202.comb                 B cells
#> cy80.Cd45.pos.Pd1.neg.S201.A09.S201.comb                 B cells
#> cy80.Cd45.pos.Pd1.neg.S221.B05.S221.comb                 B cells
#> cy80.Cd45.pos.PD1.pos.A03.S15.comb                       B cells
#> cy80.Cd45.pos.PD1.pos.B11.S47.comb                       T cells
#> cy80.Cd45.pos.PD1.pos.S189.H09.S189.comb                 T cells
#> cy80.Cd45.pos.PD1.pos.A05.S17.comb                       T cells
#> cy80.Cd45.pos.PD1.pos.C02.S62.comb                       T cells
#> cy80.Cd45.pos.PD1.pos.D12.S96.comb                       B cells
```

New columns are:

* **predicted\_cell\_type**: The predicted cell type, also containing any ambiguous assignments. In these cases, the possible cell types are separated by a “/”
* **most\_probable\_cell\_type**: contains the most probably cell type ignoring any ambiguous assignments.
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

The automatic cell identification by scAnnotatR matches the traditional cell assignment, ie. the approach based on cell canonical marker expression. Taking a simple example, we use CD19 and CD20 (MS4A1) to identify B cells:

```
# Visualize the cell types
Seurat::FeaturePlot(seurat.obj, features = c("CD19", "MS4A1"), ncol = 2)
```

![](data:image/png;base64...)

We see that the marker expression of B cells exactly overlaps the B cell prediction made by scAnnotatR.

## Session Info

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] scAnnotatR_1.16.1           SingleCellExperiment_1.32.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.1        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] Seurat_5.4.0                SeuratObject_5.3.0
#> [15] sp_2.2-0
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.23       splines_4.5.2          later_1.4.5
#>   [4] filelock_1.0.3         tibble_3.3.1           polyclip_1.10-7
#>   [7] hardhat_1.4.2          pROC_1.19.0.1          rpart_4.1.24
#>  [10] fastDummies_1.7.5      lifecycle_1.0.5        httr2_1.2.2
#>  [13] globals_0.19.0         lattice_0.22-7         MASS_7.3-65
#>  [16] magrittr_2.0.4         plotly_4.12.0          sass_0.4.10
#>  [19] rmarkdown_2.30         jquerylib_0.1.4        yaml_2.3.12
#>  [22] httpuv_1.6.16          otel_0.2.0             sctransform_0.4.3
#>  [25] spam_2.11-3            spatstat.sparse_3.1-0  reticulate_1.44.1
#>  [28] cowplot_1.2.0          pbapply_1.7-4          DBI_1.2.3
#>  [31] RColorBrewer_1.1-3     lubridate_1.9.5        abind_1.4-8
#>  [34] Rtsne_0.17             purrr_1.2.1            nnet_7.3-20
#>  [37] rappdirs_0.3.4         ipred_0.9-15           lava_1.8.2
#>  [40] data.tree_1.2.0        ggrepel_0.9.6          irlba_2.3.7
#>  [43] listenv_0.10.0         spatstat.utils_3.2-1   goftest_1.2-3
#>  [46] RSpectra_0.16-2        spatstat.random_3.4-4  fitdistrplus_1.2-6
#>  [49] parallelly_1.46.1      codetools_0.2-20       DelayedArray_0.36.0
#>  [52] tidyselect_1.2.1       farver_2.1.2           BiocFileCache_3.0.0
#>  [55] spatstat.explore_3.7-0 jsonlite_2.0.0         caret_7.0-1
#>  [58] e1071_1.7-17           progressr_0.18.0       ggridges_0.5.7
#>  [61] survival_3.8-6         iterators_1.0.14       foreach_1.5.2
#>  [64] tools_4.5.2            ica_1.0-3              Rcpp_1.1.1
#>  [67] glue_1.8.0             prodlim_2025.04.28     gridExtra_2.3
#>  [70] SparseArray_1.10.8     xfun_0.56              dplyr_1.2.0
#>  [73] withr_3.0.2            BiocManager_1.30.27    fastmap_1.2.0
#>  [76] digest_0.6.39          timechange_0.4.0       R6_2.6.1
#>  [79] mime_0.13              scattermore_1.2        tensor_1.5.1
#>  [82] dichromat_2.0-0.1      spatstat.data_3.1-9    RSQLite_2.4.5
#>  [85] tidyr_1.3.2            data.table_1.18.2.1    recipes_1.3.1
#>  [88] class_7.3-23           httr_1.4.7             htmlwidgets_1.6.4
#>  [91] S4Arrays_1.10.1        ModelMetrics_1.2.2.2   uwot_0.2.4
#>  [94] pkgconfig_2.0.3        gtable_0.3.6           timeDate_4052.112
#>  [97] blob_1.3.0             lmtest_0.9-40          S7_0.2.1
#> [100] XVector_0.50.0         htmltools_0.5.9        dotCall64_1.2
#> [103] scales_1.4.0           png_0.1-8              gower_1.0.2
#> [106] spatstat.univar_3.1-6  knitr_1.51             reshape2_1.4.5
#> [109] nlme_3.1-168           curl_7.0.0             proxy_0.4-29
#> [112] cachem_1.1.0           zoo_1.8-15             stringr_1.6.0
#> [115] BiocVersion_3.22.0     KernSmooth_2.23-26     parallel_4.5.2
#> [118] miniUI_0.1.2           AnnotationDbi_1.72.0   pillar_1.11.1
#> [121] grid_4.5.2             vctrs_0.7.1            RANN_2.6.2
#> [124] promises_1.5.0         dbplyr_2.5.1           xtable_1.8-4
#> [127] cluster_2.1.8.2        evaluate_1.0.5         cli_3.6.5
#> [130] compiler_4.5.2         rlang_1.1.7            crayon_1.5.3
#> [133] future.apply_1.20.1    labeling_0.4.3         plyr_1.8.9
#> [136] stringi_1.8.7          viridisLite_0.4.3      deldir_2.0-4
#> [139] Biostrings_2.78.0      lazyeval_0.2.2         spatstat.geom_3.7-0
#> [142] Matrix_1.7-4           RcppHNSW_0.6.0         patchwork_1.3.2
#> [145] bit64_4.6.0-1          future_1.69.0          ggplot2_4.0.2
#> [148] KEGGREST_1.50.0        shiny_1.12.1           AnnotationHub_4.0.0
#> [151] kernlab_0.9-33         ROCR_1.0-12            igraph_2.2.1
#> [154] memoise_2.0.1          bslib_0.10.0           bit_4.6.0
#> [157] ape_5.8-1
```
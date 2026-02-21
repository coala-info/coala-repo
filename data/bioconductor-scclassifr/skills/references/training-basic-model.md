# Training basic model classifying a cell type from scRNA-seq data

#### Vy Nguyen

#### 2021-05-19

## Introduction

One of key functions of the scClassifR package is to provide users easy tools to train their own model classifying new cell types from labeled scRNA-seq data.

This vignette shows how to train a basic classification model for an independant cell type, which is not a child of any other cell type.

## Preparing train object and test object

The workflow starts with either a [Seurat](https://satijalab.org/seurat/) or [SingleCellExperiment](https://osca.bioconductor.org/) object where cells have already been assigned to different cell types.

To do this, users may have annotated scRNA-seq data (by a FACS-sorting process, for example), create a Seurat/ SingleCellExperiment (SCE) object based on the sequencing data and assign the predetermined cell types as cell meta data. If the scRNA-seq data has not been annotated yet, another possible approach is to follow the basic workflow (Seurat, for example) until assigning cell type identity to clusters.

In this vignette, we use the human lung dataset from Zilionis et al., 2019, which is available in the scRNAseq (2.4.0) library. The dataset is stored as a SCE object.

To start the training workflow, we first install and load the necessary libraries.

```
# use BiocManager to install from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")

# the scClassifR package
if (!require(scClassifR))
BiocManager::install("scClassifR")

# we use the scRNAseq package to load example data
if (!require(scRNAseq))
BiocManager::install("scRNAseq")
```

```
library(scRNAseq)
library(scClassifR)
```

First, we load the dataset. To reduce the computational complexity of this vignette, we only use the first 5000 cells of the dataset.

```
zilionis <- ZilionisLungData()
#> snapshotDate(): 2021-05-05
#> see ?scRNAseq and browseVignettes('scRNAseq') for documentation
#> loading from cache
#> see ?scRNAseq and browseVignettes('scRNAseq') for documentation
#> loading from cache
zilionis <- zilionis[, 1:5000]
```

We split this dataset into two parts, one for the training and the other for the testing.

```
pivot = ncol(zilionis)%/%2
train_set <- zilionis[, 1:pivot]
test_set <- zilionis[, (1+pivot):ncol(zilionis)]
```

In this dataset, the cell type meta data is stored in the *Most likely LM22 cell type* slot of the SingleCellExperiment object (in both the train object and test object).

If the cell type is stored not stored as the default identification (set through `Idents` for Seurat object) the slot must be set as a parameter in the training and testing function (see below).

```
unique(train_set$`Most likely LM22 cell type`)
#>  [1] "Macrophages M0"               "Macrophages M2"
#>  [3] "Monocytes"                    "Macrophages M1"
#>  [5] "Mast cells activated"         NA
#>  [7] "T cells CD4 memory resting"   "NK cells resting"
#>  [9] "Neutrophils"                  "T cells CD8"
#> [11] "Dendritic cells resting"      "T cells CD4 memory activated"
#> [13] "Plasma cells"                 "T cells regulatory (Tregs)"
#> [15] "T cells follicular helper"    "Eosinophils"
#> [17] "Dendritic cells activated"    "B cells memory"
#> [19] "Mast cells resting"           "NK cells activated"
#> [21] "B cells naive"
```

```
unique(test_set$`Most likely LM22 cell type`)
#>  [1] "Monocytes"                    NA
#>  [3] "Macrophages M0"               "T cells CD4 memory resting"
#>  [5] "T cells regulatory (Tregs)"   "T cells follicular helper"
#>  [7] "B cells memory"               "T cells CD8"
#>  [9] "T cells CD4 memory activated" "Dendritic cells resting"
#> [11] "Neutrophils"                  "Plasma cells"
#> [13] "Mast cells activated"         "Macrophages M2"
#> [15] "NK cells activated"           "B cells naive"
#> [17] "Dendritic cells activated"    "NK cells resting"
#> [19] "Macrophages M1"               "Eosinophils"
#> [21] "Mast cells resting"
```

We want to train a classifier for B cells and their phenotypes. Considering memory B cells, naive B cells and plasma cells as B cell phenotypes, we convert all those cells to a uniform cell label, ie. B cells. All non B cells are converted into ‘others’.

```
# change cell label
train_set$B_cell <- unlist(lapply(train_set$`Most likely LM22 cell type`,
function(x) if (is.na(x)) {'ambiguous'} else if (x %in% c('Plasma cells', 'B cells memory', 'B cells naive')) {'B cells'} else {'others'}))

test_set$B_cell <- unlist(lapply(test_set$`Most likely LM22 cell type`,
function(x) if (is.na(x)) {'ambiguous'} else if (x %in% c('Plasma cells', 'B cells memory', 'B cells naive')) {'B cells'} else {'others'}))
```

We observe that there are cells marked NAs. Those can be understood as 1/different from all indicated cell types or 2/any unknown cell types. Here we consider the second case, ie. we don’t know whether they are positive or negative to B cells. To avoid any effect of these cells, we can assign them as ‘ambiguous’. All cells tagged ‘ambiguous’ will be ignored by scClassifR from training and testing.

We may want to check the number of cells in each category:

```
table(train_set$B_cell)
#>
#>   B cells ambiguous    others
#>        70      1406      1024
```

## Defining features

Next, we define a set of features, which will be used in training the classification model. Supposing we are training a model for classifying B cells, we define the set of features as follows:

```
selected_features_B <- c("CD19", "MS4A1", "CD79A", "CD79B", 'CD27', 'IGHG1', 'IGHG2', 'IGHM',
"CR2", "MEF2C", 'VPREB3', 'CD86', 'LY86', "BLK", "DERL3")
```

## Train model

When the model is being trained, three pieces of information must be provided:

* the Seurat/SCE object used for training
* the set of applied features
* the cell type defining the trained model

In case the dataset does not contain any cell classified as the target cell type, the function will fail.

If the cell type annotation is not set in the default identification slot (`Idents` for `Seurat` objects) the name of the metadata field must be provided to the `sce_tag_slot parameter`.

When training on an imbalanced dataset (f.e. a datasets containing 90% B cells and only very few other cell types), the trained model may bias toward the majority group and ignore the presence of the minority group. To avoid this, the number of positive cells and negative cells will be automatically balanced before training. Therefore, a smaller number cells will be randomly picked
from the majority group. To use the same set of cells while training multiple times for one model, users can use `set.seed`.

```
set.seed(123)
clf_B <- train_classifier(train_obj = train_set, cell_type = "B cells", features = selected_features_B,
sce_assay = 'counts', sce_tag_slot = 'B_cell')
#> Imbalanced dataset has: 1094 cells.
#> Balanced dataset has: 140 cells.
#> Loading required package: lattice
#> Loading required package: ggplot2
#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.
```

```
clf_B
#> An object of class scClassifR for B cells
#> *  15 features applied:  BLK, CD19, CD27, CD79A, CD79B, CD86, CR2, DERL3, IGHG1, IGHG2, IGHM, LY86, MEF2C, MS4A1, VPREB3
#> * Predicting probability threshold: 0.5
#> * No parent model
```

The classification model is a `scClassifR` object. Details about the classification model are accessible via getter methods.

For example:

```
clf(clf_B)
#> Support Vector Machines with Radial Basis Function Kernel
#>
#> No pre-processing
#> Resampling: Bootstrapped (25 reps)
#> Summary of sample sizes: 140, 140, 140, 140, 140, 140, ...
#> Resampling results:
#>
#>   Accuracy  Kappa
#>   0.83202   0.6650059
#>
#> Tuning parameter 'sigma' was held constant at a value of 0.01403232
#>
#> Tuning parameter 'C' was held constant at a value of 1
```

## Test model

The `test_classifier` model automatically tests a classifier’s performance against another dataset. Here, we used the `test_set` created before:

```
clf_B_test <- test_classifier(test_obj = test_set, classifier = clf_B,
sce_assay = 'counts', sce_tag_slot = 'B_cell')
#> Current probability threshold: 0.5
#>          Positive    Negative    Total
#> Actual       90      1024        1114
#> Predicted    188     926     1114
#> Accuracy: 0.888689407540395
#> Sensivity (True Positive Rate) for B cells: 0.855555555555556
#> Specificity (1 - False Positive Rate) for B cells: 0.8916015625
#> Area under the curve: 0.937228732638889
```

### Interpreting test model result

Apart from the output exported to console, test classifier function also returns an object, which is a list of:

* **test\_tag**: actual cell label, this can be different from the label provided by users because of ambiguous characters or the incoherence in cell type and sub cell type label assignment.
* **pred**: cell type prediction using current classifier
* **acc**: prediction accuracy at the fixed probability threshold, the probability threshold value can also be queried using *p\_thres(classifier)*
* **auc**: AUC score provided by current classifier
* **overall\_roc**: True Positive Rate and False Positive Rate with a certain number of prediction probability thresholds

Every classifier internally consists of a trained SVM and a probability threshold. Only cells that are classified with a probability exceeding this threshold are classified as the respective cell type. The *overall\_roc* slot summarizes the True Positive Rate (sensitivity) and False Positive Rate (1 - specificity) obtained by the trained model according to different thresholds.

```
clf_B_test$overall_roc
#>       p_thres        fpr       tpr
#>  [1,]     0.1 0.93652344 1.0000000
#>  [2,]     0.2 0.91992188 1.0000000
#>  [3,]     0.3 0.13183594 0.9000000
#>  [4,]     0.4 0.12109375 0.8666667
#>  [5,]     0.5 0.10839844 0.8555556
#>  [6,]     0.6 0.10253906 0.8111111
#>  [7,]     0.7 0.07324219 0.7444444
#>  [8,]     0.8 0.05468750 0.7111111
#>  [9,]     0.9 0.04589844 0.6333333
```

In this example of B cell classifier, the current threshold is at 0.5. The higher sensitivity can be reached if we set the p\_thres at 0.4. However, we will then have lower specificity, which means that we will incorrectly classify some cells as B cells. At the sime time, we may not retrieve all actual B cells with higher p\_thres (0.6, for example).

There is of course a certain trade-off between the sensitivity and the specificity of the model. Depending on the need of the project or the user-own preference, a probability threshold giving higher sensitivity or higher specificity can be chosen. In our perspective, p\_thres at 0.5 is a good choice for the current B cell model.

### Plotting ROC curve

Apart from numbers, we also provide a method to plot the ROC curve.

```
roc_curve <- plot_roc_curve(test_result = clf_B_test)
```

```
plot(roc_curve)
```

![](data:image/png;base64...)

### Which model to choose?

Changes in the training data, in the set of features and in the prediction probability threshold will all lead to a change in model performance.

There are several ways to evaluate the trained model, including the overall accuracy, the AUC score and the sensitivity/specificity of the model when testing on an independent dataset. In this example, we choose the model which has the best AUC score.

*Tip: Using more general markers of the whole population leads to higher sensitivity. This sometimes produces lower specificity because of close cell types (T cells and NK cells, for example). While training some models, we observed that we can use the markers producing high sensitivity but at the same time can improve the specificity by increasing the probability threshold. Of course, this can only applied in some cases, because some markers can even have a larger affect on the specificity than the prediction probability threshold.*

## Save classification model for further use

New classification models can be stored using the `save_new_model` function:

```
# no copy of pretrained models is performed
save_new_model(new_model = clf_B, path.to.models = getwd(),include.default = FALSE)
#> Finished saving new model
```

Parameters:

* **new\_model**: The new model that should be added to the database in the specified directory.
* **path.to.models**: The directory where the new models should be stored.
* **include.default**: If set, the default models shipped with the package are added to the database.

Users can also choose whether copy all pretrained models of the packages to the new model database. If not, in the future, user can only choose to use either default pretrained models or new models by specifying only one path to models.

Models can be deleted from the model database using the `delete_model` function:

```
# delete the "B cells" model from the new database
delete_model("B cells", path.to.models = getwd())
```

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
#>  [1] caret_6.0-88                ggplot2_3.3.3
#>  [3] lattice_0.20-44             scRNAseq_2.5.10
#>  [5] scClassifR_1.0.0            SingleCellExperiment_1.14.0
#>  [7] SummarizedExperiment_1.22.0 Biobase_2.52.0
#>  [9] GenomicRanges_1.44.0        GenomeInfoDb_1.28.0
#> [11] IRanges_2.26.0              S4Vectors_0.30.0
#> [13] BiocGenerics_0.38.0         MatrixGenerics_1.4.0
#> [15] matrixStats_0.58.0          SeuratObject_4.0.1
#> [17] Seurat_4.0.1
#>
#> loaded via a namespace (and not attached):
#>   [1] utf8_1.2.1                    reticulate_1.20
#>   [3] tidyselect_1.1.1              RSQLite_2.2.7
#>   [5] AnnotationDbi_1.54.0          htmlwidgets_1.5.3
#>   [7] BiocParallel_1.26.0           grid_4.1.0
#>   [9] Rtsne_0.15                    pROC_1.17.0.1
#>  [11] munsell_0.5.0                 codetools_0.2-18
#>  [13] ica_1.0-2                     future_1.21.0
#>  [15] miniUI_0.1.1.1                withr_2.4.2
#>  [17] colorspace_2.0-1              filelock_1.0.2
#>  [19] highr_0.9                     knitr_1.33
#>  [21] ROCR_1.0-11                   tensor_1.5
#>  [23] listenv_0.8.0                 labeling_0.4.2
#>  [25] GenomeInfoDbData_1.2.6        polyclip_1.10-0
#>  [27] bit64_4.0.5                   farver_2.1.0
#>  [29] parallelly_1.25.0             vctrs_0.3.8
#>  [31] generics_0.1.0                ipred_0.9-11
#>  [33] xfun_0.23                     BiocFileCache_2.0.0
#>  [35] R6_2.5.0                      AnnotationFilter_1.16.0
#>  [37] bitops_1.0-7                  spatstat.utils_2.1-0
#>  [39] cachem_1.0.5                  DelayedArray_0.18.0
#>  [41] assertthat_0.2.1              BiocIO_1.2.0
#>  [43] promises_1.2.0.1              scales_1.1.1
#>  [45] nnet_7.3-16                   gtable_0.3.0
#>  [47] globals_0.14.0                goftest_1.2-2
#>  [49] ensembldb_2.16.0              timeDate_3043.102
#>  [51] rlang_0.4.11                  splines_4.1.0
#>  [53] rtracklayer_1.52.0            lazyeval_0.2.2
#>  [55] ModelMetrics_1.2.2.2          spatstat.geom_2.1-0
#>  [57] BiocManager_1.30.15           yaml_2.2.1
#>  [59] reshape2_1.4.4                abind_1.4-5
#>  [61] GenomicFeatures_1.44.0        httpuv_1.6.1
#>  [63] tools_4.1.0                   lava_1.6.9
#>  [65] ellipsis_0.3.2                spatstat.core_2.1-2
#>  [67] jquerylib_0.1.4               RColorBrewer_1.1-2
#>  [69] proxy_0.4-25                  ggridges_0.5.3
#>  [71] Rcpp_1.0.6                    plyr_1.8.6
#>  [73] progress_1.2.2                zlibbioc_1.38.0
#>  [75] purrr_0.3.4                   RCurl_1.98-1.3
#>  [77] prettyunits_1.1.1             rpart_4.1-15
#>  [79] deldir_0.2-10                 pbapply_1.4-3
#>  [81] cowplot_1.1.1                 zoo_1.8-9
#>  [83] ggrepel_0.9.1                 cluster_2.1.2
#>  [85] magrittr_2.0.1                data.table_1.14.0
#>  [87] scattermore_0.7               lmtest_0.9-38
#>  [89] RANN_2.6.1                    ProtGenerics_1.24.0
#>  [91] fitdistrplus_1.1-3            hms_1.1.0
#>  [93] patchwork_1.1.1               mime_0.10
#>  [95] evaluate_0.14                 xtable_1.8-4
#>  [97] XML_3.99-0.6                  gridExtra_2.3
#>  [99] biomaRt_2.48.0                compiler_4.1.0
#> [101] tibble_3.1.2                  KernSmooth_2.23-20
#> [103] crayon_1.4.1                  htmltools_0.5.1.1
#> [105] mgcv_1.8-35                   later_1.2.0
#> [107] tidyr_1.1.3                   lubridate_1.7.10
#> [109] DBI_1.1.1                     ExperimentHub_2.0.0
#> [111] dbplyr_2.1.1                  MASS_7.3-54
#> [113] rappdirs_0.3.3                data.tree_1.0.0
#> [115] Matrix_1.3-3                  gower_0.2.2
#> [117] igraph_1.2.6                  pkgconfig_2.0.3
#> [119] GenomicAlignments_1.28.0      plotly_4.9.3
#> [121] spatstat.sparse_2.0-0         recipes_0.1.16
#> [123] foreach_1.5.1                 bslib_0.2.5.1
#> [125] XVector_0.32.0                prodlim_2019.11.13
#> [127] stringr_1.4.0                 digest_0.6.27
#> [129] sctransform_0.3.2             RcppAnnoy_0.0.18
#> [131] spatstat.data_2.1-0           Biostrings_2.60.0
#> [133] rmarkdown_2.8                 leiden_0.3.7
#> [135] uwot_0.1.10                   restfulr_0.0.13
#> [137] curl_4.3.1                    kernlab_0.9-29
#> [139] Rsamtools_2.8.0               shiny_1.6.0
#> [141] rjson_0.2.20                  lifecycle_1.0.0
#> [143] nlme_3.1-152                  jsonlite_1.7.2
#> [145] viridisLite_0.4.0             fansi_0.4.2
#> [147] pillar_1.6.1                  KEGGREST_1.32.0
#> [149] fastmap_1.1.0                 httr_1.4.2
#> [151] survival_3.2-11               interactiveDisplayBase_1.30.0
#> [153] glue_1.4.2                    png_0.1-7
#> [155] iterators_1.0.13              BiocVersion_3.13.1
#> [157] bit_4.0.4                     class_7.3-19
#> [159] stringi_1.6.2                 sass_0.4.0
#> [161] blob_1.2.1                    AnnotationHub_3.0.0
#> [163] memoise_2.0.0                 dplyr_1.0.6
#> [165] irlba_2.3.3                   e1071_1.7-6
#> [167] future.apply_1.7.0            ape_5.5
```
# Training basic model classifying a cell type from scRNA-seq data

#### Vy Nguyen

#### 2026-02-05

## Introduction

One of key functions of the scAnnotatR package is to provide users easy tools to train their own model classifying new cell types from labeled scRNA-seq data.

This vignette shows how to train a basic classification model for an independent cell type, which is not a child of any other cell type.

## Preparing train object and test object

The workflow starts with either a [Seurat](https://satijalab.org/seurat/) or [SingleCellExperiment](https://osca.bioconductor.org/) object where cells have already been assigned to different cell types.

To do this, users may have annotated scRNA-seq data (by a FACS-sorting process, for example), create a Seurat/ SingleCellExperiment (SCE) object based on the sequencing data and assign the predetermined cell types as cell meta data. If the scRNA-seq data has not been annotated yet, another possible approach is to follow the basic workflow (Seurat, for example) until assigning cell type identity to clusters.

In this vignette, we use the human lung dataset from Zilionis et al., 2019, which is available in the scRNAseq (2.4.0) library. The dataset is stored as a SCE object.

To start the training workflow, we first install and load the necessary libraries.

```
# use BiocManager to install from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# the scAnnotatR package
if (!require(scAnnotatR))
  BiocManager::install("scAnnotatR")

# we use the scRNAseq package to load example data
if (!require(scRNAseq))
  BiocManager::install("scRNAseq")
```

```
library(scRNAseq)
library(scAnnotatR)
```

First, we load the dataset. To reduce the computational complexity of this vignette, we only use the first 5000 cells of the dataset.

```
zilionis <- ZilionisLungData()
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
zilionis <- zilionis[, 1:5000]
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'

# now we add simple colnames (= cell ids) to the dataset
# Note: This is normally not necessary
colnames(zilionis) <- paste0("Cell", 1:ncol(zilionis))
```

We split this dataset into two parts, one for the training and the other for the testing.

```
pivot = ncol(zilionis)%/%2
train_set <- zilionis[, 1:pivot]
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
test_set <- zilionis[, (1+pivot):ncol(zilionis)]
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
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

We observe that there are cells marked NAs. Those can be understood as 1/different from all indicated cell types or 2/any unknown cell types. Here we consider the second case, ie. we don’t know whether they are positive or negative to B cells. To avoid any effect of these cells, we can assign them as ‘ambiguous’. All cells tagged ‘ambiguous’ will be ignored by scAnnotatR from training and testing.

We may want to check the number of cells in each category:

```
table(train_set$B_cell)
#>
#>   B cells ambiguous    others
#>        70      1406      1024
```

## Defining marker genes

Next, we define a set of marker genes, which will be used in training the classification model. Supposing we are training a model for classifying B cells, we define the set of marker genes as follows:

```
selected_marker_genes_B <- c("CD19", "MS4A1", "CD79A", "CD79B", 'CD27', 'IGHG1', 'IGHG2', 'IGHM',
                         "CR2", "MEF2C", 'VPREB3', 'CD86', 'LY86', "BLK", "DERL3")
```

## Train model

When the model is being trained, three pieces of information must be provided:

* the Seurat/SCE object used for training
* the set of applied marker genes
* the cell type defining the trained model

In case the dataset does not contain any cell classified as the target cell type, the function will fail.

If the cell type annotation is not set in the default identification slot (`Idents` for `Seurat` objects) the name of the metadata field must be provided to the `sce_tag_slot parameter`.

When training on an imbalanced dataset (f.e. a datasets containing 90% B cells and only very few other cell types), the trained model may bias toward the majority group and ignore the presence of the minority group. To avoid this, the number of positive cells and negative cells will be automatically balanced before training. Therefore, a smaller number cells will be randomly picked
from the majority group. To use the same set of cells while training multiple times for one model, users can use `set.seed`.

```
set.seed(123)
classifier_B <- train_classifier(train_obj = train_set, cell_type = "B cells",
                                 marker_genes = selected_marker_genes_B,
                                 assay = 'counts', tag_slot = 'B_cell')
#> Warning: Cell types containing /, ,,  -,  [+], [.],  and ,  or , _or_, -or-, [(], [)], ambiguous are considered as ambiguous. They are removed from training and testing.
#> Loading required package: ggplot2
#> Loading required package: lattice
#>
#> Attaching package: 'caret'
#> The following object is masked from 'package:generics':
#>
#>     train
#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.
```

```
classifier_B
#> An object of class scAnnotatR for B cells
#> * 15 marker genes applied: BLK, CD19, CD27, CD79A, CD79B, CD86, CR2, DERL3, IGHG1, IGHG2, IGHM, LY86, MEF2C, MS4A1, VPREB3
#> * Predicting probability threshold: 0.5
#> * No parent model
```

The classification model is a `scAnnotatR` object. Details about the classification model are accessible via getter methods.

For example:

```
caret_model(classifier_B)
#> Support Vector Machines with Linear Kernel
#>
#> No pre-processing
#> Resampling: Cross-Validated (10 fold)
#> Summary of sample sizes: 984, 984, 985, 985, 985, 985, ...
#> Addtional sampling using down-sampling
#>
#> Resampling results:
#>
#>   Accuracy   Kappa
#>   0.9543119  0.6263564
#>
#> Tuning parameter 'C' was held constant at a value of 1
```

## Test model

The `test_classifier` model automatically tests a classifier’s performance against another dataset. Here, we used the `test_set` created before:

```
classifier_B_test <- test_classifier(classifier = classifier_B, test_obj = test_set,
                                     assay = 'counts', tag_slot = 'B_cell')
#> Warning: Cell types containing /, ,,  -,  [+], [.],  and ,  or , _or_, -or-, [(], [)], ambiguous are considered as ambiguous. They are removed from training and testing.
#> Current probability threshold: 0.5
#>          Positive    Negative    Total
#> Actual       90      1024        1114
#> Predicted    115     999     1114
#> Accuracy: 0.957809694793537
#> Sensivity (True Positive Rate) for B cells: 0.877777777777778
#> Specificity (1 - False Positive Rate) for B cells: 0.96484375
#> Area under the curve: 0.96728515625
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
classifier_B_test$overall_roc
#>       p_thres        fpr       tpr
#>  [1,]     0.1 0.96582031 1.0000000
#>  [2,]     0.2 0.88378906 1.0000000
#>  [3,]     0.3 0.07519531 0.8888889
#>  [4,]     0.4 0.06445312 0.8888889
#>  [5,]     0.5 0.03515625 0.8777778
#>  [6,]     0.6 0.03222656 0.8333333
#>  [7,]     0.7 0.02929688 0.8222222
#>  [8,]     0.8 0.02343750 0.7555556
#>  [9,]     0.9 0.01269531 0.6777778
```

In this example of B cell classifier, the current threshold is at 0.5. The higher sensitivity can be reached if we set the p\_thres at 0.4. However, we will then have lower specificity, which means that we will incorrectly classify some cells as B cells. At the sime time, we may not retrieve all actual B cells with higher p\_thres (0.6, for example).

There is of course a certain trade-off between the sensitivity and the specificity of the model. Depending on the need of the project or the user-own preference, a probability threshold giving higher sensitivity or higher specificity can be chosen. In our perspective, p\_thres at 0.5 is a good choice for the current B cell model.

### Plotting ROC curve

Apart from numbers, we also provide a method to plot the ROC curve.

```
roc_curve <- plot_roc_curve(test_result = classifier_B_test)
```

```
plot(roc_curve)
```

![](data:image/png;base64...)

### Which model to choose?

Changes in the training data, in the set of marker genes and in the prediction probability threshold will all lead to a change in model performance.

There are several ways to evaluate the trained model, including the overall accuracy, the AUC score and the sensitivity/specificity of the model when testing on an independent dataset. In this example, we choose the model which has the best AUC score.

*Tip: Using more general markers of the whole population leads to higher sensitivity. This sometimes produces lower specificity because of close cell types (T cells and NK cells, for example). While training some models, we observed that we can use the markers producing high sensitivity but at the same time can improve the specificity by increasing the probability threshold. Of course, this can only applied in some cases, because some markers can even have a larger affect on the specificity than the prediction probability threshold.*

## Save classification model for further use

New classification models can be stored using the `save_new_model` function:

```
# no copy of pretrained models is performed
save_new_model(new_model = classifier_B, path_to_models = tempdir(),
               include.default = FALSE)
#> Saving new models to /tmp/RtmpS3hqOY/new_models.rda...
#> Finished saving new model
```

Parameters:

* **new\_model**: The new model that should be added to the database in the specified directory.
* **path\_to\_models**: The directory where the new models should be stored.
* **include.default**: If set, the default models shipped with the package are added to the database.

Users can also choose whether copy all pretrained models of the packages to the new model database. If not, in the future, user can only choose to use either default pretrained models or new models by specifying only one path to models.

Models can be deleted from the model database using the `delete_model` function:

```
# delete the "B cells" model from the new database
delete_model("B cells", path_to_models = tempdir())
```

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
#>  [1] caret_7.0-1                 lattice_0.22-7
#>  [3] ggplot2_4.0.2               scRNAseq_2.24.0
#>  [5] scAnnotatR_1.16.1           SingleCellExperiment_1.32.0
#>  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [9] GenomicRanges_1.62.1        Seqinfo_1.0.0
#> [11] IRanges_2.44.0              S4Vectors_0.48.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#> [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [17] Seurat_5.4.0                SeuratObject_5.3.0
#> [19] sp_2.2-0
#>
#> loaded via a namespace (and not attached):
#>   [1] ProtGenerics_1.42.0      spatstat.sparse_3.1-0    bitops_1.0-9
#>   [4] lubridate_1.9.5          httr_1.4.7               RColorBrewer_1.1-3
#>   [7] tools_4.5.2              sctransform_0.4.3        alabaster.base_1.10.0
#>  [10] R6_2.6.1                 HDF5Array_1.38.0         lazyeval_0.2.2
#>  [13] uwot_0.2.4               rhdf5filters_1.22.0      withr_3.0.2
#>  [16] gridExtra_2.3            progressr_0.18.0         cli_3.6.5
#>  [19] spatstat.explore_3.7-0   fastDummies_1.7.5        alabaster.se_1.10.0
#>  [22] labeling_0.4.3           sass_0.4.10              S7_0.2.1
#>  [25] spatstat.data_3.1-9      proxy_0.4-29             ggridges_0.5.7
#>  [28] pbapply_1.7-4            Rsamtools_2.26.0         dichromat_2.0-0.1
#>  [31] parallelly_1.46.1        RSQLite_2.4.5            BiocIO_1.20.0
#>  [34] ica_1.0-3                spatstat.random_3.4-4    dplyr_1.2.0
#>  [37] Matrix_1.7-4             abind_1.4-8              lifecycle_1.0.5
#>  [40] yaml_2.3.12              rhdf5_2.54.1             recipes_1.3.1
#>  [43] SparseArray_1.10.8       BiocFileCache_3.0.0      Rtsne_0.17
#>  [46] grid_4.5.2               blob_1.3.0               promises_1.5.0
#>  [49] ExperimentHub_3.0.0      crayon_1.5.3             miniUI_0.1.2
#>  [52] cowplot_1.2.0            GenomicFeatures_1.62.0   cigarillo_1.0.0
#>  [55] KEGGREST_1.50.0          pillar_1.11.1            knitr_1.51
#>  [58] rjson_0.2.23             future.apply_1.20.1      codetools_0.2-20
#>  [61] glue_1.8.0               spatstat.univar_3.1-6    data.table_1.18.2.1
#>  [64] gypsum_1.6.0             vctrs_0.7.1              png_0.1-8
#>  [67] spam_2.11-3              gtable_0.3.6             kernlab_0.9-33
#>  [70] cachem_1.1.0             gower_1.0.2              xfun_0.56
#>  [73] S4Arrays_1.10.1          mime_0.13                prodlim_2025.04.28
#>  [76] survival_3.8-6           timeDate_4052.112        iterators_1.0.14
#>  [79] hardhat_1.4.2            lava_1.8.2               fitdistrplus_1.2-6
#>  [82] ROCR_1.0-12              ipred_0.9-15             nlme_3.1-168
#>  [85] bit64_4.6.0-1            alabaster.ranges_1.10.0  filelock_1.0.3
#>  [88] RcppAnnoy_0.0.23         GenomeInfoDb_1.46.2      data.tree_1.2.0
#>  [91] bslib_0.10.0             irlba_2.3.7              KernSmooth_2.23-26
#>  [94] otel_0.2.0               rpart_4.1.24             DBI_1.2.3
#>  [97] nnet_7.3-20              tidyselect_1.2.1         bit_4.6.0
#> [100] compiler_4.5.2           curl_7.0.0               httr2_1.2.2
#> [103] h5mread_1.2.1            DelayedArray_0.36.0      plotly_4.12.0
#> [106] rtracklayer_1.70.1       scales_1.4.0             lmtest_0.9-40
#> [109] rappdirs_0.3.4           stringr_1.6.0            digest_0.6.39
#> [112] goftest_1.2-3            spatstat.utils_3.2-1     alabaster.matrix_1.10.0
#> [115] rmarkdown_2.30           XVector_0.50.0           htmltools_0.5.9
#> [118] pkgconfig_2.0.3          ensembldb_2.34.0         dbplyr_2.5.1
#> [121] fastmap_1.2.0            UCSC.utils_1.6.1         rlang_1.1.7
#> [124] htmlwidgets_1.6.4        shiny_1.12.1             farver_2.1.2
#> [127] jquerylib_0.1.4          zoo_1.8-15               jsonlite_2.0.0
#> [130] BiocParallel_1.44.0      ModelMetrics_1.2.2.2     RCurl_1.98-1.17
#> [133] magrittr_2.0.4           dotCall64_1.2            patchwork_1.3.2
#> [136] Rhdf5lib_1.32.0          Rcpp_1.1.1               ape_5.8-1
#> [139] reticulate_1.44.1        stringi_1.8.7            alabaster.schemas_1.10.0
#> [142] pROC_1.19.0.1            MASS_7.3-65              AnnotationHub_4.0.0
#> [145] plyr_1.8.9               parallel_4.5.2           listenv_0.10.0
#> [148] ggrepel_0.9.6            deldir_2.0-4             Biostrings_2.78.0
#> [151] splines_4.5.2            tensor_1.5.1             igraph_2.2.1
#> [154] spatstat.geom_3.7-0      RcppHNSW_0.6.0           reshape2_1.4.5
#> [157] BiocVersion_3.22.0       XML_3.99-0.20            evaluate_1.0.5
#> [160] BiocManager_1.30.27      foreach_1.5.2            httpuv_1.6.16
#> [163] RANN_2.6.2               tidyr_1.3.2              purrr_1.2.1
#> [166] polyclip_1.10-7          alabaster.sce_1.10.0     future_1.69.0
#> [169] scattermore_1.2          xtable_1.8-4             AnnotationFilter_1.34.0
#> [172] restfulr_0.0.16          e1071_1.7-17             RSpectra_0.16-2
#> [175] later_1.4.5              viridisLite_0.4.3        class_7.3-23
#> [178] tibble_3.3.1             memoise_2.0.1            AnnotationDbi_1.72.0
#> [181] GenomicAlignments_1.46.0 cluster_2.1.8.2          timechange_0.4.0
#> [184] globals_0.19.0
```
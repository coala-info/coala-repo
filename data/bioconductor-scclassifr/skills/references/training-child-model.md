# Training model classifying a cell subtype from scRNA-seq data

#### Vy Nguyen

#### 2021-05-19

## Introduction

Apart from a basic model for a basic independent cell type, our methods also supports cell types considered as the children of another cell type. In this case, the so-called parent cell type must already be represented by a classification model.

Here we consider the model classifying child cell type as child model and of course, parent model is used for classification of parent cell type.

Child model is used to distinguish a particular child cell type from other children cell types of the same parent. Therefore, our methods will examine all cells by parent model before training and testing for child model. Only cells that are considered as parent cell type will be used to train and test the new model.

The basis for this approach is that while markers that are very well suited to differentiate a CD4+ T cell from a CD8+ T cell, these markers may worsen the differentiation of a T cell *vs.* other cells.

## Parent model

A first prerequisite of training for a child model is the parent model. A parent model is of class scClassifR and must be available in the working space, among default pretrained models of the package or among trained models in a user supplied database.

In this example, we load B cells classifier in the package default models to our working place.

```
# use BiocManager to install from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# the scClassifR package
if (!require(scClassifR))
  BiocManager::install("scClassifR")
```

```
library(scClassifR)
```

```
data("default_models")
clf_B <- default_models[['B cells']]
clf_B
#> An object of class scClassifR for B cells
#> *  31 features applied:  CD19, MS4A1, SDC1, CD79A, CD79B, CD38, CD37, CD83, CR2, MVK, MME, IL2RA, PTEN, POU2AF1, MEF2C, IRF8, TCF3, BACH2, MZB1, VPREB3, RASGRP2, CD86, CD84, LY86, CD74, SP140, BLK, FLI1, CD14, DERL3, LRMP
#> * Predicting probability threshold: 0.5
#> * No parent model
```

## Preparing train object and test object

Same as training for basic models, training for a child model also requires a train (Seurat/SCE) object and a test (Seurat/SCE) object. All objects must have a slot in meta data indicating the type of cells. Tag slot indicating parent cell type can also be provided. In this case, parent cell type tag will further be tested for coherence with the provided parent classifier.

Cell tagged as child cell type but incoherent to parent cell type will be removed from training and testing for the child cell type classifier.

In this vignette, we use the human lung dataset from Zilionis et al., 2019, which is available in the scRNAseq (2.4.0) library. The dataset is stored as a SCE object.

To start the training workflow, we first load the neccessary libraries.

```
# we use the scRNAseq package to load example data
if (!require(scRNAseq))
  BiocManager::install("scRNAseq")
```

```
library(scRNAseq)
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
table(train_set$`Most likely LM22 cell type`)
#>
#>               B cells memory                B cells naive
#>                           36                            2
#>    Dendritic cells activated      Dendritic cells resting
#>                           31                           41
#>                  Eosinophils               Macrophages M0
#>                           14                          155
#>               Macrophages M1               Macrophages M2
#>                           18                          116
#>         Mast cells activated           Mast cells resting
#>                           63                           13
#>                    Monocytes           NK cells activated
#>                          130                            5
#>             NK cells resting                  Neutrophils
#>                           20                           86
#>                 Plasma cells T cells CD4 memory activated
#>                           32                           37
#>   T cells CD4 memory resting                  T cells CD8
#>                          215                           28
#>    T cells follicular helper   T cells regulatory (Tregs)
#>                           29                           23
```

```
table(test_set$`Most likely LM22 cell type`)
#>
#>               B cells memory                B cells naive
#>                           36                            3
#>    Dendritic cells activated      Dendritic cells resting
#>                           35                           35
#>                  Eosinophils               Macrophages M0
#>                           16                          185
#>               Macrophages M1               Macrophages M2
#>                            7                           92
#>         Mast cells activated           Mast cells resting
#>                           79                           14
#>                    Monocytes           NK cells activated
#>                          135                           11
#>             NK cells resting                  Neutrophils
#>                           21                           83
#>                 Plasma cells T cells CD4 memory activated
#>                           51                           39
#>   T cells CD4 memory resting                  T cells CD8
#>                          195                           21
#>    T cells follicular helper   T cells regulatory (Tregs)
#>                           31                           25
```

Unlike the example of the training basic model, we will remove all NAs cells in order to reduce the computational complexity for this example.

```
# remove NAs cells
train_set <- train_set[, !is.na(train_set$`Most likely LM22 cell type`)]
test_set <- test_set[, !is.na(test_set$`Most likely LM22 cell type`)]
```

```
# convert cell label:
# 1 - positive to plasma cells,
# 0 - negative to plasma cells
train_set$plasma <- unlist(lapply(train_set$`Most likely LM22 cell type`,
                                  function(x) if (x == 'Plasma cells') {1} else {0}))

test_set$plasma <- unlist(lapply(test_set$`Most likely LM22 cell type`,
                                 function(x) if (x == 'Plasma cells') {1} else {0}))
```

We may want to check the number of cells in each category:

```
table(train_set$plasma)
#>
#>    0    1
#> 1062   32
# 1: plasma cells, 0: not plasma cells
```

## Defining set of features

Next, we define a set of features, which will be used for the child classification model. Supposing we are training a model for classifying plasma cells, we define the set of features as follows:

```
selected_features_plasma <- c("SDC1", "CD19", "BACH2", "CD74", 'CD27', "CD37",
                              'IGHG1', 'IGHG2', 'IGHM', "CD40LG", "MCL1", "MZB1")
```

## Train model

Training for a child model needs more parameters than training a basic one. Users must indicate the parent classifier. There are three ways to indicate the parent classifier to the train method:

* Users can use an available model in current working place.
* Users can give name of a model among default pretrained models, for example: *parent\_cell = ‘B cells’*
* Users can give name of a model among models available in users’ database AND the path to that database, for example: `parent_cell = 'B cells', path.to.models = '.'`

Train the child classifier:

```
set.seed(123)
clf_plasma <- train_classifier(train_obj = train_set,
features = selected_features_plasma, cell_type = "Plasma cells",
sce_assay = 'counts', sce_tag_slot = 'plasma', parent_clf = clf_B)
#> Apply pretrained model for parent cell type.
#> Warning: Some annotated Plasma cells are negative to B cells classifier. They are removed from training/testing for Plasma cells classifier.
#> Imbalanced dataset has: 124 cells.
#> Balanced dataset has: 42 cells.
#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.
#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.
```

If the cells classifier has not been loaded to the current working space, an equivalent training process should be:

```
set.seed(123)
clf_plasma <- train_classifier(train_obj = train_set,
features = selected_features_plasma, cell_type = "Plasma cells",
sce_assay = 'counts', sce_tag_slot = 'plasma', parent_cell = 'B cells')
#> Parent classifier not provided. Try finding available model.
#> Apply pretrained model for parent cell type.
#> Warning: Some annotated Plasma cells are negative to B cells classifier. They are removed from training/testing for Plasma cells classifier.
#> Imbalanced dataset has: 124 cells.
#> Balanced dataset has: 42 cells.
#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.
#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.

#> Warning in .local(x, ...): Variable(s) `' constant. Cannot scale data.
```

```
clf_plasma
#> An object of class scClassifR for Plasma cells
#> *  12 features applied:  BACH2, CD19, CD27, CD37, CD40LG, CD74, IGHG1, IGHG2, IGHM, MCL1, MZB1, SDC1
#> * Predicting probability threshold: 0.5
#> * A child model of:  B cells
```

```
clf(clf_plasma)
#> Support Vector Machines with Radial Basis Function Kernel
#>
#> No pre-processing
#> Resampling: Bootstrapped (25 reps)
#> Summary of sample sizes: 42, 42, 42, 42, 42, 42, ...
#> Resampling results:
#>
#>   Accuracy   Kappa
#>   0.8897782  0.7763541
#>
#> Tuning parameter 'sigma' was held constant at a value of 0.05431195
#>
#> Tuning parameter 'C' was held constant at a value of 1
```

## Test model

The parent classifier must be also set in test method.

```
clf_plasma_test <- test_classifier(test_obj = test_set,
classifier = clf_plasma, sce_assay = 'counts', sce_tag_slot = 'plasma',
parent_clf = clf_B)
#> Apply pretrained model for parent cell type.
#> Warning: Some annotated Plasma cells are negative to B cells classifier. They are removed from training/testing for Plasma cells classifier.
#> Current probability threshold: 0.5
#>          Positive    Negative    Total
#> Actual       29      104     133
#> Predicted    36      97      133
#> Accuracy: 0.917293233082707
#> Sensivity (True Positive Rate) for Plasma cells: 0.931034482758621
#> Specificity (1 - False Positive Rate) for Plasma cells: 0.913461538461538
#> Area under the curve: 0.970490716180371
```

### Interpreting test model result

The test result obtained from a child model can be interpreted in the same way as we do with the model for basic cell types. We can change the prediction probability threshold according to the research project or personal preference and plot a roc curve.

```
print(clf_plasma_test$auc)
#> Area under the curve: 0.9705
roc_curve <- plot_roc_curve(test_result = clf_plasma_test)
plot(roc_curve)
```

![](data:image/png;base64...)

## Save child classification model for further use

In order to save child classifier, the parent classifier must already exist in the classifier database, either in the package default database or in the user-defined database.

```
# see list of available model in package
data("default_models")
names(default_models)
#>  [1] "B cells"      "NK"           "Plasma cells" "T cells"      "CD4 T cells"
#>  [6] "CD8 T cells"  "Monocytes"    "DC"           "alpha"        "beta"
#> [11] "delta"        "gamma"        "ductal"       "acinar"
```

In our package, the default models already include a model classifying plasma cells. Therefore, we will save this model to a new local database specified by the *path.to.models* parameter. If you start with a fresh new local database, there is no available parent classifier of plasma cells’ classifier. Therefore, we have to save the parent classifier first, e.g. the classifier for B cells.

```
# no copy of pretrained models is performed
save_new_model(new_model = clf_B, path.to.models = getwd(),
               include.default = FALSE)
#> Finished saving new model
save_new_model(new_model = clf_plasma, path.to.models = getwd(),
               include.default = FALSE)
#> Finished saving new model
```

## Applying newly trained models for cell classification

When we save the B cells’ classifier and the plasma cells’ classifier, a local database is newly created. We can use this new database to classify cells in a Seurat or SingleCellExperiment object.

Let’s try to classify cells in the test set:

```
classified <- classify_cells(classify_obj = test_set, sce_assay = 'counts',
                             cell_types = 'all', path_to_models = getwd())
```

Using the *classify\_cells()* function, we have to indicate exactly the repository containing the database that the models has recently been saved to. In the previous section, we saved our new models to the current working directory.

In the *classified* object, the classification process added new columns to the cell meta data, including the *predicted\_cell\_type* and *most\_probable\_cell\_type* columns.

If we use the full prediction to compare with actual plasma tag, we obtain this result:

```
# compare the prediction with actual cell tag
table(classified$predicted_cell_type, classified$plasma)
#>
#>                          0   1
#>                        959  22
#>   B cells               95   2
#>   B cells/Plasma cells   9  27
# plasma cell is child cell type of B cell
# so of course, all predicted plasma cells are predicted B cells
```

When comparing the actual tag with the most probable prediction, we obtain:

```
# compare the prediction with actual cell tag
table(classified$most_probable_cell_type, classified$plasma)
#>
#>                  0   1
#>   B cells       95   2
#>   Plasma cells   9  27
#>   unknown      959  22
```

The number of identified plasma cells is different in the *predicted\_cell\_type* slot and in the *most\_probable\_cell\_type*. This is because the *predicted\_cell\_type* takes all predictions having the probabilities satisfying the corresponding probability thresholds. Meanwhile, the *most\_probable\_cell\_type* takes only the cell type which gives highest prediction probability.

To have all plasma cells specified as plasma cells, we can set the *ignore\_ambiguous\_result* to TRUE. This option will hide all ambiguous predictions where we have more than one possible cell type. In the parent-chid(ren) relationship of cell types, the more specified cell types/phenotypes will be reported.

```
classified <- classify_cells(classify_obj = test_set, sce_assay = 'counts',
                             cell_types = 'all', path_to_models = getwd(),
                             ignore_ambiguous_result = TRUE)
table(classified$predicted_cell_type, classified$plasma)
#>
#>                  0   1
#>                959  22
#>   B cells       95   2
#>   Plasma cells   9  27
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
# Training model classifying a cell subtype from scRNA-seq data

#### Vy Nguyen

#### 2026-02-05

## Introduction

Apart from a basic model for a basic independent cell type, our methods also supports cell types considered as the children of another cell type. In this case, the so-called parent cell type must already be represented by a classification model.

Here we consider the model classifying child cell type as child model and of course, parent model is used for classification of parent cell type.

Child model is used to distinguish a particular child cell type from other children cell types of the same parent. Therefore, our methods will examine all cells by parent model before training and testing for child model. Only cells that are considered as parent cell type will be used to train and test the new model.

The basis for this approach is that while markers that are very well suited to differentiate a CD4+ T cell from a CD8+ T cell, these markers may worsen the differentiation of a T cell *vs.* other cells.

## Parent model

A first prerequisite of training for a child model is the parent model. A parent model is of class scAnnotatR and must be available in the working space, among default pretrained models of the package or among trained models in a user supplied database.

In this example, we load B cells classifier in the package default models to our working place.

```
# use BiocManager to install from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# the scAnnotatR package
if (!require(scAnnotatR))
  BiocManager::install("scAnnotatR")
```

```
library(scAnnotatR)
```

```
default_models <- load_models('default')
#> loading from cache
classifier_B <- default_models[['B cells']]
classifier_B
#> An object of class scAnnotatR for B cells
#> * 31 marker genes applied: CD38, CD79B, CD74, CD84, RASGRP2, TCF3, SP140, MEF2C, DERL3, CD37, CD79A, POU2AF1, MVK, CD83, BACH2, LY86, CD86, SDC1, CR2, LRMP, VPREB3, IL2RA, BLK, IRF8, FLI1, MS4A1, CD14, MZB1, PTEN, CD19, MME
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
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
test_set <- test_set[, !is.na(test_set$`Most likely LM22 cell type`)]
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
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

## Defining set of marker genes

Next, we define a set of marker genes, which will be used for the child classification model. Supposing we are training a model for classifying plasma cells, we define the set of marker genes as follows:

```
selected_marker_genes_plasma <- c('BACH2', 'BLK', 'CD14', 'CD19', 'CD27', 'CD37',
'CD38', 'CD40LG', 'CD74', 'CD79A', 'CD79B', 'CD83', 'CD84', 'CD86', 'CR2',
'DERL3', 'FLI1', 'IGHG1', 'IGHG2', 'IGHM', 'IL2RA', 'IRF8', 'LRMP', 'LY86',
'MCL1', 'MEF2C', 'MME', 'MS4A1', 'MVK', 'MZB1', 'POU2AF1', 'PTEN', 'RASGRP2',
'SDC1', 'SP140', 'TCF3', 'VPREB3')
```

## Train model

Training for a child model needs more parameters than training a basic one. Users must indicate the parent classifier. There are three ways to indicate the parent classifier to the train method:

* Users can use an available model in current working place.
* Users can give name of a model among default pretrained models, for example: *parent\_cell = ‘B cells’*
* Users can give name of a model among models available in users’ database AND the path to that database, for example: `parent_cell = 'B cells', path_to_models = '.'`

Train the child classifier:

```
set.seed(123)
classifier_plasma <- train_classifier(train_obj = train_set,
marker_genes = selected_marker_genes_plasma, cell_type = "Plasma cells",
assay = 'counts', tag_slot = 'plasma', parent_classifier = classifier_B)
#> Apply pretrained model for parent cell type.
#> Warning: Some annotated Plasma cells are negative to B cells classifier. They are removed from training/testing for Plasma cells classifier.
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
classifier_plasma <- train_classifier(train_obj = train_set,
marker_genes = selected_marker_genes_plasma, cell_type = "Plasma cells",
assay = 'counts', tag_slot = 'plasma', parent_cell = 'B cells')
#> Parent classifier not provided. Try finding available model.
#> loading from cache
#> Apply pretrained model for parent cell type.
#> Warning: Some annotated Plasma cells are negative to B cells classifier. They are removed from training/testing for Plasma cells classifier.
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
classifier_plasma
#> An object of class scAnnotatR for Plasma cells
#> * 37 marker genes applied: BACH2, BLK, CD14, CD19, CD27, CD37, CD38, CD40LG, CD74, CD79A, CD79B, CD83, CD84, CD86, CR2, DERL3, FLI1, IGHG1, IGHG2, IGHM, IL2RA, IRF8, LRMP, LY86, MCL1, MEF2C, MME, MS4A1, MVK, MZB1, POU2AF1, PTEN, RASGRP2, SDC1, SP140, TCF3, VPREB3
#> * Predicting probability threshold: 0.5
#> * A child model of: B cells
```

```
caret_model(classifier_plasma)
#> Support Vector Machines with Linear Kernel
#>
#> No pre-processing
#> Resampling: Cross-Validated (10 fold)
#> Summary of sample sizes: 83, 83, 84, 84, 83, 85, ...
#> Addtional sampling using down-sampling
#>
#> Resampling results:
#>
#>   Accuracy   Kappa
#>   0.9205556  0.7647773
#>
#> Tuning parameter 'C' was held constant at a value of 1
```

## Test model

The parent classifier must be also set in test method.

```
classifier_plasma_test <- test_classifier(test_obj = test_set,
classifier = classifier_plasma, assay = 'counts', tag_slot = 'plasma',
parent_classifier = classifier_B)
#> Apply pretrained model for parent cell type.
#> Warning: Some annotated Plasma cells are negative to B cells classifier. They are removed from training/testing for Plasma cells classifier.
#> Current probability threshold: 0.5
#>          Positive    Negative    Total
#> Actual       24      73      97
#> Predicted    21      76      97
#> Accuracy: 0.948453608247423
#> Sensivity (True Positive Rate) for Plasma cells: 0.833333333333333
#> Specificity (1 - False Positive Rate) for Plasma cells: 0.986301369863014
#> Area under the curve: 0.913812785388128
```

### Interpreting test model result

The test result obtained from a child model can be interpreted in the same way as we do with the model for basic cell types. We can change the prediction probability threshold according to the research project or personal preference and plot a roc curve.

```
print(classifier_plasma_test$auc)
#> Area under the curve: 0.9138
roc_curve <- plot_roc_curve(test_result = classifier_plasma_test)
plot(roc_curve)
```

![](data:image/png;base64...)

## Save child classification model for further use

In order to save child classifier, the parent classifier must already exist in the classifier database, either in the package default database or in the user-defined database.

```
# see list of available model in package
default_models <- load_models('default')
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

In our package, the default models already include a model classifying plasma cells. Therefore, we will save this model to a new local database specified by the *path\_to\_models* parameter. If you start with a fresh new local database, there is no available parent classifier of plasma cells’ classifier. Therefore, we have to save the parent classifier first, e.g. the classifier for B cells.

```
# no copy of pretrained models is performed
save_new_model(new_model = classifier_B, path_to_models = tempdir(),
               include.default = FALSE)
#> Saving new models to /tmp/RtmpS3hqOY/new_models.rda...
#> Finished saving new model
save_new_model(new_model = classifier_plasma, path_to_models = tempdir(),
               include.default = FALSE)
#> Saving new models to /tmp/RtmpS3hqOY/new_models.rda...
#> Finished saving new model
```

## Applying newly trained models for cell classification

When we save the B cells’ classifier and the plasma cells’ classifier, a local database is newly created. We can use this new database to classify cells in a Seurat or SingleCellExperiment object.

Let’s try to classify cells in the test set:

```
classified <- classify_cells(classify_obj = test_set, assay = 'counts',
                             cell_types = 'all', path_to_models = tempdir())
#> i = 1...
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
```

Using the *classify\_cells()* function, we have to indicate exactly the repository containing the database that the models has recently been saved to. In the previous section, we saved our new models to the current working directory.

In the *classified* object, the classification process added new columns to the cell meta data, including the *predicted\_cell\_type* and *most\_probable\_cell\_type* columns.

If we use the full prediction to compare with actual plasma tag, we obtain this result:

```
# compare the prediction with actual cell tag
table(classified$predicted_cell_type, classified$plasma)
#>
#>                          0   1
#>   B cells               72   4
#>   B cells/Plasma cells   1  20
#>   unknown              990  27
# plasma cell is child cell type of B cell
# so of course, all predicted plasma cells are predicted B cells
```

When comparing the actual tag with the most probable prediction, we obtain:

```
# compare the prediction with actual cell tag
table(classified$most_probable_cell_type, classified$plasma)
#>
#>                  0   1
#>   B cells       72   4
#>   Plasma cells   1  20
#>   unknown      990  27
```

The number of identified plasma cells is different in the *predicted\_cell\_type* slot and in the *most\_probable\_cell\_type*. This is because the *predicted\_cell\_type* takes all predictions having the probabilities satisfying the corresponding probability thresholds. Meanwhile, the *most\_probable\_cell\_type* takes only the cell type which gives highest prediction probability.

To have all plasma cells specified as plasma cells, we can set the *ignore\_ambiguous\_result* to TRUE. This option will hide all ambiguous predictions where we have more than one possible cell type. In the parent-chid(ren) relationship of cell types, the more specified cell types/phenotypes will be reported.

```
classified <- classify_cells(classify_obj = test_set, assay = 'counts',
                             cell_types = 'all', path_to_models = tempdir(),
                             ignore_ambiguous_result = TRUE)
#> i = 1...
#> Found more than one class "package_version" in cache; using the first, from namespace 'SeuratObject'
#> Also defined by 'alabaster.base'
table(classified$predicted_cell_type, classified$plasma)
#>
#>               0   1
#>   B cells    72   4
#>   ambiguous   1  20
#>   unknown   990  27
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
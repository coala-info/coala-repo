# Code example from 'training-child-model' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# # use BiocManager to install from Bioconductor
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# # the scAnnotatR package
# if (!require(scAnnotatR))
#   BiocManager::install("scAnnotatR")

## -----------------------------------------------------------------------------
library(scAnnotatR)

## -----------------------------------------------------------------------------
default_models <- load_models('default')
classifier_B <- default_models[['B cells']]
classifier_B

## ----eval = FALSE-------------------------------------------------------------
# # we use the scRNAseq package to load example data
# if (!require(scRNAseq))
#   BiocManager::install("scRNAseq")

## -----------------------------------------------------------------------------
library(scRNAseq)

## -----------------------------------------------------------------------------
zilionis <- ZilionisLungData()
zilionis <- zilionis[, 1:5000]

# now we add simple colnames (= cell ids) to the dataset
# Note: This is normally not necessary
colnames(zilionis) <- paste0("Cell", 1:ncol(zilionis))

## -----------------------------------------------------------------------------
pivot = ncol(zilionis)%/%2
train_set <- zilionis[, 1:pivot]
test_set <- zilionis[, (1+pivot):ncol(zilionis)]

## -----------------------------------------------------------------------------
table(train_set$`Most likely LM22 cell type`)

## -----------------------------------------------------------------------------
table(test_set$`Most likely LM22 cell type`)

## -----------------------------------------------------------------------------
# remove NAs cells
train_set <- train_set[, !is.na(train_set$`Most likely LM22 cell type`)]
test_set <- test_set[, !is.na(test_set$`Most likely LM22 cell type`)]

## -----------------------------------------------------------------------------
# convert cell label: 
# 1 - positive to plasma cells, 
# 0 - negative to plasma cells
train_set$plasma <- unlist(lapply(train_set$`Most likely LM22 cell type`,
                                  function(x) if (x == 'Plasma cells') {1} else {0}))

test_set$plasma <- unlist(lapply(test_set$`Most likely LM22 cell type`,
                                 function(x) if (x == 'Plasma cells') {1} else {0}))

## -----------------------------------------------------------------------------
table(train_set$plasma)
# 1: plasma cells, 0: not plasma cells

## -----------------------------------------------------------------------------
selected_marker_genes_plasma <- c('BACH2', 'BLK', 'CD14', 'CD19', 'CD27', 'CD37', 
'CD38', 'CD40LG', 'CD74', 'CD79A', 'CD79B', 'CD83', 'CD84', 'CD86', 'CR2', 
'DERL3', 'FLI1', 'IGHG1', 'IGHG2', 'IGHM', 'IL2RA', 'IRF8', 'LRMP', 'LY86', 
'MCL1', 'MEF2C', 'MME', 'MS4A1', 'MVK', 'MZB1', 'POU2AF1', 'PTEN', 'RASGRP2', 
'SDC1', 'SP140', 'TCF3', 'VPREB3')

## -----------------------------------------------------------------------------
set.seed(123)
classifier_plasma <- train_classifier(train_obj = train_set, 
marker_genes = selected_marker_genes_plasma, cell_type = "Plasma cells", 
assay = 'counts', tag_slot = 'plasma', parent_classifier = classifier_B)

## -----------------------------------------------------------------------------
set.seed(123)
classifier_plasma <- train_classifier(train_obj = train_set, 
marker_genes = selected_marker_genes_plasma, cell_type = "Plasma cells", 
assay = 'counts', tag_slot = 'plasma', parent_cell = 'B cells')

## -----------------------------------------------------------------------------
classifier_plasma

## -----------------------------------------------------------------------------
caret_model(classifier_plasma)

## -----------------------------------------------------------------------------
classifier_plasma_test <- test_classifier(test_obj = test_set, 
classifier = classifier_plasma, assay = 'counts', tag_slot = 'plasma', 
parent_classifier = classifier_B)

## -----------------------------------------------------------------------------
print(classifier_plasma_test$auc)
roc_curve <- plot_roc_curve(test_result = classifier_plasma_test)
plot(roc_curve)

## -----------------------------------------------------------------------------
# see list of available model in package
default_models <- load_models('default')
names(default_models)

## -----------------------------------------------------------------------------
# no copy of pretrained models is performed
save_new_model(new_model = classifier_B, path_to_models = tempdir(), 
               include.default = FALSE) 
save_new_model(new_model = classifier_plasma, path_to_models = tempdir(), 
               include.default = FALSE) 

## -----------------------------------------------------------------------------
classified <- classify_cells(classify_obj = test_set, assay = 'counts', 
                             cell_types = 'all', path_to_models = tempdir())

## -----------------------------------------------------------------------------
# compare the prediction with actual cell tag
table(classified$predicted_cell_type, classified$plasma)
# plasma cell is child cell type of B cell
# so of course, all predicted plasma cells are predicted B cells 

## -----------------------------------------------------------------------------
# compare the prediction with actual cell tag
table(classified$most_probable_cell_type, classified$plasma)

## -----------------------------------------------------------------------------
classified <- classify_cells(classify_obj = test_set, assay = 'counts',
                             cell_types = 'all', path_to_models = tempdir(),
                             ignore_ambiguous_result = TRUE)
table(classified$predicted_cell_type, classified$plasma)

## -----------------------------------------------------------------------------
sessionInfo()


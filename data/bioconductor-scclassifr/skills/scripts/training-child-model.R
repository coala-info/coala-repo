# Code example from 'training-child-model' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)

## ---- eval = FALSE------------------------------------------------------------
#  # use BiocManager to install from Bioconductor
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  # the scClassifR package
#  if (!require(scClassifR))
#    BiocManager::install("scClassifR")

## -----------------------------------------------------------------------------
library(scClassifR)

## -----------------------------------------------------------------------------
data("default_models")
clf_B <- default_models[['B cells']]
clf_B

## ---- eval = FALSE------------------------------------------------------------
#  # we use the scRNAseq package to load example data
#  if (!require(scRNAseq))
#    BiocManager::install("scRNAseq")

## -----------------------------------------------------------------------------
library(scRNAseq)

## -----------------------------------------------------------------------------
zilionis <- ZilionisLungData()
zilionis <- zilionis[, 1:5000]

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
selected_features_plasma <- c("SDC1", "CD19", "BACH2", "CD74", 'CD27', "CD37", 
                              'IGHG1', 'IGHG2', 'IGHM', "CD40LG", "MCL1", "MZB1")

## -----------------------------------------------------------------------------
set.seed(123)
clf_plasma <- train_classifier(train_obj = train_set, 
features = selected_features_plasma, cell_type = "Plasma cells", 
sce_assay = 'counts', sce_tag_slot = 'plasma', parent_clf = clf_B)

## -----------------------------------------------------------------------------
set.seed(123)
clf_plasma <- train_classifier(train_obj = train_set, 
features = selected_features_plasma, cell_type = "Plasma cells", 
sce_assay = 'counts', sce_tag_slot = 'plasma', parent_cell = 'B cells')

## -----------------------------------------------------------------------------
clf_plasma

## -----------------------------------------------------------------------------
clf(clf_plasma)

## -----------------------------------------------------------------------------
clf_plasma_test <- test_classifier(test_obj = test_set, 
classifier = clf_plasma, sce_assay = 'counts', sce_tag_slot = 'plasma', 
parent_clf = clf_B)

## -----------------------------------------------------------------------------
print(clf_plasma_test$auc)
roc_curve <- plot_roc_curve(test_result = clf_plasma_test)
plot(roc_curve)

## -----------------------------------------------------------------------------
# see list of available model in package
data("default_models")
names(default_models)

## -----------------------------------------------------------------------------
# no copy of pretrained models is performed
save_new_model(new_model = clf_B, path.to.models = getwd(), 
               include.default = FALSE) 
save_new_model(new_model = clf_plasma, path.to.models = getwd(), 
               include.default = FALSE) 

## -----------------------------------------------------------------------------
classified <- classify_cells(classify_obj = test_set, sce_assay = 'counts', 
                             cell_types = 'all', path_to_models = getwd())

## -----------------------------------------------------------------------------
# compare the prediction with actual cell tag
table(classified$predicted_cell_type, classified$plasma)
# plasma cell is child cell type of B cell
# so of course, all predicted plasma cells are predicted B cells 

## -----------------------------------------------------------------------------
# compare the prediction with actual cell tag
table(classified$most_probable_cell_type, classified$plasma)

## -----------------------------------------------------------------------------
classified <- classify_cells(classify_obj = test_set, sce_assay = 'counts',
                             cell_types = 'all', path_to_models = getwd(),
                             ignore_ambiguous_result = TRUE)
table(classified$predicted_cell_type, classified$plasma)

## -----------------------------------------------------------------------------
sessionInfo()


# Code example from 'training-basic-model' vignette. See references/ for full tutorial.

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
# 
# # we use the scRNAseq package to load example data
# if (!require(scRNAseq))
#   BiocManager::install("scRNAseq")

## -----------------------------------------------------------------------------
library(scRNAseq)
library(scAnnotatR)

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
unique(train_set$`Most likely LM22 cell type`)

## -----------------------------------------------------------------------------
unique(test_set$`Most likely LM22 cell type`)

## -----------------------------------------------------------------------------
# change cell label
train_set$B_cell <- unlist(lapply(train_set$`Most likely LM22 cell type`,
                                  function(x) if (is.na(x)) {'ambiguous'} else if (x %in% c('Plasma cells', 'B cells memory', 'B cells naive')) {'B cells'} else {'others'}))

test_set$B_cell <- unlist(lapply(test_set$`Most likely LM22 cell type`,
                                 function(x) if (is.na(x)) {'ambiguous'} else if (x %in% c('Plasma cells', 'B cells memory', 'B cells naive')) {'B cells'} else {'others'}))

## -----------------------------------------------------------------------------
table(train_set$B_cell)

## -----------------------------------------------------------------------------
selected_marker_genes_B <- c("CD19", "MS4A1", "CD79A", "CD79B", 'CD27', 'IGHG1', 'IGHG2', 'IGHM',
                         "CR2", "MEF2C", 'VPREB3', 'CD86', 'LY86', "BLK", "DERL3")

## -----------------------------------------------------------------------------
set.seed(123)
classifier_B <- train_classifier(train_obj = train_set, cell_type = "B cells", 
                                 marker_genes = selected_marker_genes_B,
                                 assay = 'counts', tag_slot = 'B_cell')

## -----------------------------------------------------------------------------
classifier_B

## -----------------------------------------------------------------------------
caret_model(classifier_B)

## -----------------------------------------------------------------------------
classifier_B_test <- test_classifier(classifier = classifier_B, test_obj = test_set,  
                                     assay = 'counts', tag_slot = 'B_cell')

## -----------------------------------------------------------------------------
classifier_B_test$overall_roc

## -----------------------------------------------------------------------------
roc_curve <- plot_roc_curve(test_result = classifier_B_test)

## -----------------------------------------------------------------------------
plot(roc_curve)

## -----------------------------------------------------------------------------
# no copy of pretrained models is performed
save_new_model(new_model = classifier_B, path_to_models = tempdir(),
               include.default = FALSE) 

## -----------------------------------------------------------------------------
# delete the "B cells" model from the new database
delete_model("B cells", path_to_models = tempdir())

## -----------------------------------------------------------------------------
sessionInfo()


# Code example from 'training-basic-model' vignette. See references/ for full tutorial.

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
#  
#  # we use the scRNAseq package to load example data
#  if (!require(scRNAseq))
#    BiocManager::install("scRNAseq")

## -----------------------------------------------------------------------------
library(scRNAseq)
library(scClassifR)

## -----------------------------------------------------------------------------
zilionis <- ZilionisLungData()
zilionis <- zilionis[, 1:5000]

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
selected_features_B <- c("CD19", "MS4A1", "CD79A", "CD79B", 'CD27', 'IGHG1', 'IGHG2', 'IGHM',
                         "CR2", "MEF2C", 'VPREB3', 'CD86', 'LY86', "BLK", "DERL3")

## -----------------------------------------------------------------------------
set.seed(123)
clf_B <- train_classifier(train_obj = train_set, cell_type = "B cells", features = selected_features_B,
                          sce_assay = 'counts', sce_tag_slot = 'B_cell')

## -----------------------------------------------------------------------------
clf_B

## -----------------------------------------------------------------------------
clf(clf_B)

## -----------------------------------------------------------------------------
clf_B_test <- test_classifier(test_obj = test_set, classifier = clf_B, 
                              sce_assay = 'counts', sce_tag_slot = 'B_cell')

## -----------------------------------------------------------------------------
clf_B_test$overall_roc

## -----------------------------------------------------------------------------
roc_curve <- plot_roc_curve(test_result = clf_B_test)

## -----------------------------------------------------------------------------
plot(roc_curve)

## -----------------------------------------------------------------------------
# no copy of pretrained models is performed
save_new_model(new_model = clf_B, path.to.models = getwd(),include.default = FALSE) 

## -----------------------------------------------------------------------------
# delete the "B cells" model from the new database
delete_model("B cells", path.to.models = getwd())

## -----------------------------------------------------------------------------
sessionInfo()


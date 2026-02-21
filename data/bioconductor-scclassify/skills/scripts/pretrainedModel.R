# Code example from 'pretrainedModel' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# # installation of scClassify
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("scClassify")

## ----setup--------------------------------------------------------------------
library(scClassify)
data("scClassify_example")
wang_cellTypes <- scClassify_example$wang_cellTypes
exprsMat_wang_subset <- scClassify_example$exprsMat_wang_subset
exprsMat_wang_subset <- as(exprsMat_wang_subset, "dgCMatrix")

## -----------------------------------------------------------------------------
data("trainClassExample_xin")
trainClassExample_xin

## -----------------------------------------------------------------------------
features(trainClassExample_xin)

## -----------------------------------------------------------------------------
plotCellTypeTree(cellTypeTree(trainClassExample_xin))

## -----------------------------------------------------------------------------
pred_res <- predict_scClassify(exprsMat_test = exprsMat_wang_subset,
                               trainRes = trainClassExample_xin,
                               cellTypes_test = wang_cellTypes,
                               algorithm = "WKNN",
                               features = c("limma"),
                               similarity = c("pearson", "spearman"),
                               prob_threshold = 0.7,
                               verbose = TRUE)

## -----------------------------------------------------------------------------
table(pred_res$pearson_WKNN_limma$predRes, wang_cellTypes)

## -----------------------------------------------------------------------------
table(pred_res$spearman_WKNN_limma$predRes, wang_cellTypes)

## -----------------------------------------------------------------------------
sessionInfo()


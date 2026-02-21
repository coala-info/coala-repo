# Code example from 'scClassify' vignette. See references/ for full tutorial.

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
#     install.packages("BiocManager")
# }
# BiocManager::install("scClassify")

## ----setup--------------------------------------------------------------------
library("scClassify")
data("scClassify_example")
xin_cellTypes <- scClassify_example$xin_cellTypes
exprsMat_xin_subset <- scClassify_example$exprsMat_xin_subset
wang_cellTypes <- scClassify_example$wang_cellTypes
exprsMat_wang_subset <- scClassify_example$exprsMat_wang_subset
exprsMat_xin_subset <- as(exprsMat_xin_subset, "dgCMatrix")
exprsMat_wang_subset <- as(exprsMat_wang_subset, "dgCMatrix")

## -----------------------------------------------------------------------------
table(xin_cellTypes)
table(wang_cellTypes)

## -----------------------------------------------------------------------------
scClassify_res <- scClassify(exprsMat_train = exprsMat_xin_subset,
                             cellTypes_train = xin_cellTypes,
                             exprsMat_test = list(wang = exprsMat_wang_subset),
                             cellTypes_test = list(wang = wang_cellTypes),
                             tree = "HOPACH",
                             algorithm = "WKNN",
                             selectFeatures = c("limma"),
                             similarity = c("pearson"),
                             returnList = FALSE,
                             verbose = FALSE)


## ----warning=FALSE------------------------------------------------------------
scClassify_res$trainRes
plotCellTypeTree(cellTypeTree(scClassify_res$trainRes))

## -----------------------------------------------------------------------------
table(scClassify_res$testRes$wang$pearson_WKNN_limma$predRes, wang_cellTypes)

## -----------------------------------------------------------------------------
scClassify_res_ensemble <- scClassify(exprsMat_train = exprsMat_xin_subset,
                                      cellTypes_train = xin_cellTypes,
                                      exprsMat_test = list(wang = exprsMat_wang_subset),
                                      cellTypes_test = list(wang = wang_cellTypes),
                                      tree = "HOPACH",
                                      algorithm = "WKNN",
                                      selectFeatures = c("limma"),
                                      similarity = c("pearson", "cosine"),
                                      weighted_ensemble = FALSE,
                                      returnList = FALSE,
                                      verbose = FALSE)


## -----------------------------------------------------------------------------
table(scClassify_res_ensemble$testRes$wang$pearson_WKNN_limma$predRes,
      scClassify_res_ensemble$testRes$wang$cosine_WKNN_limma$predRes)

## -----------------------------------------------------------------------------
table(scClassify_res_ensemble$testRes$wang$ensembleRes$cellTypes, 
      wang_cellTypes)

## -----------------------------------------------------------------------------
trainClass <- train_scClassify(exprsMat_train = exprsMat_xin_subset,
                               cellTypes_train = xin_cellTypes,
                               selectFeatures = c("limma", "BI"),
                               returnList = FALSE
)

## -----------------------------------------------------------------------------
trainClass

## -----------------------------------------------------------------------------
sessionInfo()


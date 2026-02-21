# Code example from 'using_MSPrep' vignette. See references/ for full tutorial.

## ----include=FALSE, echo=FALSE------------------------------------------------
# date: "`r doc_date()`"
# "`r pkg_ver('BiocStyle')`"
# <style>
#     pre {
#     white-space: pre !important;
#     overflow-y: scroll !important;
#     height: 50vh !important;
#     }
# </style>

## ----echo=FALSE---------------------------------------------------------------
library(MSPrep)

## -----------------------------------------------------------------------------
data(msquant)
colnames(msquant)[3]

## -----------------------------------------------------------------------------
summarizedDF <- msSummarize(msquant,
                            cvMax = 0.50,
                            minPropPresent = 1/3,
                            compVars = c("mz", "rt"),
                            sampleVars = c("spike", "batch", "replicate", 
                                           "subject_id"),
                            colExtraText = "Neutral_Operator_Dif_Pos_",
                            separator = "_",
                            missingValue = 1)

## ----echo = FALSE-------------------------------------------------------------
summarizedDF[1:10, 1:6]

## -----------------------------------------------------------------------------
filteredDF <- msFilter(summarizedDF,
                       filterPercent = 0.8,
                       compVars = c("mz", "rt"),
                       sampleVars = c("spike", "batch", "subject_id"),
                       separator = "_")

## ----echo = FALSE-------------------------------------------------------------
filteredDF[1:10, 1:6]

## -----------------------------------------------------------------------------
imputedDF <- msImpute(filteredDF,
                      imputeMethod = "knn",
                      compVars = c("mz", "rt"),
                      sampleVars = c("spike", "batch", "subject_id"),
                      separator = "_",
                      returnToSE = FALSE,
                      missingValue = 0)

## ----echo = FALSE-------------------------------------------------------------
imputedDF[1:10, 1:6]

## ----message = FALSE, results = 'hide'----------------------------------------
normalizedDF <- msNormalize(imputedDF,
                            normalizeMethod = "quantile + ComBat",
                            transform = "log10",
                            compVars = c("mz", "rt"),
                            sampleVars = c("spike", "batch", "subject_id"),
                            covariatesOfInterest = c("spike"),
                            separator = "_")

## ----echo = FALSE-------------------------------------------------------------
normalizedDF[1:10, 1:6]

## ----message = FALSE, results = 'hide'----------------------------------------
preparedDF <- msPrepare(msquant,
                        minPropPresent = 1/3,
                        missingValue = 1,
                        filterPercent = 0.8,
                        imputeMethod = "knn",
                        normalizeMethod = "quantile + ComBat",
                        transform = "log10",
                        covariatesOfInterest = c("spike"),
                        compVars = c("mz", "rt"),
                        sampleVars = c("spike", "batch", "replicate", 
                                       "subject_id"),
                        colExtraText = "Neutral_Operator_Dif_Pos_",
                        separator = "_")

## ----echo = FALSE-------------------------------------------------------------
preparedDF[1:10, 1:6]

## -----------------------------------------------------------------------------
data(COPD_131)

summarizedSE131 <- msSummarize(COPD_131,
                               cvMax = 0.5,
                               minPropPresent = 1/3,
                               replicate = "replicate",
                               compVars = c("Mass", "Retention.Time", 
                                            "Compound.Name"),
                               sampleVars = c("subject_id", "replicate"),
                               colExtraText = "X",
                               separator = "_",
                               returnToSE = TRUE)


## ----echo = FALSE-------------------------------------------------------------
#head(assay(summarizedSE131))

## -----------------------------------------------------------------------------
filteredSE131 <- msFilter(summarizedSE131,
                          filterPercent = 0.8)

## ----echo = FALSE-------------------------------------------------------------
#head(assay(filteredSE131))

## -----------------------------------------------------------------------------
imputedSE131 <- msImpute(filteredSE131,
                         imputeMethod = "bpca",
                         nPcs = 3,
                         missingValue = 0)

## -----------------------------------------------------------------------------
normalizedSe131 <- msNormalize(imputedSE131,
                               normalizeMethod = "median",
                               transform = "none")

## ----echo = FALSE-------------------------------------------------------------
#head(assay(imputedSE131))

## -----------------------------------------------------------------------------
preparedSE <- msPrepare(COPD_131,
                        cvMax = 0.5,
                        minPropPresent = 1/3,
                        compVars = c("Mass", "Retention.Time", 
                                     "Compound.Name"),
                        sampleVars = c("subject_id", "replicate"),
                        colExtraText = "X",
                        separator = "_",
                        filterPercent = 0.8,
                        imputeMethod = "bpca",
                        normalizeMethod = "median",
                        transform = "none",
                        nPcs = 3,
                        missingValue = 0,
                        returnToSE = TRUE)

## ----echo = FALSE-------------------------------------------------------------
#head(assay(imputedSE131))

## -----------------------------------------------------------------------------
sessionInfo()


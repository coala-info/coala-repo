# Code example from 'cfToolsData' vignette. See references/ for full tutorial.

## ----message=FALSE------------------------------------------------------------
library(cfToolsData)
models <- c(DNN1(), DNN2())
names(models) <- c("DNN1", "DNN2")
models

## ----message=FALSE------------------------------------------------------------
tumorMarkerParams <- c(
    COAD.tumorMarkerParams.hg19(),
    LIHC.tumorMarkerParams.hg19(),
    LUNG.tumorMarkerParams.hg19(),
    STAD.tumorMarkerParams.hg19()
)
names(tumorMarkerParams) <- c(
    "COAD.tumorMarkerParams",
    "LIHC.tumorMarkerParams",
    "LUNG.tumorMarkerParams",
    "STAD.tumorMarkerParams"
)
tumorMarkerParams

## ----message=FALSE------------------------------------------------------------
tissueMarkerParams <- tissueMarkerParams.hg19()
tissueMarkerParams

tissueMarkerAnnot <- tissueMarkerParams.annot()
tissueMarkerAnnot

## -----------------------------------------------------------------------------
sessionInfo()


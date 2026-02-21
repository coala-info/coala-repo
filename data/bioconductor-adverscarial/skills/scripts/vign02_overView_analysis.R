# Code example from 'vign02_overView_analysis' vignette. See references/ for full tutorial.

## ----load libraries, warning = FALSE, message=FALSE---------------------------
library(adverSCarial)
library(LoomExperiment)
library(DelayedArray)

## ----min change attack, message=FALSE, warning = FALSE------------------------
pbmcPath <- system.file("extdata", "pbmc_short.loom", package="adverSCarial")
lfile <- import(pbmcPath, type="SingleCellLoomExperiment")

## ----load table---------------------------------------------------------------
matPbmc <- counts(lfile)

## ----visualize1, message=FALSE, warning = FALSE-------------------------------
matPbmc[1:5,1:5]

## ----Load cell type annotations, message=FALSE, warning = FALSE---------------
cellTypes <- rowData(lfile)$cell_type

## ----visualize2, message=FALSE, warning = FALSE-------------------------------
head(cellTypes)

## ----modifications for overview, warning = FALSE------------------------------
modifOutlier <- function(x, y){
    return (max(x)*1000)
}

## ----use the function, warning = FALSE----------------------------------------
modifications <- list(c("perc1"), c("full_row_fct", modifOutlier))

## ----run min change overview, warning = FALSE, message=FALSE------------------
min_change_overview <- singleGeneOverview(matPbmc, cellTypes, MClassifier,
    modifications= modifications, maxSplitSize = 20, firstDichot = 5)

## ----run min change overview bis, warning = FALSE-----------------------------
min_change_overview

## ----run max change overview, warning = FALSE, message=FALSE------------------
max_change_overview <- maxChangeOverview(matPbmc, cellTypes, MClassifier,
    modifications= modifications, maxSplitSize = 20)

## ----run max change overview bis, warning = FALSE-----------------------------
max_change_overview

## ----session info-------------------------------------------------------------
sessionInfo()


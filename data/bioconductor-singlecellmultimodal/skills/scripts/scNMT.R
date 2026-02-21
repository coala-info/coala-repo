# Code example from 'scNMT' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SingleCellMultiModal")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(SingleCellMultiModal)
library(MultiAssayExperiment)

## -----------------------------------------------------------------------------
scNMT("mouse_gastrulation", mode = "*", version = "1.0.0", dry.run = TRUE)

## -----------------------------------------------------------------------------
scNMT("mouse_gastrulation", version = "1.0.0")

## -----------------------------------------------------------------------------
scNMT("mouse_gastrulation", version = '2.0.0', dry.run = TRUE)

## ----message=FALSE------------------------------------------------------------
nmt <- scNMT("mouse_gastrulation", mode = c("*_DHS", "*_cgi", "*_genebody"),
    version = "1.0.0", dry.run = FALSE)
nmt

## -----------------------------------------------------------------------------
colData(nmt)

## -----------------------------------------------------------------------------
rownames(nmt)

## -----------------------------------------------------------------------------
sampleMap(nmt)

## -----------------------------------------------------------------------------
colnames(nmt)

## -----------------------------------------------------------------------------
head(assay(nmt, "acc_DHS"))[, 1:4]

## -----------------------------------------------------------------------------
head(assay(nmt, "met_DHS"))[, 1:4]

## -----------------------------------------------------------------------------
sessionInfo()


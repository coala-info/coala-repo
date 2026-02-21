# Code example from 'GTseq' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SingleCellMultiModal")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(SingleCellMultiModal)
library(MultiAssayExperiment)

## -----------------------------------------------------------------------------
GTseq("mouse_embryo_8_cell", mode = "*", dry.run = TRUE)

## -----------------------------------------------------------------------------
GTseq()

## ----message=FALSE------------------------------------------------------------
gts <- GTseq(dry.run = FALSE)
gts

## -----------------------------------------------------------------------------
colData(gts)

## -----------------------------------------------------------------------------
sampleMap(gts)

## -----------------------------------------------------------------------------
head(assay(gts, "genomic"))[, 1:4]

## -----------------------------------------------------------------------------
head(assay(gts, "transcriptomic"))[, 1:4]

## -----------------------------------------------------------------------------
sessionInfo()


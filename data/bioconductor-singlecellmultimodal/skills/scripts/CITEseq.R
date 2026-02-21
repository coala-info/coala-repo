# Code example from 'CITEseq' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SingleCellMultiModal")

## ----include=TRUE, results="hide", message=FALSE, warning=FALSE---------------

library(MultiAssayExperiment)
library(SingleCellMultiModal)
library(SingleCellExperiment)

## -----------------------------------------------------------------------------

CITEseq(DataType="cord_blood", modes="*", dry.run=TRUE, version="1.0.0")


## ----message=FALSE------------------------------------------------------------

mae <- CITEseq(
    DataType="cord_blood", modes="*", dry.run=FALSE, version="1.0.0"
)

mae

## -----------------------------------------------------------------------------
experiments(mae)

## -----------------------------------------------------------------------------
rownames(mae)

## -----------------------------------------------------------------------------
sampleMap(mae)

## -----------------------------------------------------------------------------
head(experiments(mae)$scRNAseq)[, 1:4]

## -----------------------------------------------------------------------------
head(experiments(mae)$scADT)[, 1:4]

## ----message=FALSE------------------------------------------------------------
sce <- CITEseq(DataType="cord_blood", modes="*", dry.run=FALSE, version="1.0.0",
              DataClass="SingleCellExperiment")
sce

## ----tidy=TRUE----------------------------------------------------------------
sessionInfo()


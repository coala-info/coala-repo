# Code example from 'seqFISH' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SingleCellMultiModal")

## ----include=TRUE, results="hide", message=FALSE, warning=FALSE---------------
library(MultiAssayExperiment)
library(SpatialExperiment)
library(SingleCellMultiModal)

## -----------------------------------------------------------------------------
seqFISH(
    DataType="mouse_visual_cortex", modes="*", dry.run=TRUE, version="2.0.0"
)

## -----------------------------------------------------------------------------
seqfish <- seqFISH(
    DataType="mouse_visual_cortex", modes="*", dry.run=FALSE, version="2.0.0"
)
seqfish

## -----------------------------------------------------------------------------
experiments(seqfish)

## -----------------------------------------------------------------------------
rownames(seqfish)

## -----------------------------------------------------------------------------
sampleMap(seqfish)

## -----------------------------------------------------------------------------
upsetSamples(seqfish)

## -----------------------------------------------------------------------------
seqfish[["scRNAseq"]]

## -----------------------------------------------------------------------------
head(assay(seqfish, "scRNAseq"))[,1:4]

## -----------------------------------------------------------------------------
seqfish[["seqFISH"]]

## -----------------------------------------------------------------------------
head(assay(seqfish, "seqFISH"))[,1:4]

## -----------------------------------------------------------------------------
(sd <- spatialData(seqfish[["seqFISH"]]))

## -----------------------------------------------------------------------------
head(sc <- spatialCoords(seqfish[["seqFISH"]]))

## -----------------------------------------------------------------------------
spatialCoordsNames(seqfish[["seqFISH"]])

## -----------------------------------------------------------------------------
seqFISH(
    DataType="mouse_visual_cortex", modes="*", dry.run=FALSE, version="1.0.0"
)

## ----tidy=TRUE----------------------------------------------------------------
sessionInfo()


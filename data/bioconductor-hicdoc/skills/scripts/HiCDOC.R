# Code example from 'HiCDOC' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
options(warn=-1)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("HiCDOC")

## -----------------------------------------------------------------------------
library(HiCDOC)

## ----tabFormat, eval = FALSE--------------------------------------------------
# hic.experiment <- HiCDOCDataSetFromTabular('path/to/data.tsv')

## ----coolFormat, eval = FALSE-------------------------------------------------
# # Path to each file
# paths = c(
#     'path/to/condition-1.replicate-1.cool',
#     'path/to/condition-1.replicate-2.cool',
#     'path/to/condition-2.replicate-1.cool',
#     'path/to/condition-2.replicate-2.cool',
#     'path/to/condition-3.replicate-1.cool'
# )
# 
# # Replicate and condition of each file. Can be names instead of numbers.
# replicates <- c(1, 2, 1, 2, 1)
# conditions <- c(1, 1, 2, 2, 3)
# 
# # Resolution to select in .mcool files
# binSize = 500000
# 
# # Instantiation of data set
# hic.experiment <- HiCDOCDataSetFromCool(
#     paths,
#     replicates = replicates,
#     conditions = conditions,
#     binSize = binSize # Specified for .mcool files.
# )

## ----hicFormat, eval = FALSE--------------------------------------------------
# # Path to each file
# paths = c(
#     'path/to/condition-1.replicate-1.hic',
#     'path/to/condition-1.replicate-2.hic',
#     'path/to/condition-2.replicate-1.hic',
#     'path/to/condition-2.replicate-2.hic',
#     'path/to/condition-3.replicate-1.hic'
# )
# 
# # Replicate and condition of each file. Can be names instead of numbers.
# replicates <- c(1, 2, 1, 2, 1)
# conditions <- c(1, 1, 2, 2, 3)
# 
# # Resolution to select
# binSize <- 500000
# 
# # Instantiation of data set
# hic.experiment <- HiCDOCDataSetFromHiC(
#     paths,
#     replicates = replicates,
#     conditions = conditions,
#     binSize = binSize
# )

## ----hicproFormat, eval = FALSE-----------------------------------------------
# # Path to each matrix file
# matrixPaths = c(
#     'path/to/condition-1.replicate-1.matrix',
#     'path/to/condition-1.replicate-2.matrix',
#     'path/to/condition-2.replicate-1.matrix',
#     'path/to/condition-2.replicate-2.matrix',
#     'path/to/condition-3.replicate-1.matrix'
# )
# 
# # Path to each bed file
# bedPaths = c(
#     'path/to/condition-1.replicate-1.bed',
#     'path/to/condition-1.replicate-2.bed',
#     'path/to/condition-2.replicate-1.bed',
#     'path/to/condition-2.replicate-2.bed',
#     'path/to/condition-3.replicate-1.bed'
# )
# 
# # Replicate and condition of each file. Can be names instead of numbers.
# replicates <- c(1, 2, 1, 2, 1)
# conditions <- c(1, 1, 2, 2, 3)
# 
# # Instantiation of data set
# hic.experiment <- HiCDOCDataSetFromHiCPro(
#     matrixPaths = matrixPaths,
#     bedPaths = bedPaths,
#     replicates = replicates,
#     conditions = conditions
# )

## ----reloadExample------------------------------------------------------------
data(exampleHiCDOCDataSet)

## ----filterSmallChromosomes---------------------------------------------------
hic.experiment <- filterSmallChromosomes(exampleHiCDOCDataSet, threshold = 100)

## ----filterSparseReplicates---------------------------------------------------
hic.experiment <- filterSparseReplicates(hic.experiment, threshold = 0.3)

## ----filterWeakPositions------------------------------------------------------
hic.experiment <- filterWeakPositions(hic.experiment, threshold = 1)

## ----normalizeTechnicalBiases-------------------------------------------------
suppressWarnings(hic.experiment <- normalizeTechnicalBiases(hic.experiment))

## ----normalizeBiologicalBiases------------------------------------------------
hic.experiment <- normalizeBiologicalBiases(hic.experiment)

## ----normalizeDistanceEffect--------------------------------------------------
hic.experiment <- 
    normalizeDistanceEffect(hic.experiment, loessSampleSize = 20000)

## ----detectCompartments-------------------------------------------------------
hic.experiment <- detectCompartments(hic.experiment)

## ----plotInteractions---------------------------------------------------------
p <- plotInteractions(hic.experiment, chromosome = "Y")
p

## ----plotDistanceEffect-------------------------------------------------------
p <- plotDistanceEffect(hic.experiment)
p

## ----extractCompartments------------------------------------------------------
compartments(hic.experiment)

## ----extractConcordances------------------------------------------------------
concordances(hic.experiment)

## ----extractDifferences-------------------------------------------------------
differences(hic.experiment)

## ----plotCompartmentChanges---------------------------------------------------
p <- plotCompartmentChanges(hic.experiment, chromosome = "Y")
p

## ----plotConcordanceDifferences-----------------------------------------------
p <- plotConcordanceDifferences(hic.experiment)
p

## ----plotCentroids------------------------------------------------------------
p <- plotCentroids(hic.experiment, chromosome = "Y")
p

## ----plotSelfInteractionRatios------------------------------------------------
p <- plotSelfInteractionRatios(hic.experiment, chromosome = "Y")
p

## ----sessionInfo--------------------------------------------------------------
sessionInfo()


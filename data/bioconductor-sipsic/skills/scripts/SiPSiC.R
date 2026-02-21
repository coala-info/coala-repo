# Code example from 'SiPSiC' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
suppressPackageStartupMessages({library(SiPSiC)})

## ----setup, eval=FALSE--------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SiPSiC")

## ----Example, warning=FALSE---------------------------------------------------
library(SiPSiC)
geneCountsMatrix <- matrix(rpois(16, lambda = 10), ncol = 4, nrow = 4)
geneCountsMatrix <- as(geneCountsMatrix, "dgCMatrix")

## Make sure your matrix is indeed a sparse matrix (of type dgCMatrix)! 

rownames(geneCountsMatrix) <- c("Gene1", "Gene2", "Gene3", "Gene4")
colnames(geneCountsMatrix) <- c("Cell1", "Cell2", "Cell3", "Cell4")
assayData <- SingleCellExperiment(assays = list(counts = geneCountsMatrix))
pathwayGenesList <- c("Gene1", "Gene2", "Gene4")
scoresAndIndices <- getPathwayScores(counts(assayData), pathwayGenesList) # The third parameter, percentForNormalization, is optional; If not specified, its value is set to 5.
pathwayScoresOfCells <- scoresAndIndices$pathwayScores
pathwayGeneIndices <- scoresAndIndices$index

## -----------------------------------------------------------------------------
sessionInfo()


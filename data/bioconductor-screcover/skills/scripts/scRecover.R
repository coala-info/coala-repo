# Code example from 'scRecover' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  collapse = TRUE,
  comment = "#>"
)

## ----Installation from Bioconductor, eval = FALSE-----------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("scRecover")

## ----Developmental version from Bioconductor, eval = FALSE--------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("scRecover", version = "devel")

## ----Installation from GitHub, eval = FALSE-----------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("miaozhun/scRecover")

## ----Load scRecover, eval = TRUE----------------------------------------------
library(scRecover)
library(BiocParallel)
suppressMessages(library(SingleCellExperiment))

## ----Load scRecoverTest-------------------------------------------------------
data(scRecoverTest)

## ----counts-------------------------------------------------------------------
dim(counts)
counts[1:6, 1:6]

## ----labels-------------------------------------------------------------------
length(labels)
table(labels)

## ----oneCell------------------------------------------------------------------
head(oneCell)
length(oneCell)

## ----demo1, eval = TRUE-------------------------------------------------------
# Load test data for scRecover
data(scRecoverTest)

# Run scRecover with Kcluster specified
scRecover(counts = counts, Kcluster = 2, outputDir = "./outDir_scRecover/", verbose = FALSE)

# Or run scRecover with labels specified
# scRecover(counts = counts, labels = labels, outputDir = "./outDir_scRecover/")

## ----demo2, eval = TRUE-------------------------------------------------------
# Load test data for scRecover
data(scRecoverTest)

# Convert the test data in scRecover to SingleCellExperiment data representation
sce <- SingleCellExperiment(assays = list(counts = as.matrix(counts)))

# Run scRecover with SingleCellExperiment input sce (Kcluster specified)
scRecover(counts = sce, Kcluster = 2, outputDir = "./outDir_scRecover/", verbose = FALSE)

# Or run scRecover with SingleCellExperiment input sce (labels specified)
# scRecover(counts = sce, labels = labels, outputDir = "./outDir_scRecover/")

## ----demo3, eval = TRUE-------------------------------------------------------
# Load test data
data(scRecoverTest)

# Downsample 10% read counts in oneCell
set.seed(999)
oneCell.down <- countsSampling(counts = oneCell, fraction = 0.1)

# Count the groundtruth dropout gene number in the downsampled cell
sum(oneCell.down == 0 & oneCell != 0)

# Estimate the dropout gene number in the downsampled cell by estDropoutNum
estDropoutNum(sample = oneCell.down, depth = 10, return = "dropoutNum")

## ----demo4, eval = FALSE------------------------------------------------------
# # Run scRecover with Kcluster specified
# scRecover(counts = counts, Kcluster = 2, parallel = TRUE)
# 
# # Run scRecover with labels specified
# scRecover(counts = counts, labels = labels, parallel = TRUE)

## ----demo5, eval = FALSE------------------------------------------------------
# # Set the parameters and register the back-end to be used
# param <- MulticoreParam(workers = 18, progressbar = TRUE)
# register(param)
# 
# # Run scRecover with 18 cores (Kcluster specified)
# scRecover(counts = counts, Kcluster = 2, parallel = TRUE, BPPARAM = param)
# 
# # Run scRecover with 18 cores (labels specified)
# scRecover(counts = counts, labels = labels, parallel = TRUE, BPPARAM = param)

## ----demo6, eval = FALSE------------------------------------------------------
# # Set the parameters and register the back-end to be used
# param <- SnowParam(workers = 8, type = "SOCK", progressbar = TRUE)
# register(param)
# 
# # Run scRecover with 8 cores (Kcluster specified)
# scRecover(counts = counts, Kcluster = 2, parallel = TRUE, BPPARAM = param)
# 
# # Run scRecover with 8 cores (labels specified)
# scRecover(counts = counts, labels = labels, parallel = TRUE, BPPARAM = param)

## ----help, eval = FALSE-------------------------------------------------------
# # Documentation for scRecover
# ?scRecover
# 
# # Documentation for estDropoutNum
# ?estDropoutNum
# 
# # Documentation for countsSampling
# ?countsSampling
# 
# # Documentation for normalization
# ?normalization
# 
# # Documentation for test data
# ?scRecoverTest
# ?counts
# ?labels
# ?oneCell

## ----sessionInfo--------------------------------------------------------------
sessionInfo()


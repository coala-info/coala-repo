# Code example from 'HDCytoData_package' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(ExperimentHub))

# Create ExperimentHub instance
ehub <- ExperimentHub()

# Find HDCytoData datasets
ehub <- query(ehub, "HDCytoData")
ehub

# Retrieve metadata table
md <- as.data.frame(mcols(ehub))

head(md, 2)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(HDCytoData))

# Load 'SummarizedExperiment' object using named function
Bodenmiller_BCR_XL_SE()

# Load 'flowSet' object using named function
Bodenmiller_BCR_XL_flowSet()

## -----------------------------------------------------------------------------
# Create ExperimentHub instance
ehub <- ExperimentHub()

# Find HDCytoData datasets
query(ehub, "HDCytoData")

# Load 'SummarizedExperiment' object using dataset ID
ehub[["EH2254"]]

# Load 'flowSet' object using dataset ID
ehub[["EH2255"]]

## -----------------------------------------------------------------------------
# Load dataset in 'SummarizedExperiment' format
d_SE <- Bodenmiller_BCR_XL_SE()

# Inspect object
d_SE
length(assays(d_SE))
assay(d_SE)[1:6, 1:6]
rowData(d_SE)
colData(d_SE)
metadata(d_SE)


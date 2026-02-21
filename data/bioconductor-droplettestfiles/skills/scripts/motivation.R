# Code example from 'motivation' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)
library(BiocStyle)

## -----------------------------------------------------------------------------
library(DropletTestFiles)
out <- listTestFiles()
out

## -----------------------------------------------------------------------------
getTestFile(out$rdatapath[1], prefix=FALSE)

## -----------------------------------------------------------------------------
library(DropletUtils)
path <- getTestFile("tenx-3.1.0-5k_pbmc_protein_v3/1.0.0/filtered.h5", prefix=TRUE)
sce <- read10xCounts(path, type="HDF5")
sce

## -----------------------------------------------------------------------------
sessionInfo()


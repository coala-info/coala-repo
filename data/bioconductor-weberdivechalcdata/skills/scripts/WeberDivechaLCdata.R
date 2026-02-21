# Code example from 'WeberDivechaLCdata' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("WeberDivechaLCdata")

## ----message=FALSE------------------------------------------------------------
library(SpatialExperiment)
library(SingleCellExperiment)
library(WeberDivechaLCdata)

## ----message=FALSE------------------------------------------------------------
# Load objects using dataset names
spe <- WeberDivechaLCdata_Visium()
sce <- WeberDivechaLCdata_singleNucleus()

## ----message=FALSE------------------------------------------------------------
library(ExperimentHub)

## ----message=FALSE------------------------------------------------------------
# create ExperimentHub instance
eh <- ExperimentHub()

# query datasets
my_files <- query(eh, "WeberDivechaLCdata")
my_files

# metadata
md <- as.data.frame(mcols(my_files))

## ----message=FALSE------------------------------------------------------------
# load data using ExperimentHub query
spe <- my_files[[1]]
sce <- my_files[[2]]

## ----message=FALSE------------------------------------------------------------
# load data using ExperimentHub IDs
# spe <- myfiles[["EHXXXX"]]
# sce <- myfiles[["EHYYYY"]]

## ----message=FALSE------------------------------------------------------------
# Visium data (SpatialExperiment format)
spe

# dimensions
dim(spe)
# assays
assayNames(spe)
# row data
rowData(spe)
# column data
colData(spe)
# spatial coordinates
head(spatialCoords(spe))
# image data
imgData(spe)

## ----message=FALSE------------------------------------------------------------
# snRNA-seq data (SingleCellExperiment format)
sce

# dimensions
dim(sce)
# assays
assayNames(sce)
# row data
rowData(sce)
# column data
colData(sce)

## -----------------------------------------------------------------------------
sessionInfo()


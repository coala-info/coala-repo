# Code example from 'STexampleData_overview' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("STexampleData")

## ----message=FALSE------------------------------------------------------------
library(SpatialExperiment)
library(STexampleData)

## ----message=FALSE------------------------------------------------------------
# load object
spe <- Visium_humanDLPFC()

# check object
spe
dim(spe)
assayNames(spe)
rowData(spe)
colData(spe)
head(spatialCoords(spe))
imgData(spe)

## ----message=FALSE------------------------------------------------------------
# load object
spe <- Visium_mouseCoronal()
# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
spe <- seqFISH_mouseEmbryo()
# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
spe <- ST_mouseOB()
# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
spe <- SlideSeqV2_mouseHPC()
# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
# note: this dataset is in SingleCellExperiment format
sce <- Janesick_breastCancer_Chromium()
# check object
sce

## ----message=FALSE------------------------------------------------------------
# load object
spe <- Janesick_breastCancer_Visium()
# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
spe <- Janesick_breastCancer_Xenium_rep1()
# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
spe <- Janesick_breastCancer_Xenium_rep2()
# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
spe <- CosMx_lungCancer()
# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
spe <- MERSCOPE_ovarianCancer()
# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
spe <- STARmapPLUS_mouseBrain()
# check object
spe

## ----message=FALSE------------------------------------------------------------
library(ExperimentHub)

## ----message=FALSE------------------------------------------------------------
# create ExperimentHub instance
eh <- ExperimentHub()

# query STexampleData datasets
myfiles <- query(eh, "STexampleData")
myfiles

# metadata
md <- as.data.frame(mcols(myfiles))

## ----message=FALSE------------------------------------------------------------
# load 'Visium_humanDLPFC' dataset using ExperimentHub query
spe <- myfiles[[9]]
spe

## ----message=FALSE------------------------------------------------------------
# load 'Visium_humanDLPFC' dataset using ExperimentHub ID
spe <- myfiles[["EH9628"]]
spe

## -----------------------------------------------------------------------------
sessionInfo()


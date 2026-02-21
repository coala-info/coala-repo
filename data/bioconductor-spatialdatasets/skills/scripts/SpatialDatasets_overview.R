# Code example from 'SpatialDatasets_overview' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SpatialDatasets")

## ----message=FALSE------------------------------------------------------------
library(SpatialExperiment)
library(SpatialDatasets)

## ----message=FALSE------------------------------------------------------------
# load object
spe <- spe_Keren_2018()

# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
zip <- Ferguson_Images()
tmp <- tempfile()
unzip(zip, exdir = tmp)

images <- cytomapper::loadImages(
  tmp,
  single_channel = TRUE,
  on_disk = TRUE,
  h5FilesPath = HDF5Array::getHDF5DumpDir()
)

# check object
images

## ----message=FALSE------------------------------------------------------------
# load object
spe <- spe_Ferguson_2022()

# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
spe <- spe_Schurch_2020()

# check object
spe

## ----message=FALSE------------------------------------------------------------
# load object
spe <- spe_Ali_2020()

# check object
spe

## ----message = FALSE----------------------------------------------------------
# load object
spe <- spe_Amancherla_2025()

# check object
spe

## ----message = FALSE----------------------------------------------------------
# load object
spe <- spe_Vannan_2025()

# check object
spe

## -----------------------------------------------------------------------------
sessionInfo()


# Code example from 'stJoincount-vignette' vignette. See references/ for full tutorial.

## ----set up, include = FALSE--------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE, warning=FALSE------------------------------------
library(stJoincount)
library(pheatmap)
library(ggplot2)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")
#   }
# BiocManager::install("stJoincount")

## -----------------------------------------------------------------------------
fpath <- system.file("extdata", "dataframe.rda", package="stJoincount")
load(fpath)
head(humanBC)

## -----------------------------------------------------------------------------
fpath <- system.file("extdata", "SeuratBC.rda", package="stJoincount")
load(fpath)
df <- dataPrepFromSeurat(seuratBC, "label")

## -----------------------------------------------------------------------------
fpath <- system.file("extdata", "SpeBC.rda", package="stJoincount")
load(fpath)
df2 <- dataPrepFromSpE(SpeObjBC, "label")

## -----------------------------------------------------------------------------
resolutionList <- resolutionCalc(humanBC)
resolutionList

## -----------------------------------------------------------------------------
mosaicIntegration <- rasterizeEachCluster(humanBC)

## ----fig.dim = c(6, 6)--------------------------------------------------------
mosaicIntPlot(humanBC, mosaicIntegration)

## -----------------------------------------------------------------------------
joincount.result <- joincountAnalysis(mosaicIntegration)

## ----fig.dim = c(6, 6)--------------------------------------------------------
matrix <- zscoreMatrix(humanBC, joincount.result)
zscorePlot(matrix)

## -----------------------------------------------------------------------------
sessionInfo()


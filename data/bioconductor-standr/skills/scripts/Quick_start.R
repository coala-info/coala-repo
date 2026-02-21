# Code example from 'Quick_start' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE, include=FALSE------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("standR")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("DavisLaboratory/standR")

## ----message = FALSE, warning = FALSE-----------------------------------------
library(standR)
library(SpatialExperiment)
library(limma)
library(ExperimentHub)

## ----message = FALSE, warning = FALSE-----------------------------------------
eh <- ExperimentHub()

query(eh, "standR")

countFile <- eh[["EH7364"]]
sampleAnnoFile <- eh[["EH7365"]]
featureAnnoFile <- eh[["EH7366"]]

spe <- readGeoMx(countFile, sampleAnnoFile, featureAnnoFile = featureAnnoFile, rmNegProbe = TRUE)


## -----------------------------------------------------------------------------
colData(spe)$regions <- paste0(colData(spe)$region,"_",colData(spe)$SegmentLabel) |> 
  (\(.) gsub("_Geometric Segment","",.))() |>
  paste0("_",colData(spe)$pathology) |>
  (\(.) gsub("_NA","_ns",.))()

library(ggalluvial)

plotSampleInfo(spe, column2plot = c("SlideName","disease_status","regions"))

## -----------------------------------------------------------------------------
spe <- addPerROIQC(spe, rm_genes = TRUE)

## -----------------------------------------------------------------------------
plotGeneQC(spe, ordannots = "regions", col = regions, point_size = 2)

## -----------------------------------------------------------------------------
plotROIQC(spe, y_threshold = 50000, col = SlideName)

## -----------------------------------------------------------------------------
spe <- spe[,rownames(colData(spe))[colData(spe)$lib_size > 50000]]

## -----------------------------------------------------------------------------
plotRLExpr(spe, ordannots = "SlideName", assay = 2, col = SlideName)

## -----------------------------------------------------------------------------
drawPCA(spe, assay = 2, col = SlideName, shape = regions)

## -----------------------------------------------------------------------------
colData(spe)$biology <- paste0(colData(spe)$disease_status, "_", colData(spe)$regions)

spe_tmm <- geomxNorm(spe, method = "TMM")

## -----------------------------------------------------------------------------
spe <- findNCGs(spe, batch_name = "SlideName", top_n = 500)

metadata(spe) |> names()

## -----------------------------------------------------------------------------
spe_ruv <- geomxBatchCorrection(spe, factors = "biology", 
                   NCGs = metadata(spe)$NCGs, k = 5)

## -----------------------------------------------------------------------------
plotPairPCA(spe_ruv, assay = 2, color = disease_status, shape = regions, title = "RUV4")

## -----------------------------------------------------------------------------
plotRLExpr(spe_ruv, assay = 2, color = SlideName) + ggtitle("RUV4")


## -----------------------------------------------------------------------------
sessionInfo()


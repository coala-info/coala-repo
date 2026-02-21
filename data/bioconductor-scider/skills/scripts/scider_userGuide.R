# Code example from 'scider_userGuide' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE, include=FALSE------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE, dpi = 72)
suppressWarnings(library(ggplot2))
suppressMessages(library(scider))
suppressMessages(library(SpatialExperiment))

setClassUnion("ExpData", c("matrix", "SummarizedExperiment"))

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("scider")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("ChenLaboratory/scider")

## -----------------------------------------------------------------------------
library(scider)
library(SpatialExperiment)

## -----------------------------------------------------------------------------
data("xenium_bc_spe")

## -----------------------------------------------------------------------------
spe

## -----------------------------------------------------------------------------
table(colData(spe)$cell_type)

## ----fig.width=5, fig.height=4------------------------------------------------
plotSpatial(spe, group.by = "cell_type", pt.alpha = 0.8)

## -----------------------------------------------------------------------------
spe <- gridDensity(spe)
names(metadata(spe))

## -----------------------------------------------------------------------------
metadata(spe)$grid_density

## ----fig.width=5, fig.height=4------------------------------------------------
plotDensity(spe)

## ----fig.width=5, fig.height=4------------------------------------------------
plotDensity(spe, coi = "Fibroblasts")

## -----------------------------------------------------------------------------
spe <- findROI(spe, coi = "Fibroblasts")
metadata(spe)$fibroblasts_roi

## ----fig.width=5, fig.height=5------------------------------------------------
plotROI(spe, roi = "Fibroblasts")

## ----eval=FALSE---------------------------------------------------------------
# selectRegion(metadata(spe)$grid_density, x.col = "x_grid", y.col = "y_grid")

## ----eval=FALSE---------------------------------------------------------------
# sel_region

## ----eval=FALSE---------------------------------------------------------------
# spe1 <- postSelRegion(spe, sel_region = sel_region)
# metadata(spe1)$roi

## ----eval=FALSE---------------------------------------------------------------
# plotROI(spe1)

## -----------------------------------------------------------------------------
results <- corDensity(spe, roi = "Fibroblasts")

## -----------------------------------------------------------------------------
results$ROI

## -----------------------------------------------------------------------------
results$overall

## ----fig.width=8, fig.height=6------------------------------------------------
plotDensCor(spe, celltype1 = "Breast cancer", celltype2 = "Fibroblasts")

## ----fig.width=7, fig.height=4------------------------------------------------
plotCorHeatmap(results$ROI)

## ----fig.width=7, fig.height=4------------------------------------------------
plotCorHeatmap(results$overall)

## -----------------------------------------------------------------------------
spe <- getContour(spe, coi = "Fibroblasts", equal.cell = TRUE)

## ----fig.width=5, fig.height=4------------------------------------------------
plotContour(spe, coi = "Fibroblasts")

## -----------------------------------------------------------------------------
spe <- allocateCells(spe)

## ----fig.width=6, fig.height=4------------------------------------------------
plotSpatial(spe, group.by = "fibroblasts_contour", pt.alpha = 0.5)

## ----fig.width=6, fig.height=4------------------------------------------------
plotCellCompo(spe, contour = "Fibroblasts")

## ----fig.width=7, fig.height=5------------------------------------------------
plotCellCompo(spe, contour = "Fibroblasts", roi = "Fibroblasts")

## -----------------------------------------------------------------------------
sessionInfo()


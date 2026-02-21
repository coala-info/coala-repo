# Code example from 'Quick_start' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE, include=FALSE------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE, dpi = 80)
suppressWarnings(library(ggplot2))



## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# 
# BiocManager::install("hoodscanR")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("DavisLaboratory/hoodscanR")

## -----------------------------------------------------------------------------
library(hoodscanR)
library(SpatialExperiment)
library(scico)

## -----------------------------------------------------------------------------
data("spe_test")

spe <- readHoodData(spe, anno_col = "celltypes")

## -----------------------------------------------------------------------------
spe

## -----------------------------------------------------------------------------
colData(spe)

## ----fig.width=7, fig.height=4------------------------------------------------
col.pal <- c("red3", "royalblue", "gold", "cyan2", "purple3", "darkgreen")

plotTissue(spe, color = cell_annotation, size = 1.5, alpha = 0.8) +
  scale_color_manual(values = col.pal)

## -----------------------------------------------------------------------------
fnc <- findNearCells(spe, k = 100)

## -----------------------------------------------------------------------------
lapply(fnc, function(x) x[1:10, 1:5])

## -----------------------------------------------------------------------------
pm <- scanHoods(fnc$distance)

## -----------------------------------------------------------------------------
pm[1:10, 1:5]

## -----------------------------------------------------------------------------
hoods <- mergeByGroup(pm, fnc$cells)

## -----------------------------------------------------------------------------
hoods[1:10, ]

## ----fig.width=5, fig.height=4------------------------------------------------
plotHoodMat(hoods, n = 10, hm_height = 5)

## ----fig.width=5, fig.height=4------------------------------------------------
plotHoodMat(hoods, targetCells = c("Lung9_Rep1_5_1975", "Lung9_Rep1_5_2712"), hm_height = 3)

## -----------------------------------------------------------------------------
spe <- mergeHoodSpe(spe, hoods)

## -----------------------------------------------------------------------------
spe <- calcMetrics(spe, pm_cols = colnames(hoods))

## ----fig.width=7, fig.height=4------------------------------------------------
plotTissue(spe, size = 1.5, color = entropy) +
  scale_color_scico(palette = "tokyo")

## ----fig.width=7, fig.height=4------------------------------------------------
plotTissue(spe, size = 1.5, color = perplexity) +
  scale_color_scico(palette = "tokyo")

## ----fig.width=6, fig.height=4------------------------------------------------
plotColocal(spe, pm_cols = colnames(hoods))

## -----------------------------------------------------------------------------
spe <- clustByHood(spe, pm_cols = colnames(hoods), k = 10)

## ----fig.width=6, fig.height=5------------------------------------------------
plotProbDist(spe, pm_cols = colnames(hoods), by_cluster = TRUE, plot_all = TRUE, show_clusters = as.character(seq(10)))

## ----fig.width=7, fig.height=4------------------------------------------------
plotTissue(spe, color = clusters)

## -----------------------------------------------------------------------------
sessionInfo()


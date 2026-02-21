# Code example from 'iSEEhex' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(
    error=FALSE,
    warning=FALSE,
    message=FALSE,
    out.width='100%')
library(BiocStyle)

## ----eval=!exists("SCREENSHOT"), include=FALSE--------------------------------
SCREENSHOT <- function(x, ...) knitr::include_graphics(x)

## -----------------------------------------------------------------------------
library(iSEEhex)

## -----------------------------------------------------------------------------
library(scRNAseq)

# Example data ----
sce <- ReprocessedAllenData(assays="tophat_counts")
class(sce)

library(scater)
sce <- logNormCounts(sce, exprs_values="tophat_counts")

sce <- runPCA(sce, ncomponents=4)
sce <- runTSNE(sce)
rowData(sce)$ave_count <- rowMeans(assay(sce, "tophat_counts"))
rowData(sce)$n_cells <- rowSums(assay(sce, "tophat_counts") > 0)
sce

## -----------------------------------------------------------------------------
initialPanels <- list(
    ReducedDimensionPlot(
        ColorBy = "Feature name", ColorByFeatureName = "Cux2", PanelWidth = 6L),
    ReducedDimensionHexPlot(
        ColorBy = "Feature name", ColorByFeatureName = "Cux2", PanelWidth = 6L,
        BinResolution = 30)
)
app <- iSEE(se = sce, initial = initialPanels)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/reduced-dimension-hex-plot.png")

## -----------------------------------------------------------------------------
sessionInfo()


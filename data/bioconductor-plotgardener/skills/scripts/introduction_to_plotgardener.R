# Code example from 'introduction_to_plotgardener' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    fig.align = "center",
    fig.width = 3,
    fig.height = 3,
    collapse = TRUE,
    warning = FALSE,
    message = FALSE
)
library(grid)
library(plotgardener)
library(plotgardenerData)

## ----hic_quickplot, eval=TRUE, echo=TRUE, message=FALSE-----------------------
## Load plotgardener
library(plotgardener)

## Load example Hi-C data
library(plotgardenerData)
data("IMR90_HiC_10kb")

## Quick plot Hi-C data
plotHicSquare(
    data = IMR90_HiC_10kb,
    chrom = "chr21", chromstart = 28000000, chromend = 30300000,
    assembly = "hg19"
)

## ----signal_quickplot, eval=TRUE, echo=TRUE, message=FALSE--------------------
## Load plotgardener
library(plotgardener)

## Load example signal data
library(plotgardenerData)
data("IMR90_ChIP_H3K27ac_signal")

## Quick plot signal data
plotSignal(
    data = IMR90_ChIP_H3K27ac_signal,
    chrom = "chr21", chromstart = 28000000, chromend = 30300000,
    assembly = "hg19"
)

## ----gene_quickplot, eval=TRUE, echo=TRUE, message=FALSE----------------------
## Load plotgardener
library(plotgardener)

## Load hg19 genomic annotation packages
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)

## Quick plot genes
plotGenes(
    assembly = "hg19",
    chrom = "chr21", chromstart = 28000000, chromend = 30300000
)

## ----gwas_quickplot, eval=TRUE, echo=TRUE, message=FALSE----------------------
## Load plotgardener
library(plotgardener)

## Load hg19 genomic annotation packages
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

## Load example GWAS data
library(plotgardenerData)
data("hg19_insulin_GWAS")

## Quick plot GWAS data
plotManhattan(
    data = hg19_insulin_GWAS, 
    assembly = "hg19",
    fill = c("steel blue", "grey"),
    ymax = 1.1, cex = 0.20
)

## ----quickpage, echo=TRUE, fig.height=4, fig.width=4, message=FALSE-----------
pageCreate(width = 3.25, height = 3.25, default.units = "inches")

## ----eval=FALSE, echo=TRUE, message=FALSE-------------------------------------
# data("IMR90_HiC_10kb")
# hicPlot <- plotHicSquare(
#     data = IMR90_HiC_10kb,
#     chrom = "chr21", chromstart = 28000000, chromend = 30300000,
#     assembly = "hg19",
#     x = 0.25, y = 0.25, width = 2.5, height = 2.5, default.units = "inches"
# )

## ----quickpageHic, echo=FALSE, fig.height=4, fig.width=4, message=FALSE-------
pageCreate(width = 3.25, height = 3.25, default.units = "inches")
data("IMR90_HiC_10kb")
hicPlot <- plotHicSquare(
    data = IMR90_HiC_10kb,
    chrom = "chr21", chromstart = 28000000, chromend = 30300000,
    assembly = "hg19",
    x = 0.25, y = 0.25, width = 2.5, height = 2.5, default.units = "inches"
)

## ----eval=FALSE, echo=TRUE, message=FALSE-------------------------------------
# annoHeatmapLegend(
#     plot = hicPlot,
#     x = 2.85, y = 0.25, width = 0.1, height = 1.25, default.units = "inches"
# )
# 
# annoGenomeLabel(
#     plot = hicPlot,
#     x = 0.25, y = 2.75, width = 2.5, height = 0.25, default.units = "inches"
# )

## ----quickpageAnno, echo=FALSE, fig.height=4, fig.width=4, message=FALSE------
pageCreate(width = 3.25, height = 3.25, default.units = "inches")
data("IMR90_HiC_10kb")
hicPlot <- plotHicSquare(
    data = IMR90_HiC_10kb,
    chrom = "chr21", chromstart = 28000000, chromend = 30300000,
    assembly = "hg19",
    x = 0.25, y = 0.25, width = 2.5, height = 2.5, default.units = "inches"
)
annoHeatmapLegend(
    plot = hicPlot,
    x = 2.85, y = 0.25, width = 0.1, height = 1.25, default.units = "inches"
)

annoGenomeLabel(
    plot = hicPlot,
    x = 0.25, y = 2.75, width = 2.5, height = 0.25, default.units = "inches"
)

## ----eval=FALSE, echo=TRUE, message=FALSE-------------------------------------
# pageGuideHide()

## ----quickpageHide, echo=FALSE, fig.height=4, fig.width=4, message=FALSE------
pageCreate(
    width = 3.25, height = 3.25, default.units = "inches",
    xgrid = 0, ygrid = 0, showGuides = FALSE
)
data("IMR90_HiC_10kb")
hicPlot <- plotHicSquare(
    data = IMR90_HiC_10kb,
    chrom = "chr21", chromstart = 28000000, chromend = 30300000,
    assembly = "hg19",
    x = 0.25, y = 0.25, width = 2.5, height = 2.5, default.units = "inches"
)
annoHeatmapLegend(
    plot = hicPlot,
    x = 2.85, y = 0.25, width = 0.1, height = 1.25, default.units = "inches"
)

annoGenomeLabel(
    plot = hicPlot,
    x = 0.25, y = 2.75, width = 2.5, height = 0.25, default.units = "inches"
)

## ----eval=FALSE, echo=TRUE, message=FALSE-------------------------------------
# pdf(width = 3.25, height = 3.25)
# 
# pageCreate(width = 3.25, height = 3.25, default.units = "inches")
# data("IMR90_HiC_10kb")
# hicPlot <- plotHicSquare(
#     data = IMR90_HiC_10kb,
#     chrom = "chr21", chromstart = 28000000, chromend = 30300000,
#     assembly = "hg19",
#     x = 0.25, y = 0.25, width = 2.5, height = 2.5, default.units = "inches"
# )
# annoHeatmapLegend(
#     plot = hicPlot,
#     x = 2.85, y = 0.25, width = 0.1, height = 1.25, default.units = "inches"
# )
# 
# annoGenomeLabel(
#     plot = hicPlot,
#     x = 0.25, y = 2.75, width = 2.5, height = 0.25, default.units = "inches"
# )
# pageGuideHide()
# 
# dev.off()

## -----------------------------------------------------------------------------
sessionInfo()


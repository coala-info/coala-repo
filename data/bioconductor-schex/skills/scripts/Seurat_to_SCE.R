# Code example from 'Seurat_to_SCE' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)
library(ggplot2)
theme_set(theme_classic())

## ----load-libraries, message=FALSE, warning=FALSE-----------------------------
library(schex)
library(dplyr)
library(Seurat)

## -----------------------------------------------------------------------------
pbmc_small

## ----umap, message=FALSE, warning=FALSE---------------------------------------
set.seed(10)
pbmc_small <- RunUMAP(pbmc_small,
    dims = 1:10,
    verbose = FALSE
)

## ----seurat-to-sce, message=FALSE, warning=FALSE------------------------------
pbmc.sce <- as.SingleCellExperiment(pbmc_small)

## ----calc-hexbin--------------------------------------------------------------
pbmc.sce <- make_hexbin(pbmc.sce,
    nbins = 10,
    dimension_reduction = "UMAP"
)

## ----plot-density, fig.height=7, fig.width=7----------------------------------
plot_hexbin_density(pbmc.sce)

## ----plot-meta-1, fig.height=7, fig.width=7-----------------------------------
plot_hexbin_meta(pbmc.sce, col = "nCount_RNA", action = "median")

## ----plot-gene, fig.height=7, fig.width=7-------------------------------------
gene_id <- "CD1C"
schex::plot_hexbin_feature(pbmc.sce,
    type = "counts", feature = gene_id,
    action = "mean", xlab = "UMAP1", ylab = "UMAP2",
    title = paste0("Mean of ", gene_id)
)

## -----------------------------------------------------------------------------
gene_id <- "CD1C"
gg <- schex::plot_hexbin_feature(pbmc.sce,
    type = "counts", feature = gene_id,
    action = "mean", xlab = "UMAP1", ylab = "UMAP2",
    title = paste0("Mean of ", gene_id)
)
gg + theme_void()

## ----eval=FALSE---------------------------------------------------------------
# ggsave(gg, file = "schex_plot.pdf")

## -----------------------------------------------------------------------------
sessionInfo()


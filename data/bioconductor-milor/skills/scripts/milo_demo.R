# Code example from 'milo_demo' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = FALSE
)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(miloR)
library(SingleCellExperiment)
library(scater)
library(scran)
library(dplyr)
library(patchwork)

## -----------------------------------------------------------------------------
data("sim_trajectory", package = "miloR")

## Extract SingleCellExperiment object
traj_sce <- sim_trajectory[['SCE']]

## Extract sample metadata to use for testing
traj_meta <- sim_trajectory[["meta"]]

## Add metadata to colData slot
colData(traj_sce) <- DataFrame(traj_meta)
colnames(traj_sce) <- colData(traj_sce)$cell_id

redim <- reducedDim(traj_sce, "PCA")
dimnames(redim) <- list(colnames(traj_sce), paste0("PC", c(1:50)))
reducedDim(traj_sce, "PCA") <- redim 

## -----------------------------------------------------------------------------
logcounts(traj_sce) <- log(counts(traj_sce) + 1)
traj_sce <- runPCA(traj_sce, ncomponents=30)
traj_sce <- runUMAP(traj_sce)

plotUMAP(traj_sce)

## -----------------------------------------------------------------------------
traj_milo <- Milo(traj_sce)
reducedDim(traj_milo, "UMAP") <- reducedDim(traj_sce, "UMAP")

traj_milo

## ----eval=FALSE---------------------------------------------------------------
# library(zellkonverter)
# 
# # Obtaining an example H5AD file.
# example_h5ad <- system.file("extdata", "krumsiek11.h5ad",
#                             package = "zellkonverter")
# 
# example_h5ad_sce <- readH5AD(example_h5ad)
# example_h5ad_milo <- Milo(example_h5ad_sce)

## ----eval=FALSE---------------------------------------------------------------
# library(Seurat)
# data("pbmc_small")
# pbmc_small_sce <- as.SingleCellExperiment(pbmc_small)
# pbmc_small_milo <- Milo(pbmc_small_sce)

## -----------------------------------------------------------------------------
traj_milo <- buildGraph(traj_milo, k = 10, d = 30)

## -----------------------------------------------------------------------------
traj_milo <- makeNhoods(traj_milo, prop = 0.1, k = 10, d=30, refined = TRUE)

## -----------------------------------------------------------------------------
plotNhoodSizeHist(traj_milo)

## -----------------------------------------------------------------------------
traj_milo <- countCells(traj_milo, meta.data = data.frame(colData(traj_milo)), samples="Sample")

## -----------------------------------------------------------------------------
head(nhoodCounts(traj_milo))

## -----------------------------------------------------------------------------
traj_design <- data.frame(colData(traj_milo))[,c("Sample", "Condition")]
traj_design <- distinct(traj_design)
rownames(traj_design) <- traj_design$Sample
## Reorder rownames to match columns of nhoodCounts(milo)
traj_design <- traj_design[colnames(nhoodCounts(traj_milo)), , drop=FALSE]

traj_design

## -----------------------------------------------------------------------------
traj_milo <- calcNhoodDistance(traj_milo, d=30)

## -----------------------------------------------------------------------------
rownames(traj_design) <- traj_design$Sample
da_results <- testNhoods(traj_milo, design = ~ Condition, design.df = traj_design)

## -----------------------------------------------------------------------------
da_results %>%
  arrange(- SpatialFDR) %>%
  head() 

## ----fig.width=10, fig.height=6-----------------------------------------------
traj_milo <- buildNhoodGraph(traj_milo)

plotUMAP(traj_milo) + plotNhoodGraphDA(traj_milo, da_results, alpha=0.05) +
  plot_layout(guides="collect")

## -----------------------------------------------------------------------------
sessionInfo()


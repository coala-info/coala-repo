# Code example from 'decontPro' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install, eval= FALSE-----------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("decontX")

## ----load, message=FALSE------------------------------------------------------
library(decontX)

## ----message=FALSE------------------------------------------------------------
library(SingleCellMultiModal)
dat <- CITEseq("cord_blood", dry.run = FALSE)
counts <- experiments(dat)$scADT

## -----------------------------------------------------------------------------
set.seed(42)
sample_id <- sample(dim(counts)[2], 1000, replace = FALSE)
counts_sample <- counts[, sample_id]

## ----message=FALSE------------------------------------------------------------
library(Seurat)
library(dplyr)
adt_seurat <- CreateSeuratObject(counts_sample, assay = "ADT")
adt_seurat <- NormalizeData(adt_seurat, normalization.method = "CLR", margin = 2) %>%
  ScaleData(assay = "ADT") %>%
  RunPCA(assay = "ADT", features = rownames(adt_seurat), npcs = 10,
  reduction.name = "pca_adt") %>%
  FindNeighbors(dims = 1:10, assay = "ADT", reduction = "pca_adt") %>%
  FindClusters(resolution = 0.5)

## ----message=FALSE------------------------------------------------------------
adt_seurat <- RunUMAP(adt_seurat,
                      dims = 1:10,
                      assay = "ADT",
                      reduction = "pca_adt",
                      reduction.name = "adtUMAP",
                      verbose = FALSE)
DimPlot(adt_seurat, reduction = "adtUMAP", label = TRUE)
FeaturePlot(adt_seurat, 
            features = c("CD3", "CD4", "CD8", "CD19", "CD14", "CD16", "CD56"))

clusters <- as.integer(Idents(adt_seurat))

## ----eval=FALSE---------------------------------------------------------------
# counts <- as.matrix(counts_sample)
# out <- decontPro(counts,
#                 clusters)

## ----message=FALSE------------------------------------------------------------
counts <- as.matrix(counts_sample)
out <- decontPro(counts,
                 clusters,
                 delta_sd = 2e-4,
                 background_sd = 2e-5)

## -----------------------------------------------------------------------------
decontaminated_counts <- out$decontaminated_counts

## -----------------------------------------------------------------------------
plotDensity(counts,
            decontaminated_counts,
            c("CD3", "CD4", "CD8", "CD14", "CD16", "CD19"))

## -----------------------------------------------------------------------------
plotBoxByCluster(counts,
                 decontaminated_counts,
                 clusters,
                 c("CD3", "CD4", "CD8", "CD16"))

## -----------------------------------------------------------------------------
sessionInfo()


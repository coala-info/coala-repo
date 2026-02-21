# Code example from 'decontX' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, dev = "png")

## ----install, eval= FALSE-----------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("decontX")

## ----load, message=FALSE------------------------------------------------------
library(decontX)

## ----sce_import, eval = FALSE-------------------------------------------------
# library(singleCellTK)
# sce <- importCellRanger(sampleDirs = c("path/to/sample1/", "path/to/sample2/"))

## ----sce_import_raw, eval = FALSE---------------------------------------------
# sce.raw <- importCellRanger(sampleDirs = c("path/to/sample1/", "path/to/sample2/"), dataType = "raw")

## ----load_10X, eval=TRUE, message=FALSE---------------------------------------
# Load PBMC data
library(TENxPBMCData)
sce <- TENxPBMCData("pbmc4k")
colnames(sce) <- paste(sce$Sample, sce$Barcode, sep = "_")
rownames(sce) <- rowData(sce)$Symbol_TENx
counts(sce) <- as(counts(sce), "dgCMatrix")

## ----decontX, eval=TRUE, message=FALSE----------------------------------------
sce <- decontX(sce)

## ----decontX_background, eval=FALSE, message=FALSE----------------------------
# sce <- decontX(sce, background = sce.raw)

## ----UMAP_Clusters------------------------------------------------------------
library(celda) # To use plotting functions in celda
umap <- reducedDim(sce, "decontX_UMAP")
plotDimReduceCluster(x = sce$decontX_clusters,
    dim1 = umap[, 1], dim2 = umap[, 2])

## ----plot_decon---------------------------------------------------------------
plotDecontXContamination(sce)

## ----plot_feature, message=FALSE----------------------------------------------
library(scater)
sce <- logNormCounts(sce)
plotDimReduceFeature(as.matrix(logcounts(sce)),
    dim1 = umap[, 1],
    dim2 = umap[, 2],
    features = c("CD3D", "CD3E", "GNLY",
        "LYZ", "S100A8", "S100A9",
        "CD79A", "CD79B", "MS4A1"),
    exactMatch = TRUE)

## ----barplotCounts------------------------------------------------------------
markers <- list(Tcell_Markers = c("CD3E", "CD3D"),
    Bcell_Markers = c("CD79A", "CD79B", "MS4A1"),
    Monocyte_Markers = c("S100A8", "S100A9", "LYZ"),
    NKcell_Markers = "GNLY")
cellTypeMappings <- list(Tcells = 2, Bcells = 5, Monocytes = 1, NKcells = 6)
plotDecontXMarkerPercentage(sce,
    markers = markers,
    groupClusters = cellTypeMappings,
    assayName = "counts")

## ----barplotDecontCounts------------------------------------------------------
plotDecontXMarkerPercentage(sce,
    markers = markers,
    groupClusters = cellTypeMappings,
    assayName = "decontXcounts")

## ----barplotBoth--------------------------------------------------------------
plotDecontXMarkerPercentage(sce,
    markers = markers,
    groupClusters = cellTypeMappings,
    assayName = c("counts", "decontXcounts"))

## ----plotDecontXMarkerExpression----------------------------------------------
plotDecontXMarkerExpression(sce,
    markers = markers[["Monocyte_Markers"]],
    groupClusters = cellTypeMappings,
    ncol = 3)

## ----plot_norm_counts, eval = TRUE--------------------------------------------
library(scater)
sce <- logNormCounts(sce,
    exprs_values = "decontXcounts",
    name = "decontXlogcounts")

plotDecontXMarkerExpression(sce,
    markers = markers[["Monocyte_Markers"]],
    groupClusters = cellTypeMappings,
    ncol = 3,
    assayName = c("logcounts", "decontXlogcounts"))

## ----findDelta----------------------------------------------------------------
metadata(sce)$decontX$estimates$all_cells$delta

## ----newDecontX, eval=TRUE, message=FALSE-------------------------------------
sce.delta <- decontX(sce, delta = c(9, 20), estimateDelta = FALSE)

plot(sce$decontX_contamination, sce.delta$decontX_contamination,
     xlab = "DecontX estimated priors",
     ylab = "Setting priors to estimate higher contamination")
abline(0, 1, col = "red", lwd = 2)

## ----seurat_create, eval = FALSE----------------------------------------------
# # Read counts from CellRanger output
# library(Seurat)
# counts <- Read10X("sample/outs/filtered_feature_bc_matrix/")
# 
# # Create a SingleCellExperiment object and run decontX
# sce <- SingleCellExperiment(list(counts = counts))
# sce <- decontX(sce)
# 
# # Create a Seurat object from a SCE with decontX results
# seuratObject <- CreateSeuratObject(round(decontXcounts(sce)))

## ----seurat_raw, eval = FALSE-------------------------------------------------
# counts.raw <- Read10X("sample/outs/raw_feature_bc_matrix/")
# sce.raw <- SingleCellExperiment(list(counts = counts.raw))
# sce <- decontX(sce, background = sce.raw)

## ----seurat_create2, eval = FALSE---------------------------------------------
# counts <- GetAssayData(object = seuratObject, slot = "counts")
# sce <- SingleCellExperiment(list(counts = counts))
# sce <- decontX(sce)
# seuratObj[["decontXcounts"]] <- CreateAssayObject(counts = decontXcounts(sce))

## -----------------------------------------------------------------------------
sessionInfo()


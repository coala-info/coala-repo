---
name: r-seurat
description: Seurat is an R toolkit for the exploration, integration, and interpretation of single-cell and spatial omics data. Use when user asks to perform quality control, normalize and scale data, cluster cells, integrate multiple datasets, or analyze spatial transcriptomics.
homepage: https://anaconda.org/channels/r/packages/r-seurat/overview
metadata:
  docker_image: "satijalab/seurat:latest"
---


# r-seurat

## Overview

Seurat is a comprehensive R toolkit designed for the exploration and interpretation of single-cell omics data. It enables researchers to identify sources of biological heterogeneity and integrate diverse data types. This skill focuses on the native R implementation of Seurat v5, emphasizing streamlined integration workflows, memory-efficient analysis of massive datasets via bit-packing (BPCells), and advanced spatial genomics capabilities.

## Core Workflow Best Practices

### 1. Data Initialization and QC
Always start by creating a Seurat object and performing standard quality control to filter out low-quality cells (dying cells or doublets).
- **Standard QC**: Filter based on `nFeature_RNA` (unique genes) and `percent.mt` (mitochondrial content).
- **V5 Layers**: Seurat v5 uses "layers" (counts, data, scale.data) to manage multiple datasets within a single object, replacing the need for frequent object splitting.

### 2. Normalization and Scaling
- **SCTransform v2**: Use `SCTransform()` for a more robust normalization that handles technical variation better than standard log-normalization. It performs normalization, variable feature selection, and scaling in one step.
- **Memory Efficiency**: For large datasets, ensure `vst.flavor = "v2"` is set within `SCTransform`.

### 3. Dimensional Reduction and Clustering
- **PCA**: Run `RunPCA()` on variable features.
- **Clustering**: Use `FindNeighbors()` followed by `FindClusters()`. In v5, the Leiden algorithm (via `method = "igraph"` and `algorithm = 4`) is often preferred for its mathematical properties.
- **Visualization**: Use `RunUMAP()` or `RunTSNE()` for non-linear embedding.

### 4. Seurat v5 Integration
Integration in v5 is streamlined through the `IntegrateLayers()` function.
- **Methods**: Supports multiple integration frameworks including Anchor-based (CCA/RPCA), Harmony, FastMNN, and scVI.
- **Workflow**:
  1. Normalize data (SCTransform or LogNormalize).
  2. Run `IntegrateLayers(object = obj, method = CCAIntegration, ...)`.
  3. Join layers using `JoinLayers()` before performing differential expression.

### 5. Scalable Analysis (Sketching)
For datasets exceeding 1 million cells, use sketch-based analysis to maintain a small memory footprint.
- **Sketching**: Use `SketchData()` to create a representative subset of cells.
- **Analysis**: Perform integration and clustering on the "sketched" cells, then project results back to the full dataset using `ProjectData()`.
- **On-disk storage**: Leverage the `BPCells` package integration to work with matrices stored on disk rather than in RAM.

### 6. Spatial Transcriptomics
Seurat v5 provides specific support for sequencing-based (Visium) and imaging-based (Xenium, MERSCOPE, CosMx) spatial data.
- **Loading**: Use `Load10X_Spatial()` for Visium or `LoadXenium()` / `LoadVizgen()` for imaging platforms.
- **Visualization**: Use `SpatialPlot()` or `ImageDimPlot()` to overlay molecular data on tissue histology or cell segmentations.

## Common CLI Patterns (R Console)

```r
# Standard v5 Integration Workflow
obj <- SCTransform(obj, verbose = FALSE)
obj <- RunPCA(obj, verbose = FALSE)
obj <- IntegrateLayers(
  object = obj, method = CCAIntegration,
  orig.reduction = "pca", new.reduction = "integrated.cca",
  verbose = FALSE
)

# Find Markers for Clusters
# Note: JoinLayers is required before DE if data was integrated
obj <- JoinLayers(obj)
markers <- FindAllMarkers(obj, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)

# Sketch-based Analysis for Large Data
obj <- SketchData(object = obj, ncells = 50000, method = "LeverageScore", sketched.assay = "sketch")
DefaultAssay(obj) <- "sketch"
# ... perform standard workflow on sketch ...
```

## Expert Tips
- **Assay Versions**: Be aware of the difference between `Assay` (v4) and `Assay5` (v5). Use `as(obj[["RNA"]], "Assay5")` to upgrade if necessary.
- **Parallelization**: Use the `future` package to speed up functions like `SCTransform` and `FindMarkers`.
- **Visualization**: Use `patchwork` to combine multiple Seurat plots (e.g., `DimPlot(obj) + FeaturePlot(obj, features = "CD3E")`).

## Reference documentation
- [Seurat v5 Command Cheat Sheet](./references/satijalab_org_seurat_articles_essential_commands.md)
- [Integrative analysis in Seurat v5](./references/satijalab_org_seurat_articles_seurat5_integration.md)
- [PBMC 3K guided tutorial](./references/satijalab_org_seurat_articles_pbmc3k_tutorial.md)
- [Sketch-based analysis in Seurat v5](./references/satijalab_org_seurat_articles_seurat5_sketch_analysis.md)
---
name: seurat
description: Seurat is an R toolkit designed for the exploration, analysis, and integration of single-cell genomics data. Use when user asks to perform quality control, normalize and scale transcriptomic data, identify cell clusters, run dimensional reduction, or integrate multimodal and spatial datasets.
homepage: https://satijalab.org/seurat/
metadata:
  docker_image: "quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0"
---


# seurat

## Overview
Seurat is a comprehensive R toolkit designed for the exploration and analysis of single-cell genomics data. It enables researchers to identify and interpret sources of heterogeneity in single-cell transcriptomic measurements and integrate diverse data types. This skill provides procedural knowledge for managing Seurat objects, executing standard workflows (v5), and utilizing advanced features like bridge integration for multimodal data and BPCells for massive scalability.

## Core Workflow Patterns

### 1. Object Initialization and Data Access
Seurat v5 uses a modular architecture centered on the `Seurat`, `Assay`, and `DimReduc` classes.

*   **Creation**: Use `CreateSeuratObject(counts = data)` to initialize.
*   **Assay Access**: Access raw counts via `obj[["RNA"]]$counts` and normalized data via `obj[["RNA"]]$data`.
*   **Metadata**: Add cell-level metadata using `obj$column_name <- vector` or `obj[[ "column_name" ]] <- vector`.
*   **Feature Metadata**: Access feature-level info (e.g., variable features) using `obj[["RNA"]][[]]`.

### 2. Standard Analytical Pipeline
Follow this sequence for basic scRNA-seq analysis:

1.  **QC**: Filter cells based on feature counts and mitochondrial percentage.
2.  **Normalization**: Use `NormalizeData()` (LogNormalization) or the preferred `SCTransform()` for improved variance stabilization.
3.  **Feature Selection**: `FindVariableFeatures()` to identify highly informative genes.
4.  **Scaling**: `ScaleData()` to shift mean expression to 0 and variance to 1.
5.  **Dimensional Reduction**: `RunPCA()` followed by non-linear reductions like `RunUMAP()` or `RunTSNE()`.
6.  **Clustering**: `FindNeighbors()` followed by `FindClusters()`.

### 3. Seurat v5 Integration
Seurat v5 introduces a streamlined integration workflow using `IntegrateLayers()`:

```R
# Example: Integrating multiple layers (e.g., different batches)
obj <- IntegrateLayers(
  object = obj, 
  method = CCAIntegration, # Options: RPCAIntegration, HarmonyIntegration, FastMNNIntegration
  orig.reduction = "pca", 
  new.reduction = "integrated.cca",
  verbose = FALSE
)
```

### 4. Multimodal and Spatial Analysis
*   **Weighted Nearest Neighbor (WNN)**: Use `FindMultiModalNeighbors()` to integrate different modalities (e.g., RNA + ADT) from the same cells.
*   **Bridge Integration**: Use a multiomic dataset as a "bridge" to map unimodal datasets (e.g., mapping scATAC-seq to an scRNA-seq reference).
*   **Spatial**: Use `Load10X_Spatial()` for Visium data. For imaging-based data (Xenium/MERFISH), Seurat v5 supports specific infrastructure for cell segmentations and molecule coordinates.

### 5. Scalability with BPCells
For datasets exceeding memory limits (millions of cells):
*   Utilize the `BPCells` package to store matrices on-disk.
*   Perform "sketch-based" analysis: Subsample representative cells for computationally intensive steps (clustering/integration) and project results back to the full dataset.

## Expert Tips & Best Practices
*   **Verbose Control**: Always include `verbose = FALSE` in functions within automated scripts to keep logs clean, unless debugging.
*   **Layer Management**: In v5, an Assay can contain multiple "layers" (e.g., `counts`, `data`, `scale.data`, plus batch-specific layers). Use `JoinLayers()` if you need to collapse these for specific downstream tools.
*   **S3 Method Consistency**: When extending Seurat, follow the S3 generic pattern: `Function.Seurat <- function(object, ...)`.
*   **Visualization**: Return `ggplot` objects from plotting functions to allow for easy modification (e.g., `p + NoLegend()`).

## Reference documentation
- [Essential Commands](./references/satijalab_org_seurat_articles_essential_commands.md)
- [Seurat v5 Integration](./references/satijalab_org_seurat_articles_seurat5_integration.md)
- [Assay Class Wiki](./references/github_com_satijalab_seurat_wiki_Assay.md)
- [Dimensional Reduction Wiki](./references/github_com_satijalab_seurat_wiki_DimReduc.md)
- [Package Conventions](./references/github_com_satijalab_seurat_wiki_Package-Conventions.md)
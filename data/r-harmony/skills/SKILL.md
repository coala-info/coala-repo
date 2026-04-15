---
name: r-harmony
description: This tool integrates single-cell RNA-seq data by performing batch correction on PCA embeddings or Seurat objects using the Harmony algorithm. Use when user asks to integrate single-cell datasets, perform batch correction, merge Seurat objects from different conditions, or harmonize PCA embeddings.
homepage: https://cloud.r-project.org/web/packages/harmony/index.html
---

# r-harmony

name: r-harmony
description: Integration of single-cell RNA-seq data using the Harmony algorithm. Use this skill to perform batch correction and data integration on Seurat objects or PCA embedding matrices. It is particularly effective for merging datasets from different donors, technologies, or experimental conditions while preserving biological variation.

# r-harmony

## Overview
Harmony is a fast and accurate algorithm for integrating single-cell data. It projects cells into a shared embedding space by iteratively clustering cells and correcting for batch effects using a Mixture of Experts model. It is designed to scale to millions of cells and supports complex experimental designs with multiple covariates.

## Installation
Install the package from CRAN:
```R
install.packages('harmony')
```

## Core Workflows

### Using Harmony with Seurat (v5)
The most common workflow involves integrating datasets stored in a Seurat object. Harmony typically runs on PCA embeddings.

1. **Prepare the Seurat Object**:
   ```R
   library(Seurat)
   library(harmony)

   # Normalize and find variable features
   pbmc <- NormalizeData(pbmc)
   pbmc <- FindVariableFeatures(pbmc, selection.method = "vst", nfeatures = 2000)
   pbmc <- ScaleData(pbmc)
   pbmc <- RunPCA(pbmc, npcs = 20)
   ```

2. **Run Harmony**:
   Pass the metadata column name(s) representing the batch effect to `group.by.vars`.
   ```R
   # Run Harmony integration
   pbmc <- RunHarmony(pbmc, group.by.vars = "stim")
   ```

3. **Downstream Analysis**:
   Use the `harmony` reduction for clustering and visualization (UMAP/tSNE).
   ```R
   pbmc <- FindNeighbors(pbmc, reduction = "harmony", dims = 1:20)
   pbmc <- FindClusters(pbmc, resolution = 0.5)
   pbmc <- RunUMAP(pbmc, reduction = "harmony", dims = 1:20)
   ```

### Using Harmony with Matrix Inputs
If not using Seurat, you can run Harmony directly on a PCA embedding matrix.

```R
# V is a cell-by-PC matrix
# meta_data is a data frame with batch labels
harmony_embeddings <- RunHarmony(V, meta_data, 'dataset_column')
```

## Key Parameters

### Integration Parameters
- `group.by.vars`: Character vector of metadata columns to harmonize (e.g., `c("donor", "technology")`).
- `theta`: Diversity penalty (default = 2). Higher values result in more aggressive integration. Set to 0 for no penalty.
- `lambda`: Ridge regression penalty.
- `sigma`: Soft assignment parameter (default = 0.1). Controls how "fuzzy" the cluster assignments are.

### Algorithm Control
- `nclust`: Number of clusters for the internal k-means (default is auto-determined).
- `max_iter`: Maximum number of integration rounds (default = 10).
- `early_stop`: If `TRUE`, stops when the objective function plateaus.
- `plot_convergence`: If `TRUE`, plots the objective function across iterations to monitor convergence.

## Tips for Success
- **Input Scaling**: Harmony expects PCA embeddings as input. Ensure your data is normalized and scaled before running PCA.
- **Multiple Covariates**: You can integrate out multiple batch effects simultaneously by passing a vector to `group.by.vars`.
- **Accessing Embeddings**: In Seurat, the integrated coordinates are stored in `pbmc@reductions$harmony`. Use `Embeddings(pbmc, reduction = "harmony")` to extract them.
- **Feature Loadings**: By default, `RunHarmony` in Seurat calculates feature loadings for the harmony reduction using `ProjectDim()`.

## Reference documentation
- [Using harmony in Seurat](./references/Seurat.Rmd)
- [Detailed Walkthrough of Harmony Algorithm](./references/detailedWalkthrough.Rmd)
- [Quick start to Harmony](./references/quickstart.Rmd)
---
name: bioconductor-sketchr
description: This tool provides an R interface for density-aware geometric sketching to subsample large single-cell datasets while preserving rare cell populations. Use when user asks to subsample single-cell data, perform geometric sketching, or reduce dataset size while maintaining biological diversity.
homepage: https://bioconductor.org/packages/release/bioc/html/sketchR.html
---

# bioconductor-sketchr

## Overview

The `sketchR` package provides an R interface to Python-based geometric sketching algorithms (like `geosketch` and `scSampler`). It allows for density-aware subsampling of single-cell datasets, ensuring that rare cell types in sparsely populated regions of the expression space are better represented in the downsampled subset compared to uniform sampling. This is particularly useful for reducing computational load while preserving biological diversity in massive datasets.

## Core Functions

### Subsampling Algorithms
- `geosketch(mat, N, seed)`: Performs geometric sketching. `mat` is typically a PCA matrix (cells as rows). Returns a vector of indices.
- `scsampler(mat, N, seed)`: Alternative subsampling algorithm via the `scSampler` package.

### Visualization and Diagnostics
- `compareCompositionPlot(colData, idx, column)`: Compares the relative abundance of cell types (or other categories) between the full dataset and the sketched subset.
- `hausdorffDistPlot(mat, Nvec, Nrep, methods)`: Plots the Hausdorff distance between the full data and subsamples across different sizes to evaluate how well the sketch represents the original space.

## Typical Workflow

### 1. Basic Subsampling
```r
library(sketchR)
library(SingleCellExperiment)

# Assuming sce is a SingleCellExperiment with PCA computed
pca_mat <- reducedDim(sce, "PCA")
sketch_indices <- geosketch(pca_mat, N = 1000, seed = 123)

# Create the sketched object
sce_sketched <- sce[, sketch_indices]
```

### 2. Integration with Downstream Analysis
To maintain the context of the full dataset while benefiting from sketching:

- **PCA Projection**: Run PCA on the sketched cells only, then project the remaining cells onto those axes using matrix multiplication with the rotation weights.
- **t-SNE/UMAP Projection**: Use `snifter::project()` or `uwot::umap_transform()` to map the full dataset into an embedding space defined by the sketched cells.
- **Clustering**: Cluster the sketched cells (e.g., using `bluster`), then assign labels to the full dataset using a 1-nearest neighbor (`class::knn`) approach.

## Usage Tips
- **Input Matrix**: Always use a dimensionality-reduced matrix (like PCA) rather than raw counts for the sketching functions to improve performance and accuracy.
- **Reproducibility**: Always set a `seed` within the function call or via `set.seed()` as the underlying Python processes require it for deterministic results.
- **Environment**: `sketchR` uses `basilisk` to manage Python dependencies. The first run will trigger the creation of a conda/virtual environment, which may take a few minutes.

## Reference documentation

- [Subsampling single-cell data sets with sketchR](./references/sketchR.md)
- [Incorporating sketching into a typical single-cell analysis workflow](./references/sketching_workflows.md)
---
name: bioconductor-smoothclust
description: bioconductor-smoothclust identifies spatial domains in spatial transcriptomics data by smoothing gene expression profiles across neighboring locations before clustering. Use when user asks to smooth spatial gene expression, identify spatial domains, or perform spatial clustering on SpatialExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/smoothclust.html
---

# bioconductor-smoothclust

## Overview

`smoothclust` is a Bioconductor package designed for spatial transcriptomics analysis. It identifies spatial domains by smoothing gene expression profiles across neighboring locations before performing unsupervised clustering. This approach reduces noise and produces spatial domains with biologically consistent, smooth boundaries. It is compatible with the `SpatialExperiment` framework and standard Bioconductor single-cell workflows (e.g., `scran`, `scater`).

## Installation

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("smoothclust")
```

## Core Workflow

### 1. Data Preparation
The package primarily works with `SpatialExperiment` (SPE) objects. Ensure your data includes spatial coordinates and, for Visium data, filter for spots over tissue.

```R
library(smoothclust)
library(SpatialExperiment)

# Example: spe is a SpatialExperiment object
# Filter for tissue if using Visium
spe <- spe[, colData(spe)$in_tissue == 1]
```

### 2. Spatial Smoothing
The `smoothclust()` function performs the core smoothing operation. It adds a new assay called `counts_smooth` to the object.

```R
# Run with default parameters (optimized for Visium)
spe <- smoothclust(spe)

# Available methods: "uniform" (default), "kernel", "knn"
# Optional parameters: bandwidth, k, truncate
spe <- smoothclust(spe, method = "kernel", bandwidth = 2)
```

### 3. Normalization and Feature Selection
After smoothing, use standard Bioconductor tools to normalize the *smoothed* counts and identify highly variable genes (HVGs).

```R
library(scuttle)
library(scran)

# Calculate logcounts using the smoothed assay
spe <- logNormCounts(spe, assay.type = "counts_smooth")

# Identify HVGs based on smoothed logcounts
dec <- modelGeneVar(spe)
top_hvgs <- getTopHVGs(dec, prop = 0.1)
```

### 4. Clustering and Visualization
Perform dimensionality reduction and clustering on the smoothed data to define spatial domains.

```R
library(scater)
library(ggspavis)

# PCA on smoothed HVGs
spe <- runPCA(spe, subset_row = top_hvgs)

# K-means clustering on PCs
set.seed(123)
clust <- kmeans(reducedDim(spe, "PCA"), centers = 5)$cluster
colLabels(spe) <- factor(clust)

# Visualize spatial domains
plotCoords(spe, annotate = "label")
```

## Usage Tips

- **Assay Selection**: Always ensure `assay.type = "counts_smooth"` is passed to downstream functions like `logNormCounts` to ensure the smoothing effect is utilized in clustering.
- **Parameter Tuning**: For non-Visium platforms or different tissue densities, adjust the `bandwidth` (for kernel/uniform) or `k` (for knn) to control the extent of spatial smoothing.
- **Input Flexibility**: While SPE is preferred, `smoothclust` can also accept a numeric matrix of expression values and a matrix of spatial coordinates.

## Reference documentation

- [Smoothclust Tutorial](./references/smoothclust.md)
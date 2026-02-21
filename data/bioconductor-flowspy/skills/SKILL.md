---
name: bioconductor-flowspy
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.10/bioc/html/flowSpy.html
---

# bioconductor-flowspy

## Overview
The `flowSpy` package provides an integrated workflow for analyzing high-dimensional single-cell cytometry data. It is particularly effective for time-course experiments, offering tools for data normalization, clustering (SOM), dimensionality reduction (PCA, tSNE, UMAP, Diffusion Maps), and trajectory inference using Minimum Spanning Trees (MST). It allows users to define root and leaf cells to calculate pseudotime and identify intermediate cellular states.

## Core Workflow

### 1. Data Preprocessing and Object Creation
Load FCS files and merge them into a single expression matrix. Create the central `FSPY` S4 object.

```r
library(flowSpy)
library(flowCore)

# Merge FCS files
fcs.files <- list.files(path, pattern = '.FCS$', full = TRUE)
fcs.data <- runExprsMerge(fcs.files, comp = FALSE, transformMethod = "none")

# Define markers and metadata
markers <- c("CD43", "CD34", "CD90", "CD45RA")
meta.data <- data.frame(cell = rownames(fcs.data), stage = stage_vector)

# Initialize FSPY object
fspy <- createFSPY(raw.data = fcs.data, 
                   markers = markers,
                   meta.data = meta.data,
                   normalization.method = "log")
```

### 2. Clustering and Dimensionality Reduction
`flowSpy` uses Self-Organizing Maps (SOM) for clustering and supports multiple projection methods.

```r
# Clustering
fspy <- runCluster(fspy, cluster.method = "som")
fspy <- processingCluster(fspy) # Downsampling/Processing

# Dimensionality Reduction
fspy <- runFastPCA(fspy)
fspy <- runTSNE(fspy)
fspy <- runUMAP(fspy)
fspy <- runDiffusionMap(fspy)
```

### 3. Trajectory and Pseudotime Analysis
Construct a trajectory tree and estimate the progression of cells.

```r
# Build MST tree based on a projection (e.g., tSNE)
fspy <- buildTree(fspy, dim.type = "tsne", dim.use = 1:2)

# Define root cells (starting point) and leaf cells (endpoints)
fspy <- defRootCells(fspy, root.cells = c(1, 5)) # Cluster IDs
fspy <- runPseudotime(fspy, dim.type = "raw")
fspy <- defLeafCells(fspy, leaf.cells = c(10, 12))

# Calculate paths/walks
fspy <- runWalk(fspy)

# Identify differentially expressed markers across branches
diff.list <- runDiff(fspy)
```

### 4. Visualization
`flowSpy` provides specialized plotting functions for cytometry data.

*   **2D Projections**: `plot2D(fspy, item.use = c("UMAP_1", "UMAP_2"), color.by = "cluster.id", category = "categorical")`
*   **Trajectory Trees**: `plotTree(fspy, color.by = "pseudotime", cex.size = 1.5)`
*   **Pie Charts on Trees**: `plotPieTree(fspy, cex.size = 3)`
*   **Heatmaps**: `plotClusterHeatmap(fspy)` or `plotBranchHeatmap(fspy)`
*   **Expression Trends**: `plotPseudotimeTraj(fspy, var.cols = TRUE)`
*   **Distribution**: `plotPseudotimeDensity(fspy, adjust = 1)`

## Tips and Best Practices
*   **Marker Selection**: Ensure the `markers` vector only contains the protein markers intended for clustering and trajectory inference, excluding technical parameters like "FSC" or "Time".
*   **Root Selection**: Pseudotime accuracy depends heavily on the correct definition of `root.cells`. Use prior biological knowledge of the earliest developmental stage.
*   **Reproducibility**: Always set a seed (`set.seed()`) before running `runCluster`, `runTSNE`, or `runUMAP` as these algorithms involve stochastic processes.
*   **Memory Management**: For very large datasets, use the `processingCluster` function to downsample cells in a cluster-dependent fashion to maintain rare populations while reducing computational load.

## Reference documentation
- [Quick start of flowSpy](./references/Quick_start_of_flowSpy.md)
- [Quick start](./references/Quick_start.md)
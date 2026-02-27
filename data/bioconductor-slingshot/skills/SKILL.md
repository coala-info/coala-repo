---
name: bioconductor-slingshot
description: Bioconductor-slingshot performs trajectory inference and pseudotime estimation for single-cell data by identifying lineage structures and fitting smooth principal curves. Use when user asks to infer cell lineages, calculate pseudotime values, or fit principal curves to reduced-dimensional single-cell expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/slingshot.html
---


# bioconductor-slingshot

name: bioconductor-slingshot
description: Trajectory inference and pseudotime estimation for single-cell data. Use this skill to identify global lineage structures (MST), fit smooth principal curves, and calculate pseudotime values from reduced-dimensional single-cell expression data.

# bioconductor-slingshot

## Overview

`slingshot` is a Bioconductor package designed to uncover global lineage structures in single-cell data and convert these structures into smooth, one-dimensional variables called "pseudotime." It works by first identifying cluster relationships using a minimum spanning tree (MST) and then fitting simultaneous principal curves to represent each lineage.

## Core Workflow

The package typically follows a two-step process, which can be executed via a single wrapper function or individual components.

### 1. Input Requirements
- **Reduced Dimensional Matrix**: A matrix (cells x dimensions) from PCA, UMAP, t-SNE, or Diffusion Maps.
- **Cluster Labels**: A vector of cluster assignments for each cell (e.g., from k-means or Louvain clustering).

### 2. Running Slingshot (Wrapper)
The `slingshot` function is the recommended entry point, especially when working with `SingleCellExperiment` (SCE) objects.

```r
library(slingshot)

# Using a SingleCellExperiment object
# clusterLabels can be a column name in colData
sce <- slingshot(sce, clusterLabels = 'GMM', reducedDim = 'PCA')

# Accessing results
pto <- colData(sce)$slingshot
pseudotimes <- slingPseudotime(sce)
weights <- slingCurveWeights(sce)
```

### 3. Manual Step-by-Step Execution
For more control, use the individual functions:

```r
# Step 1: Identify global lineage structure (MST)
# Optional: specify start.clus or end.clus to guide the tree
lin <- getLineages(rd, cl, start.clus = '1')

# Step 2: Construct smooth curves
crv <- getCurves(lin)
```

## Key Functionality

### Semi-Supervised Inference
You can guide the trajectory by specifying known biological starting or ending points:
- `start.clus`: The cluster label for the root of the trajectory.
- `end.clus`: Cluster labels for known terminal states (leaf nodes in the MST).

### Handling Multiple Trajectories
If the data contains disjoint trajectories, use the `omega` parameter to allow the MST to break into multiple components.
- `omega = TRUE`: Uses a heuristic to identify outlier clusters or separate trajectories.

### Large Datasets
For performance on large datasets, use `approx_points`. This limits the number of unique points used to define the curve (default is 150), significantly speeding up the iterative projection step without losing pseudotime resolution.

```r
sce <- slingshot(sce, clusterLabels = 'cl', approx_points = 150)
```

### Projecting New Data
Use the `predict` method to map new cells onto an existing trajectory without re-calculating the curves.

```r
# pto is a PseudotimeOrdering object from a previous run
new_pto <- predict(pto, new_reduced_dim_data)
```

## Visualization

Slingshot provides specialized plotting methods for `SlingshotDataSet` objects.

```r
# Plot the curves over the reduced dimension plot
plot(rd, col = cluster_colors[cl], pch = 16)
lines(SlingshotDataSet(sce), lwd = 2, col = 'black')

# Plot the MST structure only
plot(rd, col = cluster_colors[cl], pch = 16)
lines(SlingshotDataSet(sce), type = 'lineages', lwd = 2)
```

## Differential Topology and Expression

- **Condition Comparison**: To compare trajectories between conditions (e.g., Case vs. Control), use the common trajectory framework to test for distributional differences (Kolmogorov-Smirnov test) or condition imbalance (Logistic Regression) along pseudotime.
- **Dynamic Genes**: Use the `tradeSeq` package downstream to fit GAMs and identify genes that change significantly along the inferred pseudotime.

## Reference documentation

- [Differential Topology: Comparing Conditions along a Trajectory](./references/conditionsVignette.md)
- [Slingshot: Trajectory Inference for Single-Cell Data](./references/vignette.md)
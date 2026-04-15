---
name: bioconductor-dune
description: Dune improves the replicability of clustering results by iteratively merging clusters across different algorithms to increase their consensus. Use when user asks to reconcile multiple clustering results, improve cluster stability using the Adjusted Rand Index, or merge inconsistent clusters from different single-cell RNA-seq methods.
homepage: https://bioconductor.org/packages/release/bioc/html/Dune.html
---

# bioconductor-dune

name: bioconductor-dune
description: Use the Dune R package to improve the replicability of clustering results by merging clusters across different clustering runs or algorithms. This skill is ideal for single-cell RNA-seq analysis where multiple clustering methods (e.g., Seurat, Monocle, SC3) yield different results and the user needs a consensus or more robust set of clusters based on the Adjusted Rand Index (ARI).

# bioconductor-dune

## Overview

Dune is a Bioconductor package designed to reconcile multiple clustering results. It uses an iterative merging algorithm to increase the Adjusted Rand Index (ARI) between different clustering partitions. By merging clusters that are inconsistent across methods, Dune helps researchers identify a stable set of clusters that are more likely to be replicable and biologically meaningful.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Dune")
```

## Core Workflow

### 1. Prepare Cluster Matrix
Dune requires a matrix or data frame where each column represents a different clustering result (e.g., from different algorithms or parameters) and each row represents a cell/observation.

```r
library(Dune)
library(dplyr)

# Example: Selecting clustering columns from a dataset
cluster_mat <- nuclei %>% select(SC3, Seurat, Monocle)
```

### 2. Initial Assessment
Before merging, visualize the similarity between the different clustering methods using ARI.

```r
# Plot a heatmap of pairwise ARIs
plotARIs(cluster_mat)
```

### 3. Perform Merging
The `Dune` function performs the iterative merging. It continues until no more merges can significantly improve the mean ARI or until a stopping criterion is met.

```r
# Run the merging algorithm
merger <- Dune(clusMat = cluster_mat, verbose = TRUE)

# The output 'merger' contains:
# - initialMat: The original clusters
# - currentMat: The new, merged clusters
# - merges: A record of which clusters were merged at each step
# - ImpMetric: The improvement in ARI at each step
```

### 4. Evaluate Results
After running Dune, assess how the merging improved the consistency between methods and how it changed the cluster granularity.

```r
# Check ARI improvement
plotARIs(merger$currentMat)

# Visualize the reduction in cluster numbers across methods
plotPrePost(merger)

# Track the ARI trend throughout the merging process
ARItrend(merger)

# Visualize specific merges for a single method (e.g., SC3)
ConfusionPlot(merger$initialMat[, "SC3"], merger$currentMat[, "SC3"])
```

## Key Functions

- `Dune()`: The main function for merging clusters.
- `plotARIs()`: Displays a heatmap of Adjusted Rand Indices between all pairs of clusterings.
- `plotPrePost()`: Comparison plot showing the number of clusters before and after the Dune process.
- `ARItrend()`: Plots the evolution of the mean ARI as merges occur.
- `ConfusionPlot()`: Shows the relationship between original clusters and merged clusters for a specific method.

## Tips for Success

- **Input Format**: Ensure your cluster labels are treated as factors or characters if they are numeric IDs to avoid mathematical operations being performed on them by mistake.
- **Interpretation**: If Dune merges almost all clusters into one, it suggests that the initial clustering results were highly discordant and may not contain a robust signal.
- **Integration**: Dune is often used after running standard pipelines like Seurat or Monocle to find a "consensus" resolution that is supported by multiple algorithmic approaches.

## Reference documentation

- [Dune](./references/Dune.md)
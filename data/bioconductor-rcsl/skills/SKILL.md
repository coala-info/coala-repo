---
name: bioconductor-rcsl
description: RCSL is an R package for unsupervised clustering and trajectory inference of single-cell RNA-seq data using rank-constrained similarity learning. Use when user asks to filter genes, estimate the number of clusters, identify cell types, or reconstruct pseudo-temporal ordering and developmental trajectories.
homepage: https://bioconductor.org/packages/release/bioc/html/RCSL.html
---


# bioconductor-rcsl

## Overview
RCSL is an R package designed for unsupervised clustering and trajectory inference of single-cell RNA-seq (scRNA-seq) data. It utilizes a rank-constrained similarity learning approach to identify cell types and reconstruct the pseudo-temporal ordering of cells. The workflow typically involves data pre-processing, similarity matrix calculation, cluster estimation, and trajectory visualization.

## Core Workflow

### 1. Data Preparation and Pre-processing
RCSL expects a gene expression matrix (genes as rows, cells as columns). It is highly recommended to log-transform and filter the data before analysis.

```r
library(RCSL)

# Load your data (e.g., a matrix 'origData')
# Log transformation
data_log <- log2(as.matrix(origData) + 1)

# Filter genes to remove low-quality or non-informative features
gfData <- GenesFilter(data_log)
```

### 2. Clustering Pipeline
The clustering process is broken down into similarity calculation, cluster number estimation, and final assignment.

```r
# Step A: Calculate the initial similarity matrix S
# This function performs Spearman correlation and Neighbor Representation
resSimS <- SimS(gfData)

# Step B: Estimate the optimal number of clusters (C)
# Uses dimensionality reduced data and the similarity matrix
Estimated_C <- EstClusters(resSimS$drData, resSimS$S)

# Step C: Calculate the block diagonal matrix (BDSM) for final clustering
# resBDSM$y contains the cluster assignments
resBDSM <- BDSM(resSimS$S, Estimated_C)
```

### 3. Trajectory Analysis
For time-series or developmental datasets, RCSL can infer the lineage and pseudo-time.

```r
# Perform trajectory analysis
# startPoint: the index of the cluster representing the starting state
res_Trajec <- TrajectoryAnalysis(gfData, 
                                 resSimS$drData, 
                                 resSimS$S,
                                 clustRes = resBDSM$y, 
                                 startPoint = 1, 
                                 dataName = "MyDataset")

# Visualize results
res_Trajec$MSTPlot         # Minimum Spanning Tree
res_Trajec$PseudoTimePlot  # Cells ordered by pseudo-time
res_Trajec$TrajectoryPlot  # Inferred developmental path
```

## Key Functions
- `GenesFilter()`: Filters genes based on expression patterns to improve signal-to-noise ratio.
- `SimS()`: Computes the similarity matrix using Spearman correlation and local neighborhood information.
- `EstClusters()`: Automatically estimates the number of clusters in the dataset.
- `BDSM()`: Performs the final clustering based on the rank-constrained similarity matrix.
- `TrajectoryAnalysis()`: Integrates clustering and similarity data to produce pseudo-time ordering and trajectory plots.

## Tips
- **Starting Point**: In `TrajectoryAnalysis`, the `startPoint` argument refers to the cluster ID that represents the root of the trajectory. Ensure you identify the biologically relevant starting cluster (e.g., zygote or stem cell) from the clustering results first.
- **Memory**: For very large datasets, the similarity matrix calculation (`SimS`) can be memory-intensive.
- **Validation**: If ground truth labels are available, use `igraph::compare(resBDSM$y, true_labels, method = "adjusted.rand")` to calculate the Adjusted Rand Index (ARI).

## Reference documentation
- [A quick tour of RCSL](./references/RCSL.Rmd)
- [RCSL package manual](./references/RCSL.md)
---
name: bioconductor-tscr
description: This tool clusters time series data based on shape and slope similarity using geometric criteria like Fréchet distance. Use when user asks to cluster gene expression trajectories, calculate slope or Fréchet distances between time series, or group large temporal datasets using the senator method.
homepage: https://bioconductor.org/packages/3.11/bioc/html/tscR.html
---

# bioconductor-tscr

name: bioconductor-tscr
description: A specialized skill for clustering time series data (e.g., gene expression) using the tscR R package. Use this skill when you need to group trajectories based on slope similarity, Fréchet distance, or a combination of both. It is particularly useful for biological data where identifying similar temporal patterns (regardless of expression magnitude) is required, and it includes optimized workflows for large datasets using "senator" trajectories.

# bioconductor-tscr

## Overview

The `tscR` package provides tools for clustering time series data using geometric criteria. Unlike standard clustering methods that often group data by magnitude (Euclidean distance), `tscR` allows for clustering based on the "shape" or "evolution" of trajectories. It implements two primary metrics:
1.  **Slope Distance**: Groups trajectories with similar patterns of change over time, regardless of their absolute values.
2.  **Fréchet Distance**: A measure of similarity between curves that considers the location and ordering of points.

The package also supports a hybrid approach (combined clustering) and a "senator" method to handle large-scale datasets (e.g., >10,000 genes) efficiently.

## Core Workflow

### 1. Data Preparation
Input data should be a matrix or data frame where rows are trajectories (e.g., genes) and columns are time points.

```R
library(tscR)
data(tscR)
df <- tscR
time_points <- c(1, 2, 3) # Numeric vector of time intervals
```

### 2. Calculating Distances
Choose the distance metric based on the research goal:

*   **Slope-based**: `sDist <- slopeDist(df, time_points)`
*   **Fréchet-based**: `fDist <- frechetDistC(df, time_points)`

### 3. Clustering and Visualization
Use `getClusters` to assign trajectories to groups and `plotCluster` to visualize results.

```R
# Cluster based on slopes into 3 groups
sclust <- getClusters(sDist, k = 3)

# Visualize all clusters
plotCluster(data = df, clust = sclust, ncluster = "all")

# Visualize specific clusters (e.g., cluster 1 and 2)
plotCluster(df, sclust, c(1, 2))
```

### 4. Combined Clustering
To group trajectories that share both similar values and similar slopes:

```R
sclust <- getClusters(slopeDist(df, time_points), k = 3)
fclust <- getClusters(frechetDistC(df, time_points), k = 3)

# Combine results
ccluster <- combineCluster(sclust, fclust)
plotCluster(df, ccluster, "all")
```

## Large Dataset Workflow (Senators)

For large datasets, use the "senator" approach to reduce computational overhead:

1.  **Impute Senators**: Create representative trajectories.
    `senators <- imputeSenators(df, k = 100)`
2.  **Cluster Senators**: Calculate distances and clusters on the representatives.
    `sdistSen <- slopeDist(senators$senatorData, time_points)`
    `cSenators <- getClusters(sdistSen, k = 5)`
3.  **Assign Data**: Map original trajectories back to the senator clusters.
    `endCluster <- imputeSenatorToData(senators, cSenators)`
4.  **Plot**: `plotClusterSenator(endCluster, "all")`

## Working with SummarizedExperiment

If your data is in a `SummarizedExperiment` object, use `importFromSE` to extract the required matrix.

*   **By Time**: If assays are samples and columns are time points:
    `data <- importFromSE(se, sample = 1, SE_byTime = TRUE)`
*   **By Sample**: If assays are time points and columns are samples:
    `data <- importFromSE(se, sample = "SampleName", SE_byTime = FALSE)`

## Tips and Best Practices
*   **Time Vector**: Ensure the `time` argument matches the actual intervals of your observations, as this affects slope calculations.
*   **Memory Management**: If R crashes during distance matrix calculation, switch to the `imputeSenators` workflow.
*   **Cluster Selection**: Use `combineCluster` when you want to distinguish between genes that have the same trend but operate at significantly different expression baselines.

## Reference documentation
- [Clustering time series data with tscR](./references/tscR.md)
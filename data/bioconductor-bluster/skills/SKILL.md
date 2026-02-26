---
name: bioconductor-bluster
description: This tool provides a flexible and extensible framework for clustering matrix-like data within Bioconductor workflows. Use when user asks to perform clustering on PCA coordinates, switch between different clustering algorithms using a unified interface, or calculate clustering diagnostics like silhouette width and neighborhood purity.
homepage: https://bioconductor.org/packages/release/bioc/html/bluster.html
---


# bioconductor-bluster

name: bioconductor-bluster
description: Flexible and extensible framework for clustering in Bioconductor workflows. Use when performing clustering on matrix-like data (e.g., PCA coordinates from scRNA-seq), comparing different clustering algorithms using a unified interface, or calculating clustering diagnostics like silhouette width, neighborhood purity, and modularity.

# bioconductor-bluster

## Overview

The `bluster` package provides a unified interface for clustering through the `clusterRows()` generic function. It abstracts specific algorithm implementations into `BlusterParam` objects, allowing users to switch between hierarchical, k-means, graph-based, and density-based clustering by changing a single argument. This framework is particularly useful for single-cell analysis workflows where PCA coordinates are clustered into cell populations.

## Core Workflow

To cluster data, provide a matrix-like object (where rows are observations) and a parameter object defining the algorithm.

```r
library(bluster)

# Basic usage
# mat: matrix of coordinates (e.g., PCA results)
clusters <- clusterRows(mat, NNGraphParam(k=10))

# Obtain full statistics and intermediate objects
out <- clusterRows(mat, NNGraphParam(), full=TRUE)
clusters <- out$clusters
graph <- out$objects$graph
```

## Clustering Algorithms

Select an algorithm by initializing the corresponding `BlusterParam` subclass:

*   **Hierarchical Clustering**: `HclustParam(method="ward.D2", cut.dynamic=TRUE)` uses `hclust`.
*   **K-means**: `KmeansParam(centers=10)` or `MbkmeansParam()` for mini-batch k-means.
*   **Graph-based**: `NNGraphParam(k=20, cluster.fun="louvain")` builds a SNN graph and performs community detection.
*   **Density-based**: `DbscanParam(core.prop=0.1)` for DBSCAN clustering.
*   **Two-phase**: `TwoStepParam(first=KmeansParam(centers=1000), second=NNGraphParam())` for large datasets.
*   **Affinity Propagation**: `AffinityParam(q=-2)`.

## Clustering Diagnostics

Evaluate the quality and stability of clusters using these functions:

*   **Separation**: `approxSilhouette(mat, clusters)` computes the approximate silhouette width. Positive values indicate well-separated clusters.
*   **Overclustering**: `neighborPurity(mat, clusters)` calculates the proportion of neighbors belonging to the same cluster.
*   **Internal Heterogeneity**: `clusterRMSD(mat, clusters)` computes the root-mean-squared deviation within each cluster.
*   **Graph Modularity**: `pairwiseModularity(graph, clusters, as.ratio=TRUE)` evaluates the ratio of observed to expected edge weights between clusters.
*   **Stability**: `bootstrapStability(mat, clusters, BLUSPARAM=...)` uses bootstrapping to calculate the Adjusted Rand Index (ARI) across replicates.

## Comparing and Sweeping Clusterings

*   **Parameter Sweeps**: Use `clusterSweep()` to test multiple parameter combinations (e.g., different `k` values).
*   **Comparison**: `pairwiseRand(clusters1, clusters2, mode="index")` calculates the ARI between two clustering results.
*   **Nesting**: `nestedClusters()` checks if one clustering is a refinement of another.
*   **Linking**: `linkClusters()` identifies corresponding clusters across different algorithms by constructing a meta-graph.

## Reference documentation

- [Flexible clustering for Bioconductor](./references/clusterRows.md)
- [Assorted clustering diagnostics](./references/diagnostics.md)
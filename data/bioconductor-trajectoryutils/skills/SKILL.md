---
name: bioconductor-trajectoryutils
description: This package provides low-level infrastructure and standardized tools for trajectory inference from clustered single-cell data. Use when user asks to construct minimum spanning trees from cluster centroids, define directional paths from roots, or store pseudotime results in a standardized S4 class.
homepage: https://bioconductor.org/packages/release/bioc/html/TrajectoryUtils.html
---

# bioconductor-trajectoryutils

## Overview

The `TrajectoryUtils` package provides low-level infrastructure for trajectory inference. It does not perform inference itself but offers standardized tools for developers and analysts to build trajectories from clustered single-cell data. Its primary features include robust Minimum Spanning Tree (MST) construction and the `PseudotimeOrdering` S4 class for organized storage of pseudotime results.

## MST Construction and Analysis

The core workflow involves creating an MST from cluster centroids to serve as a trajectory backbone.

### Creating a Cluster-based MST
Use `createClusterMST()` to connect clusters. It supports several advanced distance metrics:
- **Standard**: `createClusterMST(data, clusters)`
- **Outgroup**: Set `outgroup=TRUE` to avoid spurious links between distant, unrelated clusters.
- **MNN Distance**: Use `dist.method="mnn"` to calculate distances based on mutually nearest neighbors, useful for heterogeneous clusters.
- **Slingshot/Mahalanobis**: Use `dist.method="slingshot"` to account for the shape and covariance of each cluster.
- **Robust Centroids**: Set `use.median=TRUE` to use medians instead of means for cluster centers.

### Root Identification and Path Definition
Once an MST is created (usually an `igraph` object), you can define directional paths:

1.  **Guessing Roots**: `guessMSTRoots(mst, method="maxstep")` identifies potential starting points by maximizing the distance to terminal nodes.
2.  **Defining Paths**: 
    - From roots: `defineMSTPaths(mst, roots="1")`
    - From timing data: `defineMSTPaths(mst, times=c("1"=0, "2"=5, ...))`
3.  **Branch Splitting**: `splitByBranches(mst)` decomposes the tree into unbranched segments without requiring a root.

## The PseudotimeOrdering Class

The `PseudotimeOrdering` class stores pseudotime values where rows are cells and columns are paths/lineages.

### Initialization and Metadata
```r
# Create from a matrix of pseudotime values
pto <- PseudotimeOrdering(pseudotime_matrix)

# Add cell-level metadata (e.g., clusters)
pto$cluster <- cell_clusters

# Add path-level metadata
pathData(pto)$lineage_name <- c("Lineage1", "Lineage2")
```

### Handling Multiple Statistics
You can store auxiliary data (like assignment confidence) using `pathStat`:
```r
pathStat(pto, "confidence") <- confidence_matrix
```

### Summarization
To collapse multiple paths into a single value for visualization:
```r
avg_time <- averagePseudotime(pto)
```

## Reference documentation

- [Trajectory utilities for package developers](./references/overview.Rmd)
- [Trajectory utilities for package developers](./references/overview.md)
---
name: r-nabor
description: This R package provides fast K-nearest neighbor search functionality using an optimized library for low-dimensional spatial data. Use when user asks to perform K-nearest neighbor searches, find nearest neighbors in 3D point clouds, or replace RANN for faster spatial analysis.
homepage: https://cloud.r-project.org/web/packages/nabor/index.html
---

# r-nabor

## Overview
`nabor` is an R wrapper for `libnabo`, a library optimized for K-nearest neighbor (KNN) searches in low-dimensional spaces. It is typically 5-20% faster than the ANN library (used in `RANN`) and offers more compact data structures. It is particularly effective for 3D point cloud data and spatial analysis.

## Installation
```r
install.packages("nabor")
```

## Main Functions

### knn: Simple KNN Search
The `knn` function is a drop-in replacement for `RANN::nn2`. It returns a list containing `nn.idx` (indices of neighbors) and `nn.dists` (squared distances).

```r
library(nabor)

# Generate sample data
data <- matrix(runif(300), ncol=3)
query <- matrix(runif(30), ncol=3)

# Basic search (k=3)
res <- knn(data, query, k=3)

# Approximate search (eps > 0 for speedup)
res_approx <- knn(data, query, k=3, eps=0.1)
```

### WKNN: Reusable Search Trees
For repeated queries against the same target point set, use the `WKNN` (double precision) or `WKNNF` (float precision) reference classes. This avoids rebuilding the k-d tree for every call.

```r
# 1. Build the tree once
target <- matrix(runif(3000), ncol=3)
W <- WKNNd(target)

# 2. Query multiple times
res1 <- W$query(query_set1, k=1)
res2 <- W$query(query_set2, k=5)
```

## Workflows and Tips

### Drop-in Replacement for RANN
If you have existing code using `RANN::nn2`, you can switch to `nabor` by simply changing the function call. `nabor::knn` supports the same arguments: `data`, `query`, `k`, `treetype`, `searchtype`, and `eps`.

### Memory Efficiency with Floats
If you are working with very large point sets and memory is a constraint, use `WKNNF`. It stores coordinates as 4-byte floats instead of R's default 8-byte doubles, significantly reducing the memory footprint of the k-d tree.

### Search Types
- `searchtype=1`: Priority search (default, usually fastest).
- `searchtype=2`: Simple bucket search.

### Distance Metrics
Note that `nabor` returns **squared** Euclidean distances by default to save computation time. If you need actual Euclidean distances, apply `sqrt()` to the `nn.dists` result.

## Reference documentation
- [README](./references/README.md)
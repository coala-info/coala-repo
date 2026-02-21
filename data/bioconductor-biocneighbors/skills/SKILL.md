---
name: bioconductor-biocneighbors
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocNeighbors.html
---

# bioconductor-biocneighbors

## Overview

The `BiocNeighbors` package provides a unified interface for nearest-neighbor (NN) searching in R. It abstracts different search algorithms (exact and approximate) so users can switch between them by simply changing a parameter object. This is essential for tasks like clustering, dimensionality reduction (e.g., UMAP/t-SNE), and batch correction in bioinformatics.

## Core Workflows

### 1. Finding K-Nearest Neighbors (KNN)
Use `findKNN()` to find a fixed number of neighbors for every point in a dataset.

```r
library(BiocNeighbors)

# data: matrix with observations in rows, dimensions in columns
# k: number of neighbors to find
fout <- findKNN(data, k=10)

# Returns a list:
# fout$index: Matrix of row indices of neighbors
# fout$distance: Matrix of distances to those neighbors
```

### 2. Querying Neighbors Across Datasets
Use `queryKNN()` to find neighbors in a reference dataset for points in a new query dataset.

```r
qout <- queryKNN(data, query, k=5)
```

### 3. Finding Neighbors within a Distance (Range Search)
Use `findNeighbors()` or `queryNeighbors()` to find all points within a specific radius (`threshold`).

```r
# Returns a list of vectors (since neighbor counts vary per point)
fout <- findNeighbors(data, threshold=1.0)

# Get counts only (memory efficient)
counts <- findNeighbors(data, threshold=1.0, get.index=FALSE, get.distance=FALSE)
```

## Algorithm Selection (BNPARAM)

The `BNPARAM` argument controls the algorithm and distance metric. If not specified, it defaults to an exact search using `KmknnParam()`.

| Algorithm | Parameter Function | Type | Best For |
| :--- | :--- | :--- | :--- |
| **KMKNN** | `KmknnParam()` | Exact | General purpose exact search |
| **Vantage Point Tree** | `VptreeParam()` | Exact | High-dimensional exact search |
| **Brute Force** | `ExhaustiveParam()` | Exact | Small datasets / Debugging |
| **Annoy** | `AnnoyParam()` | Approx | Very large datasets (fast, less accurate) |
| **HNSW** | `HnswParam()` | Approx | Very large datasets (fast, high memory) |

**Example: Switching to Annoy with Manhattan distance**
```r
# Note: Not all algorithms support all distance metrics
vout <- findKNN(data, k=10, BNPARAM=VptreeParam(distance="Manhattan"))
aout <- findKNN(data, k=10, BNPARAM=AnnoyParam())
```

## Performance Optimization

### Index Pre-building
If you plan to perform multiple searches on the same reference dataset, build the index once to save time.

```r
# Build the index once
prebuilt <- buildIndex(data, BNPARAM=KmknnParam())

# Reuse the index
out1 <- findKNN(prebuilt, k=5)
out2 <- queryKNN(prebuilt, query_matrix, k=5)
```

### Variable K
If different points require different numbers of neighbors, pass an integer vector to `k` wrapped in `I()`.

```r
var.k <- c(2, 5, 10, ...) 
var.out <- findKNN(data, k=I(var.k))
```

## Tips and Best Practices
- **Data Orientation**: Ensure your input is a matrix where rows are observations and columns are features.
- **Approximate vs Exact**: Use `AnnoyParam` or `HnswParam` for datasets with >100,000 points where a slight loss in accuracy is acceptable for significant speed gains.
- **Distance Metrics**: The default is "Euclidean". "Manhattan" is also supported by many backends.
- **Memory**: For range searches (`findNeighbors`) on dense data, use `get.index=FALSE` if you only need the number of neighbors to avoid creating massive lists.

## Reference documentation
- [Finding neighbors in high-dimensional space](./references/userguide.md)
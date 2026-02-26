---
name: r-rann
description: This tool performs fast exact or approximate k-nearest neighbour and fixed-radius searches using the ANN library and Euclidean metric. Use when user asks to find nearest neighbours, perform spatial clustering, or execute high-dimensional distance queries in R.
homepage: https://cloud.r-project.org/web/packages/RANN/index.html
---


# r-rann

name: r-rann
description: Fast Nearest Neighbour Search using the ANN library and L2 (Euclidean) metric. Use this skill when you need to perform k-nearest neighbour (k-NN) searches, fixed-radius searches, or approximate nearest neighbour queries in R, particularly for high-dimensional data where O(N log N) performance is required.

## Overview

The `RANN` package provides an R interface to the ANN (Approximate Nearest Neighbor) library. It is optimized for finding the k nearest neighbours for every point in a dataset using the L2 (Euclidean) metric. It supports both exact and approximate searches, as well as kd-tree and bd-tree (box-decomposition) structures.

## Installation

```r
install.packages("RANN")
```

## Main Functions

### nn2()
The primary function for nearest neighbour search.

```r
library(RANN)

# Basic k-NN search
# data: matrix or data frame of reference points
# query: matrix or data frame of query points (defaults to data)
# k: number of nearest neighbours to find
result <- nn2(data = reference_coords, query = query_coords, k = 5)

# result is a list containing:
# result$nn.idx - Matrix of indices of the nearest neighbours
# result$nn.dists - Matrix of Euclidean distances to the neighbours
```

### Key Parameters for nn2()

- `treetype`: Use `"kd"` (default) or `"bd"` (box-decomposition tree, can be more robust for highly clustered data).
- `searchtype`: 
  - `"standard"` (default): Exact search.
  - `"priority"`: Often faster for approximate searches.
  - `"radius"`: Fixed radius search (requires setting `radius`).
- `eps`: Error bound for approximate search. If `eps > 0`, the distance to the reported $i^{th}$ neighbour is at most $(1+\epsilon)$ times the distance to the true $i^{th}$ neighbour.
- `radius`: Only used if `searchtype="radius"`. Points further than this distance will have an index of 0 and distance of 1.340781e+154.

## Workflows

### Finding Self-Neighbours
When querying a dataset against itself, the first neighbour (k=1) is always the point itself (distance 0). To find the nearest "other" point, set `k=2`.

```r
# Find the nearest neighbour for each point in 'df' excluding itself
res <- nn2(df, k = 2)
nearest_neighbor_idx <- res$nn.idx[, 2]
nearest_neighbor_dist <- res$nn.dists[, 2]
```

### Approximate Search for Speed
For very large datasets where exactness is less critical than speed, increase `eps`.

```r
# 10% error tolerance for significant speedup
res <- nn2(data, query, k = 10, eps = 0.1)
```

### Fixed Radius Search
Useful for spatial clustering or finding all points within a specific distance.

```r
# Find neighbours within a radius of 5.0
res <- nn2(data, query, k = 100, searchtype = "radius", radius = 5.0)
# Note: k still acts as a ceiling for the number of points returned per query.
```

## Tips

- **Data Types**: Input data should be numeric matrices or data frames. Non-numeric columns will cause errors.
- **L1 Metric**: `RANN` only supports L2 (Euclidean). For Manhattan/Taxicab distance, use the `RANN.L1` package.
- **Memory**: The tree is built in C++ memory. For extremely large datasets, ensure sufficient RAM is available for the tree structure.
- **Search Limits**: If `k` is larger than the number of points in `data`, the function will return an error.

## Reference documentation

- [README](./references/README.md)
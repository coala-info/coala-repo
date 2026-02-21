---
name: r-fastcluster
description: "This is a two-in-one package which provides interfaces to         both R and 'Python'. It implements fast hierarchical, agglomerative         clustering routines. Part of the functionality is designed as drop-in         replacement for existing routines: linkage() in the 'SciPy' package         'scipy.cluster.hierarchy', hclust() in R's 'stats' package, and the         'flashClust' package. It provides the same functionality with the         benefit of a much faster implementation. Moreover, there are         memory-saving routines for clustering of vector data, which go beyond         what the existing packages provide. For information on how to install         the 'Python' files, see the file INSTALL in the source distribution."
homepage: https://cloud.r-project.org/web/packages/fastcluster/index.html
---

# r-fastcluster

name: r-fastcluster
description: High-performance hierarchical clustering using the fastcluster package. Use this skill when you need to perform agglomerative clustering (single, complete, average, Ward, centroid, median) on large datasets in R. It serves as a faster, drop-in replacement for stats::hclust and flashClust, offering memory-efficient routines for vector data.

## Overview

The `fastcluster` package provides highly optimized C++ implementations of hierarchical clustering algorithms. It is significantly faster than the default R `stats::hclust` function and provides a memory-saving `hclust.vector` function for high-dimensional data where a full distance matrix would exceed available RAM.

## Installation

```R
install.packages("fastcluster")
```

## Core Workflows

### 1. Drop-in Replacement for hclust
The package overwrites the default `hclust` function when loaded. It accepts a dissimilarity matrix (from `dist()`).

```R
library(fastcluster)

# Generate data and distance matrix
data <- matrix(rnorm(1000), ncol=10)
d <- dist(data)

# Perform clustering (uses fastcluster implementation)
hc <- hclust(d, method='ward.D2')

# Standard R dendrogram methods work normally
plot(hc)
groups <- cutree(hc, k=3)
```

### 2. Memory-Efficient Clustering (Vector Data)
For large $N$, use `hclust.vector` to avoid the $\Theta(N^2)$ memory cost of a distance matrix. This requires only $\Theta(N \cdot D)$ memory.

```R
# Clustering 10,000 points in 50 dimensions
X <- matrix(rnorm(10000 * 50), ncol=50)

# Memory-saving single linkage
hc_vec <- hclust.vector(X, method='single', metric='euclidean')

# Centroid, Median, and Ward methods (Euclidean only)
hc_ward <- hclust.vector(X, method='ward')
```

## Function Reference

### hclust(d, method='complete', members=NULL)
*   **d**: A dissimilarity structure (as produced by `dist`).
*   **method**: 'single', 'complete', 'average', 'mcquitty', 'centroid', 'median', 'ward.D', 'ward.D2'.
*   **Note**: For 'centroid' and 'median', R expects **squared** Euclidean distances in `d` to match standard conventions.

### hclust.vector(X, method='single', metric='euclidean', p=NULL)
*   **X**: $N \times D$ data matrix.
*   **method**: 'single', 'centroid', 'median', 'ward'.
*   **metric**: 'euclidean', 'maximum', 'manhattan', 'canberra', 'binary', 'minkowski'.
*   **Note**: Unlike `hclust`, `hclust.vector` operates on **non-squared** Euclidean distances for 'centroid', 'median', and 'ward'.

## Key Differences & Tips

*   **Ward's Method**: Use `method='ward.D2'` in `hclust` for the standard Ward algorithm that works with Euclidean distances. `ward.D` expects squared distances.
*   **Performance**: The speedup is most noticeable on large datasets ($N > 1000$).
*   **Namespace**: If you need to ensure the fast version is used without masking, call `fastcluster::hclust()`.
*   **Missing Values**: `hclust.vector` handles `NA` values similarly to `dist()`, while the Python interface does not.
*   **Ties**: Due to floating-point precision, `fastcluster` might resolve ties in distances differently than `stats::hclust`, which can lead to different dendrogram structures in rare cases.

## Reference documentation

- [fastcluster: Fast Hierarchical Clustering Routines for R and Python](./references/fastcluster.md)
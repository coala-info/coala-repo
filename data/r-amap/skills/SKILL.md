---
name: r-amap
description: This tool provides optimized and parallelized implementations for hierarchical clustering, k-means, and robust principal component analysis in R. Use when user asks to perform parallelized clustering, apply non-Euclidean distance metrics to datasets, or conduct robust PCA for outlier detection.
homepage: https://cloud.r-project.org/web/packages/amap/index.html
---


# r-amap

name: r-amap
description: Specialized tools for Clustering and Principal Component Analysis (PCA) using the 'amap' R package. Use this skill when performing multidimensional analysis requiring parallelized hierarchical clustering, k-means with various distance metrics (Euclidean, Spearman, Correlation, etc.), or robust PCA methods for outlier detection.

# r-amap

## Overview
The `amap` (Another Multidimensional Analysis Package) provides optimized and parallelized implementations of clustering and PCA. It is particularly useful for large datasets where standard R clustering functions are slow, or when non-Euclidean distance metrics (like rank-based Spearman or correlation) are required for clustering.

## Installation
```R
install.packages("amap")
library(amap)
```

## Clustering Workflows

### Hierarchical Clustering (`hcluster`)
`hcluster` is a parallelized replacement for `hclust`.
- **Basic usage**: `h <- hcluster(USArrests)`
- **Parallel execution**: Use `nbproc` to specify CPU cores: `h <- hcluster(USArrests, nbproc = 4)`
- **Distance methods**: Supports "euclidean", "maximum", "manhattan", "canberra", "binary", "pearson", "correlation", "spearman", or "kendall".
- **Integration with Heatmaps**:
  ```R
  heatmap(as.matrix(USArrests), hclustfun = hcluster, distfun = function(u){u})
  ```

### K-means Clustering (`Kmeans`)
`Kmeans` allows for different distance metrics, unlike the standard `kmeans` function.
- **Usage**: `Kmeans(x, centers = 3, method = "correlation")`
- **Methods**: "euclidean", "maximum", "manhattan", "canberra", "binary", "pearson", or "correlation".

## Robust Analysis Tools

### Robust PCA
The package provides methods to perform PCA that are less sensitive to outliers.
- **Generalized PCA**: `p <- acpgen(data, h1 = 1, h2 = 1/sqrt(2))`
- **Robust PCA**: `p <- acprob(data, h = 4)`
- **Visualization**: Use `plot(p)` on the resulting object to view projections.

### Robust Variance
Compute a robust variance estimation:
- **Usage**: `varrob(scale(data), h = 1)`

## Tips and Best Practices
- **Performance**: Always utilize the `nbproc` argument in `hcluster` when working on multi-core systems to significantly reduce computation time.
- **Distance Selection**: Use `method = "spearman"` or `method = "kendall"` in clustering when the data is ordinal or contains non-linear relationships that are monotonic.
- **Demos**: Run `demo(amap)` in the R console to see interactive examples of the package capabilities.

## Reference documentation
- [amap: Another Multidimensional Analysis Package](./references/amap.md)
---
name: r-fpc
description: "Various methods for clustering and cluster validation.   Fixed point clustering. Linear regression clustering. Clustering by    merging Gaussian mixture components. Symmetric    and asymmetric discriminant projections for visualisation of the    separation of groupings. Cluster validation statistics   for distance based clustering including corrected Rand index.    Standardisation of cluster validation statistics by random clusterings and    comparison between many clustering methods and numbers of clusters based on   this.     Cluster-wise cluster stability assessment. Methods for estimation of    the number of clusters: Calinski-Harabasz, Tibshirani and Walther's    prediction strength, Fang and Wang's bootstrap stability.    Gaussian/multinomial mixture fitting for mixed    continuous/categorical variables. Variable-wise statistics for cluster   interpretation. DBSCAN clustering. Interface functions for many    clustering methods implemented in R, including estimating the number of   clusters with kmeans, pam and clara. Modality diagnosis for Gaussian   mixtures. For an overview see package?fpc.</p>"
homepage: https://cloud.r-project.org/web/packages/fpc/index.html
---

# r-fpc

## Overview
The `fpc` package provides a comprehensive suite of flexible procedures for clustering. It is particularly valued for its implementation of DBSCAN, cluster validation statistics (like the bootstrap stability and prediction strength), and specialized methods like fixed-point clustering and linear regression clustering. It also offers powerful visualization tools for comparing cluster separations.

## Installation
To install the package from CRAN:
```R
install.packages("fpc")
library(fpc)
```

## Main Functions and Workflows

### 1. Density-Based Clustering (DBSCAN)
The `dbscan` function is a core feature for finding clusters of arbitrary shape based on density.
```R
# eps: reachability distance; MinPts: minimum points in a neighborhood
ds <- dbscan(data, eps = 0.5, MinPts = 5)
print(ds)
plot(ds, data)
```

### 2. Estimating the Number of Clusters
`fpc` provides several robust methods to determine the optimal number of clusters ($k$):
- **Prediction Strength**: `prediction.strength(data, Gmin=2, Gmax=10)`
- **Calinski-Harabasz Index**: `calinhara(data, clustering)`
- **PAM/K-means Interface**: `pamk(data)` automatically selects $k$ using the silhouette coefficient.

### 3. Cluster Validation and Stability
Use `clusterboot` to assess the stability of a clustering result via resampling (bootstrap).
```R
# Stability of k-means
cf <- clusterboot(data, B=100, bootmethod="boot", clustermethod=kmeansCBI, krange=3)
print(cf) # Look for cluster stability values > 0.75 or 0.85
```

### 4. Cluster Validation Statistics
The `cluster.stats` function computes a wide variety of distance-based statistics, including the Hubert γ, Dunn index, and corrected Rand index (for comparing two partitions).
```R
stats <- cluster.stats(dist(data), clustering_vector)
stats$avg.silwidth  # Average silhouette width
stats$corrected.rand # Comparison to ground truth if provided
```

### 5. Visualization of Cluster Separation
`plotcluster` provides a discriminant projection to visualize how well clusters are separated.
```R
# Visualizing clusters in a 2D projection
plotcluster(data, ds$cluster)
```

## Tips for Usage
- **Data Scaling**: Most functions in `fpc` are distance-based. Ensure data is standardized using `scale()` if variables are on different units.
- **CBI Interface**: Functions like `clusterboot` use "Cluster Base Interface" (CBI) functions (e.g., `kmeansCBI`, `pamCBI`). If using a custom method, ensure it follows the CBI wrapper format.
- **Large Datasets**: For very large datasets, use `clara` via the `claraCBI` interface within `clusterboot` to maintain performance.

## Reference documentation
- [Christian Hennig Home Page](./references/home_page.md)
---
name: r-flashclust
description: This tool provides a fast, memory-efficient implementation of hierarchical clustering designed as a drop-in replacement for the standard R hclust function. Use when user asks to perform hierarchical clustering on large datasets, speed up agglomerative clustering workflows, or use flashClust for high-performance data analysis.
homepage: https://cran.r-project.org/web/packages/flashclust/index.html
---


# r-flashclust

name: r-flashclust
description: Fast implementation of hierarchical clustering in R. Use this skill when performing hierarchical clustering on large datasets where the standard hclust function is too slow. It provides an optimized, computationally efficient implementation of the same agglomerative algorithms.

## Overview
The flashclust package provides a high-performance implementation of hierarchical clustering. It is designed to be a drop-in replacement for the standard `stats::hclust` function, offering significantly faster execution times for large-scale data analysis. It is frequently used in bioinformatics and genomic workflows (such as WGCNA) where distance matrices can be very large.

## Installation
To install the package from CRAN:
```R
install.packages("flashclust")
```

## Core Functions and Usage

### flashClust()
The primary function is `flashClust()`, which takes a distance matrix and returns a clustering object.

```R
library(flashclust)

# 1. Prepare data and calculate distance
data(iris)
d <- dist(iris[, 1:4])

# 2. Perform fast hierarchical clustering
# Supported methods: "ward", "single", "complete", "average", "mcquitty", "median", "centroid"
hc <- flashClust(d, method = "complete")

# 3. Standard hclust-compatible operations
plot(hc)
groups <- cutree(hc, k = 3)
```

### Key Differences from hclust
- **Performance**: `flashClust` is optimized for speed and memory efficiency.
- **Compatibility**: The output object is of class `hclust`, meaning all standard R functions that work with `hclust` (like `plot`, `cutree`, `rect.hclust`, and `as.dendrogram`) work perfectly with `flashClust` results.
- **Arguments**: It accepts the same arguments as `hclust`:
  - `d`: A dissimilarity structure (dist object).
  - `method`: The agglomeration method.
  - `members`: NULL or a vector of observation weights.

## Common Workflow: Large Scale Clustering
When working with very large datasets, use `flashClust` in conjunction with efficient distance calculations:

```R
# Example for high-dimensional data
# Use a fast correlation-based distance if applicable
sim <- cor(large_matrix)
dist_matrix <- as.dist(1 - sim)

# Cluster using flashClust
hc <- flashClust(dist_matrix, method = "average")
```

## Tips
- If you are using the `WGCNA` package, `flashClust` is often automatically utilized or recommended for the `blockwiseModules` and `adjacency` workflows.
- For extremely large datasets that do not fit into memory as a distance matrix, consider using `fastcluster` or divisive methods, though `flashClust` is the standard for optimized agglomerative clustering.

## Reference documentation
- [flashClust: Implementation of optimal hierarchical clustering](./references/home_page.md)
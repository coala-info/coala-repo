---
name: pycluster
description: Pycluster performs high-performance clustering operations on large-scale numerical datasets by interfacing Python with the C Clustering Library. Use when user asks to perform hierarchical clustering, run k-means or k-medians partitioning, or generate self-organizing maps.
homepage: http://bonsai.hgc.jp/~mdehoon/software/cluster/software.htm#pycluster
---


# pycluster

## Overview
The `pycluster` skill enables high-performance clustering operations by interfacing Python with the C Clustering Library. It is specifically optimized for large-scale biological datasets, such as gene expression matrices, but is applicable to any numerical data requiring robust clustering. This skill should be used to implement standard clustering workflows including partitioning methods (k-means/medians) and hierarchical structures (centroid, single, complete, and average linkage).

## Core Usage Patterns

### Hierarchical Clustering
Use `Pycluster.treecluster` to perform hierarchical clustering. This is the primary method for generating dendrograms.

```python
import Pycluster
import numpy as np

# data: 2D array (rows=items, cols=features)
# method: 'm' (pair-group method using arithmetic days), 's' (single), 'c' (complete), 'a' (average)
# dist: 'e' (Euclidean), 'c' (Correlation), 'a' (Absolute correlation), 'u' (Uncentered correlation), 'x' (Spearman), 'k' (Kendall)
tree = Pycluster.treecluster(data, method='m', dist='e')

# To get a specific number of clusters from the tree
labels = tree.cut(nclusters=5)
```

### K-Means and K-Medians
Use `Pycluster.kcluster` for partitioning data into a pre-defined number of clusters.

```python
# nclusters: number of clusters
# npass: number of times the algorithm is run (returns the best result)
# method: 'a' (arithmetic mean/k-means), 'm' (median/k-medians)
clusterid, error, nfound = Pycluster.kcluster(data, nclusters=10, npass=5, method='a', dist='e')
```

### Self-Organizing Maps (SOM)
Use `Pycluster.somcluster` for dimensionality reduction and topology-preserving clustering.

```python
# nxgrid, nygrid: dimensions of the rectangular grid
clusterid, grid = Pycluster.somcluster(data, nxgrid=3, nygrid=2, inittau=0.02, niter=100, dist='e')
```

## Expert Tips & Best Practices

- **Distance Metrics**: For gene expression data, 'c' (Pearson correlation) or 'u' (Uncentered correlation) are often preferred over 'e' (Euclidean) to capture shape similarities rather than magnitude.
- **Data Preparation**: Ensure data is passed as a NumPy array or a compatible nested list. `pycluster` is sensitive to `NaN` values; use the `mask` parameter (an array of 1s and 0s) to indicate missing data points.
- **Performance**: Because the underlying engine is written in C, `pycluster` is significantly faster than pure Python implementations for large matrices. Always use the `npass` parameter in k-means to avoid local minima.
- **Memory Management**: For extremely large datasets, hierarchical clustering (`treecluster`) has $O(n^2)$ memory complexity. Monitor system RAM when clustering more than 10,000 elements.

## Reference documentation
- [Open Source Clustering Software Overview](./references/bonsai_hgc_jp__mdehoon_software_cluster_software.htm.md)
- [Pycluster Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_pycluster_overview.md)
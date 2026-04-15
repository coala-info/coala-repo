---
name: fastcluster
description: fastcluster provides optimized C++ routines for hierarchical, agglomerative clustering as a high-performance replacement for Scipy and R functions. Use when user asks to perform hierarchical clustering, use linkage methods like Ward or centroid, or process large datasets that require memory-efficient clustering.
homepage: https://github.com/fastcluster/fastcluster
metadata:
  docker_image: "biocontainers/fastcluster:v1.1.22-1-deb-py2_cv1"
---

# fastcluster

## Overview
fastcluster is a C++ library providing optimized routines for hierarchical, agglomerative clustering. It implements the seven most common clustering schemes (single, complete, average, weighted, Ward, centroid, and median linkage) with significantly faster algorithms than standard libraries. In Python, it acts as a drop-in replacement for `scipy.cluster.hierarchy`, while in R, it replaces `stats::hclust`. It is particularly valuable for processing large observation sets where standard distance matrix calculations would exceed available memory.

## Python Usage and Best Practices

### Drop-in Replacement for Scipy
The Python interface is designed to mirror `scipy.cluster.hierarchy`. You can replace Scipy calls directly to gain performance:

```python
import fastcluster
import numpy as np

# X can be an (n x d) array of vectors or a condensed distance matrix
Z = fastcluster.linkage(X, method='ward', metric='euclidean')
```

### Memory Optimization with `preserve_input`
When working with large distance matrices, you can save approximately 50% of the memory by allowing the library to use the input array as scratch space.

- **Pattern**: Set `preserve_input=False`.
- **Warning**: The input array `X` will contain unspecified values after the function call. Delete the reference immediately to prevent accidental use.

```python
Z = fastcluster.linkage(X, method='complete', preserve_input=False)
del X # Ensure the corrupted matrix is not accessed
```

### Memory-Efficient Vector Clustering
For very large datasets where a distance matrix (size $O(n^2)$) cannot fit in memory, use `linkage_vector`. This function clusters $n$ observation vectors in $d$ dimensions directly.

```python
# Supported methods: 'single', 'ward', 'centroid', 'median'
Z = fastcluster.linkage_vector(X, method='ward', metric='euclidean')
```

**Constraints for `linkage_vector`**:
- `ward`, `centroid`, and `median` methods **require** the Euclidean metric.
- `single` linkage supports any metric implemented in `scipy.spatial.distance.pdist`.

## Supported Linkage Methods
- `single`
- `complete`
- `average`
- `weighted` (McQuitty)
- `ward`
- `centroid`
- `median`

## Expert Tips
- **Performance**: fastcluster is almost always faster than Scipy. For large $N$, the difference can be orders of magnitude.
- **R Interface**: In R, the package provides a `fastcluster::hclust` function that follows the same signature as `stats::hclust`.
- **Input Formats**: `linkage` accepts both the $(n \times d)$ observation matrix and the condensed distance matrix (as returned by `pdist`). `linkage_vector` only accepts the $(n \times d)$ observation matrix.

## Reference documentation
- [fastcluster README](./references/github_com_fastcluster_fastcluster.md)
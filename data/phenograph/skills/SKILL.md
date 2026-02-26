---
name: phenograph
description: PhenoGraph is a clustering method that partitions single-cell biological data into distinct subpopulations by identifying communities within a phenotypic similarity graph. Use when user asks to cluster single-cell data, identify cell types without prior labeling, or detect communities in high-dimensional biological datasets.
homepage: https://github.com/dpeerlab/PhenoGraph
---


# phenograph

## Overview
PhenoGraph is a clustering method designed to handle the complexity and dimensionality of single-cell biological data. It operates by creating a graph where nodes represent individual cells and edges represent phenotypic similarities. By identifying "communities" within this graph, it can partition cells into distinct subpopulations. It is particularly useful for researchers needing a robust, scalable way to discover cell types without prior labeling.

## Implementation Patterns

### Basic Python Usage
PhenoGraph is primarily used as a Python library. The input must be a `numpy.ndarray`.

```python
import phenograph
import numpy as np

# data should be a N x D numpy array (N cells, D features)
communities, graph, Q = phenograph.cluster(data)

# communities: array of cluster assignments
# graph: the sparse adjacency matrix
# Q: the modularity score
```

### Algorithm Selection
By default, PhenoGraph uses the Louvain method. Since version 1.5.3, the Leiden algorithm is supported, which often yields better-connected communities.

```python
# Use Leiden algorithm
communities, graph, Q = phenograph.cluster(data, clustering_algo='leiden')

# Adjust Leiden iterations for better convergence
communities, graph, Q = phenograph.cluster(data, clustering_algo='leiden', n_iterations=10)
```

### Handling Outliers
PhenoGraph identifies outliers that do not fit well into any community. These are assigned a value of `-1` in the resulting communities vector. Always filter these before downstream analysis.

```python
# Filter out outliers
valid_cells = communities != -1
clean_data = data[valid_cells]
clean_communities = communities[valid_cells]
```

### Performance and Large Datasets
For very large datasets, the choice of nearest neighbor method and parallelism is critical.

- **Nearest Neighbor Method**: Use `nn_method='kdtree'` (default) for most cases. If encountering memory issues or working with extremely high dimensions, `nn_method='brute'` with `n_jobs` can be more stable.
- **Parallelism**: PhenoGraph uses multicore parallelism via `multiprocessing`.
- **Time Limits**: For large Louvain runs, you may need to adjust `louvain_time_limit` (default is 2000s).

```python
# High-performance configuration
communities, graph, Q = phenograph.cluster(
    data, 
    k=30, 
    nn_method='kdtree', 
    n_jobs=-1, 
    louvain_time_limit=3600
)
```

## Expert Tips
- **Data Preprocessing**: PhenoGraph does not perform normalization. Ensure data is properly transformed (e.g., Arcsinh for CyTOF or Log-normalization for scRNA-seq) before clustering.
- **Granularity**: The parameter `k` (number of nearest neighbors) controls the resolution. A smaller `k` will result in more, smaller clusters; a larger `k` will result in fewer, larger clusters.
- **Sparse Input**: You can pass a square sparse matrix directly to `phenograph.cluster()`. This matrix will be interpreted as a pre-computed k-nearest neighbor graph.

## Reference documentation
- [PhenoGraph GitHub Repository](./references/github_com_dpeerlab_PhenoGraph.md)
- [Bioconda PhenoGraph Overview](./references/anaconda_org_channels_bioconda_packages_phenograph_overview.md)
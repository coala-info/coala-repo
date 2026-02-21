---
name: markov_clustering
description: This skill facilitates the use of the `markov_clustering` Python library to implement the Markov Clustering (MCL) algorithm.
homepage: https://github.com/GuyAllard/markov_clustering
---

# markov_clustering

## Overview

This skill facilitates the use of the `markov_clustering` Python library to implement the Markov Clustering (MCL) algorithm. MCL is a deterministic algorithm for graph clustering based on the simulation of stochastic flow (random walks) within a graph. This implementation is optimized for performance using sparse matrices (via SciPy) and includes built-in utilities for cluster extraction, modularity-based quality assessment, and graph visualization.

## Core Workflow

### 1. Installation
To use the full feature set including visualization:
```bash
pip install markov_clustering[drawing]
```

### 2. Basic Implementation
The algorithm operates on adjacency matrices. If using NetworkX, ensure you convert the graph to a SciPy sparse matrix first.

```python
import markov_clustering as mc
import networkx as nx

# 1. Obtain adjacency matrix (Sparse)
# Note: Use nx.adjacency_matrix as nx.to_scipy_sparse_matrix is deprecated
matrix = nx.adjacency_matrix(network)

# 2. Run MCL
# Default inflation is 2.0
result = mc.run_mcl(matrix, inflation=2.0)

# 3. Extract Clusters
clusters = mc.get_clusters(result)
```

### 3. Hyperparameter Tuning (Inflation)
The `inflation` parameter is the primary handle for cluster granularity.
- **Lower Inflation (e.g., 1.4 - 1.5):** Produces fewer, larger (coarser) clusters.
- **Higher Inflation (e.g., 2.5 - 3.0):** Produces many, smaller (finer) clusters.

To find the optimal value, iterate through a range and calculate the **Modularity (Q)**. A higher Q indicates better clustering quality.

```python
for i in range(15, 26):
    inf = i / 10
    res = mc.run_mcl(matrix, inflation=inf)
    cls = mc.get_clusters(res)
    q = mc.modularity(matrix=res, clusters=cls)
    print(f"Inflation: {inf}, Modularity: {q}")
```

### 4. Visualization
Use `draw_graph` to inspect the results. This requires `matplotlib` and `networkx`.

```python
mc.draw_graph(matrix, clusters, node_size=50, with_labels=False, edge_color="silver")
```

## Expert Tips and Best Practices

- **Sparse Matrix Efficiency:** Always pass sparse matrices (SciPy `csr_matrix` or `csc_matrix`) to `run_mcl`. The algorithm is designed to leverage sparsity for performance; using dense arrays will significantly slow down execution on large graphs.
- **NetworkX Integration:** When using `networkx.random_geometric_graph` or similar, ensure you pass the `pos` (positions) dictionary to `draw_graph` to maintain consistent layout between the original graph and the clustered output.
- **Pruning:** For extremely large or dense graphs, the algorithm's pruning feature helps maintain sparsity during the expansion/inflation cycles, preventing the "nnz (number of non-zeros) is too large" error.
- **Modularity Input:** When calling `mc.modularity()`, the `matrix` argument should be the **result matrix** returned by `run_mcl`, not the original adjacency matrix.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_GuyAllard_markov_clustering.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_markov_clustering_overview.md)
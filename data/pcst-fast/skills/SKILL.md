---
name: pcst-fast
description: pcst-fast provides a high-performance implementation of the Goemans-Williamson approximation scheme for solving the Prize-Collecting Steiner Tree and Forest problems. Use when user asks to find an optimal connected subgraph based on node prizes and edge costs, solve the Prize-Collecting Steiner Tree problem, or identify high-value clusters in large-scale networks.
homepage: https://github.com/fraenkel-lab/pcst_fast
metadata:
  docker_image: "quay.io/biocontainers/pcst-fast:1.0.10--py310h84f13bb_1"
---

# pcst-fast

## Overview

The `pcst-fast` library provides a high-performance implementation of the Goemans-Williamson approximation scheme for the Prize-Collecting Steiner Tree/Forest problem. It is designed for speed, capable of processing graphs with hundreds of thousands of edges in seconds. This tool is essential for researchers and engineers working with large-scale networks where the goal is to find a connected (or multi-component) subgraph that captures the most valuable nodes (prizes) while paying the least for the connections (costs). It offers a factor-2 approximation guarantee and runs in nearly-linear time.

## Installation

Install the package via conda or pip:

```bash
# Via Conda (Bioconda channel)
conda install bioconda::pcst-fast

# Via Pip
pip install pcst_fast
```

## Core Python Usage

The primary interface is a single function call. Ensure your data is formatted as NumPy arrays with specific bit-depths to avoid type conflicts.

```python
import pcst_fast
import numpy as np

# 1. Define edges as a 2D int64 array of node pairs (0-indexed)
edges = np.array([[0, 1], [1, 2], [0, 2]], dtype=np.int64)

# 2. Define node prizes as a 1D float64 array
prizes = np.array([10.0, 5.0, 0.0], dtype=np.float64)

# 3. Define edge costs as a 1D float64 array
costs = np.array([1.0, 1.0, 5.0], dtype=np.float64)

# 4. Execute the solver
# Parameters: edges, prizes, costs, root, num_clusters, pruning, verbosity
vertices, result_edges = pcst_fast.pcst_fast(edges, prizes, costs, -1, 1, 'strong', 0)
```

### Parameter Guide

- **root**: Use `-1` for the unrooted variant (PCSF). Specify a node index (0 to n-1) to force the tree to include a specific root.
- **num_clusters**: The number of connected components desired in the output. Typically set to `1` for a single Steiner Tree.
- **pruning**: 
    - `'gw'`: Standard Goemans-Williamson pruning.
    - `'strong'`: Recommended. Provides the same theoretical guarantees as GW but often yields better empirical results for PCSF.
    - `'none'`/`'simple'`: Only used for debugging; these do not provide approximation guarantees.
- **verbosity_level**: Set to `0` for quiet operation, higher integers for debug output.

## Expert Tips and Best Practices

- **Node Indexing**: Nodes must be labeled contiguously from `0` to `n-1`. If your source data uses strings or non-contiguous IDs, use a mapping dictionary to convert them before passing to the solver.
- **Output Interpretation**: The returned `vertices` array contains the indices of the nodes included in the solution. The `result_edges` array contains the **indices** of the edges from the input `edges` array, not the node pairs themselves.
- **Data Types**: The library is sensitive to NumPy dtypes. Always explicitly cast `edges` to `np.int64` and `prizes`/`costs` to `np.float64` to prevent "input args data type conflict" errors.
- **Handling Negative Prizes**: The algorithm is designed for non-negative prizes. If your model involves penalties, consider normalizing them or treating them as edge costs where appropriate.
- **Performance**: For very large graphs (300k+ edges), the 'strong' pruning method remains efficient, typically finishing in under 2 seconds on modern hardware.

## Reference documentation

- [pcst-fast GitHub Repository](./references/github_com_fraenkel-lab_pcst_fast.md)
- [pcst-fast Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pcst-fast_overview.md)
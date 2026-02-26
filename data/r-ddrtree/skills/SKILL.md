---
name: r-ddrtree
description: This tool performs dimensionality reduction and principal graph learning using the Discriminative Dimensionality Reduction Tree algorithm. Use when user asks to perform manifold learning, infer cell trajectories in single-cell genomics, or reconstruct tree-structured latent variables from high-dimensional data.
homepage: https://cran.r-project.org/web/packages/ddrtree/index.html
---


# r-ddrtree

name: r-ddrtree
description: Learning principal graphs and dimensionality reduction using the DDRTree (Discriminative Dimensionality Reduction Tree) algorithm. Use this skill when you need to perform manifold learning, infer cell trajectories in single-cell genomics, or reconstruct tree-structured latent variables from high-dimensional data.

## Overview

The `DDRTree` package implements the Reversed Graph Embedding (RGE) framework. It projects high-dimensional data into a reduced dimensional space while simultaneously constructing a principal tree that passes through the data. It is particularly effective for:
- Inferring temporal progression (pseudotime) in biological datasets.
- Identifying bifurcation structures (branching points) in complex data.
- Dimensionality reduction where the underlying structure is non-linear and tree-like.

## Installation

To install the package from CRAN:

```R
install.packages("DDRTree")
```

## Core Workflow

The primary function in the package is `DDRTree()`.

### Basic Usage

```R
library(DDRTree)

# Assume 'data' is a matrix where rows are features and columns are samples
# DDRTree expects a matrix [dimensions x samples]
data_matrix <- as.matrix(your_data)

# Run DDRTree
# L: number of latent nodes (defaults to number of samples)
# dimensions: target reduced dimension (default is 2)
ddrtree_res <- DDRTree(data_matrix, dimensions = 2, max_iter = 20, verbose = TRUE)

# Access results
reduced_dim_coords <- ddrtree_res$Z  # Latent coordinates
principal_tree <- ddrtree_res$stree  # Sparse tree structure (adj matrix)
centers <- ddrtree_res$Y             # Centers of the tree nodes
```

### Key Parameters

- `X`: The input data matrix (D by N, where D is features and N is samples).
- `dimensions`: The number of dimensions for the reduced space (typically 2).
- `max_iter`: Maximum number of iterations for the optimization.
- `sigma`: Bandwidth parameter for the RBF kernel (controls smoothness).
- `lambda`: Regularization parameter for the graph structure.
- `ncenter`: Number of nodes in the principal tree. If NULL, it defaults to the number of samples. Reducing this can speed up computation for large datasets.

## Tips and Best Practices

1. **Data Orientation**: Ensure your input matrix is oriented correctly. `DDRTree` typically expects features in rows and samples in columns.
2. **Scaling**: Like most dimensionality reduction techniques, it is often beneficial to log-transform and scale your data before running the algorithm.
3. **Initialization**: The algorithm uses PCA for initialization by default. If the data is highly non-linear, ensure `max_iter` is sufficient for convergence.
4. **Integration with Monocle**: `DDRTree` is the engine behind the `orderCells` function in the popular `monocle` Bioconductor package. If you are working with single-cell RNA-seq, you may be using this algorithm indirectly.

## Reference documentation

- [DDRTree README](./references/README.html.md)
- [DDRTree Home Page](./references/home_page.md)
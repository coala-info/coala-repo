---
name: r-blockmodeling
description: The r-blockmodeling package performs generalized blockmodeling and partitioning of valued networks into clusters based on various equivalence types. Use when user asks to partition nodes into blocks, evaluate network equivalence, find optimal partitions for valued matrices, or visualize partitioned adjacency matrices.
homepage: https://cloud.r-project.org/web/packages/blockmodeling/index.html
---

# r-blockmodeling

## Overview
The `blockmodeling` package is a comprehensive tool for generalized blockmodeling of valued networks. It allows users to partition nodes into clusters (blocks) based on specific equivalence types (structural, regular, generalized) and evaluate the fit of these partitions against idealized block types (e.g., complete, null, row-dominant, column-dominant).

## Installation
To install the package from CRAN:
```R
install.packages("blockmodeling")
```

## Core Workflows

### 1. Data Preparation
The package primarily works with adjacency matrices. Ensure your data is in a matrix format.
```R
# Example: Create a random valued matrix
mat <- matrix(runif(100), nrow = 10)
```

### 2. Generalized Blockmodeling
The `optParC` (or `optRandomParC`) function is the primary tool for finding optimal partitions.
```R
library(blockmodeling)

# Optimize partition for a valued network
# k = number of clusters
# rep = number of repetitions with random starting partitions
res <- optRandomParC(M = mat, k = 2, rep = 10, approaches = "val", blocks = "com")

# View results
plot(res)
summary(res)
```

### 3. Equivalence and Clustering
Calculate similarities or dissimilarities based on structural or regular equivalence.
- **Structural Equivalence**: Use `sedist` to compute distances.
- **Regular Equivalence**: Use `REGE` or `REGE.for` for valued networks.

```R
# Structural equivalence distance
d <- sedist(mat)
# Cluster based on distance
clu <- hclust(d)
plot(clu)
```

### 4. Block Types
When using generalized blockmodeling, you can specify allowed block types:
- `"com"`: Complete blocks
- `"nul"`: Null blocks
- `"rdo"`, `"cdo"`: Row/Column-dominant blocks
- `"reg"`: Regular blocks

### 5. Visualization
The `plot.mat` function is highly customizable for displaying partitioned matrices.
```R
# Plot a matrix with a specific partition
plot.mat(mat, clu = cutree(clu, k = 2))
```

## Key Functions
- `optRandomParC`: Main function for generalized blockmodeling with random starts.
- `critFunC`: Calculates the criterion function (error) for a given partition and network.
- `REGE`, `REGE.for`: Algorithms for indirect regular equivalence.
- `sedist`: Computes distances for structural equivalence.
- `funWeights`: Assigns weights to different block types in the optimization process.

## Tips
- **Valued Networks**: For valued networks, ensure the `approaches` argument in optimization functions is set to `"val"`.
- **Local Optima**: Blockmodeling is prone to local optima. Always use a high number of repetitions (`rep`) in `optRandomParC`.
- **Pre-specified Blocks**: If you have a theoretical model, use the `blocks` argument to restrict the search to specific block patterns.

## Reference documentation
- [blockmodeling: Generalized and Classical Blockmodeling of Valued Networks](./references/home_page.md)
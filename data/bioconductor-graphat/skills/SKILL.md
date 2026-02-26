---
name: bioconductor-graphat
description: This tool performs graph theoretic association tests to evaluate the statistical significance of associations between integrated functional genomics data sources. Use when user asks to perform edge and node permutation tests, convert cluster memberships to adjacency matrices, test associations between disparate genomics data sources, or estimate the power of permutation tests.
homepage: https://bioconductor.org/packages/release/bioc/html/GraphAT.html
---


# bioconductor-graphat

name: bioconductor-graphat
description: Graph theoretic association tests for integrating functional genomics data. Use this skill to perform edge and node permutation tests to evaluate the significance of associations between different data sources (e.g., expression, fitness, GO terms) represented as graphs or clusters.

# bioconductor-graphat

## Overview

The `GraphAT` package provides tools for "integromics," allowing users to test the statistical significance of associations between disparate functional genomics data sources. It represents data as graphs (where edges signify functional links) and uses permutation-based methods to determine if the observed overlap between two data sources is greater than expected by chance.

## Core Workflows

### 1. Data Preparation and Adjacency Matrices
Most functions in `GraphAT` require adjacency matrices.
- `clust2Mat(memb)`: Converts a vector of cluster memberships into a symmetric adjacency matrix.
- `makeClustM(nvec)`: Creates an adjacency matrix from a vector of cluster sizes.
- `mat2UndirG(V, mat)`: Converts an adjacency matrix into a `graphNEL` object for use with the `graph` package.

### 2. Association Testing
The primary method for testing the link between two data sources is the permutation test.
- `getpvalue(act.mat, nonact.mat, num.iterations)`: Performs both Random Edge Permutation and Random Node Permutation tests.
    - `act.mat`: The matrix to be permuted.
    - `nonact.mat`: The reference matrix.
    - Returns a vector with two p-values (Edge and Node).

### 3. Power Analysis
- `permPower(psi, clsizes, nedge, nhyper, nperms)`: Estimates the power of the permutation tests under an alternative hypothesis of preferential connection. `psi` is the non-centrality parameter.

### 4. Manual Permutations
If custom statistics are needed, use the underlying permutation functions:
- `permEdgesM2M(mat)`: Erdos-Renyi random permutation of edges.
- `permNodesM2M(mat)`: Randomly permutes node labels while preserving graph structure.

## Included Datasets
The package includes several yeast-specific datasets for practice and benchmarking:
- `causton`: mRNA expression data.
- `giaever`: Gene-knockout fitness data.
- `mRNAclusters` / `Phenoclusters`: Pre-computed k-means cluster memberships.
- `depthmatBP/CC/MF`: Matrices representing the maximum depth of shared GO terms between gene pairs.

## Example: Testing Association between Expression and Fitness Clusters

```R
library(GraphAT)

# Load pre-clustered data
data(mRNAclusters)
data(Phenoclusters)

# Convert cluster memberships to adjacency matrices
# Note: Ensure both datasets refer to the same set of genes/indices
mRNAMat <- clust2Mat(mRNAclusters[,2])
phenoMat <- clust2Mat(Phenoclusters[,2])

# Run permutation tests (1000 iterations)
p_vals <- getpvalue(mRNAMat, phenoMat, num.iterations = 1000)

# Interpret results
# p_vals[1] is Edge Permutation p-value
# p_vals[2] is Node Permutation p-value
print(p_vals)
```

## Reference documentation
- [GraphAT Reference Manual](./references/reference_manual.md)
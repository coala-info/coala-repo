---
name: bioconductor-amountain
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/AMOUNTAIN.html
---

# bioconductor-amountain

name: bioconductor-amountain
description: Identify active modules in single-layer, two-layer, and multi-layer weighted gene co-expression networks (WGCN) using convex optimization. Use this skill when you need to integrate omics data (node scores) with network topology (edge weights) to find compact, informative gene subnetworks.

## Overview
AMOUNTAIN (Active Modules for mUltilayer weighted gene co-expression Networks) provides a continuous optimization approach to identify active modules. Unlike traditional clustering, it uses an elastic net constrained optimization problem to balance network topology (edge weights $W$) and external biological information (node scores $z$). It is particularly useful for finding conserved modules across multiple layers of biological data.

## Core Functions

### Single-Layer Module Identification
To find a module in a single network, use `moduleIdentificationGPFixSS`.
- `W`: Adjacency matrix (edge weights).
- `z`: Vector of node scores (e.g., p-values or fold changes).
- `a`: Alpha parameter (0 to 1). Higher values increase sparsity (smaller modules).
- `lambda`: Weight for the node scores in the objective function.

```r
library(AMOUNTAIN)
# x[[2]] contains the membership vector; non-zero indices are module members
x <- moduleIdentificationGPFixSS(W, z, rep(1/n, n), a = 0.5, lambda = 0.1)
module_genes <- which(x[[2]] != 0)
```

### Two-Layer and Multi-Layer Identification
For cross-layer analysis (e.g., different tissues or species), use the multilayer functions.
- **Two-layer**: `moduleIdentificationGPFixSSTwolayer(W1, z1, ..., W2, z2, ..., A)` where `A` is the inter-layer weight matrix.
- **Multi-layer**: `moduleIdentificationGPFixSSMultilayer(Wlist, zlist, ...)` where `Wlist` is a list of adjacency matrices.

## Typical Workflow

1.  **Data Preparation**:
    - Construct a weighted adjacency matrix $W$ (e.g., using Pearson correlation).
    - Define node scores $z$ (e.g., $-\log(p\text{-value})$ from differential expression).
2.  **Parameter Tuning**:
    - **Grid Search**: If ground truth is available (simulations), use a grid search over `alphaset` and `lambdaset` to maximize F-score.
    - **Binary Search**: For real-world data, fix `lambda` (e.g., 0.001) and use a binary search on `a` to achieve a target module size (e.g., 100-200 genes).
3.  **Execution**: Run the identification function corresponding to your network architecture.
4.  **Downstream Analysis**: Perform gene set enrichment analysis (GSEA) or pathway analysis on the resulting gene list to interpret biological significance.

## Tips and Considerations
- **Module Size**: The parameter `a` (alpha) is the primary control for sparsity. If the returned module is too large, increase `a`.
- **Node Scores**: Ensure node scores are non-negative. Standardize them if combining disparate data types.
- **Performance**: For very large networks, the package provides C-reimplemented versions (e.g., `CGPFixSS`) which are significantly faster but may require GSL (GNU Scientific Library) dependencies.
- **Simulation**: Use `networkSimulation`, `twolayernetworkSimulation`, or `multilayernetworkSimulation` to generate synthetic data for testing and parameter calibration.

## Reference documentation
- [Usage of AMOUNTAIN](./references/AMOUNTAIN.md)
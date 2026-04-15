---
name: bioconductor-sparsematrixstats
description: The sparseMatrixStats package provides high-performance implementations of row and column summary statistics optimized for sparse matrix objects. Use when user asks to calculate means, variances, medians, or other summary statistics on large sparse matrices without converting them to dense formats.
homepage: https://bioconductor.org/packages/release/bioc/html/sparseMatrixStats.html
---

# bioconductor-sparsematrixstats

## Overview

The `sparseMatrixStats` package provides a high-performance implementation of the `matrixStats` API specifically optimized for sparse matrices (primarily the `dgCMatrix` class from the `Matrix` package). It avoids the memory overhead of converting sparse data to dense formats, offering substantial speedups (often 50x or more) for operations like row/column sums, variances, and medians on large, sparse datasets.

## Core Workflow

### 1. Data Preparation
Ensure your data is in a sparse format. You can create a sparse matrix from coordinates or convert an existing dense matrix.

```r
library(sparseMatrixStats)
library(Matrix)

# Create from coordinates
sparse_mat <- sparseMatrix(
  i = c(1, 3, 8), 
  j = c(2, 5, 6), 
  x = c(10, 20, 30), 
  dims = c(10, 10)
)

# Convert from dense
dense_mat <- matrix(0, nrow = 100, ncol = 100)
dense_mat[sample(1:10000, 10)] <- runif(10)
sparse_mat <- as(dense_mat, "dgCMatrix")
```

### 2. Calculating Statistics
The package follows the `colXXX()` and `rowXXX()` naming convention. These functions are drop-in replacements for `matrixStats` functions but accept `dgCMatrix` objects.

**Common Summary Functions:**
*   **Central Tendency:** `colMeans2()`, `rowMeans2()`, `colMedians()`, `rowMedians()`
*   **Variation:** `colVars()`, `rowVars()`, `colSds()`, `rowSds()`, `colIQRs()`
*   **Extrema:** `colMaxs()`, `rowMaxs()`, `colMins()`, `rowMins()`, `colRanges()`
*   **Counts/Logical:** `colAnyNAs()`, `colAlls()`, `colCounts()`, `rowTabulates()`

```r
# Calculate column variances
cv <- colVars(sparse_mat)

# Calculate row ranges (min and max)
rr <- rowRanges(sparse_mat)

# Count occurrences of specific values per row
rt <- rowTabulates(sparse_mat, values = c(0, 1, 2))
```

### 3. Weighted Statistics
Many functions support weights for rows or columns:
```r
w <- runif(ncol(sparse_mat))
weighted_means <- rowWeightedMeans(sparse_mat, w = w)
```

## Performance Tips
*   **Avoid apply():** Never use `apply(sparse_mat, 1, ...)` on sparse matrices; it is extremely slow as it forces coercion to dense vectors for every row/column.
*   **Memory Efficiency:** `sparseMatrixStats` operates directly on the internal slots of the `dgCMatrix` (`i`, `p`, and `x`), making it much more memory-efficient than converting to a dense matrix first.
*   **MatrixGenerics:** This package integrates with `MatrixGenerics`. If you have `MatrixGenerics` loaded, these functions will automatically dispatch to the correct sparse implementation when a `dgCMatrix` is provided.

## Reference documentation
- [sparseMatrixStats](./references/sparseMatrixStats.md)
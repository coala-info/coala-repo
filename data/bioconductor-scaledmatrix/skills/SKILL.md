---
name: bioconductor-scaledmatrix
description: This tool provides a memory-efficient representation of scaled and centered matrices by storing transformations separately to avoid full memory realization. Use when user asks to scale or center large matrices, perform memory-efficient matrix multiplication, calculate row or column sums on scaled data, or run PCA on sparse matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/ScaledMatrix.html
---

# bioconductor-scaledmatrix

name: bioconductor-scaledmatrix
description: Efficiently scale and center large or sparse matrices without full memory realization. Use this skill when performing matrix multiplication, PCA (via BiocSingular), or row/column sums on scaled data to optimize for speed and memory compared to base R scale() or DelayedArray.

# bioconductor-scaledmatrix

## Overview

The `ScaledMatrix` package provides a memory-efficient way to represent a scaled and centered matrix. Instead of realizing the full, dense matrix in memory (as `scale()` does), it stores the original matrix along with the centering and scaling vectors. It refactors matrix operations—specifically multiplication and sums—to apply these transformations mathematically on the fly. This is particularly beneficial for sparse matrices or file-backed representations (like HDF5) where maintaining sparsity or avoiding large memory allocations is critical.

## Core Workflow

### 1. Creating a ScaledMatrix
Wrap an existing matrix (ordinary, sparse, or `DelayedArray`) using the `ScaledMatrix()` constructor.

```r
library(ScaledMatrix)

# Works with ordinary matrices
mat <- matrix(rnorm(10000), ncol=10)
smat <- ScaledMatrix(mat, center=TRUE, scale=TRUE)

# Works with sparse matrices (preserves efficiency)
library(Matrix)
sparse_mat <- rsparsematrix(2000, 1000, density=0.01)
smat_sparse <- ScaledMatrix(sparse_mat, center=TRUE, scale=TRUE)
```

### 2. Efficient Matrix Operations
Use standard R operators. `ScaledMatrix` implements optimized methods for multiplication and sums that avoid expanding the matrix.

```r
# Fast matrix multiplication
blob <- matrix(runif(ncol(smat_sparse) * 5), ncol=5)
result <- smat_sparse %*% blob

# Fast row and column sums
rs <- rowSums(smat_sparse)
cs <- colSums(smat_sparse)
```

### 3. Downstream Analysis (PCA)
`ScaledMatrix` is highly effective when paired with `BiocSingular` for Principal Component Analysis on scaled data.

```r
library(BiocSingular)
# Performs PCA without ever realizing the full scaled matrix in memory
pcs <- runSVD(smat_sparse, k=10, BSPARAM=IrlbaParam())
```

## Supported Manipulations
The following operations preserve the `ScaledMatrix` representation:
- **Subsetting**: `smat[1:10, 1:5]`
- **Transposition**: `t(smat)`
- **Dimnames**: `rownames(smat) <- paste0("R", 1:nrow(smat))`

## Important Considerations

### Numerical Precision
`ScaledMatrix` refactors operations using the formula $Y = (X - c \cdot 1^T)S$. This involves subtracting potentially large values, which can lead to "catastrophic cancellation" and loss of precision if the original matrix values are extremely large (e.g., $10^{12}$) compared to the variance. For standard log-normalized genomic data, this is rarely an issue.

### Representation Collapse
Operations not specifically optimized for `ScaledMatrix` (e.g., adding a scalar `smat + 1`) will cause the object to "collapse" into a `DelayedMatrix`. While the operation will still work via block processing, it will lose the specific performance optimizations of the `ScaledMatrix` class.

### Multiplication Overhead
The optimization assumes that the matrix being multiplied (the "right-hand side") is relatively small compared to the `ScaledMatrix`. If both matrices are very large and dense, the overhead of the refactored math may offer less benefit.

## Reference documentation
- [Using the ScaledMatrix class](./references/ScaledMatrix.Rmd)
- [Using the ScaledMatrix class](./references/ScaledMatrix.md)
---
name: bioconductor-sparsearray
description: This tool provides a memory-efficient framework for representing and manipulating multidimensional sparse data in R using the SparseArray infrastructure. Use when user asks to create or coerce multidimensional sparse arrays, manipulate nonzero elements, perform matrix algebra, calculate row and column statistics, or read and write sparse CSV files.
homepage: https://bioconductor.org/packages/release/bioc/html/SparseArray.html
---


# bioconductor-sparsearray

name: bioconductor-sparsearray
description: High-performance sparse data representation and manipulation in R using the SparseArray infrastructure. Use this skill when working with multidimensional sparse data, large genomic datasets (like 10x Genomics data), or when needing memory-efficient alternatives to base R arrays and Matrix package objects (dgCMatrix).

## Overview

The `SparseArray` package provides a memory-efficient framework for handling multidimensional sparse data in R. Its primary container is the `SVT_SparseArray`, which uses a "Sparse Vector Tree" layout. This layout is more flexible than the standard `dgCMatrix` (CSC layout) because it supports arbitrary dimensions (not just 2D), any data type (integer, double, logical, complex), and bypasses the 2^31 nonzero element limit.

## Core Workflows

### 1. Construction and Coercion

The most common way to create a sparse array is by coercing existing objects or using the constructor.

```r
library(SparseArray)

# From an ordinary array or matrix
a <- array(0, dim=c(5, 5, 2))
a[1, 1, 1] <- 10
svt <- SparseArray(a)

# From a Matrix package object (dgCMatrix)
library(Matrix)
dgcm <- rsparsematrix(10, 10, density=0.1)
svt_mat <- SparseArray(dgcm)

# Manual construction via subassignment
svt_empty <- SVT_SparseArray(dim=c(100, 100))
svt_empty[c(1, 50, 100)] <- c(10, 20, 30)
```

### 2. Direct Manipulation of Nonzero Elements

Use the `nz*` family of functions to interact directly with the sparse data without expanding to a dense format.

```r
# Get count of nonzero elements
nzcount(svt)

# Get values of nonzero elements
nzvals(svt)

# Get indices (linear or array coordinates)
nzwhich(svt)
nzwhich(svt, arr.ind=TRUE)

# Check sparsity
is_sparse(svt)
is_nonzero(svt) # Returns a logical SparseArray
```

### 3. Array Operations and API

`SVT_SparseArray` objects mimic base R arrays and support the standard API.

*   **Subsetting:** `svt[1:5, , 1]` returns a sparse slice.
*   **Summarization:** `sum(svt)`, `mean(svt)`, `anyNA(svt)`, `range(svt)`.
*   **Math/Arith:** Supports group generics like `log()`, `exp()`, `+`, `-`, `*`, `/`, and comparison operators.
*   **Transposition:** `t(svt_matrix)` or `aperm(svt_array, perm)`.

### 4. Matrix-Specific Operations (2D)

For 2D `SVT_SparseMatrix` objects, the package provides high-performance implementations of matrix algebra.

```r
# Matrix multiplication
res <- svt_mat1 %*% svt_mat2

# Crossproducts
crossprod(svt_mat1)
tcrossprod(svt_mat1)

# Row/Column summarization (matrixStats API)
colSums(svt_mat)
rowMeans(svt_mat)
colVars(svt_mat)
colAnyNAs(svt_mat)

# Grouped sums
rowsum(svt_mat, group_vector)
```

### 5. Data I/O

Efficiently read and write sparse matrices using CSV files to preserve sparsity.

```r
# Write to CSV
writeSparseCSV(svt_mat, "data.csv")

# Read from CSV (returns SVT_SparseMatrix)
svt <- readSparseCSV("data.csv")
```

## Tips for Large Datasets

*   **Memory Efficiency:** `SVT_SparseArray` is significantly more memory-efficient than `COO_SparseArray`. Always prefer SVT unless a specific legacy requirement exists.
*   **Type Conversion:** Assigning a `double` value to an `integer` SVT_SparseArray will automatically promote the entire object to `double`.
*   **DelayedArray Integration:** `SparseArray` is the backend for many `DelayedArray` operations. You can load massive on-disk datasets (like HDF5/TENxMatrix) into memory using `as(x, "SVT_SparseArray")` if RAM allows.

## Reference documentation

- [SparseArray objects](./references/SparseArray_objects.md)
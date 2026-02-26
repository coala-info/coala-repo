---
name: bioconductor-delayedtensor
description: DelayedTensor provides a framework for performing out-of-core tensor operations and decompositions on large-scale biological data using DelayedArray backends. Use when user asks to reshape tensors, perform tensor arithmetic like Hadamard or Kronecker products, or execute tensor decompositions such as CP, Tucker, and HOSVD.
homepage: https://bioconductor.org/packages/release/bioc/html/DelayedTensor.html
---


# bioconductor-delayedtensor

name: bioconductor-delayedtensor
description: Expert guidance for the DelayedTensor R package. Use this skill when performing out-of-core tensor operations, including reshaping (fold/unfold), tensor arithmetic (Hadamard, Kronecker, Khatri-Rao products), and tensor decompositions (CP, Tucker, MPCA, PVD) on large-scale biological data using DelayedArray backends.

# bioconductor-delayedtensor

## Overview
The `DelayedTensor` package provides a framework for handling extremely large tensors that do not fit in memory. It extends the `DelayedArray` infrastructure to support tensor-specific operations. It is particularly useful for multi-omics biological data where high-dimensional arrays (e.g., gene x tissue x condition) are common. The package mirrors the API of the `rTensor` package, making it an easy transition for users needing out-of-core capabilities.

## Core Workflows

### 1. Global Settings
Before processing large tensors, configure the block processing and storage settings to optimize performance and manage disk space.

```r
library(DelayedTensor)
library(DelayedArray)
library(HDF5Array)

# Set the maximum memory used for each block (e.g., 100MB)
setAutoBlockSize(size = 1e+8)

# Set directory for intermediate HDF5 files
setHDF5DumpDir(tempdir())

# Optional: Enable verbose mode to monitor progress
setVerbose(TRUE)
```

### 2. Tensor Reshaping (Unfold/Fold)
Reshaping is essential for converting tensors into matrices for standard linear algebra operations.

*   **Unfold**: Convert a tensor to a matrix.
    ```r
    # Unfold darr into a matrix with modes 1 and 2 as rows, mode 3 as columns
    dmat <- unfold(darr, row_idx = c(1, 2), col_idx = 3)
    
    # k-mode unfolding (standard matricization)
    dmat_k <- k_unfold(darr, m = 1)
    ```
*   **Fold**: Convert a matrix back into a tensor.
    ```r
    # Fold dmat back into original dimensions
    darr_folded <- fold(dmat, row_idx = c(1, 2), col_idx = 3, modes = dim(darr))
    ```

### 3. Tensor Arithmetic and Products
Perform mode-wise operations and specialized products without loading the entire tensor into memory.

*   **Mode-wise Stats**: `modeSum(darr, m = 1)` or `modeMean(darr, m = 2)`.
*   **Hadamard Product**: Element-wise product (`hadamard(darr1, darr2)`).
*   **Kronecker Product**: `kronecker(darr1, darr2)`.
*   **Khatri-Rao Product**: Column-wise Kronecker product for matrices (`khatri_rao(mat1, mat2)`).
*   **Tensor-Matrix Multiplication (ttm)**: Multiply a tensor by a matrix in mode `m`.
    ```r
    res <- ttm(darr, mat, m = 3)
    ```

### 4. Tensor Decomposition
Decompose large tensors into factor matrices and core tensors.

*   **Tucker Decomposition**: `tucker(darr, ranks = c(2, 2, 2))` (uses HOOI).
*   **HOSVD**: `hosvd(darr, ranks = c(2, 2, 2))`.
*   **CP Decomposition**: `cp(darr, num_components = 2)` (uses ALS).
*   **MPCA**: Multilinear Principal Component Analysis (`mpca(darr, ranks = c(2, 2))`).

### 5. Einstein Summation (einsum)
Use `einsum` for a concise, string-based notation for complex operations like contractions and permutations.

```r
# Matrix multiplication: A %*% B
C <- DelayedTensor::einsum('ij,jk->ik', darrA, darrB)

# Extract diagonal
diag_elements <- DelayedTensor::einsum('ii->i', darrB)

# Complex contraction
res <- DelayedTensor::einsum('i,ij,ijk->jk', dvec, dmat, darr)
```

## Tips for Large Data
*   **Sparse Data**: Use `setSparse(TRUE)` if your data is mostly zeros, but note this mode is experimental and may bypass block-size limits.
*   **Disk Space**: Ensure the directory set by `setHDF5DumpDir` has enough space for intermediate HDF5 files, as tensor operations can generate large temporary objects.
*   **Backend**: Works seamlessly with `HDF5Array` and `TileDBArray`.

## Reference documentation
- [1. Concept of DelayedTensor](./references/DelayedTensor_1.md)
- [2. Tensor arithmetic by DelayedTensor](./references/DelayedTensor_2.md)
- [3. Tensor decomposition by DelayedTensor](./references/DelayedTensor_3.md)
- [4. Einsum operation by DelayedTensor](./references/DelayedTensor_4.md)
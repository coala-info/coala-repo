---
name: bioconductor-hdf5array
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/HDF5Array.html
---

# bioconductor-hdf5array

name: bioconductor-hdf5array
description: Use this skill when working with the HDF5Array Bioconductor package in R. It provides instructions for representing and manipulating HDF5 datasets as DelayedArray objects, specifically for large-scale genomic data analysis like single-cell RNA-seq. Use it to manage on-disk data storage, perform block-processed operations (normalization, PCA), and optimize memory usage for large matrices.

## Overview

The `HDF5Array` package provides a framework for working with HDF5 datasets in R without loading the entire data into memory. It implements the `HDF5Matrix` and `TENxMatrix` classes, which are derivatives of `DelayedArray`. This allows for "lazy" evaluation of operations and block-processing, making it possible to analyze datasets that exceed available RAM.

## Core Workflows

### 1. Loading HDF5 Data
To bring an HDF5 dataset into R as a `DelayedArray` object:

```R
library(HDF5Array)

# For standard HDF5 datasets
# Use h5ls("path/to/file.h5") to find the dataset name
mat_dense <- HDF5Array("path/to/file.h5", name="counts")

# For 10x Genomics formatted HDF5 (sparse)
# Use h5ls("path/to/file.h5") to find the group name (e.g., "mm10")
mat_sparse <- TENxMatrix("path/to/file.h5", group="mm10")

# Flagging a dense file as quantitatively sparse for memory efficiency
mat_ds <- HDF5Array("path/to/file.h5", name="counts", as.sparse=TRUE)
```

### 2. Inspecting Objects
Check the properties of the on-disk object:
- `dim(mat)`: Get dimensions.
- `is_sparse(mat)`: Check if the object is treated as sparse.
- `chunkdim(mat)`: View the HDF5 chunk dimensions.
- `showtree(mat)`: View the stack of delayed operations (subsets, transformations) pending on the object.

### 3. Block-Processing Optimization
Operations like `rowSums`, `colMeans`, and `%*%` are processed in blocks. You must tune the block size to balance speed and memory:

```R
# Get current block size
DelayedArray::getAutoBlockSize()

# Set block size (e.g., 100 Mb)
DelayedArray::setAutoBlockSize(100e6)
```

**Performance Tips:**
- **Normalization:** Generally performs better with larger blocks (e.g., 250 Mb) using sparse representations.
- **PCA:** Often performs better with smaller blocks (e.g., 40 Mb) when using `RSpectra`.
- **Dense vs Sparse:** If RAM is limited, use dense representations with very small blocks (16 Mb). If RAM is sufficient, use sparse representations with large blocks (250 Mb+).

### 4. On-Disk Realization
Delayed operations can slow down subsequent analysis. "Realize" the object by writing the current state (including all transformations) to a new HDF5 file:

```R
# Write to a standard HDF5 file (Dense or Sparse)
norm_mat_realized <- writeHDF5Array(norm_mat, filepath="processed_data.h5", name="norm_counts")

# Write specifically to 10x Genomics format
norm_mat_sparse <- writeTENxMatrix(norm_mat, filepath="sparse_data.h5", group="mm10")
```

## Typical Analysis Pattern
1. **Load:** Connect to the HDF5 file using `HDF5Array()` or `TENxMatrix()`.
2. **Subset/Transform:** Perform delayed operations (e.g., `log1p(mat[genes, cells])`).
3. **Realize:** Write the intermediate result to a new file using `writeHDF5Array()` to "freeze" the operations.
4. **Analyze:** Perform computationally intensive tasks like PCA on the realized, pristine object.

## Reference documentation
- [HDF5Array performance](./references/HDF5Array_performance.md)
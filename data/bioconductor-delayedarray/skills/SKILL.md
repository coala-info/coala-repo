---
name: bioconductor-delayedarray
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DelayedArray.html
---

# bioconductor-delayedarray

## Overview
The `DelayedArray` package provides a powerful framework for wrapping large array-like datasets (stored on-disk in HDF5/GDS formats or in-memory as RLE-compressed data) in a container that behaves like a standard R `matrix` or `array`. Its core power lies in **delayed operations**: transformations like subsetting, mathematical operations, and transposition are recorded as metadata without immediately modifying the data. This allows users to build complex pipelines on massive datasets that only execute when the data is explicitly "realized" or summarized via block processing.

## Core Workflows

### 1. Creating DelayedArray Objects
You can wrap ordinary arrays or specialized on-disk formats into DelayedArray objects.
```r
library(DelayedArray)
library(HDF5Array)

# From an ordinary matrix
m <- matrix(runif(100), ncol=10)
dm <- DelayedArray(m)

# From an HDF5 file (on-disk)
# Use HDF5Array for persistent storage
M <- HDF5Array("path/to/file.h5", name="dataset_name")

# RleArray for in-memory compressed data
rle_m <- as(m, "RleMatrix")
```

### 2. Delayed Operations
Most standard R matrix operations are "delayed" when applied to a `DelayedArray`. They return a new `DelayedArray` object without performing the calculation.
- **Subsetting:** `M2 <- M[1:10, 5:8]`
- **Transposition:** `M3 <- t(M2)`
- **Binding:** `M4 <- cbind(M3, some_other_matrix)`
- **Arithmetic/Math:** `M5 <- log(M + 1) / 2`
- **Comparison:** `M6 <- M > 0`

### 3. Realization
Realization is the process of executing all delayed operations and saving the result.
- **To Memory:** `as.array(M5)` or `as.matrix(M5)` (Warning: ensure it fits in RAM).
- **To RLE (In-memory compressed):** `as(M5, "RleArray")`
- **To HDF5 (On-disk):** `as(M5, "HDF5Array")` or `writeHDF5Array(M5, filepath="out.h5")`

### 4. Block Processing
Operations that cannot be delayed (e.g., `sum`, `mean`, `colSums`) are executed via block processing, which loads data into memory in chunks.
- **Summarization:** `colSums(M)`, `rowMeans(M)`, `max(M)`, `anyNA(M)`.
- **Verbosity:** Use `DelayedArray:::set_verbose_block_processing(TRUE)` to monitor progress.
- **Control:** Adjust memory usage with `setAutoBlockSize(size_in_bytes)`. Default is 1e8 (100MB).

## Advanced Usage and Tips
- **Sparsity:** `DelayedArray` supports sparse data. Check with `is_sparse(M)`. Operations like `cbind` and `rbind` preserve sparsity.
- **Constant Arrays:** Use `ConstantArray(dim, value)` to create massive virtual arrays of a single value with near-zero memory footprint.
- **HDF5 Management:** Use `setHDF5DumpFile()` and `setHDF5DumpName()` to control where automatic realization results are stored on disk.
- **Seed Access:** Use `seed(M)` to access the underlying data object (e.g., the `HDF5ArraySeed`).

## Reference documentation
- [Working with large arrays in R](./references/A-Working_with_large_arrays.md)
- [Implementing a DelayedArray Backend](./references/B-Implementing_a_backend.md)
- [DelayedArray / HDF5Array Update](./references/C-DelayedArray_HDF5Array_update.md)
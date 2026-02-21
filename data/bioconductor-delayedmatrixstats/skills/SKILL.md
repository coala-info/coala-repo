---
name: bioconductor-delayedmatrixstats
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DelayedMatrixStats.html
---

# bioconductor-delayedmatrixstats

name: bioconductor-delayedmatrixstats
description: High-performance row and column summary statistics for DelayedMatrix objects in R. Use this skill when performing matrix operations (sums, means, sds, medians, etc.) on large, out-of-memory, or disk-backed datasets (e.g., HDF5Array, RleArray) where standard matrixStats or apply() functions are too slow or memory-intensive.

## Overview

The `DelayedMatrixStats` package ports the `matrixStats` API to work seamlessly with `DelayedMatrix` objects from the `DelayedArray` ecosystem. It allows for high-performance calculations on rows and columns without loading the entire dataset into memory. It is particularly useful for Bioconductor workflows involving single-cell genomics or large-scale HDF5-backed data.

## Core Workflow

### 1. Loading the Package and Data
`DelayedMatrixStats` is designed to work on `DelayedMatrix` objects. These can be created from HDF5 files, RLE-compressed arrays, or standard matrices.

```r
library(DelayedArray)
library(DelayedMatrixStats)
library(HDF5Array)

# Example: Creating a DelayedMatrix from an HDF5 file
# x <- HDF5Array("path/to/data.h5", "dataset_name")

# Example: Creating a DelayedMatrix from a standard matrix
mat <- matrix(rpois(20000, 5), nrow = 1000, ncol = 20)
dm <- DelayedArray(mat)
```

### 2. Computing Summary Statistics
Use the standard `matrixStats` naming convention: `row[Operation]` or `col[Operation]`.

```r
# Compute row-wise standard deviations
row_sds <- rowSds(dm)

# Compute column-wise medians
col_meds <- colMedians(dm)

# Compute row-wise sums (optimized)
row_sums <- rowSums2(dm)

# Compute column-wise quantiles
col_q <- colQuantiles(dm, probs = c(0.25, 0.75))
```

### 3. Handling Delayed Operations
`DelayedArray` objects often have "delayed operations" (like `log` or `sin`) registered but not yet executed. `DelayedMatrixStats` functions automatically realize these operations before computing the statistics.

```r
# Register a delayed operation
dm_log <- log1p(dm)

# The statistic is computed on the log-transformed values
res <- colMeans2(dm_log)
```

## Key Functions

| Category | Functions (Row and Column variants) |
| :--- | :--- |
| **Basic Stats** | `rowSums2`, `colSums2`, `rowMeans2`, `colMeans2` |
| **Variance** | `rowSds`, `colSds`, `rowVars`, `colVars`, `rowMads`, `colMads` |
| **Location** | `rowMedians`, `colMedians`, `rowRanges`, `colRanges`, `rowMaxs`, `colMaxs` |
| **Counts** | `rowAlls`, `rowAnys`, `rowCounts`, `rowAnyNAs` |
| **Cumulative** | `rowCumsums`, `rowCumprods`, `rowCummaxs`, `rowCummins` |
| **Weighted** | `rowWeightedMeans`, `rowWeightedSds`, `rowWeightedVars` |

## Performance Tips

- **Seed-Awareness**: The package is "seed-aware." It detects the underlying storage (e.g., `dgCMatrix` for sparse data or `RleArray` for compressed data) and uses optimized algorithms that are significantly faster than block-processing.
- **Block Size**: For disk-backed data (like HDF5), memory usage is controlled by `DelayedArray::getAutoBlockSize()`. If you encounter memory issues, reduce the block size.
- **Avoid apply()**: Never use `apply(dm, 1, sd)` on a `DelayedMatrix`. It is extremely slow because it forces the object into a standard R loop. Always use `rowSds(dm)`.
- **Matrix Compatibility**: You can use `DelayedMatrixStats` functions on ordinary R matrices as well. This makes your code compatible with both in-memory and out-of-memory data structures.

## Reference documentation

- [Overview of DelayedMatrixStats](./references/DelayedMatrixStatsOverview.md)
---
name: bioconductor-alabaster.matrix
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.matrix.html
---

# bioconductor-alabaster.matrix

name: bioconductor-alabaster.matrix
description: Save and load matrix-like objects (base arrays, Matrix, DelayedArray) to and from file artifacts using the alabaster framework. Use this skill when you need to persist R matrices to disk in a standardized HDF5-backed format or reload them as ReloadedMatrix objects, especially when working with large datasets or delayed operations.

## Overview

The `alabaster.matrix` package is a core component of the **alabaster** framework, providing a standardized way to serialize matrix-like objects. It supports base R arrays, `Matrix` package objects (like `dgCMatrix`), and `DelayedArray` objects. A key feature is its ability to save `DelayedArray` operations without evaluating them, preserving sparsity and reducing memory overhead during storage.

## Core Functions

- `saveObject(x, path, ...)`: Saves a matrix-like object to a specified directory.
- `readObject(path)`: Loads a saved matrix object back into R as a `ReloadedMatrix`.

## Typical Workflows

### Basic Saving and Loading
To save a standard or sparse matrix:

```r
library(alabaster.matrix)
library(Matrix)

# Create a sparse matrix
y <- rsparsematrix(1000, 100, density=0.05)

# Save to a directory
tmp <- tempfile()
saveObject(y, tmp)

# Load it back
roundtrip <- readObject(tmp)
# roundtrip is a ReloadedMatrix (HDF5-backed)
```

### Working with Delayed Operations
When working with `DelayedArray` objects, you can choose to save the metadata of the operations (the "chihaya" format) instead of the realized values. This is highly efficient for complex transformation pipelines.

```r
library(DelayedArray)
y <- DelayedArray(rsparsematrix(1000, 100, 0.05))
y <- log1p(abs(y) / 1:100) # Add delayed operations

# Save while preserving operations
tmp <- tempfile()
saveObject(y, tmp, DelayedArray.preserve.ops=TRUE)

# Loading restores the object with the delayed operations intact
reloaded <- readObject(tmp)
```

## Tips and Best Practices

- **ReloadedMatrix**: Objects returned by `readObject()` are `ReloadedMatrix` instances. These are HDF5-backed S4 arrays. If you need a specific format for downstream analysis (e.g., a standard sparse matrix), use `as(roundtrip, "dgCMatrix")` or `as.matrix(roundtrip)`.
- **Directory Structure**: `saveObject()` creates a directory containing an `OBJECT` file and data files (usually `matrix.h5`). Do not manually move files out of this directory, as `readObject()` expects the full structure.
- **Efficiency**: Use `DelayedArray.preserve.ops=TRUE` when saving large matrices with many transformations to avoid "exploding" the data into a dense format on disk or consuming excessive RAM during the save process.

## Reference documentation

- [Saving arrays to artifacts and back again](./references/userguide.md)
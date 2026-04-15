---
name: bioconductor-beachmat.hdf5
description: This package provides a C++ interface for efficient, native access to HDF5-backed matrices from the HDF5Array package within the beachmat framework. Use when user asks to interact natively with HDF5-backed matrices, eliminate R-level overhead for data extraction, or enable in-memory caching for file-backed data.
homepage: https://bioconductor.org/packages/release/bioc/html/beachmat.hdf5.html
---

# bioconductor-beachmat.hdf5

## Overview

The `beachmat.hdf5` package provides the necessary glue to allow `beachmat` and `tatami`-based C++ code to interact natively with HDF5-backed matrices from the `HDF5Array` package. It eliminates the performance bottleneck of calling back into R for data extraction by using the HDF5 C library directly.

## User Workflow

### Loading the Package
Simply loading the library registers the necessary methods to handle HDF5-backed objects.

```r
library(beachmat.hdf5)
```

Once loaded, any R package that uses `beachmat` for its C++ backend will automatically gain the ability to process `HDF5Matrix` and `H5SparseMatrix` objects efficiently.

### In-Memory Caching
When initializing a C++ representation of an HDF5 matrix, you can use the `memorize` parameter to trade memory for speed.

*   **Enable Caching**: Set `memorize = TRUE` in `initializeCpp()` to load the entire matrix into a global memory cache on first use. This is ideal for workflows requiring multiple iterations over the same data.
*   **Clear Cache**: Use `beachmat::flushMemoryCache()` to free up memory by clearing the global cache.

## Developer Guidance

### Native vs. R-based Access
While `beachmat` can work with `HDF5Array` objects without this package, it does so by calling `DelayedArray::extract_array()`, which involves significant R-level overhead. Importing `beachmat.hdf5` enables native C++ access via the `tatami_hdf5` library, which is significantly faster for file-backed data.

### Implementation
To ensure your package supports HDF5 matrices natively:
1.  Add `beachmat.hdf5` to your `Imports` or `Suggests`.
2.  If using `Suggests`, ensure the package is loaded before calling C++ functions that utilize `beachmat::initializeCpp()`.

## Reference documentation

- [Using HDF5-backed matrices with beachmat](./references/userguide.md)
---
name: bioconductor-chihaya
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/chihaya.html
---

# bioconductor-chihaya

name: bioconductor-chihaya
description: Save and reload DelayedArray objects to HDF5 files for portability and stability. Use this skill when you need to serialize R DelayedArray objects while preserving delayed operations, maintaining sparsity, or avoiding data duplication through external file references.

# bioconductor-chihaya

## Overview

The `chihaya` package provides a robust framework for saving `DelayedArray` objects into HDF5 files. Unlike standard RDS serialization, `chihaya` stores the tree of delayed operations (e.g., subsetting, arithmetic, log transformations) rather than realizing the full array into memory. This ensures:
- **Portability**: The HDF5 specification allows other programming languages to interpret the delayed operations.
- **Stability**: It protects against changes in S4 class structures that often break RDS files.
- **Efficiency**: It preserves the underlying data structure, such as sparsity, and can even store pointers to external HDF5 files to avoid data duplication.

## Core Functions

- `saveDelayed(x, path)`: Saves a `DelayedArray` object `x` to an HDF5 file at `path`.
- `loadDelayed(path)`: Loads a `DelayedArray` object from an HDF5 file at `path`.

## Typical Workflows

### Basic Save and Load
```r
library(DelayedArray)
library(chihaya)

# Create a DelayedArray with operations
mat <- matrix(runif(1000), ncol=10)
x <- DelayedArray(mat)
x <- x[1:10, ] + 1
x <- log2(x)

# Save to HDF5
tmp <- tempfile(fileext=".h5")
saveDelayed(x, tmp)

# Reload in a new session
y <- loadDelayed(tmp)
```

### Preserving Sparsity
When working with sparse matrices (e.g., `dgCMatrix`), `chihaya` avoids "densifying" the data during the save process.
```r
library(Matrix)
sparse_mat <- rsparsematrix(1000, 1000, density=0.01)
x <- DelayedArray(sparse_mat) + 5

# saveDelayed will maintain the sparse nature of the seed
tmp <- tempfile(fileext=".h5")
saveDelayed(x, tmp)

# Loading back returns a DelayedArray wrapping a sparse seed
y <- loadDelayed(tmp)
```

### Referencing External Files
If the data seed is already in an HDF5 file (e.g., via `HDF5Array`), `chihaya` can store a reference to that file instead of copying the data.
```r
library(HDF5Array)
# Assume 'existing_data.h5' contains a dataset "counts"
test <- HDF5Array("existing_data.h5", "counts")
stuff <- test * 2

# This saves the '* 2' operation and a pointer to 'existing_data.h5'
saveDelayed(stuff, "delayed_ops.h5")
```

## Tips and Best Practices
- **Inspection**: Use `rhdf5::h5ls(path)` to inspect the internal structure of the saved HDF5 file. You will see a `delayed` group containing the operation tree.
- **Tree Visualization**: Use `DelayedArray::showtree(y)` after loading to verify that the operation hierarchy was preserved correctly.
- **Dependencies**: Ensure `DelayedArray` and `rhdf5` are installed, as `chihaya` relies on them for the underlying object structure and HDF5 I/O.

## Reference documentation
- [Saving and reloading DelayedArray objects](./references/userguide.md)
- [User guide (RMarkdown source)](./references/userguide.Rmd)
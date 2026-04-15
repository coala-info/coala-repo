---
name: bioconductor-tiledbarray
description: This package provides a DelayedArray backend for TileDB to enable memory-efficient storage and manipulation of large dense and sparse arrays. Use when user asks to create TileDB-backed arrays from R matrices, read TileDB datasets as DelayedArray objects, perform delayed matrix operations on large datasets, or configure TileDB storage paths and attributes.
homepage: https://bioconductor.org/packages/release/bioc/html/TileDBArray.html
---

# bioconductor-tiledbarray

name: bioconductor-tiledbarray
description: Use this skill to work with the TileDBArray Bioconductor package. This package provides a DelayedArray backend for TileDB, allowing for local and remote storage of dense and sparse arrays. Use this skill when you need to: (1) Create TileDB-backed arrays from R matrices or sparse matrices, (2) Read TileDB datasets as DelayedArray objects, (3) Perform memory-efficient matrix operations (subsetting, arithmetic, colSums) on large TileDB datasets without loading them entirely into memory, or (4) Configure TileDB storage paths and attributes.

# bioconductor-tiledbarray

## Overview

The `TileDBArray` package integrates TileDB's efficient multi-dimensional array storage with the Bioconductor `DelayedArray` framework. This allows users to treat large datasets stored in TileDB (either locally or on the cloud) as if they were ordinary R matrices. Operations are "delayed" until the data is actually needed, enabling analysis of datasets that exceed available RAM.

## Core Workflows

### Creating a TileDBArray

You can convert existing R matrices (dense or sparse) into TileDB-backed arrays using `writeTileDBArray()` or coercion.

```r
library(TileDBArray)
library(Matrix)

# From a dense matrix
X <- matrix(rnorm(1000), ncol=10)
tdb_dense <- writeTileDBArray(X)

# From a sparse matrix
Y <- rsparsematrix(1000, 1000, density=0.01)
tdb_sparse <- writeTileDBArray(Y)

# Using coercion
tdb_coerced <- as(X, "TileDBArray")
```

### Data Manipulation

`TileDBArray` objects behave like standard R matrices but keep the data on disk.

```r
# Basic metadata
dim(tdb_dense)
rownames(tdb_dense)
colnames(tdb_dense)

# Subsetting (returns a DelayedMatrix)
sub <- tdb_dense[1:10, 1:5]

# Arithmetic (delayed)
scaled <- tdb_dense * 2

# Matrix operations (supported via DelayedArray)
sums <- colSums(tdb_dense)
prod <- tdb_dense %*% runif(ncol(tdb_dense))
```

### Controlling Storage

By default, `writeTileDBArray` creates a temporary directory. You can specify a custom path and attribute name.

```r
custom_path <- "path/to/my_array"
writeTileDBArray(X, path=custom_path, attr="DATA")

# To load an existing TileDB array
existing_array <- TileDBArray(custom_path)
```

### Global Configuration

Since coercion (`as(X, "TileDBArray")`) doesn't accept arguments, use global setters to control the backend behavior.

```r
setTileDBPath("path/to/storage")
# Subsequent coercions will use this path
as(X, "TileDBArray")
```

## Tips and Best Practices

- **Sparse Data**: The package automatically detects sparse `Matrix` objects and stores them as sparse TileDB arrays, which is highly efficient for genomic data.
- **Delayed Execution**: Remember that operations like `out * 2` do not write new data to disk or perform calculations immediately. They create a `DelayedMatrix` that only computes values when you call `as.matrix()`, `blockApply()`, or specific realization functions.
- **Dimension Names**: `TileDBArray` preserves `rownames` and `colnames` during the writing process.

## Reference documentation

- [User guide (Rmd)](./references/userguide.Rmd)
- [User guide (Markdown)](./references/userguide.md)
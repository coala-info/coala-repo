---
name: bioconductor-biocsklearn
description: BiocSklearn provides an R interface to the scikit-learn library for Bioconductor workflows. Use when user asks to perform PCA, run incremental PCA on large datasets, compute pairwise distances, or interface with HDF5 matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocSklearn.html
---

# bioconductor-biocsklearn

## Overview

`BiocSklearn` provides an R interface to the Python `scikit-learn` library, specifically tailored for Bioconductor workflows. It leverages `reticulate` and `basilisk` to ensure a stable Python environment. Its primary strength lies in handling large-scale data that may not fit in memory, offering "incremental" versions of standard algorithms like PCA.

## Basic Setup and Data Import

To use the package, you must load the library. It uses `basilisk` internally to manage Python dependencies like `numpy` and `scikit-learn`.

```r
library(BiocSklearn)

# Importing data for Python handling using numpy via reticulate
np <- reticulate::import("numpy", convert=FALSE, delay_load=TRUE)
irloc <- system.file("csv/iris.csv", package="BiocSklearn")
irismat <- np$genfromtxt(irloc, delimiter=',')

# Accessing submatrices (numpy 'take' method)
# Note: 0L indicates integer type for Python indexing
np$take(irismat, 0:2, 0L) 
```

## Dimensionality Reduction (PCA)

### Standard PCA
For datasets that fit in memory, use `skPCA`.

```r
# Perform PCA
ppca <- skPCA(data.matrix(iris[,1:4]))

# Retrieve the projected coordinates (transformed data)
tx <- getTransformed(ppca)
head(tx)
```

### Incremental PCA (Out-of-Memory)
For very large datasets, `skIncrPCA` allows processing in batches to bound memory consumption.

```r
# Using a specific batch size
ippcab <- skIncrPCA(irismat, batch_size=25L)
transformed_data <- getTransformed(ippcab)
```

### Manual Chunking
If data is arriving as a stream or in manual chunks, use `skPartialPCA_step`.

```r
# Initialize and update PCA object iteratively
ipc <- skPartialPCA_step(np$take(irismat, 0:49, 0L))
ipc <- skPartialPCA_step(np$take(irismat, 50:99, 0L), obj=ipc)
ipc <- skPartialPCA_step(np$take(irismat, 100:149, 0L), obj=ipc)

# Apply the final model to new data
ipc$transform(np$take(irismat, 0:5, 0L))
```

## Working with HDF5
The package provides utilities to interface with HDF5 matrices, which are common in single-cell genomics.

```r
# Create a reference to an HDF5 matrix via h5py
# Example using internal package data
example(H5matref)
```

## Specialized Metrics
You can compute pairwise distances using the scikit-learn backend, which is often highly optimized.

```r
# Compute pairwise distances
# mat: an R matrix or compatible object
distances <- skPWD(data.matrix(iris[,1:4]), metric="euclidean")
```

## Tips for Success
1. **Type Safety**: When passing arguments to Python (like `batch_size` or axis indices), use the `L` suffix (e.g., `0L`, `25L`) to ensure they are treated as integers rather than floats.
2. **Object Persistence**: Objects returned by functions like `skPCA` are often pointers to Python objects. Use `getTransformed()` to pull the numerical results back into R.
3. **Environment Management**: `BiocSklearn` uses `basilisk`. If you encounter Python configuration errors, ensure your R session is clean and not conflicting with other `reticulate` configurations.

## Reference documentation
- [BiocSklearn](./references/BiocSklearn.md)
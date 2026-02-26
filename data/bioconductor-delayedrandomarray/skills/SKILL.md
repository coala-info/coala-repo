---
name: bioconductor-delayedrandomarray
description: The DelayedRandomArray package implements DelayedArray subclasses that generate random values on-the-fly to enable the creation of massive arrays without high memory consumption. Use when user asks to create large-scale random matrices, simulate data from various probability distributions, or generate memory-efficient arrays for Bioconductor workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/DelayedRandomArray.html
---


# bioconductor-delayedrandomarray

## Overview

The `DelayedRandomArray` package implements `DelayedArray` subclasses that contain dynamically sampled random values. Instead of storing the entire matrix in memory, values are generated on-the-fly only when a specific part of the array is accessed. This allows for the creation of massive random arrays (e.g., 10^12 elements) that would otherwise require petabytes of RAM.

## Core Workflow

### 1. Basic Array Creation
Load the library and initialize an array by specifying dimensions. The object behaves like a standard matrix or `DelayedArray`.

```r
library(DelayedRandomArray)

# Create a 1 million x 1 million uniform random array
# Occupies ~64 MB in memory instead of 8 PB
X <- RandomUnifArray(c(1e6, 1e6))
```

### 2. Available Distributions
Most standard distributions from the `stats` package are supported:

*   **Normal**: `RandomNormArray(dims, mean=0, sd=1)`
*   **Poisson**: `RandomPoisArray(dims, lambda)`
*   **Gamma**: `RandomGammaArray(dims, shape, rate)`
*   **Weibull**: `RandomWeibullArray(dims, shape, scale)`
*   **Negative Binomial**: `RandomNbinomArray(dims, mu, size)`

### 3. Parameter Mapping
Distribution parameters can be provided in three ways:
*   **Scalars**: Applied to the entire array.
*   **Vectors**: Recycled along the length of the array (useful for row-specific or column-specific parameters).
*   **Arrays**: Another `DelayedArray` of the same dimensions can provide point-specific parameters.

```r
# Vectorized means for 100 rows
means <- 1:100
X_norm <- RandomNormArray(c(100, 50), mean=means)

# Using one random array to parameterize another
lambdas <- 2 ^ RandomNormArray(c(100, 50))
X_pois <- RandomPoisArray(c(100, 50), lambda=lambdas)
```

## Advanced Configuration

### Chunking and Performance
The array is divided into rectangular chunks. Random numbers are generated per chunk using the PCG32 generator.
*   **Default**: Square root of dimensions or 100 (whichever is larger).
*   **Manual**: Use `chunkdim` to optimize for access patterns (e.g., column-wise for fast column retrieval).

```r
# Column-wise chunks for a 1000x500 matrix
X_col <- RandomUnifArray(c(1000, 500), chunkdim=c(1000, 1))
```

**Warning**: Changing `chunkdim` changes the random stream. Even with the same seed, different chunking results in different values.

### Reproducibility
Set the R-level seed **before construction** of the array. The seed is stored within the object, so the same values will be generated every time the object is accessed, regardless of the global seed at the time of access.

```r
set.seed(123)
A <- RandomNormArray(c(10, 10))
```

### Sparsity
For distributions where many values are zero (e.g., Poisson with low lambda), set `sparse=TRUE`. This allows downstream Bioconductor tools to use optimized sparse matrix algorithms.

```r
# Treat as sparse for efficient downstream processing
X_sparse <- RandomPoisArray(c(1e6, 1e6), lambda=0.1, sparse=TRUE)
```

## Typical Simulation Workflow
Simulating a large single-cell dataset:
1. Define gene-wise log-abundances.
2. Create a `DelayedArray` of cell-specific means based on cluster assignments.
3. Generate the final count matrix using `RandomNbinomArray`.

## Reference documentation

- [User's Guide (Rmd)](./references/userguide.Rmd)
- [User's Guide (Markdown)](./references/userguide.md)
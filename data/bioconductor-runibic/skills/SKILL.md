---
name: bioconductor-runibic
description: The runibic package provides a high-performance, parallel implementation of the UniBic algorithm for identifying trend-preserving biclusters in gene expression data. Use when user asks to perform biclustering on continuous or discrete data, identify subsets of genes with similar expression patterns across conditions, or calculate the longest common subsequence between vectors.
homepage: https://bioconductor.org/packages/release/bioc/html/runibic.html
---

# bioconductor-runibic

## Overview
The `runibic` package provides a high-performance, parallel implementation of the UniBic biclustering algorithm. It is designed to identify trend-preserving patterns (biclusters) where a subset of genes shows similar expression tendencies across a subset of conditions. It is highly effective for noisy gene expression data and supports continuous, discrete, and `SummarizedExperiment` data structures.

## Core Functions
- `BCUnibic()`: A method for the `biclust` framework used for continuous data.
- `runibic()`: The primary function for biclustering, supporting `matrix`, `ExpressionSet`, and `SummarizedExperiment` objects.
- `BCUnibicD()`: Specialized version for discrete data.
- `runiDiscretize()`: Discretizes continuous data using the UniBic quantile-based method.
- `pairwiseLCS()` / `calculateLCS()`: Functions to compute the Longest Common Subsequence between vectors or matrix rows.

## Typical Workflows

### Biclustering Continuous Data
The most common usage involves the `biclust` package wrapper:
```r
library(runibic)
library(biclust)

# Using a standard matrix
data_matrix <- matrix(rnorm(1000), 100, 100)
res <- biclust(data_matrix, method = BCUnibic())

# Inspecting results
res@Number # Number of biclusters found
which(res@RowxNumber[,1]) # Rows in the first bicluster
which(res@NumberxCol[1,]) # Columns in the first bicluster
```

### Working with Bioconductor Objects
`runibic` integrates directly with standard Bioconductor containers:
```r
# SummarizedExperiment
library(SummarizedExperiment)
res <- runibic(se_object)

# ExpressionSet
library(affy)
res <- runibic(exprs(eset_subset))
```

### Discrete Data Analysis
If data is already discrete or needs specific discretization:
```r
# Discretize continuous data
discrete_matrix <- runiDiscretize(data_matrix)

# Run discrete-specific UniBic
res_discrete <- BCUnibicD(discrete_matrix)
```

### Visualizing Biclusters
Use the `biclust` package visualization tools to interpret `runibic` results:
```r
# Heatmap of the first bicluster
drawHeatmap(data_matrix, res, 1)

# Parallel coordinates plot
parallelCoordinates(data_matrix, res, 1)
```

## LCS Utilities
You can use the underlying LCS engine for sequence analysis:
```r
# Find LCS between two vectors
A <- c(1, 2, 1, 5, 4, 3)
B <- c(2, 1, 3, 2, 1, 4)
backtrackLCS(A, B)

# Calculate LCS lengths for all pairs in a matrix
lcs_results <- calculateLCS(data_matrix, useFibHeap = FALSE)
```

## Tips for Success
- **Parallelism**: `runibic` is implemented in C++11 and is parallelized by default; it is significantly faster than the original sequential UniBic for large datasets.
- **Memory**: For very large matrices, ensure sufficient RAM as the LCS calculation involves pairwise comparisons.
- **Comparison**: To compare `runibic` with other algorithms (like QUBIC or Plaid), use `QUBIC::showinfo()` on a list of result objects.

## Reference documentation
- [runibic: UniBic in R Tutorial](./references/runibic.Rmd)
- [runibic: parallel UniBic biclustering algorithm for R](./references/runibic.md)
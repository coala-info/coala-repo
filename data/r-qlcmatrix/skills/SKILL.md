---
name: r-qlcmatrix
description: R package qlcmatrix (documentation from project home).
homepage: https://cran.r-project.org/web/packages/qlcmatrix/index.html
---

# r-qlcmatrix

name: r-qlcmatrix
description: Utility sparse matrix functions for Quantitative Language Comparison (QLC). Use this skill when working with sparse matrices in R, specifically for tasks involving large-scale data transformation, similarity calculations (cosine, Jaccard), and linguistic data processing where memory efficiency is critical.

## Overview

The `qlcMatrix` package extends the functionality of the `Matrix` package. It provides optimized functions for handling sparse matrices, which are essential for quantitative linguistics and other fields dealing with high-dimensional, sparse data. Key features include fast similarity measures, efficient row/column operations, and specialized functions for transforming linguistic data into sparse formats.

## Installation

```R
install.packages("qlcMatrix")
library(qlcMatrix)
```

## Main Functions and Workflows

### Similarity Measures
The package provides highly optimized functions for calculating similarities between rows or columns of sparse matrices.

- `cosSparse(X, Y = NULL)`: Calculates the cosine similarity.
- `assocSparse(X, Y = NULL, method = "cosine")`: A general wrapper for various association measures (cosine, pearson, resids, pmi).
- `jaccardSparse(X, Y = NULL)`: Calculates the Jaccard index for binary sparse matrices.

### Data Transformation
Transforming raw data into sparse matrices is a core workflow.

- `splitText(text, sep = "")`: Splits strings into characters or n-grams, useful for creating feature matrices.
- `pwMatrix(text, sep = "")`: Creates a "part-whole" sparse matrix from a vector of strings, mapping elements to their constituent parts.
- `ttMatrix(text, sep = "")`: Creates a "type-type" adjacency matrix.

### Matrix Operations
- `rowMax(X)`, `colMax(X)`: Efficiently find the maximum value in each row or column of a sparse matrix.
- `rowSD(X)`, `colSD(X)`: Calculate standard deviation for sparse matrices.
- `dropEmpty(X)`: Removes rows and columns that contain only zeros.

## Usage Tips

- **Memory Efficiency**: Always prefer `dgCMatrix` (from the `Matrix` package) as the input format for `qlcMatrix` functions to ensure maximum performance.
- **Large Datasets**: When comparing two different sets of observations, use the `Y` argument in similarity functions (e.g., `cosSparse(X, Y)`) instead of binding matrices together, which saves memory.
- **Linguistic Analysis**: Use `splitText` in combination with `Matrix::sparseMatrix` to quickly build document-term matrices or character-level models.

## Reference documentation

- [README](./references/README.html.md)
- [qlcMatrix Home Page](./references/home_page.md)
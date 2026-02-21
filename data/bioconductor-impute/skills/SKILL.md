---
name: bioconductor-impute
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/impute.html
---

# bioconductor-impute

name: bioconductor-impute
description: Imputation of missing values in microarray or high-dimensional expression data using k-nearest neighbors (KNN). Use this skill when you need to handle missing data in an expression matrix, specifically using the KNN algorithm with optional two-means clustering for large datasets.

## Overview

The `impute` package provides a robust implementation of the k-nearest neighbors (KNN) algorithm for imputing missing expression data. It is particularly well-suited for microarray data where genes are in rows and samples are in columns. For large datasets, it automatically employs a recursive two-means clustering strategy to maintain computational efficiency.

## Core Functionality

The primary function in this package is `impute.knn`.

### Basic Usage

```r
library(impute)

# Assuming 'data_matrix' is a matrix with genes in rows and samples in columns
result <- impute.knn(data_matrix, k = 10, rowmax = 0.5, colmax = 0.8, maxp = 1500)

# Access the imputed matrix
imputed_data <- result$data
```

### Key Arguments

- `data`: An expression matrix. Genes must be in rows and samples in columns.
- `k`: Number of neighbors to use (default is 10).
- `rowmax`: Maximum percentage of missing data allowed in any row (default 50%). Rows exceeding this are imputed using the overall mean per sample rather than KNN.
- `colmax`: Maximum percentage of missing data allowed in any column (default 80%). If exceeded, the function halts with an error.
- `maxp`: The threshold for recursive two-means clustering (default 1500). If the number of genes exceeds this, the data is split to speed up the KNN search.
- `rng.seed`: Seed for reproducibility (default 362436069).

## Workflow and Best Practices

### 1. Data Preparation
Ensure your data is in a `matrix` format. If you are working with a `data.frame`, convert it using `as.matrix()`. Ensure that the orientation is correct: **Rows = Genes, Columns = Samples**.

### 2. Handling Metadata
If your dataset contains non-numeric columns (like Gene IDs or Names), subset the matrix to include only the numeric expression values before passing it to `impute.knn`.

```r
# Example: Removing first two columns if they are IDs/Names
clean_matrix <- as.matrix(raw_data[, -(1:2)])
imputed_result <- impute.knn(clean_matrix)
```

### 3. Reproducibility
The function reseeds the random number generator. To maintain the state of your R session's RNG or to use a custom seed:

```r
# Using a custom seed
result <- impute.knn(clean_matrix, rng.seed = 12345)

# The original RNG state is returned in result$rng.state
# To restore it:
.Random.seed <- result$rng.state
```

### 4. Interpreting Results
The function returns a list containing:
- `data`: The matrix with all missing values filled.
- `rng.seed`: The seed used.
- `rng.state`: The state of the RNG before the function was called.

## Troubleshooting

- **Error: "column has more than colmax% missing data"**: This indicates a sample has too little data to be reliable. You should either remove that sample or increase the `colmax` parameter if you are certain the remaining data is useful.
- **Performance**: If the function is slow on very large datasets, consider decreasing `maxp`, though the default 1500 is generally optimal for most machines.

## Reference documentation

- [impute Reference Manual](./references/reference_manual.md)
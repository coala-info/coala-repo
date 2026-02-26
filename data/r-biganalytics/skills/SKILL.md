---
name: r-biganalytics
description: This tool performs analytics and statistical modeling on massive datasets using big.matrix objects from the bigmemory ecosystem. Use when user asks to run k-means clustering, fit linear or generalized linear models, calculate column statistics, or perform data binning on large-scale data.
homepage: https://cloud.r-project.org/web/packages/biganalytics/index.html
---


# r-biganalytics

name: r-biganalytics
description: Perform analytics on massive datasets using 'big.matrix' objects from the 'bigmemory' ecosystem. Use this skill when you need to run k-means clustering, descriptive statistics, or linear models on data that is too large for standard R memory limits.

## Overview

The `biganalytics` package provides a suite of analytics functions designed to work efficiently with `big.matrix` objects. It extends the `bigmemory` package by providing familiar R-style analytics (like `glm`, `kmeans`, and `apply`) that operate on shared-memory matrices without needing to load the entire dataset into the R heap.

## Installation

```r
install.packages("biganalytics")
# Requires bigmemory
install.packages("bigmemory")
```

## Core Functions

### Clustering with bigkmeans
Perform k-means clustering on a `big.matrix` or standard R matrix.
```r
# x is a big.matrix
cl <- bigkmeans(x, centers = 5, iter.max = 10, nstart = 1)
```

### Linear and Generalized Linear Models
The `biglm.big.matrix` and `bigglm.big.matrix` functions provide an interface to the `biglm` package for large-scale modeling.
```r
# Linear model
fit <- biglm.big.matrix(y ~ x1 + x2, data = my.big.matrix)

# Generalized linear model (e.g., Logistic)
fit_glm <- bigglm.big.matrix(y ~ x1 + x2, data = my.big.matrix, family = binomial())
summary(fit_glm)
```

### Fast Data Binning
The `binit` function provides fast 1D and 2D binning, useful for visualizing large datasets.
```r
# 2D binning of columns 1 and 2
bins <- binit(my.big.matrix, cols = c(1, 2), bins = 50)
```

### Column Statistics
Efficiently calculate summary statistics across a `big.matrix`.
```r
# Returns a matrix of min, max, mean, etc. for each column
stats <- colmin(my.big.matrix)
stats <- colmax(my.big.matrix)
stats <- colmean(my.big.matrix)
stats <- colsd(my.big.matrix)
stats <- colsum(my.big.matrix)
stats <- colrange(my.big.matrix)
```

### Apply Functionality
Apply a function over margins of a `big.matrix`.
```r
# Apply mean to columns (MARGIN = 2)
# Note: For standard stats, use the optimized colmean() instead
results <- apply(my.big.matrix, 2, mean)
```

## Workflows

### Analyzing Large CSVs
1. Use `bigmemory::read.big.matrix()` to create a file-backed matrix.
2. Use `biganalytics` functions to process the data.

```r
library(bigmemory)
library(biganalytics)

# 1. Attach or read data
x <- read.big.matrix("large_data.csv", type = "double", 
                     backingfile = "data.bin", 
                     descriptorfile = "data.desc")

# 2. Run analytics
model <- biglm.big.matrix(V1 ~ V2 + V3, data = x)
clusters <- bigkmeans(x, centers = 3)
```

## Tips
- **Memory Efficiency**: `biganalytics` functions are designed to minimize memory overhead. Always prefer `colmean(x)` over `apply(x, 2, mean)` for performance.
- **Integration**: For table-like operations (tapply), use the `bigtabulate` package. For linear algebra, use `bigalgebra`.
- **Shared Memory**: Because `big.matrix` objects reside in shared memory, analytics can be performed on the same data from multiple R processes simultaneously.

## Reference documentation
- [Bigmemory Home Page](./references/home_page.md)
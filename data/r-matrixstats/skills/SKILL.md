---
name: r-matrixstats
description: The matrixStats package provides high-performance functions for calculating row and column statistics on matrices using optimized C code. Use when user asks to calculate row or column medians, compute weighted statistics, perform subsetted matrix operations, or replace slow apply functions with faster alternatives.
homepage: https://cloud.r-project.org/web/packages/matrixStats/index.html
---


# r-matrixstats

## Overview
The `matrixStats` package provides highly optimized functions that apply to rows and columns of matrices, as well as specialized vector methods. These functions are written in C to maximize speed and minimize memory footprint. They are designed to be drop-in, high-performance replacements for `apply(x, margin, FUN)` patterns.

## Installation
To install the package from CRAN:
```R
install.packages("matrixStats")
```

## Core Workflows

### Row and Column Summaries
Instead of using `apply(mat, 1, median)`, use the direct row/column equivalents.
```R
library(matrixStats)

# Create a sample matrix
mat <- matrix(rnorm(1000), nrow = 100, ncol = 10)

# Location estimators
row_medians <- rowMedians(mat)
col_means   <- colMeans2(mat)
row_ranges  <- rowRanges(mat)

# Scale estimators
row_sds     <- rowSds(mat)
col_mads    <- colMads(mat)
row_iqrs    <- rowIQRs(mat)
```

### Subsetted Calculations
Most functions support `rows` and `cols` arguments to operate on subsets without creating temporary memory copies of the matrix.
```R
# Calculate SD for rows 1:10 and columns 2:5 only
res <- rowSds(mat, rows = 1:10, cols = 2:5)
```

### Counting and Testing
Efficiently check for values or missingness across dimensions.
```R
# Check if any NAs exist in each row
has_na <- rowAnyMissings(mat)

# Count how many values in each column are greater than 0
pos_counts <- colCounts(mat, value = 0, predicate = ">")

# Logical checks
all_true <- rowAlls(mat > 0)
any_true <- colAnys(mat == 0)
```

### Weighted Statistics
Functions for weighted calculations on vectors and matrices.
```R
w <- runif(10)
w_mean <- colWeightedMeans(mat, w = w)
w_median <- rowWeightedMedians(mat, w = rep(1, 10))
```

### Cumulative and Difference Operations
```R
# Cumulative sums by row
cum_sums <- rowCumsums(mat)

# Lagged differences
row_diffs <- rowDiffs(mat, lag = 1)

# Difference-based variance (robust to trends)
sd_diff <- rowSdDiffs(mat)
```

## Performance Tips
1. **Use `*2` functions**: Functions like `sum2()`, `mean2()`, and `colMeans2()` are often faster and more numerically stable than base R equivalents.
2. **Avoid `apply()`**: `rowMedians(x)` is significantly faster than `apply(x, 1, median)`.
3. **Use `useNames = FALSE`**: If you don't need to preserve row/column names in the output, setting `useNames = FALSE` can provide a slight speed boost in tight loops.
4. **Memory**: By using the `rows` and `cols` arguments, you avoid the memory overhead of `mat[rows, cols]` slicing.

## Reference documentation
- [matrixStats: Summary of functions](./references/matrixStats-methods.md)
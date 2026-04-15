---
name: bioconductor-matrixgenerics
description: This package provides S4 generic summary statistic functions for row and column operations on various matrix-like objects. Use when user asks to calculate row or column statistics, perform summary operations on Bioconductor objects like DelayedArray or SummarizedExperiment, or write backend-agnostic matrix code.
homepage: https://bioconductor.org/packages/release/bioc/html/MatrixGenerics.html
---

# bioconductor-matrixgenerics

name: bioconductor-matrixgenerics
description: S4 generic summary statistic functions for matrix-like objects. Use when performing row or column operations (means, variances, medians, etc.) on standard R matrices or Bioconductor-specific objects like DelayedArray, SparseArray, or SummarizedExperiment. This skill is essential for writing code that is compatible with multiple matrix backends.

## Overview

The `MatrixGenerics` package provides a unified S4 generic API for summary statistics on matrix-like objects. It is modeled after the `matrixStats` API but designed to work across various matrix implementations (e.g., standard R matrices, `SparseArray`, `DelayedArray`, and `SummarizedExperiment`). By using these generics, developers can write code that automatically dispatches to the most efficient implementation for the specific data type provided.

## Core Functions

The package provides both row-wise and column-wise versions of common statistics.

### Basic Statistics
- `rowMeans2()` / `colMeans2()`: Optimized mean calculations.
- `rowSums2()` / `colSums2()`: Optimized sum calculations.
- `rowMedians()` / `colMedians()`: Median of rows/columns.
- `rowVars()` / `colVars()`: Variance of rows/columns.
- `rowSds()` / `colSds()`: Standard deviation of rows/columns.
- `rowMaxs()` / `colMaxs()`: Maximum values.
- `rowMins()` / `colMins()`: Minimum values.
- `rowRanges()` / `colRanges()`: Min and max values.

### Logical and Counting
- `rowAlls()` / `colAlls()`: Check if all elements meet a condition.
- `rowAnys()` / `colAnys()`: Check if any elements meet a condition.
- `rowAnyNAs()` / `colAnyNAs()`: Check for presence of NAs.
- `rowCounts()` / `colCounts()`: Count occurrences of a specific value.

### Advanced and Weighted Statistics
- `rowQuantiles()` / `colQuantiles()`: Calculate row/column-wise quantiles.
- `rowWeightedMeans()` / `colWeightedMeans()`: Weighted average calculations.
- `rowWeightedMedians()` / `colWeightedMedians()`: Weighted median calculations.
- `rowLogSumExps()` / `colLogSumExps()`: Log-sum-exp for rows/columns (useful for probabilities).
- `rowDiffs()` / `colDiffs()`: Lagged differences.

## Typical Workflow

1. **Load the Package**:
   ```r
   library(MatrixGenerics)
   ```

2. **Identify the Object**:
   The functions work on standard `matrix` objects, but are most useful when working with Bioconductor objects:
   ```r
   # Works on standard matrices
   mat <- matrix(rnorm(100), 10, 10)
   rowMeans2(mat)

   # Works on DelayedArrays or SummarizedExperiments
   # library(SummarizedExperiment)
   # rowVars(assay(se))
   ```

3. **Use Subsetting Arguments**:
   Most functions support `rows` and `cols` arguments to operate on subsets without creating a physical copy of the data:
   ```r
   # Calculate means for the first 5 rows and specific columns
   rowMeans2(mat, rows = 1:5, cols = c(1, 3, 5))
   ```

4. **Handle Missing Values**:
   Use `na.rm = TRUE` to exclude NAs from calculations:
   ```r
   rowMedians(mat, na.rm = TRUE)
   ```

## Tips for Efficient Usage

- **Prefer `rowMeans2` over `rowMeans`**: While `rowMeans` is a base R function, `rowMeans2` is the `matrixStats`-style generic that often provides better performance and more consistent behavior across different matrix classes.
- **Avoid Manual Loops**: Always use these vectorized generics instead of `apply(x, 1, ...)` or `apply(x, 2, ...)` as they are significantly faster and memory-efficient.
- **Names Preservation**: Use the `useNames` argument (default `TRUE`) to control whether the result vector inherits names from the input object.
- **Dispatch Mechanism**: If you are developing a package with a new matrix class, you should implement methods for these generics to ensure your class works seamlessly with the Bioconductor ecosystem.

## Reference documentation

- [MatrixGenerics Reference Manual](./references/reference_manual.md)
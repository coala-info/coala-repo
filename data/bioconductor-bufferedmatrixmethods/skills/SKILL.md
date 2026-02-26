---
name: bioconductor-bufferedmatrixmethods
description: This tool performs memory-efficient microarray data analysis by processing large Affymetrix datasets using disk-buffered objects. Use when user asks to perform RMA background correction, apply quantile normalization, or summarize CEL files into expression values without exhausting available RAM.
homepage: https://bioconductor.org/packages/release/bioc/html/BufferedMatrixMethods.html
---


# bioconductor-bufferedmatrixmethods

name: bioconductor-bufferedmatrixmethods
description: Use the BufferedMatrixMethods R package to perform memory-efficient microarray data analysis. This skill is essential when working with large Affymetrix CEL file datasets that exceed available RAM, allowing for RMA background correction, quantile normalization, and summarization using BufferedMatrix objects.

## Overview

The `BufferedMatrixMethods` package provides a suite of tools for preprocessing microarray data (specifically Affymetrix) using `BufferedMatrix` objects. These objects store data on disk rather than in-memory, enabling the analysis of very large datasets that would otherwise cause memory exhaustion in standard R workflows (like those using `AffyBatch`).

## Key Workflows

### 1. Fast RMA Analysis
The most direct way to process CEL files into expression values using buffered objects is `BufferedMatrix.justRMA`. This function mimics the standard `rma()` behavior but uses disk-buffering.

```r
library(BufferedMatrixMethods)

# Process all CEL files in the current directory
eset <- BufferedMatrix.justRMA(celfile.path = ".")

# Access the resulting ExpressionSet
exprs_data <- exprs(eset)
```

### 2. Manual Data Loading
If you need to inspect the probe-level data before summarization, use the reading functions:

- `BufferedMatrix.read.celfiles()`: Reads CEL data into a single `BufferedMatrix`.
- `BufferedMatrix.read.probematrix()`: Separates data into PM (Perfect Match) and/or MM (Mismatch) matrices.

```r
# Read PM probes only
pm_matrix <- BufferedMatrix.read.probematrix(filenames = c("file1.CEL", "file2.CEL"), which = "pm")
```

### 3. Step-by-Step RMA Preprocessing
You can apply RMA steps individually to a `BufferedMatrix` object. Note the `copy` argument: if `FALSE`, the operation is performed in-place on the disk-buffered object to save space.

```r
# 1. Background Correction
bg_corrected <- bg.correct.BufferedMatrix(pm_matrix, copy = FALSE)

# 2. Quantile Normalization
norm_matrix <- normalize.BufferedMatrix.quantiles(bg_corrected, copy = FALSE)

# 3. Combined BG and Normalization (Efficient)
processed_matrix <- BufferedMatrix.bg.correct.normalize.quantiles(pm_matrix, copy = FALSE)
```

### 4. Summarization
To convert probe-level data into probeset-level expression values, use median polish summarization.

```r
# Returns a standard R matrix of expression values
expression_values <- median.polish.summarize(norm_matrix)
```

## Tips for Large Datasets
- **In-place operations**: Always set `copy = FALSE` in preprocessing functions when memory is at a premium to avoid creating temporary copies of the large matrix.
- **CDF Packages**: Like standard `affy` workflows, these functions require the appropriate CDF environment/package for the array type being analyzed. Use the `cdfname` argument if the default mapping is incorrect.
- **Dependencies**: This package requires the `BufferedMatrix` package to be installed to handle the underlying data structures.

## Reference documentation
- [BufferedMatrixMethods Reference Manual](./references/reference_manual.md)
---
name: bioconductor-preprocesscore
description: This package provides core routines for preprocessing genomic data, including quantile normalization, background correction, and robust linear model fitting. Use when user asks to normalize intensity distributions across samples, perform RMA background correction, or summarize probe-level data using robust linear models.
homepage: https://bioconductor.org/packages/release/bioc/html/preprocessCore.html
---


# bioconductor-preprocesscore

## Overview

The `preprocessCore` package provides a library of core preprocessing routines for genomic data. It is most famous for implementing **Quantile Normalization**, a method to make the distribution of intensities across different chips (columns) identical. It also includes RMA background correction and various robust linear model (PLM) fitting procedures for summarizing probe-level data.

## Core Workflows

### 1. Quantile Normalization
This is the primary use case for the package. It ensures that the statistical distribution of values in each column of a matrix is the same.

```r
library(preprocessCore)

# Basic normalization
# x is a matrix where columns are samples and rows are features/probes
normalized_data <- normalize.quantiles(x, copy = TRUE, keep.names = TRUE)

# Normalizing to a specific target distribution
target <- normalize.quantiles.determine.target(reference_matrix)
normalized_to_target <- normalize.quantiles.use.target(x, target)

# Robust normalization (experimental, allows weighting)
robust_norm <- normalize.quantiles.robust(x, weights = my_weights)
```

### 2. Background Correction
Implements the RMA (Robust Multi-array Average) background correction, which assumes observed intensities are a convolution of normal (noise) and exponential (signal) distributions.

```r
# Corrects each column independently
bg_corrected <- rma.background.correct(x, copy = TRUE)
```

### 3. Column Summarization
Functions to summarize matrix columns, often used after normalization to collapse probe-level data into gene-level or feature-level summaries.

*   **Simple Summaries:** `colSummarizeAvg()`, `colSummarizeMedian()`, `colSummarizeLogAvg()`.
*   **Robust Summaries:** `colSummarizeBiweight()` (Tukey Biweight) or `colSummarizeMedianpolish()`.
*   **Grouped Summaries:** Use `subColSummarize...` functions when rows are divided into groups (e.g., probes belonging to the same probeset).

```r
# Summarize by groups (e.g., 10 rows per group)
groups <- c(rep(1, 10), rep(2, 10), ...)
summarized <- subColSummarizeMedian(x, group.labels = groups)
```

### 4. Robust Row-Column Models (PLM)
Fits the model $y_{ij} = r_i + c_j + \epsilon_{ij}$ where $r_i$ is the row effect and $c_j$ is the column effect.

*   `rcModelPLM(y)`: Standard robust linear model.
*   `rcModelPLMr(y)`: Adds row and column robustness.
*   `rcModelPLMd(y, group.labels)`: Fits models where row effects can be "split" based on group labels if a significant relationship exists.

## Usage Tips

*   **Memory Management:** For very large matrices, set `copy = FALSE` in normalization functions to perform operations in-place, though this modifies the original object.
*   **Missing Values:** `normalize.quantiles` handles `NA` values by assuming they are missing at random. However, `normalize.quantiles.robust` does not handle `NA` values well.
*   **Data Scale:** Most functions expect raw intensities. If using log-transformed data, ensure you use the specific "Log" variants of functions (e.g., `colSummarizeAvgLog`) or account for the scale in your workflow.
*   **Row/Column Names:** By default, some functions may strip dimension names. Use `keep.names = TRUE` in `normalize.quantiles` to preserve them.

## Reference documentation

- [preprocessCore Reference Manual](./references/reference_manual.md)
---
name: bioconductor-constand
description: This tool normalizes quantification matrices from proteomics or RNA-seq data using the CONSTANd raking method to ensure row and column means equal a target value. Use when user asks to normalize data matrices, remove systematic biases from quantification data, or apply the iterative proportional fitting algorithm to biological samples.
homepage: https://bioconductor.org/packages/release/bioc/html/CONSTANd.html
---

# bioconductor-constand

name: bioconductor-constand
description: Normalization of data matrices (proteomics, RNA-seq, etc.) using the CONSTANd raking method. Use this skill to normalize quantification matrices such that row and column means equal 1, enabling comparison across samples and different data matrices.

## Overview

The `CONSTANd` package implements a normalization method based on the RAS (Iterative Proportional Fitting) algorithm. It is designed for quantification matrices (e.g., mass spectrometry intensities or RNA-seq counts) where biological samples are processed in an Identically Processed (sub)set (IPS). The normalization ensures that the mean of each row and each column equals a target value (default is 1), effectively removing systematic biases while preserving biological variation.

## Core Workflow

### 1. Data Preparation
CONSTANd requires a data matrix where rows are features (genes, peptides) and columns are samples.
*   **Missing Values**: Represent missing data as `NA`. Do not use `0` for missing values, as CONSTANd ignores `NA` but includes `0` in mean calculations.
*   **Filtering**: It is recommended to remove features with very low counts (e.g., median count of 0) before normalization.

```r
# Replace zeros with NA if they represent missing values
data[data == 0] <- NA

# Filter low-abundance features
data <- data[apply(data, 1, median, na.rm = TRUE) > 0, ]
```

### 2. Normalization
The primary function is `CONSTANd()`.

```r
library(CONSTANd)

# Basic normalization
res <- CONSTANd(data)

# Access normalized matrix
norm_data <- res$normalized_data

# Access multipliers (R = row multipliers, S = column multipliers)
row_mult <- res$R
col_mult <- res$S
```

### 3. Normalizing Multiple Assays (IPS)
If samples were processed in different batches (e.g., different MS runs or sequencing days), normalize each batch separately before merging.

```r
# Normalize batches independently
batch1_norm <- CONSTANd(batch1_data)$normalized_data
batch2_norm <- CONSTANd(batch2_data)$normalized_data

# Combine normalized data
combined_norm <- cbind(batch1_norm, batch2_norm)
```

## Advanced Parameters

*   `target`: Sets the target mean for rows/columns (default `1`).
*   `precision`: The stopping criterion for the L1-norm (default `1e-5`).
*   `maxIterations`: Maximum number of raking cycles (default `50`).

## Quality Control: MA Plots
To verify normalization assumptions (majority of features not DE, symmetry of up/down regulation, linear bias), use MA plots.

```r
# Standard MA plot logic for normalized data
# M = log2(y/x)
# A = (log2(y/R) + log2(x/R)) / 2
# Where R is the row multiplier vector from CONSTANd output
```

## Differential Expression Analysis (DEA)
Normalized values can be used directly in linear modeling (e.g., `limma`). Note that CONSTANd output is on the original scale (not log-transformed), so log-transformation or specific handling in `limma` may be required depending on the downstream tool's expectations.

## Reference documentation

- [CONSTANd](./references/CONSTANd.md)
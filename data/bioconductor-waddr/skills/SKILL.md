---
name: bioconductor-waddr
description: This tool compares two distributions using the 2-Wasserstein distance to decompose differences into location, size, and shape. Use when user asks to calculate 2-Wasserstein distance, perform two-sample distribution testing, or identify differential expression in single-cell RNA-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/waddR.html
---


# bioconductor-waddr

## Overview

The `waddR` package provides tools to compare two distributions using the 2-Wasserstein distance. Unlike simple mean-based tests, this approach allows for the decomposition of differences into **location** (mean), **size** (variance), and **shape** (skewness/kurtosis). It is particularly useful for single-cell RNA-seq analysis where gene expression distributions often differ in complex ways beyond simple fold-changes.

## Core Workflows

### 1. Calculating 2-Wasserstein Distance
Use these functions to quantify the distance between two numeric vectors `x` and `y`.

```r
library(waddR)

# Basic distance calculation (p=2 for 2-Wasserstein)
dist <- wasserstein_metric(x, y, p=2)

# Squared distance with decomposition (location, size, shape)
decomp <- squared_wass_decomp(x, y)
# Access components: decomp$location, decomp$size, decomp$shape
```

### 2. Two-Sample Distribution Testing
Test the null hypothesis that two samples come from the same distribution.

```r
# Semi-parametric (SP) test: Permutation-based, accurate for small p-values
# Recommended for most cases. Set seed for reproducibility.
set.seed(42)
res_sp <- wasserstein.test(x, y, method="SP", permnum=10000)

# Asymptotic (ASY) test: Faster, valid for continuous distributions
res_asy <- wasserstein.test(x, y, method="ASY")
```

### 3. Single-Cell RNA-seq Differential Expression
Specifically tailored for scRNAseq data using a Two-Stage (TS) approach:
1.  **Stage 1**: Logistic regression for differential proportions of zero expression (DPZ).
2.  **Stage 2**: 2-Wasserstein test for differences in non-zero expression.

```r
# Input: Two SingleCellExperiment objects (must have 'counts' assay)
# Or: A data matrix and a condition vector
res_sc <- wasserstein.sc(sce_control, sce_treated, method="TS", permnum=1000, seed=24)

# Key output columns:
# p.zero: p-value for zeros
# p.nonzero: p-value for non-zero expression
# p.combined: Fisher's combined p-value
# p.adj.combined: BH-adjusted combined p-value
```

## Interpretation of Results

*   **Location**: Differences in the average expression level.
*   **Size**: Differences in the spread or variance of expression.
*   **Shape**: Differences in the distribution geometry (e.g., unimodal vs. bimodal).
*   **perc.loc/size/shape**: These columns in test outputs indicate what percentage of the total squared distance is attributed to each component.

## Tips for scRNAseq
*   **Normalization**: Ensure input data is normalized for cell-specific biases before running `wasserstein.sc`.
*   **Permutations**: While `permnum=1000` is often used for speed in examples, higher values (e.g., 10,000) are recommended for publication-quality p-values.
*   **Seed**: Always set a seed for the "SP" or "TS" methods to ensure results are reproducible across R sessions.

## Reference documentation

- [The waddR package](./references/waddR.md)
- [2-Wasserstein distance calculation](./references/wasserstein_metric.md)
- [Detection of differential gene expression distributions in scRNAseq](./references/wasserstein_singlecell.md)
- [Two-sample tests based on the 2-Wasserstein distance](./references/wasserstein_test.md)
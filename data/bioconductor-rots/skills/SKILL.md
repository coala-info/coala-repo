---
name: bioconductor-rots
description: ROTS is a data-adaptive method that identifies differentially expressed features by optimizing a reproducibility Z-score across bootstrapped datasets. Use when user asks to identify differentially expressed genes or proteins, perform multi-group comparisons, or conduct survival analysis using reproducibility-optimized statistics.
homepage: https://bioconductor.org/packages/release/bioc/html/ROTS.html
---

# bioconductor-rots

## Overview

ROTS (Reproducibility Optimized Test Statistic) is a data-adaptive method for identifying differentially expressed features. Unlike fixed t-tests, ROTS optimizes a family of t-type statistics by maximizing a reproducibility Z-score across bootstrapped datasets. It is robust to missing values and works across various omics technologies including RNA-seq (count data), microarrays (intensity), and proteomics.

## Core Workflow

### 1. Data Preparation
Input data should be a matrix or data frame with features as rows and samples as columns.
- **Normalization**: Input should be normalized. For RNA-seq, use TMM (edgeR) or Voom (limma) transformed values.
- **Missing Values**: ROTS handles moderate missingness but requires at least two non-missing values per group per row.

### 2. Running ROTS
The primary function is `ROTS()`.

```r
library(ROTS)

# Example: Two-group comparison
# groups: vector of 0 and 1 (or other identifiers)
# B: Number of bootstraps (use 1000+ for publication)
# K: Top-list size for optimization (e.g., 500 to 5000)
results <- ROTS(data = input_matrix, groups = groups, B = 1000, K = 500)
```

### 3. Multi-group and Survival Analysis
ROTS automatically detects the analysis type based on the `groups` argument:
- **Two-group**: `groups` contains two distinct levels.
- **Multi-group**: `groups` contains more than two levels (optimizes an F-statistic).
- **Survival**: `groups` is a `survival` object (optimizes Cox scores).

### 4. Interpreting Results
The output object contains the optimized parameters (`a1`, `a2`), p-values, and FDR.
- **Reproducibility Z-score**: A rule of thumb is that $Z < 2$ suggests the data or statistics are insufficient for reliable detection.
- **Summary**: Use `summary(results, fdr = 0.05)` to view top-ranked features.

```r
# Summarize top features
summary(results, fdr = 0.05)

# Access specific components
head(results$FDR)
head(results$pvalue)
```

## Visualization
ROTS provides built-in plotting methods for the results object.

```r
# Volcano Plot
plot(results, fdr = 0.05, type = "volcano")

# Heatmap of top features
plot(results, fdr = 0.05, type = "heatmap")
```

## Tips and Best Practices
- **Seed**: Set a seed (`seed = 1234`) for reproducibility, as ROTS relies on bootstrapping and permutations.
- **Performance**: If the data matrix is very large, reduce `K` (the top list size) to speed up the optimization phase.
- **FDR Cutoff**: To get results for all features regardless of significance, set `fdr = 1` in the summary function.
- **Parameter Manual Override**: If you already know the optimal `a1` and `a2`, you can provide them directly to skip the optimization step.

## Reference documentation
- [ROTS: Reproducibility Optimized Test Statistic](./references/ROTS.md)
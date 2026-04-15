---
name: bioconductor-spqn
description: The spqn package implements spatial quantile normalization to remove the mean-correlation bias from gene co-expression matrices. Use when user asks to normalize correlation matrices, remove expression-linked bias in co-expression analysis, or perform spatial quantile normalization.
homepage: https://bioconductor.org/packages/release/bioc/html/spqn.html
---

# bioconductor-spqn

## Overview

The `spqn` package implements Spatial Quantile Normalization (SpQN). In gene co-expression analysis, correlation matrices often exhibit a "mean-correlation" relationship: gene pairs with higher expression levels show higher correlations than those with lower expression. This bias can lead to false positives among highly expressed genes and hidden signals among lowly expressed ones. `spqn` corrects this by partitioning the correlation matrix into bins based on expression levels and applying quantile normalization to equalize the distribution of correlations across the matrix.

## Core Workflow

### 1. Data Preparation
Before using `spqn`, you must have a correlation matrix and a vector of average expression levels for the same genes.

```r
library(spqn)
library(SummarizedExperiment)

# Load your data (e.g., SummarizedExperiment)
# Ensure principal components have been removed to account for global batch effects
# ave_exp should be the mean/median expression (e.g., log2 RPKM) before PC removal
cor_m <- cor(t(assay(se)))
ave_exp <- rowData(se)$ave_logrpkm
```

### 2. Diagnostic Plotting
Assess the mean-correlation relationship before normalization.

```r
# Plot distribution of correlations for bins on the diagonal
plot_signal_condition_exp(cor_m, ave_exp, signal = 0)

# Plot Inter-Quantile Range (IQR) to see variance shifts
IQR_list <- get_IQR_condition_exp(cor_m, ave_exp)
plot_IQR_condition_exp(IQR_list)

# Q-Q plots to compare different expression bins
qqplot_condition_exp(cor_m, ave_exp, i = 1, j = 1) # Compare bin (1,1) to reference
```

### 3. Spatial Quantile Normalization
Use `normalize_correlation` to remove the bias.

```r
cor_m_spqn <- normalize_correlation(
  cor_m, 
  ave_exp = ave_exp, 
  ngrp = 20,      # Number of bins per row/column
  size_grp = 300, # Size of outer bins for smoothing (ngrp * size_grp >= n_genes)
  ref_grp = 18    # Index of the reference bin on the diagonal (usually high expression)
)
```

### 4. Validation
Verify that the normalization removed the dependency.

```r
# The relationship between expression and correlation IQR should now be flat
IQR_spqn <- get_IQR_condition_exp(cor_m_spqn, ave_exp)
plot_IQR_condition_exp(IQR_spqn)
```

## Key Parameters for `normalize_correlation`

*   `ngrp`: The number of bins to partition the matrix. Higher values provide finer resolution but require more genes.
*   `size_grp`: Controls the smoothing. It defines the size of the "outer" bin used to estimate the distribution for the "inner" bin.
*   `ref_grp`: The target distribution. It is recommended to use a bin corresponding to high (but not necessarily the highest) expression levels as the reference.

## Tips for Success

*   **PC Removal**: Always remove principal components (e.g., using `WGCNA::removePrincipalComponents`) before calculating the correlation matrix. SpQN is designed to remove the expression-linked bias that remains after global latent factors are removed.
*   **Expression Scale**: Use `log2(RPKM)` or similar length-normalized scales for `ave_exp` to ensure gene length doesn't confound the expression measurement.
*   **Memory**: For very large matrices, ensure sufficient RAM is available as `spqn` operates on the full dense correlation matrix.

## Reference documentation

- [spqn User's Guide](./references/spqn.md)
- [spqn RMarkdown Source](./references/spqn.Rmd)
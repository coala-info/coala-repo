---
name: bioconductor-lbe
description: bioconductor-lbe estimates the false discovery rate and the proportion of true null hypotheses in genome-wide studies using a transformation of p-values. Use when user asks to estimate q-values, calculate the proportion of true null hypotheses, or control the false discovery rate in large-scale hypothesis testing.
homepage: https://bioconductor.org/packages/release/bioc/html/LBE.html
---

# bioconductor-lbe

## Overview

The `LBE` package provides an efficient procedure for estimating the False Discovery Rate (FDR) in genome-wide studies. It is based on a transformation of p-values to estimate $\pi_0$ (the proportion of true null hypotheses). Unlike the smoothing methods used in other packages like `qvalue`, LBE uses a family of estimators $\hat{\pi}_0(a)$ where the parameter $a$ balances bias and variance.

## Core Workflow

### 1. Basic FDR and q-value Estimation
The primary function is `LBE()`. It requires a vector of p-values.

```r
library(LBE)
data(golub.pval) # Example dataset

# Run LBE with default settings
# Default: FDR.level = 0.05, ci.level = 0.95
lbe_res <- LBE(golub.pval)

# Access results
lbe_res$pi0          # Estimated proportion of true null hypotheses
lbe_res$pi0.ci       # Confidence interval for pi0
lbe_res$qvalues      # Vector of estimated q-values
lbe_res$significant  # Indices of significant p-values
```

### 2. Controlling FDR and Significance
You can specify either a target FDR level or a fixed number of significant genes to determine the corresponding threshold.

```r
# Set a specific FDR threshold (e.g., 10%)
res_10pct <- LBE(golub.pval, FDR.level = 0.1, plot.type = "none")
res_10pct$n.significant

# Find the FDR if exactly 300 genes are declared significant
res_300 <- LBE(golub.pval, FDR.level = NA, n.significant = 300)
```

### 3. Tuning the Estimator (Parameter 'a')
The parameter `a` controls the transformation. By default, LBE chooses the largest `a` such that the standard deviation is below a threshold `l` (default `l = 0.05`).

```r
# Manually set the standard deviation threshold
res_l <- LBE(golub.pval, l = 0.1)

# Manually fix the parameter 'a' (e.g., a = 2)
res_a2 <- LBE(golub.pval, a = 2, l = NA)

# Use identity transformation (equivalent to a simple pi0 estimator)
res_simple <- LBE(golub.pval, a = -1, l = NA)
```

## Visualization and Summary

### Plotting Results
`LBEplot` is called automatically by `LBE` unless `plot.type = "none"`.
- `plot.type = "main"`: Histogram of p-values and q-values vs. p-values.
- `plot.type = "multiple"`: Four plots including significant tests vs. q-value cut-off and expected false positives.

```r
LBEplot(lbe_res, plot.type = "multiple")
```

### Summarizing and Exporting
```r
# Print a summary table of significant calls at various thresholds
LBEsummary(lbe_res)

# Write results to a file
LBEwrite(lbe_res, filename = "lbe_results.txt")
```

## Tips for AI Agents
- **Input Validation**: Ensure the input is a numeric vector of p-values between 0 and 1.
- **pi0 Only**: If you only need the $\pi_0$ estimate without calculating q-values, set `qvalues = FALSE` in the `LBE()` call to save computation.
- **Comparison**: LBE is often compared to the `qvalue` package. LBE provides a theoretical confidence interval for $\pi_0$, which is a distinct advantage for reporting uncertainty.
- **Parameter a**: If the p-value distribution is highly non-uniform near 1, adjusting `l` or `a` can help refine the $\pi_0$ estimate.

## Reference documentation
- [LBE](./references/LBE.md)
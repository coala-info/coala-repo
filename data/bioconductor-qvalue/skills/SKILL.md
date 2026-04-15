---
name: bioconductor-qvalue
description: This tool estimates false discovery rates and calculates q-values for multiple hypothesis testing in high-throughput experiments. Use when user asks to estimate q-values, calculate the proportion of true null hypotheses, determine local false discovery rates, or adjust p-values for multiple testing.
homepage: https://bioconductor.org/packages/release/bioc/html/qvalue.html
---

# bioconductor-qvalue

name: bioconductor-qvalue
description: False discovery rate (FDR) estimation and q-value calculation for multiple hypothesis testing. Use this skill when you need to estimate q-values, the proportion of true null hypotheses (pi0), or local false discovery rates (lfdr) from a collection of p-values or test statistics.

## Overview

The `qvalue` package provides tools for estimating the False Discovery Rate (FDR) in high-throughput experiments. Unlike traditional p-value adjustments (like Bonferroni) which control the family-wise error rate, `qvalue` estimates the proportion of false positives among the features called significant. Key outputs include:
- **q-value**: The minimum FDR at which a test is called significant.
- **pi0 ($\pi_0$)**: The estimated proportion of true null hypotheses in the data.
- **local FDR (lfdr)**: The probability that a specific null hypothesis is true given its p-value.

## Core Workflow

### 1. Data Preparation and P-value Calculation
If you have p-values, you can proceed directly to the `qvalue()` function. If you have observed statistics and null statistics (e.g., from permutations), use `empPvals`.

```R
library(qvalue)

# Calculate p-values from statistics if necessary
# stat: observed statistics; stat0: null statistics
pvalues <- empPvals(stat = obs_stats, stat0 = null_stats)

# Always check the p-value histogram first
hist(pvalues, nclass = 20)
```
*Note: The histogram should be flat at the right tail. A "U-shape" indicates potential issues with the test model or data dependencies.*

### 2. Estimating Q-values
The `qvalue()` function is the primary interface.

```R
# Basic usage
qobj <- qvalue(p = pvalues)

# Controlling FDR at a specific level (e.g., 0.05)
qobj_fdr <- qvalue(p = pvalues, fdr.level = 0.05)

# Accessing results
qvals <- qobj$qvalues
pi0_est <- qobj$pi0
local_fdr <- qobj$lfdr
is_significant <- qobj$significant # Only if fdr.level was provided
```

### 3. Customizing $\pi_0$ Estimation
You can adjust how $\pi_0$ is estimated using the `pi0.method` ("smoother" or "bootstrap") and `lambda` arguments.

```R
# Using bootstrap method for pi0
qobj_boot <- qvalue(p = pvalues, pi0.method = "bootstrap")

# Manual pi0 estimation
pi0_res <- pi0est(p = pvalues, lambda = seq(0.1, 0.9, 0.1), pi0.method = "smoother")
```

### 4. Summarizing and Visualizing
The package provides S3 methods for quick inspection of the results.

```R
# Summary of pi0 and significant calls at various thresholds
summary(qobj)

# Standard plots: pi0 vs lambda, q-values vs p-values, 
# significant tests vs q-value cut-off, and expected FPs
plot(qobj)

# Histogram of p-values with q-value and lfdr overlays
hist(qobj)
```

## Key Functions

- `qvalue()`: Main function to estimate q-values and $\pi_0$.
- `empPvals()`: Calculates p-values from observed and null statistics.
- `pi0est()`: Specifically estimates the proportion of true null hypotheses.
- `lfdr()`: Specifically estimates local false discovery rates.

## Tips for Interpretation
- **q-value vs p-value**: A q-value can be smaller than its corresponding p-value because it incorporates the $\pi_0$ estimate.
- **Maximum q-value**: The maximum possible q-value is $\pi_0$.
- **Significance**: To control FDR at level $\alpha$, call all features with $q \le \alpha$ significant.

## Reference documentation

- [qvalue](./references/qvalue.md)
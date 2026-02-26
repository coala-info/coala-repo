---
name: r-locfdr
description: The locfdr package computes the local false discovery rate for a vector of summary statistics to identify significant cases in large datasets. Use when user asks to estimate local fdr, calculate empirical null distributions, or identify interesting cases from z-scores.
homepage: https://cloud.r-project.org/web/packages/locfdr/index.html
---


# r-locfdr

## Overview
The `locfdr` package computes the local false discovery rate (fdr) for a vector of summary statistics. Unlike the global FDR, which provides an error rate for a set of rejected hypotheses, the local fdr provides a probability for each individual case. It is particularly useful for identifying "interesting" cases in large datasets (N > 200) by comparing an empirical or theoretical null distribution to the observed mixture distribution.

## Installation
```R
install.packages("locfdr")
library(locfdr)
```

## Core Workflow

### 1. Data Preparation
The input `zz` should be a vector of summary statistics. For best results, transform statistics (like t-stats or p-values) so they are theoretically $N(0, 1)$ under the null hypothesis.
- **From t-statistics:** `zz <- qnorm(pt(t_stat, df))`
- **From p-values:** `zz <- qnorm(p_val)`
- **From permutation tests:** `zz <- qnorm(ecdf(z_perm)(z_orig))`

### 2. Running locfdr
The primary function is `locfdr()`.

```R
result <- locfdr(zz, nulltype = 1, plot = 1)
```

**Key Arguments:**
- `zz`: Vector of z-scores (length > 200 recommended).
- `nulltype`: 
  - `0`: Theoretical null $N(0, 1)$.
  - `1`: Empirical null (MLE) - **Default and usually recommended**.
  - `2`: Empirical null (Central Matching).
- `df`: Degrees of freedom for fitting the mixture density (default 7). Increase if the fit is poor.
- `plot`: `0` (none), `1` (histogram + fit), `2` (adds fdr curve), `3` (adds power cdf), `4` (all).

### 3. Interpreting Results
The function returns a list with several components:
- `fdr`: The estimated local false discovery rate for each case in `zz`.
- `fp0`: A matrix of estimated parameters ($\delta_0, \sigma_0, p_0$) for the null distribution.
- `mat`: A summary matrix for plotting, containing bin midpoints, fdr values, and counts.
- `z.2`: The z-score boundaries where $fdr(z) < 0.2$.

### 4. Identifying Significant Cases
A common rule-of-thumb is to consider cases with $fdr < 0.2$ as "interesting."

```R
interesting_indices <- which(result$fdr < 0.2)
interesting_values <- zz[interesting_indices]
```

## Usage Tips
- **Check the Plot:** Always set `plot = 1` to ensure the green curve (mixture density) and blue dashed line (null subdensity) fit the histogram well.
- **Poor Fit:** If the null subdensity doesn't match the central peak, try changing `nulltype` or manually setting `mlests` to provide better starting values for the MLE.
- **Power Assessment:** Check `result$Efdr`. Values > 0.4 generally indicate low power in the experiment.
- **Large Datasets:** If `length(zz)` is small (< 1000), consider reducing the `bre` (breaks) argument from the default 120.

## Reference documentation
- [locfdr Vignette and Examples](./references/locfdr-example.md)
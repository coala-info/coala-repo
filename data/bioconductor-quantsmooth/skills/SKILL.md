---
name: bioconductor-quantsmooth
description: This tool performs quantile smoothing on genomic array data to identify copy number variations while preserving sharp boundaries between segments. Use when user asks to smooth noisy genomic data, identify regions of gain or loss, visualize genomic profiles across chromosomes, or find optimal smoothing parameters using cross-validation.
homepage: https://bioconductor.org/packages/release/bioc/html/quantsmooth.html
---


# bioconductor-quantsmooth

name: bioconductor-quantsmooth
description: Analysis of genomic arrays using quantile smoothing. Use this skill when you need to process noisy genomic data (like SNP or BAC arrays) to identify copy number variations, perform trend-preserving smoothing that maintains sharp boundaries (jumps), or visualize genomic profiles across chromosomes.

# bioconductor-quantsmooth

## Overview

The `quantsmooth` package provides a method for smoothing genomic data using penalized functions. Unlike classical smoothing (which blurs edges), `quantsmooth` uses the L1 norm (quantile regression) to preserve sharp "jumps" in copy number data while flattening the segments between them. This makes it particularly effective for visualizing and detecting genomic deletions and amplifications.

## Core Workflow

### 1. Data Preparation
The package typically expects vectors of intensity or copy number values and their corresponding chromosomal positions.

```r
library(quantsmooth)
# Example data: chr14 (contains affy.cn, affy.pos, bac.cn, bac.pos, etc.)
data(chr14)
```

### 2. Quantile Smoothing
The primary function is `quantsmooth()`. By default, it calculates the median (tau = 0.5).

```r
# Basic smoothing
smoothed_values <- quantsmooth(affy.cn[,1])

# Smoothing with chromosomal positions
plot(affy.pos, affy.cn[,1], pch=".")
lines(affy.pos, quantsmooth(affy.cn[,1]), lwd=2)
```

### 3. Tuning the Smoothing Parameter (Lambda)
The `smooth.lambda` parameter controls the trade-off between smoothness and fit.
- **Manual Scaling:** A common heuristic is to scale lambda by the number of probes.
  ```r
  lambda_val <- length(affy.pos) / 50
  smoothed <- quantsmooth(affy.cn[,1], smooth.lambda = lambda_val)
  ```
- **Cross-Validation:** Use `quantsmooth.cv()` to find the optimal lambda.
  ```r
  lambdas <- 2^seq(-2, 5, by=0.5)
  cv_results <- sapply(lambdas, function(l) quantsmooth.cv(bac.cn[,1], l))
  opt_lambda <- lambdas[which.min(cv_results)]
  ```

### 4. Visualizing Variability
You can plot multiple quantiles (e.g., 25th and 75th percentiles) to show data dispersion.

```r
# Plotting median and quartiles
plot(bac.pos, quantsmooth(bac.cn[,1], tau=0.5), type="l")
lines(bac.pos, quantsmooth(bac.cn[,1], tau=0.25), lty=2)
lines(bac.pos, quantsmooth(bac.cn[,1], tau=0.75), lty=2)
```

### 5. High-level Plotting and Region Detection
The package provides convenience functions for standardized genomic plots and identifying altered regions.

```r
# Plot smoothed data with a baseline (normalized.to)
plotSmoothed(ill.cn[,1], ill.pos, ylim=c(1, 2.5), normalized.to=2)

# Identify regions of gain or loss
# interval: the threshold around the normalized value to consider 'changed'
res <- getChangedRegions(ill.cn[,1], ill.pos, normalized.to=2, interval=0.5)
# res contains columns: start, end, and value
```

## Tips for Success
- **Lambda Selection:** If the smoothed line is too erratic, increase `smooth.lambda`. If it misses obvious jumps, decrease it.
- **Memory/Speed:** The underlying algorithm uses sparse linear programming (via `quantreg` and `SparseM`), making it efficient even for high-density arrays.
- **Normalization:** Ensure your copy number data is correctly centered (e.g., around 2 for diploid organisms) before using `getChangedRegions`.

## Reference documentation
- [Analysis of genomic arrays using quantile smoothing](./references/quantsmooth.md)
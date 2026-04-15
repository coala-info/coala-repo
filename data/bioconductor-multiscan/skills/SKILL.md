---
name: bioconductor-multiscan
description: This tool estimates gene expression levels by combining data from multiple laser scans of a single microarray using a non-linear functional regression model. Use when user asks to combine multiple microarray scans, recover saturated signals, or reduce measurement noise in gene expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/multiscan.html
---

# bioconductor-multiscan

name: bioconductor-multiscan
description: Statistical estimation of gene expression from multiple laser scans of microarrays. Use this skill when you need to combine data from the same microarray scanned at different sensitivity settings to recover censored signals (saturated pixels) and reduce measurement noise.

## Overview

The `multiscan` package implements a non-linear functional regression model to estimate gene expression by combining multiple scans of a single microarray. It addresses the trade-off between sensitivity for weakly expressed genes and signal censoring (saturation) for highly expressed genes. The method uses maximum likelihood estimation based on a Cauchy distribution to handle outliers and systematic bias.

## Typical Workflow

1.  **Data Preparation**: Input must be a numeric matrix or data frame of raw (untransformed) intensities. Rows represent spots/probes; columns represent different scans.
2.  **Model Fitting**: Use the `multiscan()` function to estimate scanning effects and gene expressions.
3.  **Extraction**: Retrieve estimated expressions from the `mu` component of the fitted object.
4.  **Diagnostics**: Use the `plot()` method to visualize the fit and standardized residuals.

## Key Functions and Usage

### multiscan()
The primary function for model fitting.

```r
library(multiscan)

# Load example data
data(murine)

# Fit the model
# 'data' should be raw intensities (not log-transformed)
fit <- multiscan(data = murine)

# View summary of scanning effects and scale parameters
print(fit)

# Extract estimated gene expressions
gene_expressions <- fit$mu
```

### Visualization and Diagnostics
The package provides S3 methods for plotting the results.

```r
# Plot rescaled intensities against estimated expressions
plot(fit)

# Plot standardized residuals to check for outliers or bias
# Residuals are plotted against the rank of estimated expressions
op <- par(mfrow = c(2, 2))
plot(fit, residual = TRUE)
par(op)
```

## Performance Tips

*   **Large Datasets**: The optimization process is computationally intensive. For arrays with tens of thousands of probes, it is recommended to:
    1. Fit the model on a random subset (e.g., 10,000 rows).
    2. Use the resulting scanning effects (`beta`) and scale parameters (`scale`) as initial values for the full dataset.
*   **Data Scale**: Ensure data is on the raw scale. Do not apply log transformations before passing data to `multiscan()`.
*   **Column Order**: The function automatically arranges columns in order of scanner sensitivity; you do not need to pre-sort them.

## Reference documentation

- [multiscan: Combining multiple laser scans of microarrays](./references/multiscan.md)
---
name: bioconductor-mbamethyl
description: bioconductor-mbamethyl performs region-based DNA methylation analysis by smoothing values across genomic windows using a group fused lasso penalty. Use when user asks to smooth methylation data, model probe-specific effects, or identify change points in methylation levels across biological replicates.
homepage: https://bioconductor.org/packages/release/bioc/html/MBAmethyl.html
---


# bioconductor-mbamethyl

## Overview

MBAmethyl is an R package designed for region-based DNA methylation analysis. It addresses the limitations of single-probe analysis by modeling probe-specific effects and leveraging neighboring probe similarity through a group fused lasso penalty. This approach is particularly effective when multiple biological replicates are available, providing smoothed methylation values across a genomic window.

## Core Workflow

The package centers around a single primary function, `MBAmethyl()`.

### 1. Data Preparation
The input must be a matrix $Y$ of methylation values (typically beta values) of size $p \times n$:
- $p$: Number of probes in a specific genomic window (e.g., 200 probes).
- $n$: Number of samples (biological replicates).

```r
# Example: Y is a matrix where rows are probes and columns are samples
# Y <- matrix(data, nrow = p, ncol = n)
```

### 2. Running the Analysis
The `MBAmethyl` function performs the smoothing. The `steps` parameter controls the number of steps in the group fused lasso.

```r
library(MBAmethyl)

# Fit the model
fit <- MBAmethyl(Y, steps = 30)
```

### 3. Interpreting Results
The function returns a list containing two sets of results based on different model selection criteria:
- `fit$ans.aic`: Results selected by Akaike Information Criterion.
- `fit$ans.bic`: Results selected by Bayesian Information Criterion (often preferred for parsimony).

Each result set (e.g., `fit$ans.bic`) contains:
- `theta`: A matrix of the same dimensions as $Y$ containing the smoothed methylation values.
- `phi`: A vector of length $p$ representing the estimated probe-specific effects.
- `change.p`: The indices of probes where a change in methylation level was detected.
- `rss`: Residual sum of squares.
- `df`: Degrees of freedom.

```r
# Extract smoothed values
smoothed_values <- fit$ans.bic$theta

# Identify change points in the region
change_points <- fit$ans.bic$change.p
```

## Usage Tips
- **Window Size**: While the function can handle various sizes, using windows of approximately 200 probes is recommended for real-world data like Illumina 450k arrays.
- **Replicates**: The model's strength lies in its ability to aggregate information across biological replicates; ensure your input matrix includes all replicates for a condition to get the best smoothing performance.
- **Probe Effects**: The `phi` output is useful for identifying probes that consistently deviate from the regional average, which may indicate technical bias or local sequence context effects.

## Reference documentation

- [MBAmethyl](./references/MBAmethyl.md)
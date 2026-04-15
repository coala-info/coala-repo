---
name: r-changepoint
description: The r-changepoint package provides frequentist and non-parametric methods for identifying structural breaks in data. Use when user asks to detect changes in mean, variance, or regression structure, identify single or multiple changepoints, or use algorithms like PELT and Binary Segmentation.
homepage: https://cloud.r-project.org/web/packages/changepoint/index.html
---

# r-changepoint

## Overview
The `changepoint` package provides a suite of frequentist and non-parametric methods for identifying changepoints (structural breaks) in data. It supports single changepoint detection (AMOC) and multiple changepoint detection using exact (PELT, Segment Neighborhoods) or approximate (Binary Segmentation) algorithms.

## Installation
```R
install.packages("changepoint")
library(changepoint)
```

## Core Functions
The package is organized around three primary functions based on what is changing in the data:

- `cpt.mean(data, ...)`: Detects changes in the mean of a series.
- `cpt.var(data, ...)`: Detects changes in the variance (assuming mean is constant or known).
- `cpt.meanvar(data, ...)`: Detects changes in both mean and variance.
- `cpt.reg(data, ...)`: Detects changes in a linear regression structure.

## Common Workflows

### 1. Detecting Multiple Changepoints (PELT)
PELT (Pruned Exact Linear Time) is the recommended default for multiple changepoints as it is exact and computationally efficient.
```R
# Change in mean using PELT and MBIC penalty
set.seed(1)
data <- c(rnorm(100, 0, 1), rnorm(100, 5, 1), rnorm(100, 2, 1))
ans <- cpt.mean(data, method = "PELT", penalty = "MBIC")

# Extract results
cpts(ans)       # Get changepoint locations
param.est(ans)  # Get estimated parameters for each segment
plot(ans)       # Visualize the segments
```

### 2. Detecting a Single Changepoint (AMOC)
Use the "At Most One Change" (AMOC) method when you expect zero or one break.
```R
# Change in variance
data_var <- c(rnorm(100, 0, 1), rnorm(100, 0, 10))
ans_var <- cpt.var(data_var, method = "AMOC", penalty = "SIC")
print(ans_var)
```

### 3. Penalty Selection
The choice of penalty determines how "easy" it is to trigger a new changepoint.
- `MBIC`: Modified BIC (often the default, robust).
- `SIC` / `BIC`: Schwarz Information Criterion.
- `AIC`: Akaike Information Criterion (often over-estimates changepoints).
- `Manual`: User-specified value via `pen.value`.
- `CROPS`: Used with PELT to explore a range of penalties.

### 4. Working with the 'cpt' Object
Functions to extract data from the returned S4 object:
- `cpts(object)`: Returns the changepoint indices.
- `ncpts(object)`: Returns the number of changepoints.
- `seg.len(object)`: Returns the length of each segment.
- `param.est(object)`: Returns the parameter estimates (mean/variance) for each segment.

## Advanced Usage: CROPS
If you are unsure of the penalty, use `penalty = "CROPS"` with `method = "PELT"` to see how the number of changepoints changes across a range of penalty values.
```R
out <- cpt.mean(data, penalty = "CROPS", pen.value = c(5, 500), method = "PELT")
plot(out, diagnostic = TRUE) # Elbow plot to choose optimal number of cpts
plot(out, ncpts = 3)         # Plot specific segmentation
```

## Tips and Best Practices
- **Minimum Segment Length**: Use `minseglen` to prevent segments that are too short to be statistically meaningful.
- **Data Format**: Functions accept vectors, `ts` objects, or matrices. If a matrix is provided, the analysis is performed on each row independently.
- **Distributional Assumptions**: `test.stat` defaults to "Normal". For `cpt.meanvar`, you can also use "Gamma", "Exponential", or "Poisson".

## Reference documentation
- [changepoint: Methods for Changepoint Detection](./references/reference_manual.md)
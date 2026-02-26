---
name: r-longitudinal
description: The r-longitudinal package provides data structures and functions for analyzing multiple time course data with irregular sampling and repeated measurements. Use when user asks to manage longitudinal data structures, estimate dynamical correlation or covariance using shrinkage methods, handle time-series data with unequal temporal spacing, or summarize and plot multiple time course variables.
homepage: https://cloud.r-project.org/web/packages/longitudinal/index.html
---


# r-longitudinal

name: r-longitudinal
description: Analysis of multiple time course data with repeated measurements and irregular sampling. Use when Claude needs to: (1) Manage longitudinal data structures in R, (2) Estimate dynamical correlation or covariance using shrinkage methods, (3) Handle time-series data with unequal temporal spacing or varying repeats per time point, or (4) Summarize and plot multiple time course variables.

# r-longitudinal

## Overview
The `longitudinal` package provides data structures and functions for analyzing multiple time course data. It is specifically designed to handle:
- Irregularly spaced time points.
- Repeated measurements at specific time points.
- Multiple variables (e.g., gene expression levels).
- Dynamical correlation and covariance estimation using shrinkage (Functional Data Analysis perspective).

## Installation
```r
install.packages("longitudinal")
library(longitudinal)
```

## Core Workflow

### 1. Creating Longitudinal Objects
Convert a matrix to a `longitudinal` object. Rows must contain measurements in temporal order. Columns represent individual variables (time series).

```r
# x: data matrix
# repeats: number of measurements per time point (integer or vector)
# time: vector of dates/time points
data_long <- as.longitudinal(x, repeats=1, time=c(1, 2, 5, 10))

# Check object properties
is.longitudinal(data_long)
summary(data_long)
plot(data_long, series=1:3) # Plot first three variables
```

### 2. Data Inspection and Utilities
Use these functions to understand the experimental design and manipulate the data structure.

- `get.time.repeats(x)`: Returns the time points and the number of repeats per point.
- `is.equally.spaced(x)`: Returns TRUE if time intervals are uniform.
- `is.regularly.sampled(x)`: Returns TRUE if the number of repeats is identical for all time points.
- `condense.longitudinal(x, s, func=median)`: Collapses multiple repeats into a single value per time point using a summary function.
- `combine.longitudinal(x1, x2)`: Merges two longitudinal objects with the same variables.

### 3. Dynamical Correlation and Covariance
The package implements shrinkage estimators that account for the distances between time points by assigning weights to samples.

```r
# Estimate dynamical correlation
# lambda: shrinkage intensity (auto-estimated if omitted)
d_cor <- dyn.cor(data_long)

# Estimate dynamical partial correlation (for network inference)
d_pcor <- dyn.pcor(data_long)

# Get dynamical moments (means and variances)
moments <- dyn.moments(data_long)

# Standardize longitudinal data
scaled_data <- dyn.scale(data_long, center=TRUE, scale=TRUE)
```

## Tips for AI Agents
- **Data Ordering**: Ensure the input matrix rows are in temporal order before calling `as.longitudinal`.
- **Shrinkage**: If `lambda` is not specified in `dyn.cor` or `dyn.pcor`, the package uses an analytic formula to estimate the optimal shrinkage intensity.
- **Weights**: The package uses a linear spline approach to calculate `dyn.weights` based on time intervals. If time points are equally spaced and repeats are regular, these weights are equal.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
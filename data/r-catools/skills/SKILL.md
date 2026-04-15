---
name: r-catools
description: This package provides high-performance R utility functions for moving window statistics, machine learning evaluation, and binary file processing. Use when user asks to calculate running statistics, split data for model training, compute ROC AUC, or read and write GIF and ENVI files.
homepage: https://cran.r-project.org/web/packages/catools/index.html
---

# r-catools

## Overview
The `caTools` package provides a collection of high-performance utility functions for R. It is particularly well-known for its "running" (moving window) statistics which are often faster than base R equivalents, as well as tools for binary file I/O and machine learning evaluation.

## Installation
To install the package from CRAN:
```R
install.packages("caTools")
```

## Main Functions and Workflows

### Moving Window Statistics
Use `run*` functions to calculate statistics over a sliding window of size `k`. These functions handle end-effects and are optimized for speed.
- `runmean(x, k)`: Running mean.
- `runmax(x, k)` / `runmin(x, k)`: Running maximum/minimum.
- `runsd(x, k)`: Running standard deviation.
- `runquantile(x, k, probs)`: Running quantile.
- `runmad(x, k)`: Running Median Absolute Deviation.

### Machine Learning Utilities
- **Data Splitting**: Use `sample.split(Y, SplitRatio)` to create logical vectors for train/test splits while preserving group relative ratios (stratification).
- **ROC AUC**: Use `colAUC(X, y)` to calculate the Area Under the ROC Curve (AUC) for multi-class or multi-column data efficiently.
- **LogitBoost**: Use `LogitBoost(xlearn, ylearn)` for a classifier based on the LogitBoost algorithm.

### File I/O and Encoding
- **GIF Files**: `read.gif` and `write.gif` for reading and writing 2D or 3D arrays as GIF images.
- **ENVI Files**: `read.ENVI` and `write.ENVI` for binary data in ENVI format (common in remote sensing).
- **Base64**: `base64encode` and `base64decode` for converting between binary and ASCII text.

### Mathematical Utilities
- `sumadj` and `cumsumadj`: Round-off-error-free sum and cumulative sum.
- `trapz(x, y)`: Trapezoidal rule numerical integration.

## Tips for Usage
- **Window Alignment**: Most `run*` functions support an `endrule` argument (e.g., "keep", "constant", "NA") to determine how the algorithm handles the beginning and end of the vector where a full window is not available.
- **Performance**: `caTools` functions are implemented in C/C++ and are generally much faster than using `apply` or `rollapply` from other packages for the specific statistics supported.
- **Logical Splitting**: When using `sample.split`, the result is a logical vector. Use `subset(data, split == TRUE)` for training and `subset(data, split == FALSE)` for testing.

## Reference documentation
- [caTools Home Page](./references/home_page.md)
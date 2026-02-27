---
name: bioconductor-outlierd
description: This tool detects outliers in high-throughput biological data using intensity-level adaptive quantile regression on M-A scatterplots. Use when user asks to identify outliers in replicates, account for heterogeneous variability in intensity data, or perform quantile regression on M-A plots.
homepage: https://bioconductor.org/packages/3.5/bioc/html/OutlierD.html
---


# bioconductor-outlierd

name: bioconductor-outlierd
description: Detect outliers in high-throughput biological data (microarray, mass spectrometry, LC/MS) using intensity-level adaptive quantile regression on M-A scatterplots. Use this skill when you need to identify outliers while accounting for heterogeneous variability between replicates.

## Overview

The `OutlierD` package provides a robust framework for outlier detection by applying quantile regression to M-A plots. Unlike standard constant fences (Q3+1.5IQR), `OutlierD` adjusts the outlier thresholds based on the intensity level (A), which is essential for high-throughput data where variability often changes with signal intensity.

## Core Workflow

### 1. Data Preparation
The package requires two vectors of intensities (replicates) from the same biological condition. Data should typically be log-transformed before analysis.

```R
library(OutlierD)
data(lcms) # Example dataset
# Log2 transformation is recommended
x <- log2(lcms)
x1 <- x[,1]
x2 <- x[,2]
```

### 2. Running Outlier Detection
The primary function is `OutlierD()`. You must choose a regression method based on the complexity of the variability observed in the M-A plot.

```R
# Basic usage
fit <- OutlierD(x1 = x1, x2 = x2, k = 1.5, method = "nonlin")
```

**Parameters:**
- `x1`, `x2`: Vectors of intensities for the two replicates.
- `k`: The multiplier for the Interquartile Range (IQR). Default is 1.5. Increase `k` for more stringent outlier detection.
- `method`: The quantile regression approach:
    - `"constant"`: Standard boxplot-style fences (no intensity adjustment).
    - `"linear"`: Linear quantile regression (fences change linearly with intensity).
    - `"nonlin"`: Nonlinear quantile regression (uses `nlrq`).
    - `"nonpar"`: Nonparametric quantile regression (uses `rqss`).

### 3. Interpreting Results
The output object contains a data frame with outlier status and calculated bounds.

```R
# Total number of outliers found
fit$n.outliers

# Access the results table
results <- fit$x
head(results)
```

**Result Columns:**
- `Outlier`: Boolean (TRUE/FALSE) indicating if the row is an outlier.
- `A`: Average intensity (log scale).
- `M`: Difference in intensity (log scale).
- `Q1`, `Q3`: Estimated 25th and 75th quantiles at that intensity level.
- `LB`, `UB`: Lower and Upper Bounds (fences) used for detection.

## Tips for Method Selection
- **Visual Inspection**: Always plot your M-A data first. If the spread of M increases or decreases significantly as A changes, avoid the `"constant"` method.
- **Complexity vs. Overfitting**: `"nonpar"` is the most flexible but computationally intensive. `"nonlin"` or `"linear"` are often sufficient for typical microarray or LC/MS data.
- **Stringency**: If you are getting too many false positives, increase the `k` parameter (e.g., `k = 3`).

## Reference documentation
- [How to use the OutlierD Package](./references/OutlierD.md)
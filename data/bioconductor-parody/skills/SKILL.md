---
name: bioconductor-parody
description: The parody package provides a unified interface for identifying outliers in univariate and multivariate datasets using classical and robust statistical procedures. Use when user asks to detect outliers in data, apply the Generalized Extreme Studentized Deviate test, or use robust methods like median absolute deviation for outlier labeling.
homepage: https://bioconductor.org/packages/release/bioc/html/parody.html
---


# bioconductor-parody

## Overview

The `parody` package provides a unified interface for identifying outliers in both univariate and multivariate datasets. It implements several classical and robust statistical procedures that go beyond simple thresholding, allowing for calibrated outlier labeling based on sample size and desired significance levels ($\alpha$).

## Univariate Outlier Detection

The primary function for univariate analysis is `calout.detect`. It supports multiple methods for defining "inlier" boundaries.

### Common Methods
*   **Boxplot**: Uses the standard interquartile range (IQR) rule.
*   **GESD**: Generalized Extreme Studentized Deviate. Best for detecting multiple outliers in normally distributed data without needing to guess the exact number of outliers (requires a maximum $k$).
*   **medmad**: A robust method using the Median and Median Absolute Deviation.
*   **shorth**: Uses the "shorth" (the shortest interval containing half the data).

### Basic Workflow
```r
library(parody)

# Example data
vals <- c(83, 70, 62, 55, 56, 57, 57, 58, 59, 50, 51, 52, 35, 13, 14)

# 1. Standard Boxplot rule (1.5 * IQR)
calout.detect(vals, alpha=0.05, method="boxplot", 
              scaling=function(n, alpha) 1.5)

# 2. Rosner's GESD (testing up to k potential outliers)
calout.detect(vals, alpha=0.05, method="GESD", k=5)

# 3. Robust Median/MAD (Hampel)
calout.detect(vals, alpha=0.05, method="medmad", scaling=hamp.scale.3)
```

### Interpreting Results
The function returns a list:
*   `$ind`: Indices of the detected outliers in the input vector.
*   `$val`: The actual values of the outliers.
*   `$outlier.region`: The numerical boundaries beyond which a point is considered an outlier.

## Multivariate Outlier Detection

For multivariate data (data frames or matrices), use `mv.calout.detect`. This implements the Caroni and Prescott generalization of the GESD.

### Workflow
```r
# Load sample multivariate data
data(tcost)

# Detect outliers
ostr <- mv.calout.detect(tcost, alpha=0.05, k=10)

# Access results
ostr$inds  # Indices of multivariate outliers
ostr$vals  # Values of the outlying rows

# Visualization: Highlight outliers in a pairs plot
thecol <- rep("black", nrow(tcost))
thecol[ostr$inds] <- "red"
pairs(tcost, col=thecol, pch=19)
```

## Tips and Best Practices
*   **Choosing k**: In GESD and multivariate detection, `k` is the *maximum* number of outliers to search for. It should be less than half the sample size.
*   **Calibration**: Use `ftype="ideal"` in the boxplot method to apply theoretical calibration for the boxplot rule based on sample size.
*   **Visualization**: Always compare formal outlier detection results with visual plots (Boxplots for univariate, Pairs plots or PCA Biplots for multivariate) to ensure the statistical results align with the data distribution.

## Reference documentation
- [parody: parametric and resistant outlier dytection](./references/parody.md)
---
name: r-ks
description: Kernel smoothers for univariate and multivariate data, with comprehensive visualisation and bandwidth selection capabilities, including for densities, density derivatives, cumulative distributions, clustering, classification, density ridges, significant modal regions, and two-sample hypothesis tests.
homepage: https://cloud.r-project.org/web/packages/ks/index.html
---

# r-ks

## Overview

The `ks` package provides advanced tools for kernel smoothing. Unlike many other R packages that restrict multivariate smoothing to diagonal bandwidth matrices, `ks` supports unconstrained (full) bandwidth matrices, allowing the kernel to orient itself to the data's structure. It supports data from 1 to 6 dimensions.

## Installation

```R
install.packages("ks")
library(ks)
```

## Core Workflow: Kernel Density Estimation (KDE)

The standard workflow involves two steps: selecting a bandwidth matrix ($H$) and computing the estimate.

### 1. Bandwidth Selection
Bandwidth selection is the most critical step. `ks` provides several data-driven selectors:
*   **Plug-in Selectors:** `Hpi()` (unconstrained) or `Hpi.diag()` (diagonal). Generally faster and recommended for most applications.
*   **Cross-validation Selectors:** `Hscv()` (Smoothed Cross Validation) or `Hlscv()` (Least-squares CV).

```R
# For 2D data 'x'
H.plug <- Hpi(x = x)      # Unconstrained (allows oblique orientation)
H.diag <- Hpi.diag(x = x) # Diagonal (axes-aligned only)
```

### 2. Computing and Plotting KDE
The `kde()` function creates a `kde` object used for visualization and further analysis.

```R
# Compute KDE
fhat <- kde(x = x, H = H.plug)

# Plotting (2D)
# Default shows 25%, 50%, and 75% highest density region (HDR) contours
plot(fhat)

# 3. Advanced Plotting Options
plot(fhat, display="persp") # Perspective plot
plot(fhat, display="image") # Image/heat map
```

## Multivariate Features

### Kernel Discriminant Analysis (KDA)
Use `kda()` for non-parametric classification based on kernel density estimates for each group.

### Two-Sample Testing
Use `kde.test()` to perform a non-parametric test to determine if two samples come from the same distribution.

```R
# Compare two samples x1 and x2
test_results <- kde.test(x1 = x1, x2 = x2)
test_results$pvalue
```

### Clustering and Modal Regions
*   **`kms()`**: Kernel Mean Shift clustering to find local maxima (modes).
*   **`kdr()`**: Kernel Density Ridges for finding 1D structures in higher dimensional data.

## Tips for Success
*   **Unconstrained vs. Diagonal:** Use unconstrained bandwidths (`Hpi`) when your data has correlations or features oriented obliquely to the coordinate axes. Diagonal bandwidths (`Hpi.diag`) may produce artifacts (like artificial multimodality) in such cases.
*   **Memory Management:** For very large datasets, use the `binned = TRUE` argument in `kde()` to speed up computation via linear binning.
*   **Dimensions:** While `ks` supports up to 6D, visualization is primarily optimized for 1D, 2D, and 3D (using the `rgl` package for 3D).

## Reference documentation

- [Kernel density estimation for bivariate data](./references/kde.md)
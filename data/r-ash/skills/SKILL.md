---
name: r-ash
description: This tool performs fast, non-parametric 1D and 2D statistical density estimation using Averaged Shifted Histograms. Use when user asks to estimate data density, compute bin counts, or perform computationally efficient alternatives to kernel density estimation in R.
homepage: https://cloud.r-project.org/web/packages/ash/index.html
---


# r-ash

name: r-ash
description: Statistical density estimation using Averaged Shifted Histograms (ASH). Use this skill when performing fast, non-parametric density estimation for 1D or 2D data in R, particularly as a computationally efficient alternative to standard kernel density estimation (KDE).

# r-ash

## Overview
The `ash` package implements David Scott's Averaged Shifted Histogram (ASH) routines. ASH is a method for density estimation that improves upon standard histograms by averaging several histograms with shifted bin edges. This results in a smoother estimate that is computationally efficient, especially for large datasets.

## Installation
Install the package from CRAN:
```R
install.packages("ash")
```

## Core Functions
- `bin1`: Compute 1D bin counts.
- `ash1`: Compute 1D averaged shifted histogram estimate.
- `bin2`: Compute 2D bin counts.
- `ash2`: Compute 2D averaged shifted histogram estimate.

## Workflows

### 1D Density Estimation
To estimate the density of a univariate vector `x`:
1. Define the interval `ab` (range) and the number of bins `nbin`.
2. Generate bin counts using `bin1`.
3. Compute the ASH estimate using `ash1`.
4. Plot the results.

Example:
```R
library(ash)
x <- rnorm(100)
# 1. Bin the data
bins <- bin1(x, ab=c(-5, 5), nbin=50)
# 2. Compute ASH estimate (m is the smoothing parameter)
est <- ash1(bins, m=5)
# 3. Visualize
plot(est, type="l")
```

### 2D Density Estimation
To estimate the density of a bivariate dataset (matrix or data frame with two columns):
1. Define the ranges for both dimensions in a 2x2 matrix `ab`.
2. Define the number of bins for both dimensions `nbin`.
3. Generate 2D bin counts using `bin2`.
4. Compute the 2D ASH estimate using `ash2`.
5. Visualize using `image`, `contour`, or `persp`.

Example:
```R
library(ash)
data(iris)
x <- as.matrix(iris[,1:2])
# 1. Define ranges
rng <- matrix(c(4, 8, 2, 5), ncol=2, byrow=TRUE)
# 2. Bin the data
bins <- bin2(x, ab=rng, nbin=c(20, 20))
# 3. Compute 2D ASH estimate
est <- ash2(bins, m=c(5, 5))
# 4. Visualize
image(est$x, est$y, est$z)
contour(est$x, est$y, est$z, add=TRUE)
```

## Tips and Parameters
- **Smoothing Parameter (m)**: The integer `m` controls the smoothness. It represents the number of shifted histograms being averaged. Larger values of `m` result in smoother estimates but may increase bias.
- **Kernel Selection (kopt)**: Use the `kopt` argument in `ash1` or `ash2` to specify the kernel.
  - `1`: Uniform kernel (default).
  - `2`: Triangle kernel.
  - `3`: Epanechnikov kernel.
  - `4`: Biweight kernel.
- **Range (ab)**: Ensure the range `ab` covers all data points in `x`, otherwise points outside the range will be ignored during binning.

## Reference documentation
- [README](./references/README.md)
- [Home Page](./references/home_page.md)
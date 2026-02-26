---
name: r-ptw
description: This tool performs Parametric Time Warping to align signals or peak lists using polynomial warping functions. Use when user asks to align chromatographic or spectroscopic samples to a reference, correct retention time shifts, or perform profile-based warping using WCC or RMS criteria.
homepage: https://cloud.r-project.org/web/packages/ptw/index.html
---


# r-ptw

name: r-ptw
description: Parametric Time Warping (PTW) for aligning patterns, signals, and peak lists in R. Use this skill when you need to align one or more samples to a reference using polynomial warping functions, specifically for chromatographic or spectroscopic data. It supports both profile-based warping (RMS or WCC criteria) and peak-list-based warping.

# r-ptw

## Overview
The `ptw` package provides methods for Parametric Time Warping, which aligns signals by searching for an optimal polynomial that describes the warping of the time (or index) axis. Unlike Dynamic Time Warping (DTW), PTW uses a global parametric model, making it less prone to "overfitting" local noise and maintaining the relative order of features. It is widely used in chemistry (GC, HPLC, NMR) to correct for retention time shifts.

## Installation
Install the package from CRAN:
```R
install.packages("ptw")
```

## Core Workflows

### 1. Aligning Signal Profiles
The primary function is `ptw()`. It aligns a `sample` to a `reference`.

```R
library(ptw)

# Basic alignment (1st order polynomial = shift; 2nd order = shift + stretch)
# init.coeff: [intercept, slope, quadratic, ...]
# Default is c(0, 1) for no initial warping
warp_model <- ptw(ref = reference_vector, 
                  samp = sample_vector, 
                  init.coeff = c(0, 1), 
                  warp.type = "individual",
                  optim.crit = "WCC")

# Apply the warping to the sample
aligned_sample <- warp_model$warped.sample

# Summary and Plotting
summary(warp_model)
plot(warp_model)
```

### 2. Optimization Criteria
- **WCC (Weighted Cross Correlation):** Recommended for peak-like data. It is robust against baseline issues and focuses on peak overlap. Requires a `trwdth` (triangle width) parameter.
- **RMS (Root Mean Square):** Standard least-squares difference. Best for signals with similar baselines and intensities.

```R
# Using WCC with a specific triangle width
warp_wcc <- ptw(ref, samp, optim.crit = "WCC", trwdth = 20)
```

### 3. Aligning Multiple Samples
You can align multiple samples to a single reference simultaneously.

```R
# samp can be a matrix where each row is a sample
warp_multi <- ptw(ref = reference_vector, 
                   samp = sample_matrix, 
                   warp.type = "individual") # or "global"
```

### 4. Peak List Warping
For data already processed into peak lists (position and intensity), use `ptw` with the `selected.peaks` argument or the specific peak-matching logic.

```R
# Aligning peak lists (list of matrices with columns 'pos' and 'height')
peak_warp <- ptw(ref_peaks, samp_peaks, type = "peaks")
```

## Key Functions
- `ptw()`: Main function for calculating and applying warping.
- `stptw()`: Simplified version for "Stick" (peak) PTW.
- `WCC()`: Calculate the Weighted Cross Correlation between two vectors.
- `as.warpman()`: Convert ptw objects for manual inspection/manipulation.

## Tips for Success
- **Initial Coefficients:** The length of `init.coeff` determines the degree of the polynomial. `c(0, 1)` is linear, `c(0, 1, 0)` is quadratic.
- **Reference Selection:** Choose a reference signal that is representative, high-quality, and contains all major features present in the samples.
- **WCC Width:** In `optim.crit = "WCC"`, the `trwdth` should roughly match the expected width of the peaks in your data.

## Reference documentation
- [ptw Home Page](./references/home_page.md)
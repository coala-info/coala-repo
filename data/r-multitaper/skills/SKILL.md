---
name: r-multitaper
description: Implements multitaper spectral analysis using discrete prolate spheroidal sequences (Slepians) and sine tapers. It includes an adaptive weighted multitaper spectral estimate, a coherence estimate, Thomson's Harmonic F-test, and complex demodulation. The Slepians sequences are generated efficiently using a tridiagonal matrix solution, and jackknifed confidence intervals are available for most estimates. This package is an implementation of the method described in D.J.
homepage: https://cloud.r-project.org/web/packages/multitaper/index.html
---

# r-multitaper

name: r-multitaper
description: Perform multitaper spectral analysis in R. Use this skill to estimate power spectral density (PSD) using Slepians (DPSS) or sine tapers, conduct Thomson's Harmonic F-test for periodic signals, calculate coherence between time series, and perform complex demodulation. Ideal for high-resolution spectral estimation with reduced leakage and jackknifed confidence intervals.

# r-multitaper

## Overview
The `multitaper` package implements the Multitaper Method (MTM) for spectral analysis, providing a more robust estimate of the power spectrum than traditional periodograms. It uses Discrete Prolate Spheroidal Sequences (Slepians) to minimize spectral leakage and allows for adaptive weighting, harmonic analysis, and confidence interval estimation via jackknifing.

## Installation
Install the package from CRAN:
```r
install.packages("multitaper")
library(multitaper)
```

## Core Workflow

### 1. Basic Spectral Estimation
Use `spec.mtm` to compute the power spectral density.
```r
# Generate or load a time series 'x'
# nw: time-bandwidth product; k: number of tapers
res <- spec.mtm(x, nw = 4, k = 7, plot = TRUE)
```

### 2. Harmonic Analysis (F-test)
Identify periodic components (lines) in the spectrum using Thomson's Harmonic F-test.
```r
# returnIdentify: enables interactive identification of peaks
res <- spec.mtm(x, nw = 4, k = 7, returnIdentify = TRUE)

# Access F-test statistics
f_stats <- res$mtm$Ftest
```

### 3. Coherence Estimation
Calculate the coherence between two time series.
```r
# x and y are time series of the same length
coh_res <- mtm.coh(x, y, nw = 4, k = 7, plot = TRUE)
```

### 4. Complex Demodulation
Extract the amplitude and phase of a signal at a specific frequency over time.
```r
# f0: frequency of interest
demod <- demod.mtm(x, f0 = 0.25, nw = 4, k = 7)
plot(demod)
```

## Key Functions and Parameters

- `spec.mtm(x, nw, k, ...)`: The primary function for MTM.
    - `nw`: Time-bandwidth product (typically 2 to 4).
    - `k`: Number of tapers (usually $2 \times nw - 1$).
    - `adaptive`: Logical; if TRUE, use adaptive weighting to reduce leakage from distant frequencies.
    - `jackknife`: Logical; if TRUE, compute jackknifed confidence intervals.
- `dpss(n, nw, k)`: Generate Discrete Prolate Spheroidal Sequences (Slepians) directly.
- `resample(x)`: Utility for centering and scaling time series before analysis.

## Tips for Effective Analysis
- **Choosing NW**: A higher `nw` provides more smoothing (lower variance) but lower frequency resolution.
- **Zero Padding**: Use the `nfft` parameter in `spec.mtm` to pad the series with zeros, which interpolates the frequency grid for smoother plots.
- **Pre-processing**: Always remove the mean and any linear trends from the data before spectral estimation to avoid leakage from the zero-frequency (DC) component.

## Reference documentation
- [README.md](./references/README.md)
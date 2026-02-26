---
name: r-waveslim
description: This tool provides comprehensive routines for 1D, 2D, and 3D wavelet analysis and wavelet-based statistical modeling in R. Use when user asks to perform discrete wavelet transforms, conduct multiresolution analysis, denoise images, or estimate wavelet variance and correlation.
homepage: https://cloud.r-project.org/web/packages/waveslim/index.html
---


# r-waveslim

name: r-waveslim
description: Expert guidance for the 'waveslim' R package, used for 1D, 2D, and 3D wavelet analysis. Use this skill when performing discrete wavelet transforms (DWT), maximal overlap DWT (MODWT), wavelet packet transforms (DWPT), multiresolution analysis (MRA), and wavelet-based statistical analysis (variance, correlation, and long-memory process estimation).

## Overview

`waveslim` is a comprehensive R package for wavelet routines based on the methodologies of Percival and Walden (2000) and Gencay, Selcuk, and Whitcher (2001). It supports basic wavelet transforms, dual-tree complex wavelet transforms (DTCWT), and Hilbert wavelet pairs for signal and image processing.

## Installation

```R
install.packages("waveslim")
library(waveslim)
```

## Core Workflows

### 1. One-Dimensional Analysis (Time Series)

For 1D signals, use `dwt` for decimated transforms or `modwt` for non-decimated (translation-invariant) transforms.

```R
# Discrete Wavelet Transform (DWT)
data(ibm)
returns <- diff(log(ibm))
x.dwt <- dwt(returns, wf="la8", n.levels=4, boundary="periodic")

# Maximal Overlap DWT (MODWT) - preferred for variance analysis
x.modwt <- modwt(returns, wf="la8", n.levels=4)

# Multiresolution Analysis (MRA) - additive decomposition
x.mra <- mra(returns, wf="la8", J=4, method="modwt")
plot.ts(do.call(cbind, x.mra), main="MRA Decomposition")
```

### 2. Two-Dimensional Analysis (Images)

Use `.2d` suffixes for image processing tasks like denoising or decomposition.

```R
data(xbox)
# 2D DWT
xbox.dwt <- dwt.2d(xbox, wf="haar", J=3)
plot(xbox.dwt) # Visualizes coefficients

# Denoising
data(dau)
dau.denoise <- denoise.dwt.2d(dau, wf="d4", J=4, rule="soft")
image(dau.denoise, col=grey(0:64/64))
```

### 3. Wavelet Statistics

`waveslim` provides robust tools for analyzing the variance and correlation of time series across scales.

```R
# Wavelet Variance
x.modwt <- modwt(returns, wf="la8", n.levels=5)
x.modwt.bw <- brick.wall(x.modwt, wf="la8") # Remove boundary effects
wave.variance(x.modwt.bw, type="gaussian")

# Wavelet Correlation between two series
data(exchange)
returns <- diff(log(exchange))
dw1 <- brick.wall(modwt(returns[,1], "d4", 6), "d4")
dw2 <- brick.wall(modwt(returns[,2], "d4", 6), "d4")
wave.correlation(dw1, dw2)
```

### 4. Long-Memory Processes

The package includes Maximum Likelihood Estimation (MLE) for Fractional Difference (FD) and Seasonal Persistent (SP) processes.

```R
# MLE for Fractional Difference parameter 'd'
data(ibm)
vol <- abs(diff(log(ibm)))
fdp.mle(vol, wf="d4", J=4)

# Simulating a Seasonal Persistent Process
spec <- dwpt.sim(N=256, wf="mb16", delta=0.4, fG=1/12)
```

## Key Functions Reference

| Function | Description |
| :--- | :--- |
| `dwt` / `idwt` | 1D Forward/Inverse Discrete Wavelet Transform |
| `modwt` / `imodwt` | 1D Forward/Inverse Maximal Overlap DWT |
| `dwpt` / `idwpt` | Discrete Wavelet Packet Transform |
| `mra` | Multiresolution Analysis (Additive decomposition) |
| `brick.wall` | Replaces boundary-affected coefficients with NA |
| `phase.shift` | Aligns wavelet coefficients with original time series |
| `wave.variance` | Calculates wavelet variance per scale |
| `dualtree` | Dual-tree complex wavelet transform |

## Tips and Best Practices

- **Boundary Effects**: Always use `brick.wall()` before calculating statistics (variance/correlation) to ensure boundary-contaminated coefficients do not bias results.
- **Filter Selection**: Common filters include "haar", "d4" (Daubechies 4-tap), and "la8" (Least Asymmetric 8-tap). Use `wave.filter("la8")` to inspect coefficients.
- **Dyadic Lengths**: While `modwt` handles any signal length, `dwt` requires dyadic lengths ($2^J$). Use `dwt.nondyadic` if your data is not a power of two.
- **Visualization**: Use `stackPlot()` for a clean visualization of MRA components or multiple wavelet levels.

## Reference documentation
- [Package ‘waveslim’](./references/reference_manual.md)
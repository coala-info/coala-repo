---
name: r-signal
description: The r-signal package provides a comprehensive suite of signal processing functions in R for filter design, digital filtering, and spectral analysis. Use when user asks to design digital filters, apply zero-phase filtering, perform Savitzky-Golay smoothing, resample signals, or analyze frequency responses.
homepage: https://cloud.r-project.org/web/packages/signal/index.html
---

# r-signal

name: r-signal
description: Signal processing functions for R, including filter design (Butterworth, Chebyshev, Elliptic), digital filtering, resampling, interpolation, and spectral analysis. Use this skill when performing tasks such as noise reduction, signal smoothing, frequency response analysis, or converting Matlab/Octave signal processing code to R.

## Overview

The `signal` package provides a comprehensive suite of signal processing tools in R, largely ported from Matlab and Octave. It is the standard choice for designing digital filters, applying zero-phase filtering, and performing signal decimation or interpolation.

## Installation

```R
install.packages("signal")
library(signal)
```

## Core Workflows

### 1. Filter Design and Application
The package supports standard IIR and FIR filter design.

*   **Butterworth Filter**: `butter(n, Wp, type = c("low", "high", "stop", "pass"))`
*   **Chebyshev I/O**: `cheby1(n, Rp, Wp, ...)` and `cheby2(n, Rs, Wp, ...)`
*   **Elliptic Filter**: `ellip(n, Rp, Rs, Wp, ...)`
*   **Filter Application**:
    *   `filter(filt, x)`: Standard causal filtering.
    *   `filtfilt(filt, x)`: Zero-phase filtering (forward and backward) to avoid phase shift.

```R
# Example: Low-pass Butterworth filter
bf <- butter(4, 0.1) # 4th order, 0.1 Nyquist frequency
clean_signal <- filtfilt(bf, noisy_signal)
```

### 2. Savitzky-Golay Smoothing
Used for smoothing data and calculating derivatives without significantly distorting the signal.

*   `sgolay(p, n)`: Computes filter coefficients.
*   `sgolayfilt(x, p, n)`: Applies the filter directly.
    *   `p`: Polynomial order.
    *   `n`: Window size (must be odd).

```R
smoothed <- sgolayfilt(x, p = 3, n = 11)
```

### 3. Resampling and Interpolation
*   **Resample**: `resample(x, p, q)` changes the sampling rate by a factor of p/q using an FIR filter.
*   **Decimate**: `decimate(x, q)` reduces the sample rate by an integer factor.
*   **Interp**: `interp(x, q)` increases the sample rate by an integer factor.

### 4. Spectral Analysis and Visualization
*   **Frequency Response**: `freqz(filt)` calculates and plots the complex frequency response.
*   **Group Delay**: `grpdelay(filt)` calculates the average delay of the filter as a function of frequency.
*   **Z-Plane**: `zplane(filt)` plots poles and zeros.

```R
# Visualize a filter
spec <- freqz(butter(3, 0.2))
plot(spec)
```

### 5. Window Functions
Generate standard windows for FIR design or spectral estimation:
*   `hamming(n)`, `hanning(n)`, `bartlett(n)`, `blackman(n)`, `triang(n)`.

## Tips for Success
*   **Frequency Scaling**: Frequencies in `butter`, `cheby1`, etc., are normalized to the Nyquist frequency (half the sampling rate). A value of 1.0 corresponds to $\pi$ radians/sample.
*   **Object Classes**: Many functions return objects of class `Arma` (Autoregressive Moving Average). You can extract coefficients using `filt$b` (numerator) and `filt$a` (denominator).
*   **Matlab Compatibility**: Most function signatures are identical to their Matlab/Octave counterparts, making porting straightforward.

## Reference documentation

- [signal: Signal Processing](./references/home_page.md)
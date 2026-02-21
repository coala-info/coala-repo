---
name: r-rseis
description: R package rseis (documentation from project home).
homepage: https://cran.r-project.org/web/packages/rseis/index.html
---

# r-rseis

## Overview
The `rseis` package provides a comprehensive suite of tools for seismic time series analysis. It is designed for both automated processing and interactive exploration of seismic data. Key capabilities include spectral analysis, wavelet transforms, particle motion analysis (hodograms), and various filtering techniques. It integrates with other geophysical packages like `GEOmap` and `RFOC`.

## Installation
To install the package from CRAN:
```R
install.packages("RSEIS")
```

## Core Workflows

### Data Structure
`rseis` typically works with a list structure (often called `GH`) that contains seismic traces, headers, and timing information.
- Use `prepSEIS` to format raw data into the standard `rseis` list format.
- Use `swig` (Seismic Window Interactive Graphics) for the primary interactive interface.

### Interactive Visualization
The `swig` function is the centerpiece of the package, allowing for:
- Paging through long time series.
- Picking arrival times (P and S waves).
- Applying real-time filters.
- Zooming and windowing specific events.

```R
# Basic usage of swig
library(RSEIS)
data(KHZ) # Example dataset
swig(KHZ)
```

### Signal Processing & Filtering
Common filtering operations include:
- `filtsignal`: Apply bandpass, lowpass, or highpass Butterworth filters.
- `taper`: Apply cosine tapers to the ends of signals to avoid edge effects.
- `detrend`: Remove linear trends from the data.

```R
# Example: Bandpass filter between 1Hz and 10Hz
filtered_trace <- filtsignal(trace_data, dt=0.01, fl=1, fh=10, type="BP")
```

### Spectral and Wavelet Analysis
- `evolfft`: Calculate evolving Fourier spectrometers (spectrograms).
- `evolwave`: Perform continuous wavelet transforms for time-frequency analysis.
- `mtapspec`: Multi-taper spectral estimation for high-resolution frequency analysis.

### Particle Motion
For three-component seismic data, use `hodogram` to visualize particle motion in 2D or 3D, which is essential for identifying phase arrivals and polarization.

## Tips for Success
- **Sampling Rate**: Always ensure your `dt` (sample interval) or `sel` (sampling frequency) parameters match your data metadata.
- **Interactive Mode**: Many functions in `rseis` rely on the `RPMG` package for interactive buttons. Ensure your R graphics device supports interactive input (like X11, windows, or quartz).
- **Large Datasets**: For very large seismic files (e.g., SEGY or SAC), use the specific reading functions like `read1sac` or `read1segy` before passing them to `prepSEIS`.

## Reference documentation
- [rseis Home Page](./references/home_page.md)
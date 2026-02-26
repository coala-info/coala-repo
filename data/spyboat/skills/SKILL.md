---
name: spyboat
description: SpyBOAT applies wavelet transform analysis to spatially extended oscillatory systems to quantify phase, period, amplitude, and power across image stacks. Use when user asks to analyze spatial oscillations in movies, generate wavelet-based phase or period maps, or quantify synchronization in 3D image data.
homepage: https://github.com/tensionhead/SpyBOAT
---


# spyboat

## Overview
SpyBOAT (Spatial pyBOAT) is a framework designed to apply wavelet transform analysis to spatially extended oscillatory systems. By treating each pixel in a 3D image stack as an individual time-series, it generates four primary output movies: phase, period, amplitude, and power. This allows researchers to visualize and quantify how oscillatory properties like frequency and synchronization evolve across a tissue or sample over time.

## Installation
SpyBOAT can be installed via pip or conda:

```bash
pip3 install spyboat
# OR
conda install -c conda-forge spyboat
```

## Core Workflow and Best Practices

### 1. Preliminary 1D Analysis
Full 3D wavelet transforms are computationally intensive. Before processing an entire stack, extract a few single-pixel signals or ROI tracks and analyze them using the standard `pyBOAT` tool. Use this to calibrate:
- **Period Range**: The expected minimum and maximum bounds of the oscillations.
- **Sinc Filter Cut-off**: The period threshold for noise filtering.
- **Sampling Interval (dt)**: Ensure the time-step matches your acquisition rate.

### 2. Spatial Preprocessing
To improve signal-to-noise ratios and reduce computational load:
- **Downsampling**: Spatially downscale the input movie (e.g., by a scaling factor in %) if the spatial resolution significantly exceeds the temporal resolution.
- **Gaussian Blurring**: Apply spatial smoothing. Because SpyBOAT operates on individual pixels, blurring helps the pipeline resolve larger biological structures rather than getting lost in pixel-level noise.

### 3. Scripting Interface
The primary way to use SpyBOAT is through its Python API. Use the `spyboat.datasets` module to load data and the core transform functions to process the stack.

### 4. Masking Results
Wavelet transforms will produce values for every pixel, including background noise.
- **Power Movie**: Use the power output as a guide for masking. High power typically indicates a robust oscillatory signal.
- **Interactive Masking**: For Fiji users, utilize the provided script `local-scripts/mask_wmovie_ij.py` to interactively mask the resulting wavelet movies.

## Key Parameters
- `period_range`: A tuple defining the search window for the wavelet (e.g., `(18, 30)` for circadian data).
- `sinc_filter`: The cut-off period used to remove high-frequency fluctuations before the transform.
- `dt`: The sampling interval (time between frames).
- `amplitude_normalization`: (Optional) Window size for normalizing signal intensity.

## Reference documentation
- [SpyBOAT Main Repository](./references/github_com_tensionhead_SpyBOAT.md)
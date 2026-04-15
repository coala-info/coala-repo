---
name: bioconductor-massspecwavelet
description: This tool processes mass spectrometry data using Continuous Wavelet Transform to identify and refine peaks without requiring baseline correction. Use when user asks to detect peaks in mass spectrometry spectra, perform continuous wavelet transforms, identify ridge lines, or estimate signal-to-noise ratios for peak filtering.
homepage: https://bioconductor.org/packages/release/bioc/html/MassSpecWavelet.html
---

# bioconductor-massspecwavelet

## Overview
MassSpecWavelet is a Bioconductor package designed for processing Mass Spectrometry (MS) data using Continuous Wavelet Transform (CWT). It excels at identifying both strong and weak peaks by matching the characteristic shapes of peaks in wavelet space. This approach is robust against noise and eliminates the need for traditional preprocessing steps like baseline correction or aggressive smoothing.

## Core Workflow

### 1. Data Preparation and Transformation
Load your MS data (typically a numeric vector of intensities) and apply the CWT using the Mexican Hat wavelet (`mexh`).

```r
library(MassSpecWavelet)
data(exampleMS)

# Define scales (smaller for narrow peaks, larger for wide peaks)
scales <- seq(1, 64, 2)

# Perform Continuous Wavelet Transform
wCoefs <- cwt(exampleMS, scales = scales, wavelet = "mexh")
```

### 2. Peak Identification Pipeline
The package provides a high-level wrapper for the entire detection process, or you can execute the steps manually for finer control.

**Automated Approach:**
```r
peakInfo <- peakDetectionCWT(exampleMS, SNR.Th = 3, nearbyPeak = TRUE)
peakIndex <- peakInfo$majorPeakInfo$peakIndex
```

**Manual Step-by-Step Approach:**
1. **Identify Local Maxima:** Find maxima across the CWT coefficient matrix.
2. **Identify Ridges:** Connect local maxima across adjacent scales.
3. **Identify Major Peaks:** Filter ridges based on SNR and length.

```r
# 1. Local Maxima
localMax <- getLocalMaximumCWT(wCoefs)

# 2. Ridge Lines
ridgeList <- getRidge(localMax)

# 3. Major Peaks
majorPeakInfo <- identifyMajorPeaks(exampleMS, ridgeList, wCoefs, SNR.Th = 3)
peakIndex <- majorPeakInfo$peakIndex
```

### 3. Refining Results
After initial detection, use `tuneInPeakInfo` to improve the estimation of peak centers, widths, and intensities.

```r
betterPeakInfo <- tuneInPeakInfo(exampleMS, majorPeakInfo)
# Access refined centers: betterPeakInfo$peakCenterIndex
```

## Visualization
The package includes specialized plotting functions to inspect the CWT space and identified peaks.

```r
# Plot identified peaks on the raw spectrum
plotPeak(exampleMS, peakIndex, main = "Identified Peaks")

# Plot ridge lines (visualizes peak persistence across scales)
plotRidgeList(ridgeList, wCoefs)
```

## Algorithm Selection (Local Maxima)
MassSpecWavelet offers different algorithms for detecting local maxima. The "faster" algorithm is the default, but "new" provides better handling of plateaus and edge cases.

```r
# Switch to the experimental 'new' algorithm for better precision
options("MassSpecWavelet.localMaximum.algorithm" = "new")

# Switch back to the classic/faster implementation
options("MassSpecWavelet.localMaximum.algorithm" = "faster")
```

## Tips for Success
- **Scale Selection:** The `scales` parameter is critical. Small scales (e.g., 1-10) capture narrow peaks and noise; larger scales (e.g., 30-64) capture broad peaks but may merge closely spaced signals.
- **SNR Threshold:** Adjust `SNR.Th` (Signal-to-Noise Ratio threshold) to control sensitivity. A value of 3 is a standard starting point.
- **No Preprocessing:** Avoid manual baseline subtraction or smoothing before using `cwt()`, as the wavelet transform inherently handles these components.

## Reference documentation
- [Finding local maxima with MassSpecWavelet](./references/FindingLocalMaxima.md)
- [Using the MassSpecWavelet package](./references/MassSpecWavelet.md)
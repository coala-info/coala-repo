---
name: r-maldiquant
description: "A complete analysis pipeline for matrix-assisted laser         desorption/ionization-time-of-flight (MALDI-TOF) and other         two-dimensional mass spectrometry data. In addition to commonly         used plotting and processing methods it includes distinctive         features, namely baseline subtraction methods such as         morphological filters (TopHat) or the statistics-sensitive         non-linear iterative peak-clipping algorithm (SNIP), peak         alignment using warping functions, handling of replicated         measurements as well as allowing spectra with different         resolutions.</p>"
homepage: https://cloud.r-project.org/web/packages/MALDIquant/index.html
---

# r-maldiquant

## Overview
`MALDIquant` is an R package providing a complete analysis pipeline for matrix-assisted laser desorption/ionization-time-of-flight (MALDI-TOF) and other 2D mass spectrometry data. It handles the full workflow from raw data import (via `MALDIquantForeign`) to the generation of a feature matrix for statistical analysis.

## Installation
To use this package, install it and its companion for data import from CRAN:

```R
install.packages(c("MALDIquant", "MALDIquantForeign"))
library("MALDIquant")
```

## Core Workflow

### 1. Data Import and Quality Control
Data is typically imported as a list of `MassSpectrum` objects.
- **Import**: Use `MALDIquantForeign::importBrukerFlex`, `importMzMl`, or `importMzXml`.
- **QC**: Check for empty spectra or irregular mass intervals.
  ```R
  any(sapply(spectra, isEmpty))
  all(sapply(spectra, isRegular))
  ```

### 2. Preprocessing
Preprocessing stabilizes the signal and removes technical artifacts.
- **Variance Stabilization**: `transformIntensity(spectra, method="sqrt")`
- **Smoothing**: `smoothIntensity(spectra, method="SavitzkyGolay", halfWindowSize=10)`
- **Baseline Correction**: Estimate and remove chemical background.
  ```R
  # SNIP is the recommended algorithm
  spectra <- removeBaseline(spectra, method="SNIP", iterations=100)
  ```
- **Normalization**: Equalize intensities across spectra (e.g., Total Ion Current).
  ```R
  spectra <- calibrateIntensity(spectra, method="TIC")
  ```

### 3. Alignment (Warping)
Align spectra to correct for mass shifts.
- **Align**: `spectra <- alignSpectra(spectra, halfWindowSize=20, SNR=2, tolerance=0.002, warpingMethod="lowess")`
- **Average Replicates**: If technical replicates exist, average them after alignment.
  ```R
  avgSpectra <- averageMassSpectra(spectra, labels=sample_factors, method="mean")
  ```

### 4. Peak Detection and Binning
Identify significant signals and group them across samples.
- **Detection**: `peaks <- detectPeaks(avgSpectra, method="MAD", halfWindowSize=20, SNR=2)`
- **Binning**: Align peak positions into discrete bins.
  ```R
  peaks <- binPeaks(peaks, tolerance=0.002)
  ```
- **Filtering**: Remove infrequent peaks (potential false positives).
  ```R
  peaks <- filterPeaks(peaks, minFrequency=0.25)
  ```

### 5. Feature Matrix Generation
Convert the processed peaks into a matrix for downstream statistics (PCA, clustering, etc.).
```R
# Missing values are automatically interpolated from the spectra
fm <- intensityMatrix(peaks, avgSpectra)
```

## Key Functions Reference
- `createMassSpectrum()` / `createMassPeaks()`: Manual object creation.
- `mass()` / `intensity()`: Accessors for m/z and intensity values.
- `estimateBaseline()`: Visualize background before removal.
- `estimateNoise()`: Determine appropriate Signal-to-Noise Ratio (SNR) thresholds.
- `plot()`: Specialized plotting methods for `MassSpectrum` and `MassPeaks` objects.

## Reference documentation
- [MALDIquant: Quantitative Analysis of Mass Spectrometry Data](./references/MALDIquant-intro.md)
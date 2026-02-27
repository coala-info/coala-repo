---
name: bioconductor-process
description: This tool processes and analyzes SELDI and MALDI mass spectrometry data to identify protein biomarkers. Use when user asks to subtract baselines, detect peaks, normalize intensities, or align peaks across multiple protein spectra.
homepage: https://bioconductor.org/packages/release/bioc/html/PROcess.html
---


# bioconductor-process

name: bioconductor-process
description: Processing and analyzing surface-enhanced laser desorption/ionization (SELDI) and matrix-assisted laser desorption/ionization (MALDI) mass spectrometry (MS) data. Use this skill to perform baseline subtraction, peak detection, normalization, and biomarker identification from protein spectra.

## Overview

The `PROcess` package provides a comprehensive pipeline for the pre-processing of mass spectrometry data. It is designed to handle the specific noise characteristics of MS data, such as elevated baselines at low m/z values and horizontal shifts in peak locations. The workflow typically involves importing raw spectra, removing baseline drifts, normalizing intensities across samples, detecting peaks, and aligning those peaks into "proto-biomarkers" for downstream statistical analysis.

## Core Workflow

### 1. Data Import and Baseline Subtraction
Raw spectra (often in CSV format) exhibit chemical noise that must be removed.

```r
library(PROcess)
# Read a single file
f1 <- read.files("path/to/spectrum.csv")
# Remove baseline using loess (bw controls smoothness)
bseoff <- bslnoff(f1[f1[,1] > 0, ], method = "loess", bw = 0.1, plot = TRUE)
```

### 2. Peak Detection
Peaks are identified after baseline removal. Smoothing is applied to reduce spurious peaks.

```r
# Detect peaks; span and sm.span control smoothing and peak width
pkgobj <- isPeak(bseoff, span = 81, sm.span = 11, plot = TRUE)

# Zoom into specific m/z ranges for inspection
specZoom(pkgobj, xlim = c(5000, 10000))
```

### 3. Batch Processing and Normalization
For multiple spectra, use batch functions to ensure consistency.

```r
# Batch baseline removal from a directory
testM <- rmBaseline("path/to/spectra_dir")

# Renormalize to median Area Under the Curve (AUC)
# cutoff ignores low m/z noise during normalization
rtM <- renorm(testM, cutoff = 1500)

# Batch peak identification
peakfile <- "testpeakinfo.csv"
getPeaks(rtM, peakfile)
```

### 4. Quality Assessment
Identify noisy or low-quality spectra that should be excluded.

```r
qualRes <- quality(testM, peakfile, cutoff = 1500)
# Criteria for removal: Quality < 0.4, Retain < 0.1, and low peak count
print(qualRes)
```

### 5. Proto-biomarker Alignment
Align peaks across different spectra to create a unified feature matrix.

```r
bmkfile <- "testbiomarker.csv"
testBio <- pk2bmkr(peakfile, rtM, bmkfile)

# Extract aligned m/z values
bks <- getMzs(testBio)
```

## Alternative Workflow: Mean Spectrum Approach
A faster method involves detecting peaks on the average spectrum of all samples and then quantifying those specific peaks in individual spectra.

```r
# 1. Compute mean spectrum
grandAve <- aveSpec(list.files(pattern = "\\.csv"))

# 2. Baseline correct and detect peaks on the mean
grandOff <- bslnoff(grandAve[grandAve[,1] > 0, ], method = "loess")
grandPkg <- isPeak(grandOff[grandOff[,1] > 1500, ], ratio = 0.1)
grandpvec <- round(grandPkg[grandPkg$peak, "mz"])

# 3. Quantify these peaks in individual normalized spectra
grandBmk <- getPeaks2(rtM, grandpvec)
```

## Key Functions Reference

- `read.files()`: Imports MS data from CSV files.
- `bslnoff()`: Performs baseline subtraction (methods: "loess" or "monotone").
- `isPeak()`: Core peak detection function using local maxima and signal-to-noise ratios.
- `rmBaseline()`: Wrapper for batch baseline removal.
- `renorm()`: Normalizes spectra intensities.
- `pk2bmkr()`: Aligns detected peaks across multiple spectra into biomarkers.
- `getPeaks2()`: Quantifies specific m/z locations across a matrix of spectra.

## Reference documentation

- [HowTo Use the Bioconductor PROcess package](./references/howtoprocess.md)
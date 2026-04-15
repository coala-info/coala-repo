---
name: r-maldirppa
description: The MALDIrppa package provides robust statistical methods for pre-processing and quality control of MALDI mass spectrometry data. Use when user asks to screen spectra for quality, perform robust peak alignment, detect atypical peak profiles, or filter mass spectrometry data for downstream analysis.
homepage: https://cran.r-project.org/web/packages/maldirppa/index.html
---

# r-maldirppa

## Overview
The `MALDIrppa` package provides specialized tools for the robust pre-processing of Matrix-Assisted Laser Desorption/Ionization (MALDI) mass spectrometry data. It extends the `MALDIquant` framework by introducing robust statistical methods to handle outliers, technical variation, and signal artifacts that can compromise downstream analysis.

Key capabilities include:
- Identification and removal of poor-quality spectra.
- Robust peak alignment and filtering.
- Detection of atypical peak profiles.
- Data transformation and export to common formats (e.g., for `MSclassifR`).

## Installation
To install the stable version from CRAN:
```R
install.packages("MALDIrppa")
```

## Core Workflow

### 1. Data Import and Quality Control
Load your spectra (typically using `MALDIquant::importBrukerFlex` or similar) and use `MALDIrppa` to screen for low-quality acquisitions.

```R
library(MALDIrppa)

# Screen spectra for quality based on signal-to-noise or intensity
# 'spectra' is a list of MassSpectrum objects
qc_results <- screenSpectra(spectra)
summary(qc_results)

# Filter out potential outliers
clean_spectra <- spectra[qc_results$isOk]
```

### 2. Robust Pre-processing
`MALDIrppa` provides wrappers and functions to handle baseline correction and normalization robustly.

```R
# Robust baseline correction
processed_spectra <- wavSmoothing(clean_spectra)

# Peak detection (integrates with MALDIquant)
peaks <- detectPeaks(processed_spectra, method="MAD", halfWindowSize=20, SNR=3)

# Align peaks across samples
peaks <- alignSpectra(peaks)
```

### 3. Peak Filtering and Atypical Profile Detection
Identify peaks that are inconsistent across technical replicates or biological groups.

```R
# Filter peaks based on frequency of occurrence
filtered_peaks <- filterPeaks(peaks, minFrequency = 0.5)

# Detect atypical peak profiles (outliers in peak intensity space)
atypical <- detectAtypical(filtered_peaks, threshold = 0.95)
plot(atypical)
```

### 4. Data Export
Convert processed peak data into data frames or matrices for statistical analysis.

```R
# Create a peak intensity matrix
peak_matrix <- intensityMatrix(filtered_peaks)

# Export to format used by other packages
writeMetadata(filtered_peaks, file = "metadata.csv")
```

## Key Functions
- `screenSpectra()`: Primary tool for initial quality control.
- `wavSmoothing()`: Discrete wavelet transform for signal smoothing.
- `detectAtypical()`: Uses robust Mahalanobis distances to find outlier spectra based on peak patterns.
- `alignSpectra()`: Robust alignment of mass-to-charge ratios.
- `countPeaks()`: Summary statistics of peak counts across the dataset.

## Tips for Success
- **Integration**: Always load `MALDIquant` alongside `MALDIrppa` as they are designed to work together.
- **Robustness**: Use `MALDIrppa` specifically when your dataset has high technical variability or suspected outliers that standard mean-based pre-processing might miss.
- **Visualization**: Use the built-in plotting methods for `screenSpectra` and `detectAtypical` objects to visually inspect why certain spectra were flagged.

## Reference documentation
- [MALDIrppa README](./references/README.html.md)
- [MALDIrppa Project Home](./references/home_page.md)
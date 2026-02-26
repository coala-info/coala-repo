---
name: r-speaq
description: The r-speaq package provides a comprehensive suite for NMR spectral data analysis, including alignment and peak-based feature extraction. Use when user asks to align NMR spectra using CluPA, detect and group peaks, or perform quantitative analysis on spectral features.
homepage: https://cran.r-project.org/web/packages/speaq/index.html
---


# r-speaq

## Overview
The `speaq` package provides a comprehensive suite for NMR spectral data analysis. It supports two primary workflows:
1. **Spectral Alignment (CluPA):** Hierarchical Cluster-based Peak Alignment for raw spectra.
2. **Peak-based Processing (speaq 2.0):** Converting spectra into peak features for quantitative analysis.

## Installation
```R
install.packages("speaq")
library(speaq)
```

## Core Workflows

### 1. Spectral Alignment (CluPA)
Use this workflow to align raw NMR spectra before performing binning or multivariate analysis.

```R
# 1. Detect peaks for alignment landmarks
peakList <- detectSpecPeaks(X, 
                            nDivRange = 128, 
                            scales = seq(1, 16, 2),
                            baselineThresh = 50000,
                            SNR.Th = -1)

# 2. Find the best reference spectrum
resFindRef <- findRef(peakList)
refInd <- resFindRef$refInd

# 3. Perform alignment (CluPA)
# Set maxShift to NULL for automatic detection
Y <- dohCluster(X, 
                peakList = peakList, 
                refInd = refInd, 
                maxShift = 50, 
                acceptLostPeak = TRUE)
```

### 2. Peak-based Feature Extraction (speaq 2.0)
Use this workflow to convert spectra into a feature matrix (samples x peak groups).

```R
# 1. Wavelet-based peak detection
wine.peaks <- getWaveletPeaks(Y.spec = Spectra, 
                              X.ppm = ppm, 
                              baselineThresh = 10, 
                              nCPU = 4)

# 2. Group peaks across samples
wine.grouped <- PeakGrouper(Y.peaks = wine.peaks, 
                            grouping.window.width = 200)

# 3. Fill missing peaks
wine.filled <- PeakFilling(Y.grouped = wine.grouped, 
                           Y.spec = Spectra, 
                           max.index.shift = 50)

# 4. Build feature matrix
wine.Features <- BuildFeatureMatrix(wine.filled)
```

## Quantitative Analysis

### BW-Ratio Analysis (Classic)
Quantifies variability between groups vs. within groups.
```R
BW <- BWR(Y, groupLabel)
H0 <- createNullSampling(Y, groupLabel, N = 100) # Permutation test
```

### Linear Models (Feature-based)
Identifies significant features using linear models with p-value correction.
```R
p.all <- relevant.features.p(datamatrix = scaled_features, 
                             responsevector = group_factor, 
                             p.adj = "bonferroni")
```

## Visualization
- `drawSpec(Y)`: Plot raw or aligned spectra.
- `drawSpecPPM(Y.spec, X.ppm)`: Plot spectra with PPM axis and group coloring.
- `ROIplot(...)`: Detailed view of a Region of Interest showing spectra, peaks, and groups.
- `drawBW(BW, perc, Y)`: Visualize BW-ratio results against a null distribution.

## Tips & Best Practices
- **maxShift:** In `dohCluster`, if you are unsure of the shift, set `maxShift = NULL` to let the algorithm estimate the optimal shift based on Pearson correlation.
- **Nearby Peaks:** In `getWaveletPeaks`, `include_nearbyPeaks = TRUE` detects peaks in the tails of larger peaks. If this causes grouping errors, set to `FALSE`.
- **Silhouette Values:** Use `SilhouetR()` to check the quality of peak grouping. If a group has a low silhouette value (< 0.5), consider using `regroupR()` to refine it.
- **Scaling:** Always scale the feature matrix (e.g., Pareto scaling via `SCANT()`) before performing PCA or differential analysis.

## Reference documentation
- [User guide for speaq package version <= 1.2.3](./references/classic_speaq_vignette.Rmd)
- [speaq 2.0 function illustrations](./references/speaq2_illustrations.Rmd)
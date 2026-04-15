---
name: bioconductor-autotuner
description: Autotuner automates the selection of optimal parameters for metabolomics preprocessing by analyzing regions of interest in raw mass spectrometry data. Use when user asks to identify regions of interest in the total ion current, extract peak-picking parameters from extracted ion chromatograms, or estimate settings for XCMS.
homepage: https://bioconductor.org/packages/3.10/bioc/html/Autotuner.html
---

# bioconductor-autotuner

## Overview
Autotuner automates the selection of parameters for metabolomics preprocessing. It uses a three-step process: identifying regions of interest in the Total Ion Current (TIC), extracting parameters from individual Extracted Ion Chromatograms (EICs) within those regions, and aggregating those values into final estimates for software like XCMS.

## Workflow and Core Functions

### 1. Initialization
Create an `Autotuner` object by providing paths to raw data files and a metadata data frame.
```r
library(Autotuner)

# rawPaths: vector of file paths (.mzML, .mzXML, etc.)
# metadata: data.frame with file names and experimental factors
Autotuner <- createAutotuner(rawPaths,
                             metadata,
                             file_col = "Raw.Spectral.Data.File",
                             factorCol = "Factor.Value.genotype.")
```

### 2. TIC Peak Identification (Sliding Window)
Identify regions enriched with chemical signals using a sliding window moving average.
```r
# Parameters:
# lag: number of scan points for moving average
# threshold: intensity multiplier for significance
# influence: scaling factor for significant scans (0-1)
lag <- 25
threshold <- 3.1
influence <- 0.1

signals <- lapply(getAutoIntensity(Autotuner), 
                  ThresholdingAlgo, lag, threshold, influence)

# Visualize to ensure narrow peaks are captured in the signal plot
plot_signals(Autotuner, threshold, sample_index = 1:3, signals = signals)
```

### 3. Peak Isolation
Isolate and expand the detected TIC regions to prepare for EIC-level parameter estimation.
```r
# returned_peaks: number of peaks to use for estimation (e.g., 10-20)
Autotuner <- isolatePeaks(Autotuner = Autotuner, 
                          returned_peaks = 10, 
                          signals = signals)

# Verify bounds visually
plot_peaks(Autotuner = Autotuner, peak = 1)
```

### 4. EIC Parameter Extraction
Perform statistical inference on the isolated peaks to calculate specific parameters.
```r
# massThresh: absolute mass error (Da) slightly above instrument capability
eicParamEsts <- EICparams(Autotuner = Autotuner, 
                          massThresh = .005, 
                          verbose = FALSE,
                          returnPpmPlots = FALSE,
                          useGap = TRUE)
```

### 5. Retrieving Results
Extract the final estimates to be used in XCMS or other tools.
```r
results <- returnParams(eicParamEsts, Autotuner)
# results$eicParams contains: ppm, noise, preIntensity, snThresh, Peakwidth
# results$ticParams contains: max_width, min_width, group_diff
```

## Best Practices
- **Sliding Window Tuning**: Prioritize finding where peaks *start*. The goal is to isolate regions with real features, not to perfectly bound every peak.
- **Metadata Matching**: Ensure the `file_col` in your metadata exactly matches the basenames or paths provided in `rawPaths`.
- **Mass Threshold**: The `massThresh` in `EICparams` should be set based on the mass analyzer's expected error (e.g., 0.005 for high-res instruments).

## Reference documentation
- [Intro to AutoTuner](./references/Autotuner.Rmd)
- [Autotuner Vignette](./references/Autotuner.md)
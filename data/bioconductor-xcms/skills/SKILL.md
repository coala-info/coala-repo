---
name: bioconductor-xcms
description: This tool processes and analyzes high-resolution mass spectrometry data including LC-MS and direct injection workflows. Use when user asks to perform peak detection, retention time alignment, feature correspondence, gap filling, or feature compounding.
homepage: https://bioconductor.org/packages/release/bioc/html/xcms.html
---

# bioconductor-xcms

name: bioconductor-xcms
description: Expert guidance for using the xcms R package for processing and analyzing mass spectrometry (MS) data. Use this skill when performing LC-MS or direct injection MS data analysis, including peak detection, retention time alignment, correspondence (grouping), and feature compounding.

# bioconductor-xcms

## Overview
The `xcms` package is a powerful framework for the processing of high-resolution MS data. It supports various workflows including Liquid Chromatography-Mass Spectrometry (LC-MS) and direct injection (FTICR-MS). The package handles the entire preprocessing pipeline: from raw data import to peak picking, alignment, and feature grouping (compounding).

## Core Workflows

### 1. Data Import and Initialization
`xcms` uses `XcmsExperiment` or `XCMSnExp` objects to manage data.
```r
library(xcms)
# Load raw data (mzML, mzXML, etc.)
raw_data <- readMSData(files, mode = "onDisk")
```

### 2. Peak Detection (MS1)
Peak picking is performed using `findChromPeaks`.
- **LC-MS (CentWave)**: Best for high-resolution data.
  ```r
  cwp <- CentWaveParam(ppm = 10, peakwidth = c(5, 20), snthresh = 10)
  xdata <- findChromPeaks(raw_data, param = cwp)
  ```
- **Direct Injection (MSW)**: Uses wavelet transformation for single-spectrum data.
  ```r
  msw <- MSWParam(snthresh = 10)
  xdata <- findChromPeaks(raw_data, param = msw)
  ```

### 3. Alignment and Correspondence
- **Alignment**: Corrects retention time shifts across samples.
  ```r
  xdata <- adjustRtime(xdata, param = PeakGroupsParam(minFraction = 0.5))
  ```
- **Correspondence**: Groups peaks across samples into "features".
  ```r
  pdp <- PeakDensityParam(sampleGroups = xdata$sample_group, minFraction = 0.5)
  xdata <- groupChromPeaks(xdata, param = pdp)
  ```

### 4. Compounding (Feature Grouping)
Compounding aims to group features originating from the same compound (e.g., adducts, isotopes).
- **SimilarRtimeParam**: Groups by retention time window.
- **AbundanceSimilarityParam**: Groups by correlation of abundances across samples.
- **EicSimilarityParam**: Groups by correlation of Extracted Ion Chromatogram (EIC) shapes.
```r
# Sequential refinement
xdata <- groupFeatures(xdata, param = SimilarRtimeParam(diffRt = 10))
xdata <- groupFeatures(xdata, param = AbundanceSimilarityParam(threshold = 0.8))
```

### 5. Gap Filling
Recover signal for features missing in specific samples.
```r
xdata <- fillChromPeaks(xdata, param = FillChromPeaksParam())
```

## Working with MS/MS (DDA/DIA)
`xcms` can extract fragmentation spectra associated with identified MS1 peaks.
```r
# Extract MS2 spectra for peaks
ms2_spectra <- chromPeakSpectra(xdata, msLevel = 2L, return.type = "Spectra")

# Estimate precursor intensities if missing
fData(xdata)$precursorIntensity <- estimatePrecursorIntensity(xdata)
```

## Tips for Success
- **Parallel Processing**: Use `register(SerialParam())` for debugging or `MulticoreParam()` for speed.
- **Visualization**: Use `plotChromatogramsOverlay()` to inspect EICs and `plotFeatureGroups()` to validate compounding.
- **Feature Values**: Use `featureValues(xdata, value = "into", filled = TRUE)` to get the final intensity matrix for statistical analysis.

## Reference documentation
- [Compounding (grouping) of LC-MS features](./references/LC-MS-feature-grouping.md)
- [Grouping FTICR-MS data with xcms](./references/xcms-direct-injection.md)
- [LC-MS/MS data analysis with xcms](./references/xcms-lcms-ms.md)
- [xcms: Object-oriented MS data analysis](./references/xcms.md)
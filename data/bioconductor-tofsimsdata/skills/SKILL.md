---
name: bioconductor-tofsimsdata
description: This package provides example Time-of-Flight Secondary Ion Mass Spectrometry imaging and spectra datasets for the tofsims Bioconductor package. Use when user asks to load sample MassImage or MassSpectra objects, practice multivariate analysis on mass spectrometry data, or demonstrate imaging mass spectrometry workflows in R.
homepage: https://bioconductor.org/packages/release/data/experiment/html/tofsimsData.html
---

# bioconductor-tofsimsdata

name: bioconductor-tofsimsdata
description: Provides example ToF-SIMS (Time-of-Flight Secondary Ion Mass Spectrometry) imaging and spectra data for testing and demonstrating the 'tofsims' package. Use when a user needs sample MassImage or MassSpectra objects to practice data processing, multivariate analysis, or visualization workflows in R.

# bioconductor-tofsimsdata

## Overview

The `tofsimsData` package is a specialized Bioconductor ExperimentData package. It provides example datasets recorded on a Ulvac-Phi TRIFT-II ToF-SIMS instrument. These datasets are primarily intended for use with the `tofsims` package to demonstrate multivariate analysis methods (like PCA or MCR) and imaging mass spectrometry workflows.

The data represents a freeze-dried transversal poplar wood section (100 micrometer thickness).

## Loading Data

To use the datasets, load the package and use the `data()` function:

```r
library(tofsimsData)

# Load the datasets into the environment
data(testImage)
data(testSpectra)
```

## Available Datasets

### testImage
- **Format**: `MassImage` object.
- **Description**: A ToF-SIMS image dataset. It was originally imported from a .RAW file using a peak list derived from the spectra.
- **Use Case**: Use this for practicing image-based analysis, spatial distribution plotting, and multivariate imaging analysis.

### testSpectra
- **Format**: `MassSpectra` object.
- **Description**: A ToF-SIMS spectra dataset.
- **Use Case**: Use this for practicing mass calibration, peak picking, and spectral interpretation.

## Typical Workflow with tofsims

The data in this package is designed to be passed into functions from the `tofsims` library:

1. **Exploration**: Check the dimensions and slots of the `testImage` object to understand the spatial and mass resolution.
2. **Analysis**: Perform Principal Component Analysis (PCA) or Maximum Autocorrelation Factors (MAF) on `testImage`.
3. **Visualization**: Use `plot` methods provided by the `tofsims` package to render ion maps or total ion chromatograms (TIC).

Example integration:
```r
library(tofsims)
library(tofsimsData)
data(testImage)

# Example: Run PCA on the test image (requires tofsims package)
# pca_results <- imagePCA(testImage, comps = 3)
# plot(pca_results)
```

## Reference documentation

- [tofsimsData Reference Manual](./references/reference_manual.md)
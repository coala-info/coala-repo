---
name: bioconductor-cardinal
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/Cardinal.html
---

# bioconductor-cardinal

name: bioconductor-cardinal
description: Comprehensive mass spectrometry imaging (MSI) analysis using the Cardinal R package. Use this skill for reading/writing imzML files, pre-processing MSI data (normalization, smoothing, peak picking), visualization (ion images and spectra), and statistical analysis (PCA, NMF, segmentation, and classification).

# bioconductor-cardinal

## Overview
Cardinal is a Bioconductor package designed for the analysis of mass spectrometry imaging (MSI) experiments. It provides a specialized infrastructure for handling high-dimensional imaging data that often exceeds available memory. The package supports the entire MSI workflow from data import (imzML/Analyze 7.5) to pre-processing, exploratory analysis, and spatial statistics.

## Core Data Structures
*   **`MSImagingArrays`**: Used for raw/profile data where each spectrum may have different *m/z* values (common in "processed" imzML).
*   **`MSImagingExperiment`**: The primary container for MSI data where all spectra share a common *m/z* axis (common in "continuous" imzML or after alignment).
*   **Accessors**:
    *   `mz(x)`: Get *m/z* values.
    *   `spectra(x)`: Get intensity matrix/list.
    *   `pixelData(x)` or `pData(x)`: Get spatial metadata (x, y, run).
    *   `featureData(x)` or `fData(x)`: Get feature metadata (*m/z* info).

## Typical Workflow

### 1. Data Import
```R
library(Cardinal)
# Read imzML or Analyze 7.5
mse <- readMSIData("path/to/data.imzML")
```

### 2. Visualization
```R
# Plot mass spectra
plot(mse, coord=list(x=10, y=10))

# Plot ion images (m/z with tolerance)
image(mse, mz=800.5, tolerance=0.5, units="mz")

# Contrast enhancement and smoothing for images
image(mse, mz=800.5, enhance="histogram", smooth="gaussian")
```

### 3. Pre-processing
Cardinal uses a "lazy" processing queue. Functions queue operations, and `process()` executes them.
```R
mse_proc <- mse |>
    normalize(method="tic") |>
    smooth(method="gaussian") |>
    reduceBaseline(method="locmin") |>
    peakPick(SNR=3) |>
    process()

# Align peaks across spectra to create an MSImagingExperiment
mse_aligned <- peakAlign(mse_proc, tolerance=200, units="ppm")
```

### 4. Statistical Analysis
*   **Dimension Reduction**:
    *   `PCA(mse, ncomp=3)`: Principal Component Analysis.
    *   `NMF(mse, ncomp=3)`: Non-negative Matrix Factorization.
*   **Spatial Clustering (Segmentation)**:
    *   `spatialShrunkenCentroids(mse, r=1, k=5, s=c(0, 3, 6))`: Spatially-aware clustering and feature selection.
    *   `spatialDGMM(mse, r=1, k=3)`: Fits a Dirichlet Gaussian Mixture Model to each mass feature.
*   **Classification**:
    *   `crossValidate(PLS, x=mse, y=mse$class, ncomp=1:5, folds=run(mse))`: Supervised learning with cross-validation.

## Tips for Large Datasets
*   **Out-of-memory**: Cardinal uses the `matter` package backend. Data remains on disk until accessed.
*   **Parallelization**: Use `BPPARAM` in functions or set a global backend:
    ```R
    register(MulticoreParam(workers=4)) # macOS/Linux
    # or
    setCardinalBPPARAM(SnowParam(workers=4)) # Windows
    ```
*   **Subsetting**: Use `subsetPixels()` and `subsetFeatures()` to reduce data size before intensive calculations.

## Reference documentation
- [Cardinal 3: User guide for mass spectrometry imaging analysis](./references/Cardinal3-guide.md)
- [Cardinal 3: Statistical methods for mass spectrometry imaging](./references/Cardinal3-stats.md)
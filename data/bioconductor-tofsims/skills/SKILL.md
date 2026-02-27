---
name: bioconductor-tofsims
description: This tool processes and analyzes Time-of-Flight Secondary Ion Mass Spectrometry (ToF-SIMS) data. Use when user asks to import raw instrument data, perform mass calibration, generate peaklists, reconstruct images, or conduct multivariate image analysis and segmentation.
homepage: https://bioconductor.org/packages/3.8/bioc/html/tofsims.html
---


# bioconductor-tofsims

name: bioconductor-tofsims
description: Analysis of Time-of-Flight Secondary Ion Mass Spectrometry (ToF-SIMS) data. Use this skill to import raw data from ULVAC-Phi or IONTOF platforms, perform mass calibration, create peaklists, and execute multivariate image analysis (PCA, MAF, MCR, MNF) and image segmentation.

## Overview

The `tofsims` package is a specialized toolbox for processing and analyzing Time-of-Flight Secondary Ion Mass Spectrometry (ToF-SIMS) data. It bridges the gap between raw instrument data and biological interpretation by providing tools for mass calibration, image reconstruction, and multivariate statistical analysis. It is particularly useful for chemical imaging where spatial distribution of molecules is critical.

## Workflow and Core Functions

### 1. Data Import
The package supports pre-processed binary files (BIF/BIF6) and raw data from ULVAC-Phi and IONTOF platforms.

```r
library(tofsims)
library(tofsimsData)
library(BiocParallel)

# Register parallel backend (use SnowParam(workers=0) for non-parallel)
register(SnowParam(workers=0), default=TRUE)

# Import raw data as spectra
rawData <- system.file('rawdata', 'trift_test_001.RAW', package="tofsimsData")
spectraImport <- MassSpectra(select = 'ulvacraw', analysisName = rawData)

# Summary and Visualization
show(spectraImport)
plot(spectraImport, mzRange=c(1, 150), type='l')
```

### 2. Mass Calibration
Calibration can be performed interactively or by specifying known M/z values.

```r
# Add calibration points
spectraImport <- calibPointNew(object = spectraImport, mz = 15, value = 15.0113)
spectraImport <- calibPointNew(object = spectraImport, mz = 181, value = 181.0444)

# Apply recalibration
spectraImport <- recalibrate(spectraImport)
```

### 3. Peaklist Generation
Create a peaklist to define the M/z windows for image reconstruction.

```r
# Generate unit mass peaks
spectraImport <- unitMassPeaks(object = spectraImport, 
                               mzRange = c(1, 250), 
                               widthAt = c(15, 181), 
                               factor = c(0.4, 0.6))
```

### 4. Image Reconstruction and Scaling
Import the experiment as image data using the generated peaklist and apply Poisson scaling to account for counting noise.

```r
imageImport <- MassImage(select = 'ulvacrawpeaks', 
                         analysisName = rawData, 
                         PeakListobj = spectraImport)

# Apply Poisson scaling
imageImport <- poissonScaling(imageImport)

# Visualize
image(imageImport)
```

### 5. Multivariate Image Analysis
Extract chemical features using dimension reduction techniques.

*   **PCA (Principal Component Analysis):** General dimension reduction.
*   **MAF (Maximum Autocorrelation Factors):** Specifically designed for spatial datasets to maximize spatial correlation.
*   **MCR (Multivariate Curve Resolution):** For resolving pure components.

```r
# Run PCA and MAF
imageImport <- PCAnalysis(imageImport, nComp = 4)
imageImport <- MAF(imageImport, nComp = 4)

# Plot results (e.g., first 4 components of PCA)
for(i in 1:4) image(analysis(imageImport, 1), comp=i)
```

### 6. Image Segmentation and Masking
Use `EBImage` integration to segment features based on multivariate scores.

```r
library(EBImage)

# Create a mask from a PCA score (e.g., component 3)
pcaScore3 <- imageMatrix(analysis(imageImport, 1), comp=3)
mask <- thresh(x = pcaScore3, h = 30, w = 30)

# Apply mask back to the original image to isolate specific regions
# (opened-1)^2 inverts the mask if necessary
cellWallOnly <- bwApply(imageImport, (mask - 1)^2)
image(cellWallOnly)
```

## Tips and Best Practices
*   **Parallel Processing:** Use `BiocParallel` to speed up raw data import, especially for large imaging datasets.
*   **Scaling:** Always consider `poissonScaling()` for ToF-SIMS data, as the noise characteristics are typically Poisson-distributed.
*   **Peak Widths:** When using `unitMassPeaks()`, the `factor` argument allows for asymmetric peak widths, which is common in ToF-SIMS due to instrument-specific peak tailing.
*   **Segmentation:** Use PCA or MAF scores as the input for thresholding rather than raw mass channels to capture correlated chemical signals.

## Reference documentation
- [Example Workflow using the tofsims package (Rmd)](./references/workflow.Rmd)
- [Example Workflow using the tofsims package (Markdown)](./references/workflow.md)
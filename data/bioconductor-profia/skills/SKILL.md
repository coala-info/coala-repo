---
name: bioconductor-profia
description: This tool processes raw Flow Injection Analysis coupled to High-Resolution Mass Spectrometry (FIA-HRMS) data to generate peak tables. Use when user asks to perform peak detection, build noise models, group peaks across samples, or impute missing values in FIA-HRMS datasets.
homepage: https://bioconductor.org/packages/3.5/bioc/html/proFIA.html
---


# bioconductor-profia

name: bioconductor-profia
description: Preprocessing of Flow Injection Analysis coupled to High-Resolution Mass Spectrometry (FIA-HRMS) data. Use when Claude needs to process raw mass spectrometry data (mzML/mzXML) from FIA experiments to generate peak tables, perform peak grouping, handle matrix effects, and impute missing values.

## Overview

The proFIA package provides a specialized workflow for processing FIA-HRMS data. Unlike liquid chromatography (LC-MS), FIA involves direct injection without chromatographic separation, resulting in complex signals affected by matrix effects. proFIA handles this by building noise models, detecting m/z strips, grouping peaks across samples, and providing tools for quality control and data export.

## Core Workflow

The standard workflow involves four main steps, each updating a `proFIAset` object.

### 1. Peak Detection and Noise Modeling

Use `proFIAset` to initialize the object and perform initial signal detection. This is the most time-consuming step as it builds a noise model to filter signals.

```r
library(proFIA)
# path: directory containing mzML or mzXML files
# ppm: mass accuracy (e.g., 2 for Orbitrap, 5 for Q-ToF)
plasSet <- proFIAset(path, ppm = 2, parallel = FALSE)
```

Key parameters:
- `ppm`: Maximum deviation between scans in ppm.
- `dmz`: Minimum absolute m/z deviation (used if ppm calculation is smaller).
- `noiseEstimation`: Logical, whether to build a noise model (recommended).

### 2. Peak Grouping

Match signals across different samples using `group.FIA`.

```r
# ppmGroup: mass accuracy for grouping (should be <= ppm used in proFIAset)
# fracGroup: minimum fraction of samples in a class to form a group
plasSet <- group.FIA(plasSet, ppmGroup = 1, fracGroup = 0.2)
```

### 3. Building the Peak Table

Generate the intensity matrix using `makeDataMatrix`.

```r
# maxo: FALSE uses peak area (robust), TRUE uses maximum intensity
plasSet <- makeDataMatrix(plasSet, maxo = FALSE)
```

### 4. Missing Value Imputation

Impute missing values using a weighted k-nearest neighbors (WKNN) approach tailored for truncated distributions.

```r
# k: number of neighbors (typically half the size of the smallest class)
plasSet <- imputeMissingValues.WKNN_TN(plasSet, k = 3)
```

## Simplified Workflow

For convenience, the entire pipeline can be executed with a single function call:

```r
plasSet <- analyzeAcquisitionFIA(path, ppm = 2, ppmGroup = 1, fracGroup = 0.2, k = 3, parallel = TRUE)
```

## Visualization and Quality Control

proFIA provides several methods to assess data quality at various stages:

- `plot(plasSet)`: Provides a summary dashboard including the number of peaks per category, injection peak shapes, m/z density, and a PCA plot (if the data matrix exists).
- `plotRaw(plasSet, type = "r", sample = 1, ylim = c(mzmin, mzmax))`: Visualizes raw data regions. Use `type = "p"` to see filtered peaks.
- `plotSamplePeaks(plasSet)`: Shows the regressed injection peaks for all samples.
- `plotFlowgrams(plasSet, mz = 256.1696)`: Plots Extracted Ion Chromatograms (EICs) for a specific mass across samples.
- `findMzGroup(plasSet, mz, tol = 5)`: Searches for specific masses within the detected groups.

## Data Export

Processed data can be exported into various formats for downstream statistical analysis:

- **ExpressionSet**: `eset <- exportExpressionSet(plasSet)`
- **Peak Table (Data Frame)**: `pt <- exportPeakTable(plasSet)`
- **Tabular Files (W4M compatible)**:
  - `dm <- exportDataMatrix(plasSet)`
  - `sm <- exportSampleMetadata(plasSet)`
  - `vm <- exportVariableMetadata(plasSet)`

## Reference documentation

- [proFIA-vignette](./references/proFIA-vignette.md)
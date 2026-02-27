---
name: bioconductor-ptairms
description: This tool processes and analyzes raw PTR-TOF-MS data to transform ion counts into quantified expression sets for volatolomics research. Use when user asks to import HDF5 files, perform mass calibration, detect peaks, align samples, impute missing values, or annotate volatile organic compounds.
homepage: https://bioconductor.org/packages/release/bioc/html/ptairMS.html
---


# bioconductor-ptairms

name: bioconductor-ptairms
description: Processing and analysis of PTR-TOF-MS (Proton Transfer Reaction - Time Of Flight - Mass Spectrometry) data. Use this skill to perform end-to-end workflows for volatolomics data (exhaled breath, headspace, ambient air) including HDF5 file import, mass calibration, peak detection, sample alignment, missing value imputation, and VOC annotation.

## Overview
The `ptairMS` package provides a comprehensive suite for processing raw PTR-TOF-MS data stored in HDF5 (.h5) format. It transforms raw ion counts into an `ExpressionSet` object, facilitating statistical analysis of Volatile Organic Compounds (VOCs). Key features include automated expiration/headspace phase detection, drift-corrected mass calibration, and integration with the Human Breathomics Database for feature annotation.

## Typical Workflow

### 1. Initialization and Calibration
Start by creating a `ptrSet` object from a directory of `.h5` files. This step handles mass calibration and identifies time periods of interest (e.g., expiration phases).

```r
library(ptairMS)
library(ptairData)

# Define directory containing .h5 files
dirRaw <- system.file("extdata/exhaledAir", package = "ptairData")

# Create the ptrSet
ptrSet <- createPtrSet(dir = dirRaw, 
                       setName = "my_study", 
                       mzCalibRef = c(21.022, 60.0525), 
                       fracMaxTIC = 0.7)

# Check calibration quality
plot(ptrSet, type = "calibError")
```

### 2. Peak Detection
Detect and quantify peaks across all files. This function performs untargeted peak picking and calculates intensities in cps, ncps, and ppb.

```r
# Detect peaks (supports parallel processing)
ptrSet <- detectPeak(ptrSet, parallelize = TRUE, nbCores = 2)

# View peak list for a specific file
peaks <- getPeakList(ptrSet)
```

### 3. Alignment and Imputation
Align features across the cohort and handle missing values by re-interrogating the raw data at the expected m/z coordinates.

```r
# Align samples into an ExpressionSet
# group: metadata column for reproducibility filtering
eset <- alignSamples(ptrSet, group = "subfolder", fracGroup = 0.8)

# Impute missing values from raw data
eset <- ptairMS::impute(eset, ptrSet)
```

### 4. Annotation and Export
Annotate detected ions using the Human Breathomics Database and export the final tables.

```r
# Annotate features
eset <- annotateVOC(eset)

# Access data
dataMatrix <- Biobase::exprs(eset)
featureData <- Biobase::fData(eset)

# Export to TSV
writeEset(eset, dirC = "output_directory")
```

## Key Functions and Tips

- **`createPtrSet`**: The foundation of the workflow. Use `mzCalibRef` to provide known masses for TOF-to-m/z conversion.
- **`updatePtrSet`**: Use this if you add or remove files from the data directory after initial processing; it preserves existing peak lists while adding new ones.
- **`plotTIC`**: Essential for visualizing the Total Ion Chromatogram and verifying that expiration/headspace limits were correctly detected.
- **`plotRaw`**: Useful for inspecting the raw 2D matrix (m/z vs time) for specific ions before peak detection.
- **`annotateVOC`**: Can be called on a single mass (e.g., `annotateVOC(59.049)`) or an entire `ExpressionSet`.
- **`RunShinnyApp()`**: Launches a GUI for interactive visualization and quality control.

## Reference documentation
- [ptairMS: Processing and analysis of PTR-TOF-MS data](./references/ptairMS.md)
- [ptairMS Vignette Source](./references/ptairMS.Rmd)
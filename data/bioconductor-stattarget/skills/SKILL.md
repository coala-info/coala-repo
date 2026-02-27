---
name: bioconductor-stattarget
description: statTarget provides signal drift correction and statistical analysis for mass spectrometry-based omics data. Use when user asks to perform QC-based signal correction, adjust for batch effects, or conduct multivariate and univariate statistical analysis for metabolomics and proteomics.
homepage: https://bioconductor.org/packages/release/bioc/html/statTarget.html
---


# bioconductor-stattarget

name: bioconductor-stattarget
description: Signal drift correction and statistical analysis for MS-based omics data (metabolomics/proteomics). Use this skill to perform QC-based signal correction (QC-RFSC), batch effect correction (ComBat), and comprehensive statistical analysis including PCA, PLS-DA, and Random Forest.

# bioconductor-stattarget

## Overview
The `statTarget` package provides a streamlined workflow for the quality control and statistical analysis of mass spectrometry-based omics data. It is particularly effective for multi-batch experiments, offering ensemble learning methods (Random Forest) to correct signal drift using QC samples. It also includes a suite of multivariate and univariate statistical tools for biomarker discovery.

## Core Workflows

### 1. Signal Correction (QC-based)
Use `shiftCor` when you have QC samples interspersed throughout your run order to correct for signal drift.

```r
library(statTarget)

# Define paths to Meta file (Sample, Class, Batch, Order) and Profile file (Expression data)
datpath <- system.file('extdata', package = 'statTarget')
samPeno <- paste(datpath, 'MTBLS79_sampleList.csv', sep='/')
samFile <- paste(datpath, 'MTBLS79.csv', sep='/')

# Perform QC-based Random Forest Signal Correction (QC-RFSC)
shiftCor(samPeno, samFile, 
         Frule = 0.8, 
         MLmethod = "QCRFSC", 
         imputeM = "KNN", 
         coV = FALSE)
```

### 2. Batch Correction (QC-free)
Use `shiftCor_dQC` with the "Combat" method for datasets without QC samples to adjust for known batch effects.

```r
samPeno2 <- paste(datpath, 'MTBLS79_dQC_sampleList.csv', sep='/')
shiftCor_dQC(samPeno2, samFile, Frule = 0.8, MLmethod = "Combat")
```

### 3. Statistical Analysis
The `statAnalysis` function automates preprocessing, multivariate modeling, and univariate testing.

```r
file <- paste(datpath, 'data_example.csv', sep='/')

statAnalysis(file, 
             Frule = 0.8, 
             normM = "NONE", 
             imputeM = "KNN", 
             glog = TRUE, 
             scaling = "Pareto",
             nvarRF = 20)
```

### 4. Data Transformation
Convert outputs from common software (XCMS, MZmine2, Skyline) into `statTarget` compatible formats using `transX`.

```r
dataXcms <- paste(datpath, 'xcmsOutput.tsv', sep='/')
transX(dataXcms, 'xcms')
```

## Key Parameters and Tips

- **Meta File Requirements**: 
    - `Class`: Group labels (use `NA` for QC samples in `shiftCor`).
    - `Order`: Injection sequence/run order.
    - `Batch`: Analysis block/batch ID.
    - `Sample`: Must match Profile file; QC samples must contain "QC" in the name.
- **NA.Filter (Frule)**: The "n percent rule". A variable is kept if it has non-zero values in at least n% of samples in any one group (Default: 0.8).
- **Imputation**: Options include "KNN", "min", "minHalf", or "median".
- **Scaling**: Supports "Center", "Pareto", "Auto", "Vast", and "Range". Pareto is the default for metabolomics.
- **Output**: Results are saved in local directories: `statTarget/shiftCor` for correction results and `statTarget/statAnalysis` for statistical outputs (plots, P-values, VIP scores).

## Reference documentation
- [QC-free approach with Combat method](./references/Combat.md)
- [Pathway analysis (mummichog)](./references/pathway_analysis.md)
- [statTarget Main Manual](./references/statTarget.md)
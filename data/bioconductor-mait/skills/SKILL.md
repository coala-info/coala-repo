---
name: bioconductor-mait
description: The MAIT package provides a comprehensive workflow for LC/MS metabolomics data processing, peak annotation, and statistical validation. Use when user asks to process LC/MS metabolomics data, annotate peaks with metabolite identifications, perform statistical analysis between sample classes, or validate significant features using cross-validation.
homepage: https://bioconductor.org/packages/release/bioc/html/MAIT.html
---

# bioconductor-mait

## Overview

The **MAIT** (Metabolite Automatic Identification Toolkit) package provides a comprehensive workflow for Liquid Chromatography-Mass Spectrometry (LC/MS) metabolomics. It excels at improving peak annotation by looking for biotransformations and matching features against a built-in metabolite database. It also includes robust statistical validation tools to ensure that identified significant features effectively discriminate between sample classes.

## Core Workflow

### 1. Data Preparation and Import
MAIT expects a specific directory structure: a main project folder containing subdirectories named after each sample class (e.g., "KO" and "WT"), with raw data files (e.g., .CDF, .mzXML) inside their respective class folders.

```r
library(MAIT)
# dataDir should point to the folder containing class subdirectories
MAIT <- sampleProcessing(dataDir = "path/to/data", 
                         project = "MyProject", 
                         snThres = 2, 
                         rtStep = 0.03)
```

### 2. Peak Annotation
Annotation occurs in three stages: grouping by correlation/retention time, searching for biotransformations, and metabolite identification.

```r
# Step 1: Standard adduct and isotope annotation
MAIT <- peakAnnotation(MAIT.object = MAIT, 
                       adductTable = NULL) # NULL defaults to positive polarity

# Step 2: Biotransformations (specific mass losses)
MAIT <- Biotransformations(MAIT.object = MAIT, 
                           peakPrecision = 0.005)

# Step 3: Metabolite Identification (HMDB lookup)
MAIT <- identifyMetabolites(MAIT.object = MAIT, 
                            peakTolerance = 0.005)
```

### 3. Statistical Analysis
Identify features that significantly differ between classes and generate visualization plots.

```r
# Perform statistical tests (ANOVA/t-test)
MAIT <- spectralSigFeatures(MAIT.object = MAIT, 
                            pvalue = 0.05, 
                            p.adj = "bonferroni")

# Generate plots (saved automatically to the project folder)
plotBoxplot(MAIT)
plotHeatmap(MAIT)
MAIT <- plotPCA(MAIT, plot3d = FALSE)
MAIT <- plotPLS(MAIT, plot3d = FALSE)
```

### 4. Validation
Validate the statistical results using repeated random sub-sampling cross-validation with multiple classifiers (KNN, PLS-DA, SVM).

```r
MAIT <- Validation(Iterations = 20, 
                   trainSamples = 3, 
                   MAIT.object = MAIT)

# View classification ratios
classifRatioClasses(MAIT)
```

## Key Functions and Data Extraction

| Function | Purpose |
| :--- | :--- |
| `MAITbuilder()` | Create a MAIT object from external peak tables (masses, RT, intensities). |
| `sigPeaksTable()` | Extract a table of statistically significant features. |
| `metaboliteTable()` | Extract the final table with metabolite identifications. |
| `resultsPath()` | Get the file system path where tables and plots are saved. |
| `model()` | Retrieve the underlying PCA or PLS models. |

## Tips for Success
- **Project Naming**: Always provide a unique `project` string in `sampleProcessing`; MAIT creates a directory named `Results_<project>` to store all CSV tables and PDF plots.
- **Polarity**: If working with negative ionization data, set `adductTable = "negAdducts"` in `peakAnnotation` and `polarity = "negative"` in `identifyMetabolites`.
- **Custom Biotransformations**: You can extend the default biotransformation table by modifying the `biotransformationsTable` data frame from `data(MAITtables)` and passing it to the `bioTable` argument.

## Reference documentation
- [MAIT Vignette](./references/MAIT_Vignette.md)
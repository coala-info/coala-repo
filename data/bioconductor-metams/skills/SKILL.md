---
name: bioconductor-metams
description: The metaMS package provides an end-to-end pipeline for untargeted GC-MS and LC-MS metabolomics data processing and annotation. Use when user asks to perform peak picking, generate pseudospectra, build in-house chemical standard databases, or annotate metabolomic features.
homepage: https://bioconductor.org/packages/release/bioc/html/metaMS.html
---

# bioconductor-metams

## Overview

The `metaMS` package provides an end-to-end pipeline for untargeted metabolomics, wrapping `xcms` and `CAMERA` to simplify complex workflows. Its primary strength is the "pseudospectrum" approach for GC-MS, which groups m/z values by retention time to facilitate database matching without complex alignment, and a robust annotation framework for LC-MS. It supports the creation of in-house libraries from chemical standards to improve identification accuracy.

## Core Workflows

### 1. GC-MS Analysis
The GC-MS pipeline focuses on pseudospectra (collections of m/z and intensity pairs at specific retention times).

```r
library(metaMS)
library(metaMSdata)

# Load predefined settings (e.g., for Thermo TSQ XLS)
data(FEMsettings) 

# 1. Run the full pipeline
# DB is an optional database of standards for annotation
result <- runGC(files = cdffiles, settings = TSQXLS.GC, DB = DB)

# 2. Access results
# Annotated features and unknowns
features <- getFeatureInfo(stdDB = DB, allMatches = result, sampleList = result$allSamples.msp)

# Relative intensities (robust regression against reference patterns)
ann.mat <- getAnnotationMat(exp.msp = result$allSamples.msp, 
                            pspectra = result$PseudoSpectra, 
                            standardsDB = DB)
```

### 2. LC-MS Analysis
The LC-MS pipeline is a wrapper around `runLC` that performs peak picking, grouping, and CAMERA-based annotation.

```r
# Load settings for LC (e.g., Synapt Q-TOF)
data(FEMsettings)

# Run LC pipeline
# DB is a database created via createSTDdbLC
LC_results <- runLC(files = files, settings = Synapt.RP, DB = LCDBtest$DB)

# Inspect peak table with annotations
head(LC_results$PeakTable)
```

### 3. Building In-House Databases
To improve annotation, users should build databases from injections of known standards.

**For GC-MS:**
```r
# info.df contains CAS, Name, RTman, and stdFile path
DB_GC <- createSTDdbGC(stdInfo = info.df, settings = TSQXLS.GC, extDB = smallDB)
```

**For LC-MS:**
```r
# exptable contains ChemSpiderID, compound, mz.observed, RTman, and stdFile
DB_LC <- createSTDdbLC(stdInfo = exptable, settings = Synapt.RP, polarity = "positive")
```

## Key Functions and Settings

- `metaMSsettings`: A class that stores all parameters for `PeakPicking`, `CAMERA`, `match2DB`, and `betweenSamples`. Use `metaSetting(settings, "Slot")` to view or modify parameters.
- `runGC` / `runLC`: Main entry points for processing raw files.
- `plotPseudoSpectrum`: Visualizes the (mz, I) pairs of a clustered GC-MS feature.
- `matchExpSpec`: Compares an experimental spectrum against a database and returns match factors (0 to 1).
- `treat.DB`: Pre-scales and prepares a database for faster matching.

## Tips for Success

- **Pseudospectra vs. Features**: In GC-MS, `metaMS` treats a cluster of peaks as a single entity (pseudospectrum), which is more robust than individual feature alignment.
- **Retention Index (RI)**: If using GC-MS, providing RI information in the settings and database significantly reduces false positives.
- **Parallel Processing**: Use the `nSlaves` argument in `runGC` or `peakDetection` to speed up processing via the `snow` or `Rmpi` packages.
- **Validation**: For LC-MS, the `minfeat` parameter in settings ensures a compound is only "annotated" if a minimum number of associated features (isotopes/adducts) are found.

## Reference documentation

- [Analysis of GC-MS metabolomics data with metaMS](./references/runGC.md)
- [Annotation of LC-MS metabolomics datasets by the metaMS package](./references/runLC.md)
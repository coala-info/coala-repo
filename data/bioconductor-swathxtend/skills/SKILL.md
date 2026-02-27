---
name: bioconductor-swathxtend
description: SwathXtend extends SWATH-MS assay libraries by integrating local seed libraries with public or archived add-on libraries. Use when user asks to build extended SWATH assay libraries, align retention times using time-based or hydrophobicity-based methods, perform quality assessment of library matching, and validate SWATH data extraction consistency.
homepage: https://bioconductor.org/packages/release/bioc/html/SwathXtend.html
---


# bioconductor-swathxtend

name: bioconductor-swathxtend
description: Expert guidance for the SwathXtend R package to build extended SWATH assay libraries, perform statistical analysis, and check the reliability of SWATH proteomics results. Use this skill when integrating seed and add-on spectral libraries, aligning retention times (time-based or hydrophobicity-based), and validating SWATH data extraction consistency.

## Overview
SwathXtend is designed to extend SWATH-MS assay libraries by integrating a "seed" library (local, instrument-specific) with "add-on" libraries (public repositories like SWATHAtlas or archived local data). It provides tools for library cleaning, quality assessment of library matching, and reliability checks for SWATH results extracted using these extended libraries.

## Core Workflow

### 1. Loading and Cleaning Libraries
Libraries can be in "PeakView" or "OpenSWATH" formats (.txt or .csv).

```r
library(SwathXtend)

# Read library files
lib_file <- "path/to/library.txt"
# clean=TRUE applies default thresholds (99% confidence, intensity > 5)
lib <- readLibFile(lib_file, clean = TRUE)

# Manual cleaning with specific thresholds
lib_cleaned <- cleanLib(lib, intensity.cutoff = 5, conf.cutoff = 0.99, nomod = FALSE, nomc = FALSE)
```

### 2. Quality Assessment
Before merging, evaluate the compatibility of the seed and add-on libraries.

```r
# Statistical check
# Returns RT.corsqr (R^2 > 0.8 recommended), RT.RMSE (< 2 min recommended), and RII.cormedian (> 0.6 recommended)
quality <- checkQuality(seedLib, addonLib)

# Visual checks
plotRTCor(seedLib, addonLib, "Seed", "Addon")   # RT Correlation
plotRTResd(seedLib, addonLib)                   # RT Residuals
plotRIICor(seedLib, addonLib)                   # Relative Ion Intensity Correlation
```

### 3. Building Extended Libraries
Integrate libraries using either time-based alignment (default) or hydrophobicity-based alignment (if RT correlation is poor).

```r
# Time-based integration (Recommended if R^2 > 0.8)
extended_lib <- buildSpectraLibPair("seed.txt", "addon.txt", 
                                    clean = TRUE, 
                                    outputFormat = "peakview", 
                                    outputFile = "extended.txt")

# Hydrophobicity-based integration (using SSRCalc indices)
hydro_index <- readLibFile("hydroIndex.txt", type = "hydro")
extended_lib_hydro <- buildSpectraLibPair("seed.txt", "addon.txt", hydro_index,
                                          method = "hydro",
                                          outputFormat = "peakview")
```

### 4. Reliability Checks for SWATH Results
Compare SWATH results (PeakView .xlsx format) extracted with the seed library vs. the extended library.

```r
# Comprehensive check
# max.fdrpass: threshold for samples passing FDR < 0.01
# max.peptide: threshold for peptides per protein
results <- reliabilityCheckSwath("Swath_seed.xlsx", "Swath_ext.xlsx", 
                                 max.fdrpass = 8, max.peptide = 2)

# Manual quantification consistency check (CV, cor, or bland.altman)
# Requires 'Area - peptides' and 'FDR' sheets
swa_seed <- readWorkbook("Swath_seed.xlsx", 2)
swa_ext <- readWorkbook("Swath_ext.xlsx", 2)
acc <- quantification.accuracy(swa_seed, swa_ext, method = "cv")
```

## Key Functions Reference
- `readLibFile()`: Loads spectral libraries or hydrophobicity files.
- `cleanLib()`: Filters libraries based on confidence, intensity, and modifications.
- `checkQuality()`: Quantifies RT and Intensity similarity between two libraries.
- `buildSpectraLibPair()`: The primary function for merging two libraries into one.
- `reliabilityCheckLibrary()`: Compares peptide/protein coverage between seed and extended libraries.
- `reliabilityCheckSwath()`: Automated pipeline for validating SWATH extraction results.

## Reference documentation
- [SwathXtend Vignette](./references/SwathXtend_vignette.md)
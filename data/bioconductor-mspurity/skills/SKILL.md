---
name: bioconductor-mspurity
description: The msPurity package evaluates precursor ion purity and processes LC-MS/MS or DIMS data for metabolomics. Use when user asks to calculate precursor purity scores, link fragmentation spectra to XCMS features, average MS/MS spectra, or perform spectral matching for metabolite annotation.
homepage: https://bioconductor.org/packages/release/bioc/html/msPurity.html
---


# bioconductor-mspurity

name: bioconductor-mspurity
description: Expert guidance for the msPurity R package to assess precursor ion purity, process LC-MS/MS and DIMS data, and perform spectral matching. Use this skill when users need to calculate precursor purity scores, link fragmentation spectra to XCMS features, average MS/MS spectra, or perform metabolite annotation using spectral libraries.

# bioconductor-mspurity

## Overview
The `msPurity` package is designed for the automated evaluation of precursor ion purity in mass spectrometry-based metabolomics. It assesses the contribution of a targeted precursor within an isolation window, helping to identify "chimeric" MS/MS spectra. Beyond purity assessment, it provides a comprehensive workflow for LC-MS/MS and DIMS data, including feature mapping (with XCMS), spectral averaging, and spectral matching against SQLite-based libraries (e.g., MoNA, MassBank).

## Core Workflows

### 1. Precursor Purity Assessment (purityA)
The `purityA` class is the primary entry point for acquired MS/MS data. It calculates the ratio of the precursor intensity to the total intensity in the isolation window.

```r
library(msPurity)
mzML_files <- list.files("path/to/mzML", full.names = TRUE)

# Calculate purity for all MS/MS scans
pa <- purityA(mzML_files)

# Access purity results
head(pa@puritydf)
```

### 2. LC-MS/MS Workflow with XCMS
To link fragmentation spectra to chromatographic features, `msPurity` integrates with `xcms`.

```r
# 1. Process with XCMS (v3+)
library(xcms)
# ... [XCMS peak picking and grouping] ...
# xcmsObj is an XCMSnExp object

# 2. Link fragmentation to features
pa <- frag4feature(pa = pa, xcmsObj = xcmsObj)

# 3. Filter and Average Spectra
pa <- filterFragSpectra(pa)
pa <- averageAllFragSpectra(pa) # Or use averageIntra/Inter for more control
```

### 3. Spectral Matching and Annotation
`msPurity` uses SQLite databases for spectral matching. You can create a query database from your experiment and match it against a library.

```r
# 1. Create query database
td <- tempdir()
q_dbPth <- createDatabase(pa = pa, xcmsObj = xcmsObj, outDir = td, dbName = 'query.sqlite')

# 2. Perform spectral matching
# Matches against default library or user-specified library
result <- spectralMatching(q_dbPth, q_xcmsGroups = c(1, 2, 3))

# 3. View results
# xcmsMatchedResults contains annotations linked to XCMS features
head(result$xcmsMatchedResults)
```

### 4. Anticipated Purity (purityX and purityD)
Use these classes to predict purity for features where MS/MS has not yet been acquired, useful for prioritizing targets for future DDA/DIA runs.

*   **purityX**: For LC-MS features (requires an `xcmsSet`).
*   **purityD**: For DIMS data (Direct Infusion Mass Spectrometry).

```r
# DIMS Example
ppDIMS <- purityD(file_df, mzML = TRUE)
ppDIMS <- averageSpectra(ppDIMS)
ppDIMS <- dimsPredictPurity(ppDIMS)
```

## Key Functions and Parameters
- `purityA()`: Main constructor. Use `iwNorm = TRUE` and `iwNormFun` (e.g., `iwNormGauss()`) if the instrument's isolation efficiency is known.
- `frag4feature()`: Maps MS/MS scans to XCMS features based on m/z and RT windows.
- `averageAllFragSpectra()`: Consolidates multiple fragmentation scans for a single feature into a representative spectrum.
- `createMSP()`: Exports processed fragmentation spectra to MSP format for use in other software (e.g., NIST, MS-DIAL).
- `spectralMatching()`: Calculates Dot Product Cosine (DPC), Reverse DPC, and Composite DPC scores.

## Tips for Success
- **XCMS Compatibility**: `msPurity` works with both older `xcmsSet` objects and newer `XCMSnExp` objects. For `purityX`, you may need to cast `XCMSnExp` using `as(obj, "xcmsSet")`.
- **Isolation Windows**: Ensure the isolation window offsets in `purityA` match your instrument settings (e.g., +/- 0.5 Da).
- **Database Schema**: The SQLite databases created by `msPurity` follow a specific schema. Refer to the spectral database vignette for details on table relationships (e.g., `s_peak_meta`, `c_peaks`).

## Reference documentation
- [LC-MS/MS data processing and spectral matching workflow using msPurity and XCMS](./references/msPurity-lcmsms-data-processing-and-spectral-matching-vignette.md)
- [msPurity spectral database schema](./references/msPurity-spectral-database-vignette.md)
- [Using msPurity for Precursor Ion Purity Assessments, Data Processing and Metabolite Annotation](./references/msPurity-vignette.md)
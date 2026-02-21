---
name: r-erah
description: Automated compound deconvolution, alignment across samples, and identification of metabolites by spectral library matching in Gas Chromatography - Mass spectrometry (GC-MS) untargeted metabolomics. Outputs a table with compound names, matching scores and the integrated area of the compound for each sample. Package implementation is described in Domingo-Almenara et al.
homepage: https://cran.r-project.org/web/packages/erah/index.html
---

# r-erah

name: r-erah
description: Automated compound deconvolution, alignment, and identification for GC/MS-based untargeted metabolomics. Use this skill when processing raw GC/MS data (netCDF, mzXML) to extract metabolite profiles, align them across samples, and identify them using spectral libraries like MassBank or GMD.

## Overview

The `erah` package provides a complete pipeline for GC/MS metabolomics:
1. **Deconvolution**: Blind source separation to extract pure spectra from co-eluting peaks.
2. **Alignment**: Matching compounds across different samples based on spectral similarity and retention time.
3. **Missing Peak Recovery**: Recursive integration to fill gaps in the data matrix.
4. **Identification**: Spectral matching against reference databases.

## Installation

```r
install.packages('erah')
library(erah)
```

## Workflow

### 1. Experiment Setup

Define the samples and their metadata. You can create an experiment object (`MetaboSet`) from a directory structure or manually.

**Manual Setup:**
```r
# Create tables for instrumental and phenotypic data
instrumental <- createInstrumentalTable(list.files(pattern = ".CDF"))
phenotype <- createPhenoTable(list.files(pattern = ".CDF"), cls = c("Control", "Treat"))

# Initialize experiment
ex <- newExp(instrumental = instrumental, phenotype = phenotype, info = "My Experiment")
```

**Directory-based Setup:**
Organize files into subfolders named by class (e.g., `Experiment/ClassA/sample1.mzXML`).
```r
createdt('path/to/Experiment')
# Then load the generated .csv files and use newExp()
```

### 2. Deconvolution

Extract individual metabolite signals. The `min.peak.width` is the most critical parameter (set to approx. half the average peak width).

```r
# Set parameters (exclude common TMS fragments like 73, 147)
ex.dec.par <- setDecPar(min.peak.width = 1, 
                        avoid.processing.mz = c(1:69, 73:75, 147:149))

# Optional: Parallel processing
# future::plan(future::multisession, workers = 4)

ex <- deconvolveComp(ex, ex.dec.par)
```

### 3. Alignment

Align deconvolved compounds across the sample set.

```r
ex.al.par <- setAlPar(min.spectra.cor = 0.90, max.time.dist = 3, mz.range = 70:600)
ex <- alignComp(ex, alParameters = ex.al.par)
```

### 4. Missing Compound Recovery (Optional)

Reduces "zeros" in the data matrix by re-searching for compounds in samples where they weren't initially detected.

```r
ex <- recMissComp(ex, min.samples = 6)
```

### 5. Identification

Compare aligned spectra against the library. By default, `erah` uses a built-in MassBank library.

```r
ex <- identifyComp(ex)

# View results
id.list <- idList(ex)      # Identification details
align.list <- alignList(ex) # Peak areas across samples
final.data <- dataList(ex)  # Combined table
```

## Visualization

Inspect specific metabolites by their `AlignID`:

```r
# Plot chromatographic profile across samples
plotProfile(ex, AlignID = 84)

# Plot spectral comparison (Empirical vs Library)
plotSpectra(ex, AlignID = 84)

# Compare with the 2nd best hit
plotSpectra(ex, AlignID = 84, hit = 2)
```

## Custom Libraries

To use the Golm Metabolome Database (GMD) or in-house MSP files:

```r
# Import GMD
golm.db <- importGMD(filename="GMD_file.txt", type="VAR5.ALK")

# Use custom library in identification
ex <- identifyComp(ex, id.database = golm.db)
```

## Reference documentation

- [eRah Manual](./references/erah-manual.Rmd)
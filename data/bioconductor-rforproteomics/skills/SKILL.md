---
name: bioconductor-rforproteomics
description: This tool provides infrastructure and workflows for mass spectrometry-based proteomics data analysis within the Bioconductor ecosystem. Use when user asks to process raw MS data, handle proteomics file standards, perform quantitative workflows like TMT or label-free analysis, and visualize protein identification results.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RforProteomics.html
---

# bioconductor-rforproteomics

name: bioconductor-rforproteomics
description: Specialized knowledge for proteomics data analysis using the RforProteomics package and the Bioconductor ecosystem. Use this skill when performing mass spectrometry (MS) data processing, visualization of proteomics experiments, handling data standards (mzML, mzIdentML, mzTab), and performing quantitative proteomics workflows (TMT, iTRAQ, Label-free).

# bioconductor-rforproteomics

## Overview

The `RforProteomics` package serves as a central hub and companion to the Bioconductor proteomics ecosystem. It provides infrastructure, data examples, and workflows for analyzing mass spectrometry-based proteomics data. It integrates several key packages: `MSnbase` for raw and quantitative data, `mzR` for low-level file access, `mzID` for identification data, and `MSnID` for post-search filtering.

## Core Workflows

### 1. Data Input and Standards
The package facilitates reading various open formats.
- **Raw Data (mzML, mzXML):** Use `mzR::openMSfile()` for low-level access or `MSnbase::readMSData()` for high-level abstraction.
- **Identification Data (mzIdentML):** Use `mzID::mzID()` to parse identification results into a manipulatable object.
- **mzTab:** Use `MSnbase::readMzTabData()` to load the Proteomics Standard Initiative (PSI) exchange format.

### 2. Quantitative Proteomics with MSnSet
The `MSnSet` class is the primary container for quantitative proteomics data.
- **Creation:** Convert identification data or read spreadsheets using `readMSnSet2()`.
- **Processing:** 
  - `filterNA(object)`: Remove features with missing values.
  - `normalise(object, method)`: Apply normalization (e.g., "sum", "vsn", "quantiles").
  - `combineFeatures(object, groupBy, method)`: Aggregate peptide-level data to protein-level (e.g., method = "sum" or "median").

### 3. Visualization
- **Spectra:** `plot(raw[[i]], full = TRUE)` visualizes individual MS2 spectra.
- **MA Plots:** `MAplot(object)` for comparing two channels or conditions.
- **Quality Control:** `plotMzDelta(raw)` checks for mass accuracy and identification consistency.
- **Spatial Proteomics:** Integration with `pRoloc` for visualizing subcellular localization.

### 4. Post-Search Filtering (MSnID)
To manage False Discovery Rates (FDR):
- Initialize: `msnid <- MSnID(".")`
- Load data: `read_mzIDs(msnid, files)`
- Filter: Define criteria using `MSnIDFilter` and optimize thresholds using `optimize_filter(..., method = "Grid")`.
- Apply: `apply_filter(msnid, filterObj)`

### 5. Sequence Analysis
- **In-silico Digestion:** Use `cleaver::cleave(sequence, enzym = "trypsin")`.
- **Isotopic Distributions:** Use `BRAIN` or `Rdisop` to calculate theoretical isotopic envelopes for peptides.

## Typical Workflow Example

```r
library(RforProteomics)
library(MSnbase)

# 1. Load quantitative data from mzTab
qnt <- readMzTabData("data.mztab", what = "PEP")

# 2. Pre-process
qnt <- filterNA(qnt)
qnt_norm <- normalise(qnt, method = "vsn")

# 3. Aggregate to protein level
prot <- combineFeatures(qnt_norm, groupBy = fData(qnt_norm)$accession, method = "sum")

# 4. Visualize
plot(prot)
```

## Tips for Success
- **Memory Management:** For large raw data files, use the `onDisk = TRUE` argument in `readMSData()` to avoid loading all spectra into RAM.
- **Metadata:** Always check `fData(object)` and `pData(object)` to ensure feature (peptide/protein) and pheno (sample) annotations are correctly mapped.
- **Up-to-date Resources:** For modern MS workflows, prioritize the "R for Mass Spectrometry" initiative packages (e.g., `Spectra`, `QFeatures`) which are the successors to `MSnbase`.

## Reference documentation
- [Visualisation of proteomics data using R and Bioconductor](./references/RProtVis.md)
- [Using R for proteomics data analysis](./references/RforProteomics.md)
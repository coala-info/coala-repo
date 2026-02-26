---
name: bioconductor-adductomicsr
description: bioconductor-adductomicsr provides a computational pipeline for the untargeted screening, identification, and quantification of protein adducts using LC-MS/MS data. Use when user asks to model retention time drift, identify adducts via spectral similarity, generate target tables, or quantify adduct peak areas in mass spectrometry datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/adductomicsR.html
---


# bioconductor-adductomicsr

## Overview

The `adductomicsR` package provides a computational pipeline for "adductomics"—the untargeted screening of protein adducts using LC-MS/MS. It is designed to identify and quantify modifications to specific peptides (typically the triply charged T3 peptide of Human Serum Albumin) by comparing experimental spectra against model spectra and accounting for mass and retention time shifts.

## Core Workflow

### 1. Data Preparation and RT Correction
Before identification, samples must be corrected for retention time (RT) drift. This requires a directory of `.mzXML` files and a CSV file defining the run order.

```r
library(adductomicsR)

# Model retention time deviations
# MS2Dir: directory containing mzXML files
# runOrder: path to CSV with sample run order
rtDevModelling(
  MS2Dir = "path/to/mzXMLs",
  nCores = 4,
  runOrder = "runOrder.csv"
)
```

### 2. Adduct Identification
The `specSimPepId` function identifies potential adducts by calculating spectral similarity between the observed MS2 spectra and a theoretical model.

```r
specSimPepId(
  MS2Dir = "path/to/mzXMLs",
  rtDevModels = "path/to/mzXMLs/rtDevModels.RData",
  nCores = 4
)
```
*Note: This generates MS2 spectra plots and grouping results in the output directory.*

### 3. Target Table Generation
After identification, generate a target table containing the monoisotopic mass (MIM) and RT for each candidate adduct.

```r
generateTargTable(
  allresultsFile = "allResults_ALVLIAFAQYLQQCPFEDHVK_example.csv",
  csvDir = getwd()
)
```

### 4. Quantification
Quantify the identified adducts across all samples. This step integrates peak areas and applies quality filters.

```r
adductQuant(
  targTable = "targetTable.csv",
  filePaths = list.files("path/to/mzXMLs", pattern = ".mzXML", full.names = TRUE),
  rtDevModels = "path/to/mzXMLs/rtDevModels.RData",
  hkPeptide = 'LVNEVTEFAK', # Housekeeping peptide for normalization
  nCores = 2,
  maxPpm = 5
)
```

### 5. Results Extraction and Filtering
Extract the peak table from the resulting `AdductQuantif` object and filter out noisy data or low-quality integrations.

```r
# Load results
load("adductQuantResults.Rda")

# Export to CSV
outputPeakTable(object = object, outputDir = "results/")

# Filter results based on missing values and housekeeping peptide strength
filterAdductTable("results/adductQuantif_peakList_date.csv")
```

## Key Functions and Parameters

- `rtDevModelling()`: Essential first step to align samples.
- `specSimPepId()`: Uses spectral similarity scores (default > 0.8) to identify adducts.
- `adductQuant()`: The most computationally intensive step; performs EIC extraction and peak integration.
- `hkPeptide`: A reference peptide (housekeeping) used to monitor instrument performance and normalize integrations.

## Tips for Success
- **File Naming**: Ensure all mass spectrometry files have the `.mzXML` extension.
- **Mass Drift**: If the instrument did not use lock masses, perform mass drift correction prior to using this package.
- **Manual Validation**: Always use the generated `allGroups` plots (m/z vs RT) to verify that multiple groups do not represent the same physical peak before proceeding to quantification.

## Reference documentation
- [AdductomicsR Workflow (Rmd)](./references/adductomicsRWorkflow.Rmd)
- [AdductomicsR Workflow (Markdown)](./references/adductomicsRWorkflow.md)
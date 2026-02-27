---
name: bioconductor-msexperiment
description: This tool manages mass spectrometry experiment data in R by linking raw spectra, quantified features, and experimental design metadata. Use when user asks to create MsExperiment objects, link samples to data files, or organize proteomics and metabolomics workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/MsExperiment.html
---


# bioconductor-msexperiment

name: bioconductor-msexperiment
description: Comprehensive management of mass spectrometry (MS) experiments in R. Use this skill to create, populate, and link data in MsExperiment objects, including raw spectra, quantified features, and experimental design metadata. It is ideal for organizing proteomics or metabolomics workflows where samples must be explicitly linked to raw data files and results.

## Overview

The `MsExperiment` package provides a flexible, light-weight container for all data related to a mass spectrometry experiment. Unlike older containers, it separates the storage of raw spectra, quantified features (e.g., `SummarizedExperiment`), and experimental design, while providing a mechanism to "link" these components. This allows for consistent subsetting and filtering across the entire experiment.

## Core Workflow

### 1. Initialization and File Management
Start by creating an empty experiment or defining the files involved.

```r
library(MsExperiment)
library(Spectra)

# Create empty object
msexp <- MsExperiment()

# Manage external files (mzML, fasta, etc.)
fls <- c("file1.mzML", "file2.mzML")
experimentFiles(msexp) <- MsExperimentFiles(mzmls = fls, fasta = "human.fasta")
```

### 2. Adding Experimental Design
The `sampleData` slot (a `DataFrame`) describes the samples.

```r
sampleData(msexp) <- DataFrame(
    sample_id = c("S1", "S2"),
    group = c("Control", "Treatment")
)
```

### 3. Adding Data (Spectra and Quantified Results)
You can add `Spectra` objects for raw data and `SummarizedExperiment` or `QFeatures` for quantified data.

```r
# Add Spectra
sps <- Spectra(fls)
spectra(msexp) <- sps

# Add Quantified Data (qdata)
# se is a SummarizedExperiment object
qdata(msexp) <- se
```

### 4. Linking Samples to Data
Linking is the most critical step. It ensures that subsetting the experiment by sample also subsets the associated spectra and files.

**Manual Linking:**
Link by index (e.g., sample 1 to file 1).
```r
msexp <- linkSampleData(msexp, with = "experimentFiles.mzmls", 
                        sampleIndex = c(1, 2), withIndex = c(1, 2))
```

**Join-style Linking:**
Link using matching columns (SQL-like syntax).
```r
# Link spectra to samples using file names
sampleData(msexp)$file_path <- normalizePath(fls)
msexp <- linkSampleData(msexp, with = "sampleData.file_path = spectra.dataOrigin")
```

## Data Manipulation

### Subsetting
Subsetting an `MsExperiment` by index or logical vector operates on the **samples**. Because of the links established above, all associated data is subset simultaneously.

```r
# Keep only the first sample and its linked spectra/files
mse_sub <- msexp[1]

# Access linked quantified data for the subset
assay(qdata(mse_sub))
```

### Filtering Spectra
Use `filterSpectra` to apply `Spectra`-based filters (like RT or m/z range) while maintaining experiment integrity.

```r
# Filter spectra by retention time
res <- filterSpectra(msexp, filterRt, rt = c(200, 300))
```

## SQL Integration for Large Experiments
For large-scale data, use `MsBackendSql` to store data on disk while keeping the `MsExperiment` interface.

```r
library(MsBackendSql)
library(RSQLite)

# Create SQL database from files
con <- dbConnect(SQLite(), "experiment.db")
createMsBackendSqlDatabase(con, fls)

# Load as Spectra with SQL backend
sps <- Spectra("experiment.db", source = MsBackendOfflineSql(), drv = SQLite())

# Create experiment and write sample metadata to the DB
mse <- MsExperiment(spectra = sps, sampleData = sdata)
dbWriteSampleData(mse)
```

## Tips for Success
- **Address Syntax**: When linking, use the format `slotName.elementName` (e.g., `experimentFiles.mzmls` or `qdata.sample_id`).
- **Consistency**: Always check file existence using `existMsExperimentFiles(msexp)`.
- **Metadata**: Use the `metadata()` slot to store processing logs or command-line strings used in third-party tools (e.g., search engine parameters).
- **Spectra Variables**: Before linking, ensure the `Spectra` object has a variable (like `dataOrigin`) that matches a column in `sampleData`.

## Reference documentation
- [Managing Mass Spectrometry Experiments](./references/MsExperiment.Rmd)
- [MsExperiment](./references/MsExperiment.md)
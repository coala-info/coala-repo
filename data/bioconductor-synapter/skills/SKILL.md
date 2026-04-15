---
name: bioconductor-synapter
description: This tool analyzes label-free proteomics data from Synapt G2 mass spectrometers through identification transfer and quantification. Use when user asks to perform identification transfer, model retention times, quantify peptide intensities, or create master peptide files from multiple runs.
homepage: https://bioconductor.org/packages/3.6/bioc/html/synapter.html
---

# bioconductor-synapter

name: bioconductor-synapter
description: Analysis of label-free proteomics data acquired on Synapt G2 mass spectrometers. Use this skill to perform identification transfer, retention time modeling, and intensity quantification using the synapter R package. It supports combining multiple runs, ion mobility separation (HDMSE), and fragment matching to maximize identification accuracy.

## Overview

The `synapter` package provides a pipeline for re-analysing label-free proteomics data. Its primary strength is "identification transfer," where high-confidence peptide identifications from one run (identification run) are mapped to features in another run (quantitation run) based on Exact Mass and Retention Time (EMRT). This is particularly useful for increasing the number of quantified peptides across multiple samples.

## Core Workflows

### 1. The High-Level Pipeline (Synergise)
For most users, the `synergise` or `synergise2` functions provide a complete, automated analysis.

```r
library(synapter)

# Define input files
filenames <- list(
  identpeptide = "path/to/ident_final_peptide.csv",
  quantpeptide = "path/to/quant_final_peptide.csv",
  quantpep3d = "path/to/quant_Pep3D.csv",
  fasta = "path/to/database.fasta"
)

# Run the complete pipeline
# synergise2 is recommended for HDMSE (Ion Mobility) data
res <- synergise2(filenames = filenames, outputdir = "results_folder")
```

### 2. Step-by-Step Analysis (The Synapter Class)
For granular control, use the `Synapter` reference class.

**Initialization and Filtering:**
```r
# Create object
obj <- Synapter(filenames)

# Filter by peptide score/FDR
filterUniqueDbPeptides(obj)
setPepScoreFdr(obj, fdr = 0.01)
filterIdentPepScore(obj)
filterQuantPepScore(obj)

# Filter by mass accuracy (ppm)
filterIdentPpmError(obj, ppm = 20)
filterQuantPpmError(obj, ppm = 20)
```

**Modeling and Matching:**
```r
# Merge common peptides for RT modeling
mergePeptides(obj)

# Model retention time differences
modelRt(obj, span = 0.05)

# Grid search to optimize matching parameters (ppm and nsd)
searchGrid(obj, ppms = seq(5, 20, 2), nsds = seq(0.5, 5, 0.5))
setBestGridParams(obj, what = "auto")

# Perform identification transfer
findEMRTs(obj)
```

### 3. Creating Master Peptide Files
To combine multiple identification runs into a single "Master" set to increase coverage:

```r
# Estimate FDR for combinations
pepfiles <- c("file1.csv", "file2.csv", "file3.csv")
master_fdr <- estimateMasterFdr(pepfiles, fastafile = "db.fasta")

# Create the master file
master_obj <- makeMaster(pepfiles)
saveRDS(master_obj, "master_peptides.rds")

# Use the master in a Synapter run
filenames$identpeptide <- "master_peptides.rds"
obj <- Synapter(filenames, master = TRUE)
```

## Key Functions and Methods

- `Synapter()`: Constructor for the main analysis object.
- `synergise()` / `synergise2()`: One-stop-shop functions for the entire pipeline.
- `createUniquePeptideDbRds()`: Pre-processes a FASTA file into a faster RDS format for peptide uniqueness filtering.
- `modelRt()`: Fits a LOESS model to align retention times between runs.
- `findEMRTs()`: The core matching algorithm that transfers identifications to EMRTs.
- `requantify()`: Methods to handle detector saturation and improve quantitation accuracy.
- `writeMatchedEMRTs()`: Exports the final results to a CSV file.

## Tips for Success

- **Input Files**: Ensure you use the "Final Peptide" and "Pep3D" CSV exports from Waters PLGS software.
- **Ion Mobility**: If using HDMSE data, use `synergise2` or ensure `imdiff` parameters are set in `findEMRTs`.
- **Visualization**: Use `plotRt(obj, what="model")` and `plotFeatures(obj)` to verify that the retention time alignment and feature matching are performing correctly.
- **Memory**: For large datasets, use the `subset` or `n` arguments in `searchGrid` to speed up parameter optimization.

## Reference documentation

- [synapter Reference Manual](./references/reference_manual.md)
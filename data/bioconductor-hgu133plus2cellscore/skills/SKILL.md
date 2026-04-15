---
name: bioconductor-hgu133plus2cellscore
description: This package provides a curated reference dataset of 837 Affymetrix Human Genome U133 Plus 2.0 microarray profiles for evaluating cell identity. Use when user asks to load the standard reference ExpressionSet for CellScore, access YuGene-normalized transcription profiles for normal tissues, or evaluate the identity of engineered cell types against a standard reference.
homepage: https://bioconductor.org/packages/release/data/experiment/html/hgu133plus2CellScore.html
---

# bioconductor-hgu133plus2cellscore

name: bioconductor-hgu133plus2cellscore
description: Access and use the curated Affymetrix Human Genome U133 Plus 2.0 microarray dataset for cell identity evaluation. Use this skill when you need to load the standard reference ExpressionSet (eset.std) for the CellScore package, or when you need to understand the manual curation and normalization process (YuGene transform) used for these 837 normal tissue and cell type samples.

## Overview

The `hgu133plus2CellScore` package is a Bioconductor data experiment package. It provides a large, manually curated dataset of 837 transcription profiles from the Affymetrix Human Genome U133 Plus 2.0 (GPL570) platform. This dataset serves as the "standard" or reference set for the `CellScore` package to evaluate the identity of test samples (e.g., engineered or derived cell types).

## Loading the Data

To use the dataset, you must load both the `Biobase` package (to handle ExpressionSet objects) and the data package itself.

```R
library(Biobase)
library(hgu133plus2CellScore)

# Load the standard ExpressionSet object
data(eset.std)

# Inspect the object
eset.std
```

## Data Structure

The `eset.std` object is an `ExpressionSet` containing:
- **Assay Data**: 19,851 features (non-redundant Entrez Gene IDs) across 837 samples.
- **Element Names**: `exprs` (YuGene-normalized values between 0 and 1) and `calls` (binary Present/Absent matrix based on MAS5 detection p-values < 0.05).
- **Phenotype Data (pData)**: Includes critical metadata for CellScore:
    - `experiment_id`: GEO/ArrayExpress ID.
    - `sample_id`: Unique GSM accession.
    - `cell_type`: Text description.
    - `category`: All labeled as "standard".
    - `general_cell_type`: Abbreviations (e.g., FIB for fibroblast).
    - `sub_cell_type1`: Compound term of general cell type and donor tissue.

## Workflow: Using with CellScore

This package is designed to be used as the `standard.eset` argument in `CellScore` functions.

```R
# Example of how this data is typically passed to CellScore
# (Requires CellScore package)
library(CellScore)

# Assuming 'test.eset' is your own data processed similarly
# cellscore.results <- CellScore(test.eset, eset.std)
```

## Data Assembly Standards

If you are preparing new data to be compatible with this reference set, follow these standards used in the package:
1. **Normalization**: Raw .CEL files were background corrected (RMA) and then normalized using the **YuGene transform**. This allows adding samples without re-processing the entire cohort.
2. **Detection Calls**: MAS5 detection p-values were calculated. A probeset is "Present" if p < 0.05.
3. **Annotation**: Probesets were mapped to Entrez Gene IDs. For genes with multiple probesets, the one with the highest median expression across all samples was selected to ensure a non-redundant gene table.

## Reference documentation

- [hgu133plus2CellScore Vignette](./references/hgu133plus2Vignette.md)
---
name: bioconductor-affymoe4302expr
description: This package provides a curated database of normalized mouse gene expression profiles for the Affymetrix Mouse Genome 430 2.0 Array. Use when user asks to retrieve standardized mouse transcriptome data, perform Gene Set Context Analysis, or access curated NCBI GEO metadata for the GPL1261 platform.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Affymoe4302Expr.html
---

# bioconductor-affymoe4302expr

name: bioconductor-affymoe4302expr
description: Access and utilize the pre-built mouse gene expression database for the Affymetrix Mouse Genome 430 2.0 Array (GPL1261). Use this skill when needing to retrieve normalized, standardized expression profiles from NCBI GEO for Gene Set Context Analysis (GSCA) or meta-analysis of mouse transcriptomes.

## Overview

The `Affymoe4302Expr` package provides a curated compendium of 9,444 mouse expression profiles across 20,630 genes, specifically for the GPL1261 platform. The data has been consistently preprocessed using Frozen Robust Multiarray Analysis (fRMA) and standardized via the gene expression barcode approach. 

Key features:
- Data is stored in HDF5 format for efficient access.
- Values are scaled by 1000 (stored as integers) to reduce file size.
- Includes a reference table (`Affymoe4302Exprtab`) mapping Sample IDs (GSM), Experiment IDs (GSE), and Sample Types (tissues/conditions).
- Primarily designed for use with the `GSCA` package.

## Loading the Data

To use the metadata and reference table within R:

```r
library(Affymoe4302Expr)

# Load the reference table containing sample metadata
data(Affymoe4302Exprtab)

# View the structure of the metadata
str(Affymoe4302Exprtab)

# Preview the first few entries
head(Affymoe4302Exprtab)
```

## Data Structure

The `Affymoe4302Exprtab` data frame contains three primary columns:
1. **SampleID**: The NCBI GEO GSM identifier.
2. **ExperimentID**: The NCBI GEO GSE identifier.
3. **SampleType**: Manually verified biological context (cell type, tissue, or treatment condition).

## Usage with GSCA

While the expression values are stored in HDF5 format and not intended for manual extraction by the user, they are automatically accessed by the `GSCA` package. When performing Gene Set Context Analysis for mouse data on the 430 2.0 array, ensure this package is loaded so `GSCA` can locate the underlying database.

## Tips and Best Practices

- **Integer Scaling**: Remember that the raw expression values in the HDF5 matrix are 1000x their actual value. If you attempt to read them directly (not recommended), you must divide by 1000.
- **Gene Mapping**: The package retains only the probeset with the largest coefficient of variation for each gene, ensuring a 1:1 mapping between genes and rows.
- **Memory Management**: Because the dataset is large, it uses `rhdf5` for disk-backed access rather than loading the entire matrix into RAM.

## Reference documentation

- [Affymoe4302Expr Reference Manual](./references/reference_manual.md)
---
name: bioconductor-migsadata
description: This package provides breast cancer datasets and pre-computed results for multidimensional gene set analysis. Use when user asks to load breast cancer microarray or RNAseq data, access benchmarking timings for mGSZ, or retrieve pre-computed MIGSA results for testing and demonstration.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/MIGSAdata.html
---


# bioconductor-migsadata

name: bioconductor-migsadata
description: Access and utilize the MIGSAdata package, which provides essential data objects for the MIGSA (Multidimensional Gene Set Analysis) package vignettes and reproducible research. Use this skill when a user needs to load breast cancer datasets (microarray and RNAseq), benchmark timings for mGSZ speedup, or pre-computed MIGSA results for demonstration and testing purposes.

## Overview
The `MIGSAdata` package is a data-only experiment package designed to support the `MIGSA` package. It contains several high-quality biological datasets, primarily focused on breast cancer (Basal vs. Luminal A subtypes), which have been pre-processed and formatted for gene set enrichment analysis. This skill helps in loading these datasets and converting them into usable objects for functional analysis.

## Loading the Package and Data
To use the data, first load the library and then use the `data()` function to load specific objects into your R environment.

```r
library(MIGSAdata)

# List available datasets in the package
data(package = "MIGSAdata")

# Load a specific dataset
data(bcMigsaResAsList)
data(pbcmcData)
data(tcgaMAdata)
data(tcgaRNAseqData)
data(mGSZspeedup)
```

## Working with MIGSA Results
The `bcMigsaResAsList` object contains pre-computed MIGSA results across multiple datasets (mainz, nki, tcga, transbig, unt, upp, vdx). To use this as a formal `MIGSAres` object, you must use the internal converter from the `MIGSA` package.

```r
library(MIGSA)
data(bcMigsaResAsList)

# Convert the list format to a MIGSAres data.table object
bcMigsaRes <- MIGSA:::MIGSAres.data.table(bcMigsaResAsList$dframe, bcMigsaResAsList$genesRank)
```

## Available Datasets

### Breast Cancer Expression Data
These datasets are filtered for Basal and Luminal A subjects, classified using the PAM50 algorithm.

*   **pbcmcData**: A list containing six microarray datasets (mainz, nki, transbig, unt, upp, vdx). Each entry contains a `gene expression` data.frame and a `subtypes` vector.
*   **tcgaMAdata**: TCGA breast cancer microarray expression matrix and subtypes.
*   **tcgaRNAseqData**: TCGA breast cancer RNAseq expression matrix and subtypes.

Example of accessing expression data:
```r
data(tcgaRNAseqData)
expr_matrix <- tcgaRNAseqData$expression
sample_subtypes <- tcgaRNAseqData$subtypes
```

### Benchmarking Data
*   **mGSZspeedup**: Contains timing benchmarks comparing the standard `mGSZ` algorithm against the optimized `MIGSAmGSZ` implementation. Use this to demonstrate performance improvements.

## Typical Workflow
1.  **Load Data**: Retrieve the expression matrix and sample classifications.
2.  **Setup MIGSA**: Use the loaded data to create `MIGSA` input objects (like `GSEAparams`).
3.  **Run Analysis**: Execute `MIGSA` on the provided datasets to identify enriched Gene Ontology (BP, CC, MF) or KEGG pathways.
4.  **Compare**: Use `bcMigsaResAsList` to compare your new results against the package's pre-computed benchmarks.

## Reference documentation
- [MIGSAdata Reference Manual](./references/reference_manual.md)
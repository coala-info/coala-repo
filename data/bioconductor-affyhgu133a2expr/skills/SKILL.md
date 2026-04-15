---
name: bioconductor-affyhgu133a2expr
description: This package provides curated and normalized human gene expression data from the Affymetrix Human Genome U133A 2.0 Array. Use when user asks to retrieve normalized expression data for the GPL571 platform, perform Gene Set Context Analysis, or access pre-built gene expression profiles for meta-analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Affyhgu133A2Expr.html
---

# bioconductor-affyhgu133a2expr

name: bioconductor-affyhgu133a2expr
description: Access and utilize pre-built human gene expression profiles from the Affymetrix Human Genome U133A 2.0 Array (GPL571). Use this skill when needing to retrieve normalized (fRMA) and standardized (barcode approach) expression data for 12,494 genes across 313 samples for Gene Set Context Analysis (GSCA) or meta-analysis.

## Overview
The `Affyhgu133A2Expr` package provides a curated compendium of human gene expression data specifically for the GPL571 platform. The data is sourced from NCBI GEO, normalized using Frozen Robust Multiarray Analysis (fRMA), and standardized via the gene expression barcode approach. To optimize performance and storage, the expression matrix is stored in HDF5 format. This package is primarily intended to be used as a data source for the `GSCA` (Gene Set Context Analysis) package.

## Loading the Data
The package contains a reference table that describes the samples included in the compendium.

```r
# Load the library
library(Affyhgu133A2Expr)

# Load the reference table
data(Affyhgu133A2Exprtab)

# View the structure of the metadata
str(Affyhgu133A2Exprtab)
```

## Data Structure
The reference table `Affyhgu133A2Exprtab` contains three primary variables:
*   **SampleID**: The NCBI GEO GSM identifier.
*   **ExperimentID**: The GEO series ID.
*   **SampleType**: Manually verified biological context (cell type, tissue, or treatment condition).

## Usage with GSCA
While the expression values are stored in an HDF5 format to minimize file size, users typically do not interact with the raw matrix directly. Instead, this package serves as a backend for the `GSCA` package.

1.  **Integration**: When performing Gene Set Context Analysis, specify this package as the database source.
2.  **Scaling**: Note that the internal expression values are stored as integers (1000x the actual value) to save space; the `GSCA` package handles this scaling automatically.
3.  **Gene Mapping**: Each gene is uniquely matched to one row (the probeset with the largest coefficient of variation was retained where multiple probesets mapped to the same gene).

## Manual Data Inspection
If you need to inspect the sample metadata to filter for specific tissues or conditions before analysis:

```r
# Example: Find all samples related to a specific tissue
liver_samples <- Affyhgu133A2Exprtab[grep("liver", Affyhgu133A2Exprtab$SampleType, ignore.case = TRUE), ]

# View unique sample types available
unique(Affyhgu133A2Exprtab$SampleType)
```

## Reference documentation
- [Affyhgu133A2Expr Reference Manual](./references/reference_manual.md)
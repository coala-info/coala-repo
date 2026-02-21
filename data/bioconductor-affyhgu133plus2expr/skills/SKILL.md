---
name: bioconductor-affyhgu133plus2expr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Affyhgu133Plus2Expr.html
---

# bioconductor-affyhgu133plus2expr

name: bioconductor-affyhgu133plus2expr
description: Access and utilize the Affyhgu133Plus2Expr Bioconductor package, which provides a pre-built database of 5,153 human gene expression profiles from the Affymetrix Human Genome U133 Plus 2.0 Array (GPL570). Use this skill when needing to retrieve normalized (fRMA) and standardized (barcode) expression data for Gene Set Context Analysis (GSCA) or meta-analysis of human transcriptomes.

## Overview

The `Affyhgu133Plus2Expr` package is a specialized data package containing a large-scale compendium of human gene expression data. The data consists of 5,153 samples across 19,944 genes, sourced from NCBI GEO. All samples were processed consistently using Frozen Robust Multiarray Analysis (fRMA) and standardized via the gene expression barcode approach. The expression matrix is stored in HDF5 format to optimize storage and access speed.

## Data Access and Usage

### Loading Metadata
The package provides a reference table containing sample identifiers and biological contexts. This is the primary way to explore the available samples before performing analysis.

```r
library(Affyhgu133Plus2Expr)

# Load the reference table
data(Affyhgu133Plus2Exprtab)

# View the structure of the metadata
# Columns: SampleID (GSM ID), ExperimentID (GEO ID), SampleType (Cell/Tissue/Condition)
head(Affyhgu133Plus2Exprtab)
```

### Understanding the Data Structure
- **Format**: The expression values are stored in an HDF5 file within the package's `data` directory.
- **Scaling**: Values in the HDF5 matrix are multiplied by 1000 and stored as integers to reduce file size.
- **Dimensions**: 5,153 samples (rows) by 19,944 genes (columns).
- **Integration**: This package is specifically designed to be used as a backend for the `GSCA` (Gene Set Context Analysis) package.

### Integration with GSCA
While the data is stored in HDF5, users typically interact with it through the `GSCA` package rather than reading the HDF5 file directly.

```r
# Example of how this data is typically invoked in a GSCA workflow
# (Requires the GSCA package)
library(GSCA)

# The GSCA functions will internally reference the Affyhgu133Plus2Expr 
# data when the GPL570 platform is specified.
```

## Key Considerations
- **Gene Mapping**: Probesets corresponding to the same gene have been averaged so that each gene uniquely matches one row/column in the database.
- **Manual Verification**: The `SampleType` field has been manually verified based on GEO descriptions to ensure biological accuracy.
- **Storage**: Because the data is stored in HDF5 format via the `rhdf5` package, ensure that `rhdf5` is installed if attempting manual data extraction.

## Reference documentation

- [Affyhgu133Plus2Expr Reference Manual](./references/reference_manual.md)
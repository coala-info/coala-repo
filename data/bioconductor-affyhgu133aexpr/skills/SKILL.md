---
name: bioconductor-affyhgu133aexpr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Affyhgu133aExpr.html
---

# bioconductor-affyhgu133aexpr

name: bioconductor-affyhgu133aexpr
description: Access and utilize pre-built human gene expression profiles from the Affymetrix Human hgu133a Array (GPL96). Use this skill when needing to retrieve normalized, standardized expression data for over 11,000 human samples from NCBI GEO, specifically for Gene Set Context Analysis (GSCA) or cross-study comparisons.

## Overview

The `Affyhgu133aExpr` package provides a curated compendium of human gene expression data (GPL96 platform). The data consists of 11,778 samples and 12,495 genes. All samples were preprocessed using frozen Robust Multiarray Analysis (fRMA) and standardized via the gene expression barcode approach. 

Key features:
- Data is stored in HDF5 format for efficient access.
- Values are scaled by 1000 (stored as integers) to reduce file size.
- Includes a reference table (`Affyhgu133aExprtab`) mapping samples to GEO IDs and biological contexts.
- Designed primarily for use with the `GSCA` package.

## Loading and Inspecting Metadata

The package provides a reference table containing Sample IDs (GSM), Experiment IDs (GSE), and Sample Types (cell type/tissue/condition).

```r
# Load the package
library(Affyhgu133aExpr)

# Load the reference metadata table
data(Affyhgu133aExprtab)

# Inspect the structure
str(Affyhgu133aExprtab)

# View the first few entries
head(Affyhgu133aExprtab)

# Search for specific tissue types or conditions
subset(Affyhgu133aExprtab, SampleType == "liver")
```

## Accessing Expression Data

The expression matrix is stored in an HDF5 format within the package's `data` directory. While the package is optimized for the `GSCA` package, you can identify the location of the data file if manual inspection is required.

Note: The expression values are 1000 times the actual fRMA/barcode values. To get the original values, you must divide by 1000.

```r
# Locate the HDF5 data file path
system.file("data", "Affyhgu133aExpr.h5", package="Affyhgu133aExpr")
```

## Integration with GSCA

This package is a data provider for Gene Set Context Analysis. When using the `GSCA` package, you specify this database to perform analysis across the thousands of human samples provided here.

```r
# Typical workflow (requires GSCA package)
# library(GSCA)
# result <- GSCA(geneSet, "Affyhgu133aExpr")
```

## Usage Tips
- **Memory Efficiency**: Do not attempt to load the entire expression matrix into memory unless necessary; use the `rhdf5` package or `GSCA` workflows to query specific subsets.
- **Gene Mapping**: Each gene uniquely matches one row; for genes with multiple probesets, the one with the largest coefficient of variation was retained during package construction.
- **Sample Identification**: Use `Affyhgu133aExprtab` to filter for specific biological contexts before performing downstream analysis.

## Reference documentation
- [Affyhgu133aExpr Reference Manual](./references/reference_manual.md)
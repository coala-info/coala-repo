---
name: bioconductor-omicspcadata
description: This package provides integrated transcriptomic and epigenomic datasets for 28,770 transcription start site groups across multiple human cell lines. Use when user asks to access example CAGE and ChIP-seq data, load multi-assay datasets for OMICsPCA analysis, or explore regulatory landscapes across different cell types.
homepage: https://bioconductor.org/packages/release/data/experiment/html/OMICsPCAdata.html
---


# bioconductor-omicspcadata

## Overview

The `OMICsPCAdata` package is a Bioconductor experiment data package designed to support the `OMICsPCA` analysis framework. It provides high-resolution datasets encompassing transcriptomic (CAGE) and epigenomic (ChIP-seq for histone modifications) features. The data is structured around 28,770 GENCODE Transcription Start Site (TSS) groups, allowing for integrated analysis of gene expression and regulatory landscapes across multiple human cell lines.

## Data Loading and Exploration

To use the datasets, load the package and access the `assays` object.

```r
# Load the package
library(OMICsPCAdata)

# Load the data into the environment
data("assays")

# Check the available datasets within the assays list
names(assays)
# Expected: "CAGE", "H2az", "H3k9ac", "H3k4me1"
```

## Dataset Descriptions

The package contains four primary matrices where rows represent TSS groups and columns represent specific cell lines:

1.  **CAGE (Cap Analysis of Gene Expression):** Normalized read counts (tpm) for 31 cell lines.
2.  **H2az:** ChIP-seq peak intensities for 5 cell lines.
3.  **H3k9ac:** ChIP-seq peak intensities for 13 cell lines.
4.  **H3k4me1:** ChIP-seq peak intensities for 12 cell lines.

## Typical Workflow

### 1. Inspecting Data Structure
The datasets are typically stored as tibbles or matrices within the `assays` list.

```r
# View dimensions of the CAGE dataset
dim(assays$CAGE)

# Preview the first few rows and columns
head(assays$CAGE[, 1:5])
```

### 2. Preparing for OMICsPCA
These datasets are specifically formatted to be used as input for the `OMICsPCA` package. You can use them to test integration functions or dimensionality reduction techniques.

```r
# Example: Extracting a specific assay for analysis
cage_data <- assays$CAGE
h3k4me1_data <- assays$H3k4me1

# Note: Ensure row alignment if subsetting, 
# though these datasets are pre-aligned by TSS groups.
```

## Usage Tips
- **Row Alignment:** All four datasets in this package share the same 28,770 rows (GENCODE TSS groups), making them ideal for multi-assay integration without complex re-mapping.
- **Data Types:** CAGE data represents expression levels, while the Histone modification data (H2az, H3k9ac, H3k4me1) represents regulatory activity/chromatin states.
- **Cell Line Overlap:** Not all cell lines are present in every assay. Check column names to identify overlapping cell lines for integrative analysis (e.g., K562 and HepG2 are present in most).

## Reference documentation

- [OMICsPCAdata: Supporting data for package OMICsPCA](./references/vignettes.md)
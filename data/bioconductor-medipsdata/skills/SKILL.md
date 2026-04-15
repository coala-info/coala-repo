---
name: bioconductor-medipsdata
description: This package provides example MeDIP-seq and Input-seq datasets for DNA methylation analysis workflows in R. Use when user asks to access sample datasets for MEDIPS or QSEA packages, perform methylation analysis on hESC or NSCLC samples, or load hg19-aligned genomic data for chromosome 22.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MEDIPSData.html
---

# bioconductor-medipsdata

name: bioconductor-medipsdata
description: Access and use example MeDIP-seq and Input-seq data from the MEDIPSData package. This skill should be used when a user needs sample datasets for DNA methylation analysis using the MEDIPS or QSEA R packages, specifically involving human embryonic stem cells (hESCs), definitive endoderm (DE), or Non-Small Cell Lung Cancer (NSCLC) samples aligned to hg19.

## Overview

The `MEDIPSData` package is an experiment data package providing datasets for demonstrating DNA methylation analysis workflows in R. It contains MeDIP-seq (Methylated DNA Immunoprecipitation) and Input-seq (control) data. The data is primarily focused on human chromosome 22 (hg19) for stem cell differentiation studies, and chromosomes 20-22 for lung cancer (NSCLC) studies.

## Loading Data

To use the datasets, first load the library and then use the `data()` function:

```r
library(MEDIPSData)

# Load specific datasets
data(DE_MeDIP)    # MeDIP-seq from definitive endoderm
data(hESCs_MeDIP) # MeDIP-seq from human embryonic stem cells
data(CS)          # CpG coupling set for chr22
```

## Available Datasets

### MEDIPS Workflow Data (Chr 22, hg19)
These objects are typically used with the `MEDIPS` package:
- `DE_MeDIP` / `DE_Input`: MeDIP and Input sets for definitive endoderm.
- `hESCs_MeDIP` / `hESCs_Input`: MeDIP and Input sets for embryonic stem cells.
- `CS`: A CpG coupling set (window size 100bp) required for normalizing MEDIPS data.
- `resultTable`: A pre-calculated result table from `MEDIPS.meth()` comparing hESCs and DE.
- `mart_gene`: BioMart annotations for human genes on chromosome 22.

### QSEA Workflow Data (Chr 20-22, hg19)
These objects are designed for the `qsea` package:
- `NSCLC_dataset`: Contains `qseaSet` (MeDIP-seq from 3 NSCLC samples and normal tissue) and `qseaGLM` (test statistics).
- `samplesNSCLC`: Sample sheet/metadata for the NSCLC dataset.
- `tcga_luad_lusc_450kmeth`: Calibration data from TCGA for lung cancer analysis.
- `annotation`: Genomic annotations (ROIs, TFBS) for hg19 reference.

## Typical Workflows

### Using MEDIPS for Differential Methylation
```r
library(MEDIPS)
data(DE_MeDIP)
data(hESCs_MeDIP)
data(CS)

# Example: Selecting significant regions from the provided resultTable
data(resultTable)
sig_regions = MEDIPS.selectSig(results=resultTable, p.value=0.05, adj=TRUE)
```

### Using QSEA for Cancer Analysis
```r
library(qsea)
data(NSCLC_dataset)
data(samplesNSCLC)

# View the qseaSet object
qseaSet

# Access the GLM results
qseaGLM
```

## Tips
- **Genome Version**: All data in this package is aligned to **hg19**. Ensure any additional annotations or BSgenome objects used alongside this data match this version.
- **Object Classes**: Most objects are of class `MEDIPSset` (for MEDIPS) or `qseaSet`/`qseaGLM` (for QSEA). Use `class(object_name)` to verify.
- **Memory**: While these are subsetted datasets (specific chromosomes), loading multiple concatenated sets may still consume significant memory in a standard R session.

## Reference documentation
- [MEDIPSData Reference Manual](./references/reference_manual.md)
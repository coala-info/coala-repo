---
name: bioconductor-ngscopydata
description: This package provides subsetted BAM files from human lung tumor and pooled normal sequencing for testing copy number variation analysis. Use when user asks to retrieve sample BAM file paths, access chromosome 6 sequencing data for hg19, or provide example datasets for the NGScopy package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/NGScopyData.html
---

# bioconductor-ngscopydata

name: bioconductor-ngscopydata
description: Access and use the NGScopyData experiment data package, which provides subsetted BAM files from human lung tumor and pooled normal sequencing (Zhao et al. 2014). Use this skill when you need to retrieve file paths for sample BAM files (chr6, hg19) to demonstrate or test copy number variation (CNV) analysis, specifically for the NGScopy package.

# bioconductor-ngscopydata

## Overview
The `NGScopyData` package is a Bioconductor experiment data package. It provides a 10% random subsample of targeted panel sequencing data from human lung tumor and pooled normal samples, specifically restricted to chromosome 6 (hg19). This data is primarily intended for use with the `NGScopy` package to demonstrate copy number estimation workflows.

The package contains three primary datasets:
- **tps_27.chr6**: Tumor sample ID 27.
- **tps_90.chr6**: Tumor sample ID 90.
- **tps_N8.chr6**: A pooled normal sample (rescaled based on the number of samples in the pool).

## Installation
To use this data, the package must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("NGScopyData")
```

## Loading Data
Unlike standard data packages that use `data()`, `NGScopyData` uses accessor functions that return the absolute file paths to the BAM files and their corresponding indices (.bai) stored within the package installation directory.

### Retrieve BAM File Paths
Call the specific function for the sample you need. Each function returns a character vector containing the path to the sorted BAM file.

```r
library(NGScopyData)

# Get path for tumor sample 27
bam_27 <- tps_27.chr6()
print(bam_27)

# Get path for tumor sample 90
bam_90 <- tps_90.chr6()

# Get path for the pooled normal sample
bam_normal <- tps_N8.chr6()
```

## Typical Workflow with NGScopy
The primary use case for these files is to provide input for the `NGScopy` package functions.

```r
library(NGScopyData)
library(NGScopy)

# 1. Identify the file paths
t_bam <- tps_27.chr6()
n_bam <- tps_N8.chr6()

# 2. Use with NGScopy (example workflow)
# This typically involves processing the BAMs to count reads in bins
# and then estimating copy number ratios.
# Note: Since these are chr6 subsets, ensure your analysis is restricted to chr6.
```

## Data Specifications
- **Genome Build**: hg19 (GRCh37).
- **Region**: Chromosome 6 (chr6).
- **Sampling**: 10% random subsample of the original sequencing depth.
- **Format**: Sorted BAM files with associated index files in the same directory.

## Reference documentation
- [NGScopyData Reference Manual](./references/reference_manual.md)
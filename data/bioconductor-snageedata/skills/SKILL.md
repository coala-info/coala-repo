---
name: bioconductor-snageedata
description: This package provides gene-gene correlation matrices and gene lists for signal-to-noise analysis of gene expression data. Use when user asks to retrieve pre-calculated gene correlation data, access reference gene lists for SNAGEE, or load correlation matrices excluding specific platforms.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SNAGEEdata.html
---

# bioconductor-snageedata

name: bioconductor-snageedata
description: Access gene-gene correlation data and gene lists from the SNAGEEdata package. Use when performing signal-to-noise analysis on gene expression experiments (SNAGEE), retrieving pre-calculated gene correlation matrices, or identifying the specific gene sets used in SNAGEE calculations.

## Overview

SNAGEEdata is an experiment data package that provides the necessary gene-gene correlation matrices and gene lists for the SNAGEE (Signal-to-Noise applied to Gene Expression Experiments) package. It contains correlations calculated across a large number of platforms, which serve as a reference for evaluating the quality of gene expression studies.

## Installation

Install the package using BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SNAGEEdata")
```

## Core Functions and Usage

The package primarily provides the `getCC` function to retrieve the correlation data.

### Retrieving Correlation Data

Use `getCC()` to load the gene list and the correlation matrix.

```r
library(SNAGEEdata)

# Get the complete correlation data (calculated with all platforms)
data_complete <- getCC(mode = "complete")

# Get correlation data calculated without Affymetrix platforms
data_no_affy <- getCC(mode = "woAffy")
```

### Data Structure

The function returns a list containing two elements:
1. `g`: A vector of gene IDs (Entrez Gene IDs).
2. `cc`: A numeric vector representing the upper triangular part of the gene-gene correlation matrix.

### Accessing Specific Components

```r
# Extract the list of genes
gene_list <- data_complete$g

# Extract the correlation values
cor_values <- data_complete$cc

# Check the number of genes
num_genes <- length(gene_list)
```

## Typical Workflow

SNAGEEdata is typically used in conjunction with the `SNAGEE` package to calculate the signal-to-noise ratio of a new study.

```r
library(SNAGEE)
library(SNAGEEdata)

# 1. Load the reference data
ref_data <- getCC()

# 2. Use the data with a study (assuming 'my_study' is a matrix or ExpressionSet)
# sn_ratio <- snagee(my_study, reference = ref_data)
```

## Tips

- The `cc` element is stored as a vector (upper triangular part) to save memory. If you need a full matrix, you must reconstruct it based on the length of `g`.
- The `woAffy` mode is useful if you want to avoid potential biases introduced by Affymetrix platform-specific artifacts when analyzing Affymetrix data.

## Reference documentation

- [SNAGEEdata Reference Manual](./references/reference_manual.md)
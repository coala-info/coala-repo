---
name: bioconductor-ath1121501frmavecs
description: This package provides pre-computed parameter vectors for performing frozen Robust Multiarray Analysis (fRMA) on Affymetrix Arabidopsis ATH1 Genome Array data. Use when user asks to normalize Arabidopsis microarray data using fRMA, process ATH1-121501 CEL files individually, or perform meta-analysis on Arabidopsis gene expression datasets.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ath1121501frmavecs.html
---

# bioconductor-ath1121501frmavecs

## Overview

The `ath1121501frmavecs` package is a specialized data annotation package for Bioconductor. It provides the necessary parameter vectors (normalization distribution, probe effects, and variance estimates) to perform **frozen Robust Multiarray Analysis (fRMA)** on *Arabidopsis thaliana* microarray data. 

This package is specifically designed for the **Affymetrix Arabidopsis ATH1 Genome Array** (GEO platform **GPL198**), which uses the `ATH1-121501` CDF file. Using fRMA instead of standard RMA allows for the processing of samples individually or in small batches while maintaining consistency with a large training database, making it ideal for meta-analyses.

## Installation

To install the package and its dependencies:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ath1121501frmavecs")
# Required for execution
BiocManager::install(c("frma", "affy", "ath1121501.db"))
```

## Typical Workflow

### 1. Load Data and Vectors
Load the `affy` package to read CEL files and the `frma` package to perform the preprocessing.

```r
library(affy)
library(frma)
library(ath1121501frmavecs)

# Load CEL files into an AffyBatch object
# Ensure all CEL files are from the ATH1-121501 platform
cel_batch <- read.affybatch(filenames = c("sample1.CEL", "sample2.CEL"))

# Load the pre-computed vectors
data(ath1121501frmavecs)
```

### 2. Run fRMA Preprocessing
The `frma` function uses the vectors to normalize and summarize the probe-level data.

```r
# target="full" is standard for gene expression
cel_frma <- frma(
    object = cel_batch,
    target = "full",
    input.vec = ath1121501frmavecs
)

# Extract expression matrix (log2 scale)
expression_matrix <- exprs(cel_frma)
```

### 3. Annotation and Probe Selection
Since multiple probesets can map to the same AGI (Arabidopsis Gene Index) identifier, it is common practice to select the probeset with the highest average signal.

```r
library(ath1121501.db)

# Map Probeset IDs to TAIR/AGI identifiers
probeset_ids <- rownames(expression_matrix)
gene_mappings <- mapIds(
    ath1121501.db,
    keys = probeset_ids,
    column = "TAIR",
    keytype = "PROBEID"
)

# Example: Filter or aggregate data based on gene_mappings
```

## Tips and Best Practices

- **Platform Specificity**: This package ONLY works with the Affymetrix ATH1-121501 platform (GPL198). Do not use it for other Arabidopsis arrays (like the AG array).
- **Batch Independence**: fRMA allows you to process a single CEL file and get results that are comparable to a large database. You do not need to re-process your entire database when adding new samples.
- **Memory Efficiency**: Because fRMA processes samples using pre-computed vectors, it is significantly more memory-efficient than standard RMA when dealing with hundreds of samples.
- **Data Source**: If downloading from GEO using `GEOquery`, ensure you are retrieving the raw `.CEL.gz` files, as fRMA requires probe-level data, not pre-processed series matrices.

## Reference documentation

- [ath1121501frmavecs](./references/ath1121501frmavecs.md)
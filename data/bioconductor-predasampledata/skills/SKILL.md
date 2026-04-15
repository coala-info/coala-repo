---
name: bioconductor-predasampledata
description: This package provides sample datasets including gene expression and copy number data for testing and demonstrating the PREDA package workflows. Use when user asks to access example genomic data, load renal cell carcinoma datasets for position-related analysis, or test SODEGIR workflow functions.
homepage: https://bioconductor.org/packages/release/data/experiment/html/PREDAsampledata.html
---

# bioconductor-predasampledata

name: bioconductor-predasampledata
description: Access and utilize sample datasets for the PREDA (Position Related Data Analysis) package, including gene expression and copy number data from clear cell renal carcinoma (RCC). Use this skill when needing example data for genomic position-related analyses, SODEGIR (Significant Overlap of Differentially Expressed and Genomic Imbalanced Regions) workflows, or testing PREDA package functions.

## Overview
The `PREDAsampledata` package provides specialized data objects designed for use with the `PREDA` package. It contains raw and preprocessed data from clear cell renal carcinoma (RCC) studies, including AffyBatch objects, ExpressionSets, and specific `DataForPREDA` or `PREDAResults` objects. These datasets are essential for demonstrating the integration of gene expression profiles with genomic copy number alterations.

## Loading Data
All datasets in this package are loaded using the standard R `data()` function.

```r
library(PREDAsampledata)

# Load raw AffyBatch data
data(AffybatchRCC)

# Load preprocessed ExpressionSet
data(ExpressionSetRCC)

# Load specific objects formatted for PREDA analysis
data(SODEGIRGEDataForPREDA) # Gene Expression input
data(SODEGIRCNDataForPREDA) # Copy Number input
```

## Available Datasets

### Raw and Preprocessed Expression Data
- `AffybatchRCC`: Raw CEL file data (AffyBatch) for 12 RCC samples and 11 normal kidney samples.
- `ExpressionSetRCC`: Preprocessed data (justRMA) using standard Affymetrix CDFs.

### PREDA-Specific Input Objects
These objects are of class `DataForPREDA`, ready for genomic position-related analysis:
- `SODEGIRGEDataForPREDA`: Gene expression data formatted for SODEGIR analysis.
- `SODEGIRCNDataForPREDA`: Copy number data formatted for SODEGIR analysis.

### Analysis Results Objects
These objects contain results from previously executed PREDA/SODEGIR analyses, useful for practicing visualization or downstream filtering:
- `GEanalysisResults`: Results of differential expression analysis across genomic regions.
- `SODEGIRGEanalysisResults`: SODEGIR results for gene expression.
- `SODEGIRCNanalysisResults`: SODEGIR results for copy number data.

## Typical Workflow Example
To explore the structure of the sample data before running a PREDA analysis:

```r
library(PREDAsampledata)
library(PREDA)

# 1. Load the input data object
data(SODEGIRGEDataForPREDA)

# 2. Inspect the object structure
str(SODEGIRGEDataForPREDA)

# 3. Load corresponding results to see expected output format
data(SODEGIRGEanalysisResults)
str(SODEGIRGEanalysisResults)
```

## Tips
- The datasets are synchronized with GeneAnnot custom CDFs (version 2.2.0).
- Use `str()` or `show()` on the results objects (like `GEanalysisResults`) to understand the slots available in `PREDAResults` objects.
- These datasets are specifically designed to work with the workflows described in the `PREDA` package vignettes.

## Reference documentation
- [PREDAsampledata Reference Manual](./references/reference_manual.md)
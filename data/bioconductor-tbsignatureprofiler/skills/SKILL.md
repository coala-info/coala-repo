---
name: bioconductor-tbsignatureprofiler
description: This tool profiles and compares gene expression signatures for Tuberculosis and other diseases using various enrichment algorithms. Use when user asks to calculate signature scores, perform cross-validation, benchmark signature performance, or visualize results using heatmaps and AUC plots.
homepage: https://bioconductor.org/packages/release/bioc/html/TBSignatureProfiler.html
---

# bioconductor-tbsignatureprofiler

name: bioconductor-tbsignatureprofiler
description: Profiling and comparing gene expression signatures for Tuberculosis (TB) and other diseases. Use this skill to calculate signature scores using various algorithms (GSVA, ssGSEA, ASSIGN), perform cross-validation, and visualize results using heatmaps and AUC plots.

# bioconductor-tbsignatureprofiler

## Overview
The `TBSignatureProfiler` package is a comprehensive tool for evaluating gene expression signatures, primarily focused on Tuberculosis (TB). It aggregates over 75 published signatures and provides a unified framework to score these signatures against new datasets, typically stored as `SummarizedExperiment` objects. The package supports multiple enrichment methods and provides built-in tools for benchmarking signature performance via AUC bootstrapping and leave-one-out cross-validation (LOOCV).

## Core Workflow

### 1. Data Preparation
The package works best with `SummarizedExperiment` objects. It includes a utility function `mkAssay` to generate necessary data transformations like log-counts and CPM.

```r
library(TBSignatureProfiler)
library(SummarizedExperiment)

# Load example data (HIV/TB dataset)
hivtb_data <- get0("TB_hiv", envir = asNamespace("TBSignatureProfiler"))

# Create log, CPM, and log-CPM assays automatically
hivtb_data <- mkAssay(hivtb_data, log = TRUE, counts_to_CPM = TRUE)
```

### 2. Accessing Signatures
The package provides built-in signature lists and annotation data.
- `TBsignatures`: A list of 79+ TB signatures.
- `TBcommon`: Signatures with publication-given names.
- `sigAnnotData`: Metadata for the signatures (disease, tissue type).

```r
data("TBsignatures")
# View available signature names
names(TBsignatures)
```

### 3. Profiling and Scoring
Use `runTBSigProfiler` to calculate enrichment scores. Supported methods include "ssGSEA", "GSVA", "ASSIGN", "PLAGE", and "zscore".

```r
# Profile data using ssGSEA for all signatures
results <- runTBSigProfiler(hivtb_data, 
                            signatures = TBsignatures, 
                            algorithm = "ssGSEA", 
                            combine_Cl = FALSE)
```

### 4. Evaluation and Visualization
The package includes functions for statistical evaluation and plotting.

- **Heatmaps**: Visualize signature scores across samples.
- **AUC/ROC**: Evaluate diagnostic accuracy if ground truth labels are available in `colData`.
- **LOOCV**: Perform leave-one-out cross-validation to test signature robustness.

```r
# Example: Starting the interactive Shiny interface
# TBSPapp()
```

## Key Functions
- `mkAssay()`: Prepares data by adding log and CPM assays to a SummarizedExperiment.
- `runTBSigProfiler()`: The primary engine for scoring signatures.
- `compareSignatures()`: Compare multiple signatures against each other.
- `signatureBoxplot()`: Visualize score distributions across groups.
- `signatureHeatmap()`: Generate annotated heatmaps of signature scores.

## Tips for Success
- **Input Format**: Ensure your input is a `SummarizedExperiment`. If you have a matrix, convert it using `SummarizedExperiment(assays=list(counts=your_matrix))`.
- **Gene Symbols**: Ensure your row names match the gene symbols used in the signatures (usually HGNC symbols).
- **Algorithm Selection**: "ssGSEA" is a common default for single-sample enrichment, while "ASSIGN" is useful for pathway-specific profiling.

## Reference documentation
- [Introduction to the TBSignatureProfiler](./references/tbspVignetteT.md)
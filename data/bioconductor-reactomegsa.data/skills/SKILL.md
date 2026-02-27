---
name: bioconductor-reactomegsa.data
description: This package provides multi-omics datasets including RNA-seq, proteomics, and single-cell data for the ReactomeGSA analysis framework. Use when user asks to load example melanoma datasets, access pre-computed Reactome analysis results, or benchmark gene set analysis methods.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ReactomeGSA.data.html
---


# bioconductor-reactomegsa.data

## Overview
The `ReactomeGSA.data` package provides high-quality multi-omics datasets specifically formatted for use with the `ReactomeGSA` analysis framework. It contains real-world data from melanoma studies, including bulk RNA-seq, proteomics, and single-cell RNA-seq (scRNA-seq) data. These datasets are essential for benchmarking, tutorials, and testing the functional analysis capabilities of ReactomeGSA.

## Loading the Data
To use the datasets, first load the library. The data objects are then available as lazy-loaded datasets or can be explicitly loaded using `data()`.

```r
library(ReactomeGSA.data)

# List available datasets
data(package = "ReactomeGSA.data")
```

## Available Datasets

### 1. Proteomics Data (`griss_melanoma_proteomics`)
Intensity-based quantitation data from a B-cell melanoma induction study.
- **Format:** `EList` object (from the `limma` package).
- **Details:** 6456 rows (proteins) and 20 columns (samples). Normalization was performed at the PSM level.
- **Usage:**
  ```r
  data(griss_melanoma_proteomics)
  # Access expression values
  head(griss_melanoma_proteomics$E)
  ```

### 2. Bulk RNA-seq Data (`griss_melanoma_rnaseq`)
Raw read counts from the same B-cell melanoma induction study.
- **Format:** `DGEList` object (from the `edgeR` package).
- **Details:** 58237 rows (genes) and 16 columns (samples).
- **Usage:**
  ```r
  data(griss_melanoma_rnaseq)
  # Access counts
  head(griss_melanoma_rnaseq$counts)
  ```

### 3. Single-cell RNA-seq Data (`jerby_b_cells`)
B-cells extracted from a melanoma single-cell dataset.
- **Format:** `Seurat` object.
- **Details:** 23686 rows (genes) and 920 columns (cells).
- **Usage:**
  ```r
  data(jerby_b_cells)
  # Standard Seurat inspection
  Seurat::DimPlot(jerby_b_cells, reduction = "pca")
  ```

### 4. Pre-computed Results (`griss_melanoma_result`)
An example of a completed ReactomeGSA analysis.
- **Format:** `ReactomeAnalysisResult` object.
- **Usage:** Useful for testing visualization functions without running a full analysis.
  ```r
  data(griss_melanoma_result)
  # View result summary
  print(griss_melanoma_result)
  ```

## Typical Workflow with ReactomeGSA
These datasets are typically used to create a `ReactomeAnalysisRequest` in the main `ReactomeGSA` package.

```r
library(ReactomeGSA)
library(ReactomeGSA.data)

# Example: Creating a request using the proteomics data
data(griss_melanoma_proteomics)

# Create the request object
my_request <- ReactomeAnalysisRequest(method = "Camera")

# Add the dataset
my_request <- add_dataset(request = my_request, 
                          expression = griss_melanoma_proteomics, 
                          name = "Proteomics", 
                          type = "proteomics")
```

## Reference documentation
- [ReactomeGSA.data Reference Manual](./references/reference_manual.md)
---
name: bioconductor-bronchialil13
description: This package provides raw and pre-processed microarray data from a time-course experiment tracking the response of human bronchial cells to Interleukin-13. Use when user asks to access AffyBatch or ExpressionSet data for IL13-treated A549 cell lines, perform time-course analysis on bronchial cell gene expression, or practice differential expression workflows with provided experimental data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/bronchialIL13.html
---

# bioconductor-bronchialil13

## Overview
The `bronchialIL13` package is a Bioconductor ExperimentData package containing microarray data from a time-course experiment. It tracks the response of the human bronchial cell line A549 to Interleukin-13 (IL13). The data is provided in two primary formats: raw AffyBatch data and pre-processed ExpressionSet data.

## Data Structures
The package provides two main datasets:
- `HAH`: A `ReadAffy` object (AffyBatch) containing raw data from 15 CEL files.
- `HAHrma`: An `ExpressionSet` object derived from `HAH` using the Robust Multi-array Average (RMA) algorithm.

## Workflow and Usage

### Loading the Data
To use the data, you must first load the library and then use the `data()` function.

```r
library(bronchialIL13)

# Load the RMA-processed ExpressionSet
data(HAHrma)

# Load the raw AffyBatch data
data(HAH)
```

### Inspecting Metadata
The `HAHrma` object contains phenotypic data (phenoData) essential for differential expression analysis. Key variables include:
- `id`: Sample identifier.
- `trt`: Treatment status (e.g., control vs. IL13).
- `time`: Time point of the sample in hours.

```r
# View sample metadata
pData(HAHrma)

# Summarize the experimental design
table(HAHrma$time, HAHrma$trt)
```

### Accessing Expression Values
Since `HAHrma` is an `ExpressionSet`, you can use standard Biobase methods to extract data.

```r
# Get log2 expression matrix
exp_matrix <- exprs(HAHrma)

# Get feature (probe) information
fData(HAHrma)
```

## Analysis Tips
- **Time Course Analysis**: The data is structured for time-series modeling. Use the `time` and `trt` variables to identify genes responding to IL13 over the duration of the experiment.
- **Platform**: The data uses Affymetrix Human Genome U133 Plus 2.0 Array (U133a) chips. You may need the `hgu133a.db` annotation package for gene mapping.
- **Preprocessing**: While `HAHrma` is already normalized, you can perform your own normalization starting from the `HAH` AffyBatch object using the `affy` package.

## Reference documentation
- [bronchialIL13 Reference Manual](./references/reference_manual.md)
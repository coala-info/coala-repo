---
name: bioconductor-frmaexampledata
description: This package provides example AffyBatch datasets for testing and demonstrating frozen Robust Multi-array Analysis workflows. Use when user asks to access sample microarray data, practice preprocessing with frma or frmaTools, or load platform-specific datasets like HGU133a and HGU133plus2.
homepage: https://bioconductor.org/packages/release/data/experiment/html/frmaExampleData.html
---

# bioconductor-frmaexampledata

name: bioconductor-frmaexampledata
description: Access and use example AffyBatch datasets for the frma and frmaTools Bioconductor packages. Use this skill when needing sample microarray data (HGU133a, HGU133atag, HGU133plus2) to test or demonstrate frozen Robust Multi-array Analysis (fRMA) workflows.

# bioconductor-frmaexampledata

## Overview
The `frmaExampleData` package is a specialized data-experiment package for R/Bioconductor. It provides example `AffyBatch` objects specifically formatted for use with the `frma` (frozen Robust Multi-array Analysis) and `frmaTools` packages. These datasets allow users to practice preprocessing and analyzing microarray data without needing to download large external CEL files.

## Loading the Package and Data
To use the datasets, first load the library and then use the `data()` function to load the specific object into your R environment.

```r
# Load the package
library(frmaExampleData)

# Load a specific dataset (e.g., HGU133plus2)
data(AffyBatch133plus2)

# Inspect the object
print(AffyBatch133plus2)
```

## Available Datasets
The package contains four primary `AffyBatch` objects:

*   `AffyBatch133a`: Example data for the HGU133a platform, intended for use with `frmaTools`.
*   `AffyBatch133atag`: Example data for the HGU133atag platform, intended for use with `frmaTools`.
*   `AffyBatch133plus2`: Example data for the HGU133plus2 platform, intended for use with `frmaTools`.
*   `AffyBatchExample`: A general example `AffyBatch` intended for use with the main `frma` package examples.

## Typical Workflow
These datasets are typically used as inputs for the `frma` function to demonstrate how to apply frozen preprocessing vectors to new data.

```r
library(frma)
library(frmaExampleData)

# Load the general example data
data(AffyBatchExample)

# Run fRMA preprocessing
# Note: This requires the appropriate annotation and platform-specific vectors (e.g., hgu133aprobe)
expression_set <- frma(AffyBatchExample)

# View results
head(exprs(expression_set))
```

## Usage Tips
*   **Memory Management**: While these are "example" datasets, `AffyBatch` objects can still be memory-intensive. Use `rm(AffyBatchExample)` to clear them from the environment when finished.
*   **Platform Matching**: Ensure the dataset you choose matches the platform requirements of the `frma` workflow you are testing (e.g., use `AffyBatch133plus2` when testing HGU133 Plus 2.0 workflows).

## Reference documentation
- [Frma Example Data Reference Manual](./references/reference_manual.md)
---
name: bioconductor-flowfitexampledata
description: This package provides example flow cytometry datasets for testing and demonstrating the flowFit package. Use when user asks to access sample flowSet objects, practice cell proliferation analysis, or test fluorescence decay modeling in R.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/flowFitExampleData.html
---


# bioconductor-flowfitexampledata

name: bioconductor-flowfitexampledata
description: Access and load example flow cytometry datasets (PKH26data and QuahAndParish) for testing and demonstrating the flowFit package. Use this skill when a user needs sample flowSet objects to practice cell proliferation analysis, fluorescence decay modeling, or flow cytometry data transformation in R.

# bioconductor-flowfitexampledata

## Overview
The `flowFitExampleData` package is a data-only Bioconductor experiment package. It provides lightweight, pre-configured `flowSet` objects specifically designed for use with the `flowFit` package. These datasets allow users to test proliferation tracking algorithms and visualization tools without needing to provide their own raw FCS files.

## Installation
To use this data, the package must be installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("flowFitExampleData")
```

## Loading Data
The package contains two primary datasets: `PKH26data` and `QuahAndParish`.

```r
library(flowFitExampleData)

# Load the PKH26 dataset (2 experiments)
data(PKH26data)
print(PKH26data)

# Load the Quah and Parish dataset (4 experiments)
data(QuahAndParish)
print(QuahAndParish)
```

## Dataset Details

### PKH26data
- **Type**: `flowSet`
- **Experiments**: 2 (NONPROL.FCS and PROL.FCS)
- **Channels**: FSC-Height, SSC-Height, FL1-Height LOG, FL2-Height LOG.
- **Use Case**: Ideal for simple proliferation analysis using PKH26 dye.

### QuahAndParish
- **Type**: `flowSet`
- **Experiments**: 4 (Non-stimulated and Stimulated samples using different stains like CFSE, CPD, and CTV).
- **Channels**: Includes standard scatter (FSC/SSC) and multiple fluorescence channels (FITC, PE, APC, etc.).
- **Use Case**: Demonstrating multi-color flow cytometry and comparing different proliferation tracking dyes.

## Typical Workflow with flowFit
Once the data is loaded, it is typically passed to the `flowFit` package for modeling:

```r
library(flowFit)
# Example: Modeling the first sample in PKH26data
# Note: flowFit functions like 'proliferating' or 'fitModel' would be used here
parent_population <- PKH26data[[1]]
proliferating_population <- PKH26data[[2]]

# Users would then proceed with flowFit modeling steps
```

## Reference documentation
- [flowFitExampleData](./references/flowFitExampleData.md)
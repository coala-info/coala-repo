---
name: bioconductor-optimalflowdata
description: This package provides 40 simulated flow cytometry datasets and clinical metadata designed for testing and developing flow cytometry analysis algorithms. Use when user asks to access simulated Euroflow datasets, load cytometry data frames for benchmarking, or retrieve clinical diagnosis labels for healthy and cancer samples.
homepage: https://bioconductor.org/packages/release/data/experiment/html/optimalFlowData.html
---


# bioconductor-optimalflowdata

## Overview
The `optimalFlowData` package is a Bioconductor experiment data package providing 40 simulated flow cytometry datasets saved as data frames. These datasets mimic real-world measurements obtained via Euroflow protocols, representing 31 healthy individuals and 9 patients with various cancer types (e.g., CLL, MCL, FL, DLBCL). It is primarily designed to support the development and testing of the `optimalFlow` package.

## Installation
To install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("optimalFlowData")
```

## Typical Workflow

### 1. Loading Data
The datasets are named `Cytometry1` through `Cytometry40`. You can load the library and inspect a specific dataset directly:

```r
library(optimalFlowData)
# View the first few rows of a dataset
head(Cytometry1)
```

### 2. Understanding Data Structure
Each dataset is a data frame where:
- Columns represent markers (e.g., CD19, CD38, CD3, CD45, SSC-A).
- The last column (`Population ID (name)`) contains the gated cell type labels.
- Markers are typically transformed (LOGICAL or LINEAR scales).

### 3. Accessing Diagnosis Metadata
The package includes a vector `cytometry.diagnosis` that provides the clinical status for each of the 40 cytometries.

```r
# Check the diagnosis for all 40 samples
data("cytometry.diagnosis")
print(cytometry.diagnosis)

# Abbreviations include:
# HD: Healthy Donor
# MCL: Mantle Cell Lymphoma
# CLL: Chronic Lymphocytic Leukemia
# FL: Follicular Lymphoma
# HCL: Hairy Cell Leukemia
# LPL: Lymphoplasmacytic Lymphoma
# DLBCL: Diffuse Large B-cell Lymphoma
```

### 4. Building a Database for optimalFlow
A common use case is selecting a subset of cytometries to act as a "learning set" or database for the `optimalFlow` clustering and registration algorithms.

```r
# Example: Build a database using a subset of cytometries and specific cell populations
# Note: buildDatabase is a function from the 'optimalFlow' package
library(optimalFlow)
database <- buildDatabase(
  dataset_names = paste0('Cytometry', c(1:10)), 
  population_ids = c('Monocytes', 'Basophils', 'Neutrophils')
)
```

### 5. Visualization
You can visualize the distribution of cell populations in a subspace using standard R plotting functions:

```r
# Plotting CD3, CD38, and CD45 markers
# Assuming column 11 is the Population ID
pairs(Cytometry1[, c(3, 2, 5)], col = as.factor(Cytometry1[, 11]))
```

## Tips
- **Memory Management**: Since there are 40 data frames, loading all of them simultaneously can be memory-intensive. Load only the specific `CytometryX` objects required for your analysis.
- **Gating**: The data is already "gated" (labeled). If you are testing unsupervised clustering, you should remove the `Population ID` column before running your algorithm.

## Reference documentation
- [optimalFlowData: a data package for optimalFlow](./references/optimalFlowData_vignette.md)
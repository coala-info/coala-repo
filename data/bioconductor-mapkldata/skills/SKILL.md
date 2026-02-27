---
name: bioconductor-mapkldata
description: This package provides a breast cancer gene expression dataset from the Turashvili et al. study as a Bioconductor ExpressionSet object. Use when user asks to load the mAPKLData dataset, access breast cancer expression data for lobular and ductal carcinomas, or provide example data for the mAPKL package.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/mAPKLData.html
---


# bioconductor-mapkldata

## Overview
The `mAPKLData` package is a Bioconductor Experiment Data package. It contains a specific dataset from a study published by Turashvili et al. (2007) titled "Novel markers for differentiation of lobular and ductal invasive breast carcinomas." The data is provided as a standard Bioconductor `ExpressionSet` object, making it compatible with a wide range of bioinformatics analysis tools in R, particularly the `mAPKL` package for which it serves as the primary testing data.

The dataset includes:
- **Expression Data**: 54,675 features (Affymetrix hgu133plus2 technology).
- **Phenotype Data**: Clinical information for 30 samples, including normal ductal/lobular cells, IDC cells, and ILC cells.
- **Feature Metadata**: Affymetrix chip annotations.

## Loading the Data
To use the dataset, you must load the package and then use the `data()` function to bring the `mAPKLData` object into your environment.

```r
# Load the necessary libraries
library(Biobase)
library(mAPKLData)

# Load the dataset
data(mAPKLData)

# Inspect the object
mAPKLData
```

## Typical Workflows

### 1. Accessing Expression Values
The expression matrix contains the normalized intensity values for the probesets.

```r
# View the first 5 rows and columns
exprs(mAPKLData)[1:5, 1:5]
```

### 2. Accessing Clinical/Phenotype Data
The phenotype data (`pData`) contains the sample classifications (Normal vs. IDC vs. ILC) which are essential for differential expression analysis.

```r
# View the sample metadata
head(pData(mAPKLData))

# Check the distribution of sample types
table(pData(mAPKLData)$type) 
```

### 3. Feature and Experiment Metadata
You can retrieve the probe identifiers and general experiment information using standard `Biobase` methods.

```r
# Get the first 20 feature (probe) names
featureNames(mAPKLData)[1:20]

# View experiment summary
experimentData(mAPKLData)

# Check the annotation platform
annotation(mAPKLData)
```

## Usage Tips
- **Object Class**: The data is stored as an `ExpressionSet`. Ensure you have the `Biobase` package loaded to use accessor functions like `exprs()`, `pData()`, and `fData()`.
- **Downstream Analysis**: This package is specifically designed to be used with the `mAPKL` package (Hybrid Feature Selection and SVM Classification). You can pass `mAPKLData` directly into `mAPKL` functions to test feature selection algorithms.
- **Sample Groups**: The study focuses on the differences between Invasive Ductal Carcinoma (IDC) and Invasive Lobular Carcinoma (ILC). When setting up a contrast matrix or group comparison, refer to the `pData` columns to identify these histological types.

## Reference documentation
- [mAPKLData Reference Manual](./references/reference_manual.md)
---
name: bioconductor-hapmap500ksty
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/hapmap500ksty.html
---

# bioconductor-hapmap500ksty

name: bioconductor-hapmap500ksty
description: Access and use the hapmap500ksty experiment data package. Use this skill when you need to load sample Affymetrix 500K Sty SNP array data for demonstrating Bioconductor tools, testing genotyping algorithms, or practicing with the 'oligo' package.

# bioconductor-hapmap500ksty

## Overview
The `hapmap500ksty` package is a Bioconductor experiment data package containing sample CEL files from the HapMap project. Specifically, it provides data for the Affymetrix 500K Sty platform. This package is primarily intended for demonstration purposes, allowing users to test preprocessing and analysis workflows without needing to provide their own high-density oligonucleotide array data.

## Loading and Locating Data
The package does not contain processed R objects but rather the raw CEL files stored within the package installation directory.

```r
# Load the package
library(hapmap500ksty)

# Locate the directory containing the sample CEL files
cel_path <- system.file("celFiles", package="hapmap500ksty")

# List the available CEL files
library(oligo)
cels <- list.celfiles(path = cel_path, full.names = TRUE)
```

## Typical Workflow with 'oligo'
The most common use case for this package is to provide input for the `oligo` package to demonstrate data import and normalization.

```r
library(oligo)
library(hapmap500ksty)

# 1. Identify CEL files
cel_path <- system.file("celFiles", package="hapmap500ksty")
filenames <- list.celfiles(path = cel_path, full.names = TRUE)

# 2. Read CEL files into a FeatureSet object
# It is recommended to use a temporary directory for large data processing
temporaryDir <- tempdir()
rawData <- read.celfiles(filenames, tmpdir = temporaryDir)

# 3. Inspect the raw data object
show(rawData)

# 4. Example: Perform Robust Multichip Analysis (RMA)
# Note: This requires the appropriate annotation package (pd.hapmap.500k.sty)
# normalizedData <- rma(rawData)
```

## Usage Tips
- **Annotation Requirements**: To process this data (e.g., using `rma()` or `snprma()`), you must have the corresponding platform design package installed: `pd.hapmap.500k.sty`.
- **Demonstration Only**: This dataset is a subset of the full HapMap data. It is intended for code verification and tutorial purposes, not for biological inference.
- **Memory Management**: When using `read.celfiles`, the `tmpdir` argument is useful for managing memory on systems with limited RAM, as `oligo` can use disk-backed storage.

## Reference documentation
- [hapmap500ksty Reference Manual](./references/reference_manual.md)
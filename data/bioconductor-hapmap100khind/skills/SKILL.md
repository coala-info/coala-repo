---
name: bioconductor-hapmap100khind
description: This package provides sample CEL files from the HapMap Project for the Affymetrix 100K Hind SNP array platform. Use when user asks to load demonstration data for oligonucleotide array analysis, test Bioconductor tools like oligo, or access sample HapMap CEL files.
homepage: https://bioconductor.org/packages/release/data/experiment/html/hapmap100khind.html
---

# bioconductor-hapmap100khind

name: bioconductor-hapmap100khind
description: Access and use the hapmap100khind Bioconductor experiment data package. Use this skill when a user needs to load sample Affymetrix 100K Hind SNP array data for demonstration, testing, or benchmarking Bioconductor tools like 'oligo'.

# bioconductor-hapmap100khind

## Overview
The `hapmap100khind` package is a Bioconductor Experiment Data package containing sample CEL files from the HapMap Project. It specifically provides data for the Affymetrix 100K Hind platform. This package is primarily used as a lightweight dataset for demonstrating the functionality of oligonucleotide array analysis packages, such as `oligo`.

## Installation
To use this data, the package must be installed from Bioconductor:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hapmap100khind")
```

## Typical Workflow

### 1. Locating Sample Data
The package stores raw CEL files in a sub-directory. You can retrieve the file paths using `system.file`.

```r
library(hapmap100khind)
# Get the directory containing the CEL files
cel_path <- system.file("celFiles", package="hapmap100khind")

# List the available CEL files
cels <- list.files(cel_path, pattern = "\\.[cC][eE][lL]$")
print(cels)
```

### 2. Loading Data with 'oligo'
The most common use case is loading these files into an `FeatureSet` object for analysis.

```r
library(oligo)

# Get full paths to the CEL files
full_filenames <- list.celfiles(cel_path, full.names=TRUE)

# Read the CEL files
# Note: Using a temporary directory for large data processing if required
rawData <- read.celfiles(full_filenames)

# Inspect the object
show(rawData)
```

## Usage Tips
- **Purpose**: This is a demonstration dataset. Do not use it for biological inference; it is intended for software testing and workflow examples.
- **Platform**: This data is specific to the **100K Hind** chip. Ensure you have the corresponding annotation package (`pd.hapmap.100k.hind`) if performing downstream normalization or genotyping, though `oligo` usually handles this automatically.
- **Memory**: While this is a subset of data, always check `object.size(rawData)` when working with many CEL files in R.

## Reference documentation
- [hapmap100khind Reference Manual](./references/reference_manual.md)
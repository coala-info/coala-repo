---
name: bioconductor-hapmap100kxba
description: This package provides sample CEL files from the International HapMap Project for the Affymetrix 100K Xba platform. Use when user asks to access real-world SNP genotyping data for demonstration purposes, test Bioconductor microarray analysis tools, or load sample HapMap 100K Xba dataset files.
homepage: https://bioconductor.org/packages/release/data/experiment/html/hapmap100kxba.html
---


# bioconductor-hapmap100kxba

name: bioconductor-hapmap100kxba
description: Access and use the HapMap 100K Xba Affymetrix sample dataset. Use this skill when you need to demonstrate Bioconductor microarray analysis tools (like 'oligo') using real-world SNP genotyping data or when a user requires sample CEL files from the HapMap project for the 100K Xba platform.

# bioconductor-hapmap100kxba

## Overview
The `hapmap100kxba` package is a Bioconductor Experiment Data package containing sample dataset files from the International HapMap Project. Specifically, it provides CEL files for the Affymetrix 100K Xba platform. This package is primarily intended for demonstration purposes, allowing users to test and learn Bioconductor tools for SNP genotyping and copy number analysis without needing to provide their own raw data.

## Loading and Using Data
The package does not contain R objects directly; instead, it contains raw CEL files stored within the package installation directory. You must locate these files and then use a processing package like `oligo` to read them.

### Locating CEL Files
To find the path to the sample data:
```r
library(hapmap100kxba)
# Get the directory containing the CEL files
cel_path <- system.file("celFiles", package="hapmap100kxba")
# List the available CEL files
celfiles <- list.files(cel_path, pattern = "\\.[cC][eE][lL]$|\\.gz$", full.names = TRUE)
```

### Typical Workflow with 'oligo'
The most common use case is loading this data into an `FeatureSet` object for analysis:
```r
library(oligo)
library(hapmap100kxba)

# 1. Identify the file paths
cel_path <- system.file("celFiles", package="hapmap100kxba")
filenames <- list.celfiles(cel_path, full.names = TRUE)

# 2. Read the CEL files
# Note: This requires the appropriate annotation package (pd.mapping50k.xba240)
rawData <- read.celfiles(filenames)

# 3. Inspect the object
show(rawData)
```

## Tips
- **Annotation Requirements**: To process this data with `oligo`, you will likely need the platform-specific annotation package `pd.mapping50k.xba240`.
- **Purpose**: This data is for demonstration and software testing. The maintainers do not warrant the accuracy of the data for biological conclusions.
- **Memory Management**: When reading many CEL files, use the `tmpdir` argument in `read.celfiles` to manage disk-backed storage if memory is limited.

## Reference documentation
- [Package Manual](./references/reference_manual.md)
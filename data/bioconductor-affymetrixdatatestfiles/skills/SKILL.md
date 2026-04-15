---
name: bioconductor-affymetrixdatatestfiles
description: This package provides sample Affymetrix microarray data files in various formats for testing and development purposes. Use when user asks to access test CEL, CDF, or CHP files, verify Affymetrix file parsers, or benchmark microarray analysis workflows using Bioconductor.
homepage: https://bioconductor.org/packages/release/data/experiment/html/AffymetrixDataTestFiles.html
---

# bioconductor-affymetrixdatatestfiles

name: bioconductor-affymetrixdatatestfiles
description: Access and use Affymetrix test data files (CEL, CDF, CHP, EXP, PGF, PSI) from the AffymetrixDataTestFiles package. Use this skill when you need sample microarray data for testing Affymetrix file parsers, benchmarking Bioconductor packages like affy, oligo, or affxparser, or demonstrating microarray data analysis workflows.

# bioconductor-affymetrixdatatestfiles

## Overview

The `AffymetrixDataTestFiles` package is a specialized data-only package providing a variety of Affymetrix file formats (ASCII, XDA/Binary, and Calvin/HDF5). These files are sourced from the Affymetrix Fusion SDK and are intended for testing and development purposes. It does not contain analysis functions but provides the infrastructure to locate sample annotation and raw data files on your local system.

## Locating Data Files

The package organizes files into two main categories: `annotationData` (CDFs, PGFs, etc.) and `rawData` (CEL, CHP, EXP). Use `system.file` to retrieve the absolute paths to these directories.

### Root Directories
```r
library(AffymetrixDataTestFiles)

# Path to annotation files (CDFs, PGFs, PSI)
anno_path <- system.file("annotationData", package="AffymetrixDataTestFiles")

# Path to raw data files (CEL, CHP, EXP)
raw_path <- system.file("rawData", package="AffymetrixDataTestFiles")
```

### Specific File Access
Files are nested by chip type and format version (1.XDA, 2.Calvin, 3.ASCII).

```r
# Example: Locate a Calvin format CEL file for HG-Focus
cel_file <- system.file("rawData/FusionSDK_HG-Focus/HG-Focus/2.Calvin/HG-Focus-1-121502.CEL", 
                        package="AffymetrixDataTestFiles")

# Example: Locate an ASCII CDF file for Mapping10K_Xba131
cdf_file <- system.file("annotationData/chipTypes/Mapping10K_Xba131/3.ASCII/Mapping10K_Xba131.CDF", 
                        package="AffymetrixDataTestFiles")
```

## Common Workflows

### Testing File Parsers
Use these files to verify that a parser (like `affxparser`) can handle different generations of Affymetrix formats.

```r
library(affxparser)

# Identify a file
path <- system.file("rawData/FusionSDK_HG-Focus/HG-Focus/2.Calvin/HG-Focus-1-121502.CEL", 
                    package="AffymetrixDataTestFiles")

# Read header to verify format
hdr <- readCelHeader(path)
print(hdr$chiptype)
```

### Benchmarking with 'oligo' or 'affy'
You can use these files to create small `AffyBatch` or `FeatureSet` objects for quick code demonstrations.

```r
library(affy)

# Get directory containing ASCII CEL files
data_dir <- system.file("rawData/FusionSDK_HG-Focus/HG-Focus/3.ASCII", 
                        package="AffymetrixDataTestFiles")

# Read all CEL files in that directory
# Note: Requires corresponding CDF to be available in R environment
# data <- ReadAffy(celfile.path = data_dir)
```

## Directory Structure Reference

- **annotationData/chipTypes/**: Contains subdirectories for HG-Focus, HuGene-1_0-st-v1, Mapping10K_Xba131, and Test3.
- **rawData/**: Contains subdirectories for FusionSDK_HG-Focus, FusionSDK_HG-U133A, and FusionSDK_Test3.
- **Format Subfolders**:
    - `1.XDA/`: Binary format files.
    - `2.Calvin/`: Modern HDF5-based format.
    - `3.ASCII/`: Plain text format.

## Reference documentation

- [AffymetrixDataTestFiles Reference Manual](./references/reference_manual.md)
---
name: bioconductor-celeganscdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix C. elegans GeneChip. Use when user asks to map probe coordinates to indices, access chip dimensions, or process low-level C. elegans microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/celeganscdf.html
---

# bioconductor-celeganscdf

name: bioconductor-celeganscdf
description: A specialized skill for working with the Bioconductor annotation package 'celeganscdf'. Use this skill when analyzing Affymetrix C. elegans GeneChip data in R, specifically for mapping probe coordinates to indices, accessing CDF environment metadata, and managing chip dimensions.

# bioconductor-celeganscdf

## Overview
The `celeganscdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Caenorhabditis elegans (C. elegans) genome array. It provides the necessary mapping between probe identifiers and their physical locations on the microarray, which is essential for low-level processing of .CEL files using packages like `affy`.

## Core Components
The package provides three primary objects/functions:
- `celeganscdf`: An environment containing the mapping of probeset IDs to probe locations.
- `celegansdim`: An environment describing the physical dimensions of the chip.
- `i2xy` / `xy2i`: Utility functions to convert between 1D indices and 2D (x, y) coordinates.

## Usage and Workflows

### Loading the Package
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("celeganscdf")

library(celeganscdf)
```

### Coordinate Conversion
The chip uses a 712 x 712 grid (506,944 total points). Use these functions to translate between CEL file coordinates and AffyBatch indices.

```r
# Convert (x, y) coordinates to a single index
# x and y range from 1 to 712
index <- xy2i(x = 5, y = 5)

# Convert a single index back to (x, y) coordinates
# i ranges from 1 to 506944
coords <- i2xy(index)
# Returns a matrix with columns "x" and "y"
```

### Accessing Chip Metadata
You can inspect the dimensions or the CDF structure directly:

```r
# View dimensions
ls(celegansdim)

# Access the CDF environment
# This is typically used internally by affy functions like rma() or mas5()
# but can be queried manually:
as.list(celeganscdf)[1:5]
```

## Integration with affy
This package is automatically called by the `affy` package when loading C. elegans data. If you have an `AffyBatch` object named `data`, R will look for this package to correctly interpret the probe intensities.

```r
library(affy)
# If 'data' is an AffyBatch object for C. elegans
# The cdfname will be set to "celegans"
# R will automatically load celeganscdf to process it
```

## Reference documentation
- [celeganscdf Reference Manual](./references/reference_manual.md)
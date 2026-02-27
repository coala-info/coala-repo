---
name: bioconductor-cottoncdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Cotton Genome Array. Use when user asks to map CEL file coordinates to indices, process raw cotton expression data, or load the CDF environment for AffyBatch objects.
homepage: https://bioconductor.org/packages/release/data/annotation/html/cottoncdf.html
---


# bioconductor-cottoncdf

name: bioconductor-cottoncdf
description: Provides specialized environment data and coordinate mapping for the Affymetrix Cotton Genome Array. Use when working with Bioconductor's cottoncdf package to map CEL file (x,y) coordinates to indices, or when requiring the CDF environment for AffyBatch objects in cotton gene expression analysis.

# bioconductor-cottoncdf

## Overview
The `cottoncdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix Cotton Genome Array. It is primarily used in conjunction with the `affy` package to process raw expression data (CEL files) from cotton samples. It includes mapping functions to convert between spatial coordinates on the chip and the single-number indices used in R.

## Installation and Loading
To use this package, it must be installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("cottoncdf")
library(cottoncdf)
```

## Core Environments
The package loads two primary environments into the R session:
- `cottoncdf`: The environment describing the CDF file structure.
- `cottondim`: The environment describing the dimensions of the cotton chip (732 x 732).

## Coordinate Mapping (i2xy)
The package provides utility functions to convert between the 2D grid of the physical chip and the 1D indices used in Bioconductor's `AffyBatch` objects.

### Convert (x,y) to Index
To find the index `i` for a specific set of coordinates:
```r
# Example for coordinates x=5, y=5
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
To find the spatial coordinates for a given index:
```r
# Example for index 100
coords <- i2xy(100)
# Returns a matrix with columns "x" and "y"
```

### Validation Example
```r
# Create a range of indices
i <- 1:(732*732)
# Convert to coordinates
coord <- i2xy(i)
# Convert back to indices
j <- xy2i(coord[, "x"], coord[, "y"])
# Verify consistency
stopifnot(all(i == j))
```

## Usage in Workflows
This package is typically not called directly by the user for high-level analysis but is required by the `affy` package. When you load an `AffyBatch` object containing cotton array data, `affy` will automatically search for `cottoncdf`.

```r
library(affy)
# If you have CEL files in the working directory
# data <- ReadAffy() 
# The 'data' object will automatically use cottoncdf for mapping probes
```

## Reference documentation
- [cottoncdf Reference Manual](./references/reference_manual.md)
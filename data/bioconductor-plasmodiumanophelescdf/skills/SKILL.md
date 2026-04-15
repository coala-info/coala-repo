---
name: bioconductor-plasmodiumanophelescdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Plasmodium/Anopheles Genome Array. Use when user asks to map probe intensities to probe sets, convert between microarray coordinates and indices, or process Affymetrix CEL files for malaria research.
homepage: https://bioconductor.org/packages/release/data/annotation/html/plasmodiumanophelescdf.html
---

# bioconductor-plasmodiumanophelescdf

name: bioconductor-plasmodiumanophelescdf
description: Provides specialized environment data and coordinate mapping functions for the Plasmodium/Anopheles Genome Array. Use this skill when working with Affymetrix CEL files or AffyBatch objects specifically for Plasmodium falciparum and Anopheles gambiae malaria research in R.

# bioconductor-plasmodiumanophelescdf

## Overview
The `plasmodiumanophelescdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Plasmodium/Anopheles Genome Array. It is primarily used to map probe intensities from CEL files to their respective probe sets and to handle the spatial dimensions of the microarray.

## Installation and Loading
To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("plasmodiumanophelescdf")
library(plasmodiumanophelescdf)
```

## Core Functions and Usage

### Coordinate Mapping
The package provides utility functions to convert between the 2D (x, y) coordinates on the microarray chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinates: 1 to 712
- Y-coordinates: 1 to 712
- Total Indices: 1 to 506,944

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### Accessing CDF Data
The package exposes two main environments:

1.  `plasmodiumanophelescdf`: The main environment containing the mapping between probe sets and probe indices.
2.  `plasmodiumanophelesdim`: Contains the dimensions of the array (712 x 712).

To view the contents or structure:
```r
# List probe sets in the CDF
ls(plasmodiumanophelescdf)[1:10]

# Get dimensions
as.list(plasmodiumanophelesdim)
```

## Typical Workflow
This package is usually not called directly by the user but is loaded automatically by higher-level packages like `affy` when processing Plasmodium/Anopheles array data.

```r
library(affy)
# When reading CEL files, 'affy' detects the chip type 
# and looks for this CDF package
data <- ReadAffy() 

# The 'data' object will now use the mappings 
# provided by plasmodiumanophelescdf
```

## Reference documentation
- [plasmodiumanophelescdf Reference Manual](./references/reference_manual.md)
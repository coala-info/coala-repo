---
name: bioconductor-xtropicaliscdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Xenopus tropicalis Affymetrix microarray. Use when user asks to map (x,y)-coordinates to probe indices, access the CDF environment for Xenopus tropicalis, or handle spatial dimensions for this specific Affymetrix chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/xtropicaliscdf.html
---

# bioconductor-xtropicaliscdf

name: bioconductor-xtropicaliscdf
description: A specialized skill for working with the Bioconductor R package 'xtropicaliscdf'. Use this skill when you need to map (x,y)-coordinates to indices for the Xenopus tropicalis Affymetrix chip, or when accessing the CDF (Chip Definition File) environment for this platform.

# bioconductor-xtropicaliscdf

## Overview
The `xtropicaliscdf` package is an annotation data package providing the Chip Definition File (CDF) environment for the Xenopus tropicalis Affymetrix microarray. It is primarily used to map probe intensities from CEL files to their respective probe sets and to handle the spatial dimensions of the array.

## Installation
To use this package, it must be installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("xtropicaliscdf")
```

## Core Functions and Usage

### Coordinate Mapping
The package provides utilities to convert between 2D chip coordinates (x, y) and 1D indices (i) used in `AffyBatch` objects. The chip dimensions are 1164 x 1164.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

```r
library(xtropicaliscdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### CDF Environments
The package exposes two main environments:
- `xtropicaliscdf`: The main environment containing the mapping of probe sets to probe locations.
- `xtropicalisdim`: An environment describing the dimensions of the CDF file.

```r
# Accessing the environment
ls(xtropicaliscdf)[1:10] # List first 10 probe sets

# Get dimensions
ls(xtropicalisdim)
```

## Typical Workflow
When working with `affy` and Xenopus tropicalis data, this package is often loaded automatically by functions like `ReadAffy()`. However, manual coordinate mapping is useful for spatial analysis of chip artifacts:

```r
library(affy)
library(xtropicaliscdf)

# Example: Checking coordinate ranges
all_indices <- 1:(1164 * 1164)
coords <- i2xy(all_indices)
range(coords[, "x"]) # 1 to 1164
range(coords[, "y"]) # 1 to 1164
```

## Reference documentation
- [xtropicaliscdf Reference Manual](./references/reference_manual.md)
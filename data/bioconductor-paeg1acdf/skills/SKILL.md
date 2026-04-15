---
name: bioconductor-paeg1acdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Pseudomonas aeruginosa PAO1 Affymetrix GeneChip. Use when user asks to map (x,y)-coordinates to single-number indices, access the CDF environment, or determine chip dimensions for the paeg1a platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/paeg1acdf.html
---

# bioconductor-paeg1acdf

name: bioconductor-paeg1acdf
description: A specialized skill for working with the Bioconductor annotation package 'paeg1acdf'. Use this skill when you need to map (x,y)-coordinates to single-number indices for the Pseudomonas aeruginosa PAO1 Affymetrix GeneChip (paeg1a) or access its CDF environment and dimensions.

# bioconductor-paeg1acdf

## Overview
The `paeg1acdf` package is a Bioconductor annotation interface for the Affymetrix Pseudomonas aeruginosa PAO1 genome array. Its primary purpose is to provide the Chip Definition File (CDF) environment, which maps probe identifiers to their physical locations on the chip. It includes utility functions for converting between 2D chip coordinates and the 1D indices used in `AffyBatch` objects.

## Installation and Loading
To use this package in R, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("paeg1acdf")
library(paeg1acdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides two main functions to translate between the (x,y) grid of the CEL file and the linear indexing used in R's AffyBatch objects. The chip dimensions for `paeg1a` are 403 x 403.

- `xy2i(x, y)`: Converts x and y coordinates (1 to 403) into a single-number index (1 to 162,409).
- `i2xy(i)`: Converts a single-number index back into a matrix containing "x" and "y" columns.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# coords["x"] should be 5, coords["y"] should be 5
```

### CDF Environments
The package exposes two environment objects used by other Bioconductor tools (like `affy`):

- `paeg1acdf`: The main environment describing the CDF mapping.
- `paeg1adim`: An environment containing the dimensions of the chip.

## Typical Workflow
This package is rarely used standalone; it is typically called automatically by the `affy` package when processing `.CEL` files from the `paeg1a` platform.

```r
library(affy)
# If you have .CEL files in the working directory
# data <- ReadAffy() 
# The 'affy' package will look for 'paeg1acdf' to interpret the probe locations.
```

## Reference documentation
- [paeg1acdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-vitisviniferacdf
description: This package provides the Chip Definition File environment for the Affymetrix Vitis vinifera platform. Use when user asks to map probe coordinates to indices, access chip dimensions, or process Affymetrix grape transcriptomics data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/vitisviniferacdf.html
---

# bioconductor-vitisviniferacdf

name: bioconductor-vitisviniferacdf
description: Provides specialized knowledge for the vitisviniferacdf Bioconductor package. Use this skill when working with Affymetrix Vitis vinifera (Grape) chip data in R, specifically for mapping (x,y)-coordinates to probe indices and accessing the Chip Definition File (CDF) environment.

# bioconductor-vitisviniferacdf

## Overview
The `vitisviniferacdf` package is an annotation package containing the Chip Definition File (CDF) environment for the Affymetrix Vitis vinifera platform. It is primarily used in transcriptomics workflows to map probe intensities from CEL files to their respective probe sets.

## Installation and Loading
To use this package in an R session:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("vitisviniferacdf")
library(vitisviniferacdf)
```

## Core Environments
The package provides two main environments:
- `vitisviniferacdf`: The main environment describing the CDF file structure.
- `vitisviniferadim`: Contains the dimensions of the chip (732 x 732).

## Coordinate Mapping
The package includes utility functions to convert between 2D chip coordinates and 1D indices used in `AffyBatch` objects.

### Convert (x,y) to Index
To convert a specific x and y coordinate to a single-number index:
```R
# Example for coordinates x=5, y=5
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
To convert a single-number index back into its (x,y) coordinates:
```R
# Example for index 100
coords <- i2xy(100)
# Returns a matrix with "x" and "y" columns
```

## Usage Tips
- **Chip Dimensions**: The chip is a square grid ranging from 1 to 732 for both x and y coordinates.
- **Index Range**: The single-number indices range from 1 to 535,824 (732 * 732).
- **Integration**: This package is typically used automatically by higher-level packages like `affy`. When you load a CEL file from a Vitis vinifera chip, `affy` looks for this package to correctly interpret the probe locations.

## Reference documentation
- [vitisviniferacdf Reference Manual](./references/reference_manual.md)
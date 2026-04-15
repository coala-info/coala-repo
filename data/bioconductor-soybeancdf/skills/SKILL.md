---
name: bioconductor-soybeancdf
description: This package provides the Chip Definition File environment for mapping Affymetrix soybean microarray probe identifiers to their physical chip coordinates. Use when user asks to map probe sets to locations, convert between (x,y) coordinates and indices, or access the CDF environment for soybean expression data analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/soybeancdf.html
---

# bioconductor-soybeancdf

name: bioconductor-soybeancdf
description: A specialized skill for working with the Bioconductor annotation package 'soybeancdf'. Use this skill when you need to map Affymetrix probe identifiers to their physical locations on a soybean genome chip, convert between (x,y) coordinates and index positions, or access the CDF environment for soybean microarray data analysis.

# bioconductor-soybeancdf

## Overview
The `soybeancdf` package is a Bioconductor annotation resource containing the Chip Definition File (CDF) environment for soybean Affymetrix microarrays. It provides the mapping between probe set identifiers and their specific (x,y) coordinates on the chip, which is essential for low-level preprocessing and quality control of soybean expression data.

## Core Functions and Usage

### Loading the Package
To use the CDF environment, load the library in R:
```R
library(soybeancdf)
```

### Coordinate Conversion
The package provides utility functions to convert between the 2D grid coordinates (x,y) used in CEL files and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X and Y coordinates range from 1 to 1164.
- Single-number indices range from 1 to 1,354,896.

### Accessing CDF Data
The package exposes two main environments:
1. `soybeancdf`: The environment mapping probe sets to their locations.
2. `soybeandim`: The environment describing the dimensions of the soybean chip.

### Example Workflow
```R
library(soybeancdf)

# Convert a specific coordinate to an index
idx <- xy2i(5, 5)

# Convert the index back to coordinates
coords <- i2xy(idx)
# coords will be a matrix with columns "x" and "y"

# Verify dimensions
ls(soybeancdf)[1:10] # List first 10 probe sets
```

## Tips
- This package is typically used as a dependency by higher-level analysis packages like `affy`. You rarely need to call these functions manually unless performing custom spatial analysis or low-level probe-level modeling.
- Ensure your `AffyBatch` object's `cdfname` matches "soybean" for this package to be utilized automatically by Bioconductor tools.

## Reference documentation
- [soybeancdf Reference Manual](./references/reference_manual.md)
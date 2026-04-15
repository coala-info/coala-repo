---
name: bioconductor-hu6800subbcdf
description: This package provides the Chip Definition File environment for the Affymetrix Hu6800subB array to map probe coordinates and structural information. Use when user asks to map probe coordinates to indices, access CDF environment data, or determine chip dimensions for the Hu6800subB array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu6800subbcdf.html
---

# bioconductor-hu6800subbcdf

name: bioconductor-hu6800subbcdf
description: A specialized skill for working with the hu6800subbcdf Bioconductor annotation package. Use this skill when you need to map probe coordinates to indices, access CDF environment data, or determine chip dimensions for the Hu6800subB Affymetrix array.

# bioconductor-hu6800subbcdf

## Overview
The `hu6800subbcdf` package is a Bioconductor annotation data package providing the Chip Definition File (CDF) environment for the Affymetrix Hu6800subB array. It is primarily used to map between (x, y) coordinates on the chip and the single-number indices used in `AffyBatch` objects, and to provide structural information about the probe sets.

## Package Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hu6800subbcdf")
library(hu6800subbcdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between 2D chip coordinates and 1D indices. The array dimensions are 276 x 276 (total 76,176 indices).

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices to coordinates
coords <- i2xy(1:100)
# Returns a matrix with columns "x" and "y"
```

### CDF Environments
The package exposes two main environments:

1.  `hu6800subbcdf`: The main environment containing the mapping of probe sets to their respective indices.
2.  `hu6800subbdim`: An environment containing the dimensions of the chip.

**Example: Accessing Dimensions**
```r
# View dimension information
ls(hu6800subbdim)
# Typically used internally by affy functions to determine array boundaries
```

## Typical Workflow
This package is usually a dependency for the `affy` package. When you load a CEL file corresponding to a Hu6800subB chip, `affy` will automatically look for this package to correctly interpret the probe locations.

Manual interaction is typically limited to:
1. Validating probe locations during quality control.
2. Customizing probe-set definitions by extracting data directly from the `hu6800subbcdf` environment.
3. Visualizing spatial artifacts on the chip using coordinates.

## Reference documentation
- [hu6800subbcdf Reference Manual](./references/reference_manual.md)
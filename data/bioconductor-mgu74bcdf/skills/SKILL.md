---
name: bioconductor-mgu74bcdf
description: This package provides the Chip Definition File environment and coordinate mapping data for the Affymetrix Mouse Genome U74B microarray. Use when user asks to map probe intensities to probe sets, convert between (x,y) coordinates and indices, or access chip dimensions for MG-U74B expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74bcdf.html
---

# bioconductor-mgu74bcdf

name: bioconductor-mgu74bcdf
description: Provides specialized mapping and environment data for the Affymetrix Mouse Genome U74B chip. Use this skill when working with the mgu74bcdf R package to convert between (x,y) coordinates and single-number indices on the microarray, or when accessing the CDF environment and chip dimensions for MG-U74B expression data.

# bioconductor-mgu74bcdf

## Overview
The `mgu74bcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Mouse Genome U74B array. It is primarily used in the analysis of AffyBatch objects to map probe intensities to their respective probe sets.

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to translate between the 2D (x,y) grid of the CEL file and the 1D indices used in R's `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

The MG-U74B chip has dimensions of 640 x 640, resulting in 409,600 total indices.

```r
library(mgu74bcdf)

# Convert specific coordinates to an index
index <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(index)
# Returns a matrix with "x" and "y" columns
```

### Accessing CDF Data
The package exposes two main environments:
- `mgu74bcdf`: The main environment containing the mapping of probe sets to probe locations.
- `mgu74bdim`: An environment containing the dimensions of the chip.

```r
# View chip dimensions
as.list(mgu74bdim)

# List probe sets (first 10)
ls(mgu74bcdf)[1:10]

# Get probe locations for a specific probe set
get("1000_at", envir = mgu74bcdf)
```

## Typical Workflow
1. **Loading**: Load the library alongside `affy` to ensure the `AffyBatch` object can automatically locate the annotation.
2. **Verification**: Use `mgu74bdim` to verify the expected grid size (640x640).
3. **Manual Mapping**: Use `i2xy` or `xy2i` when performing custom quality control or spatial analysis on the raw probe intensities.

## Reference documentation
- [mgu74bcdf Reference Manual](./references/reference_manual.md)
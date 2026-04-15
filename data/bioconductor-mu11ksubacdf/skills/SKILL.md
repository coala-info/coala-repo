---
name: bioconductor-mu11ksubacdf
description: This package provides the CDF environment mapping and coordinate conversion functions for the Affymetrix Mu11KsubA microarray chip. Use when user asks to map probe coordinates to indices, access chip dimensions, or work with Mu11KsubA chip metadata in murine genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu11ksubacdf.html
---

# bioconductor-mu11ksubacdf

name: bioconductor-mu11ksubacdf
description: A specialized skill for working with the mu11ksubacdf Bioconductor annotation package. Use this skill when you need to map probe coordinates to indices for the Affymetrix Mu11KsubA chip, access CDF environment data, or determine chip dimensions for murine genomic studies.

# bioconductor-mu11ksubacdf

## Overview
The `mu11ksubacdf` package is a Bioconductor annotation interface for the Affymetrix Mu11KsubA chip. It provides the environment mapping between probe identifiers and their physical locations on the microarray. This package is primarily used in low-level analysis of CEL files and AffyBatch objects where coordinate-to-index conversion is required.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mu11ksubacdf")
library(mu11ksubacdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to convert between (x,y) grid coordinates and single-number indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Parameters:**
- `x`: Numeric x-coordinate (range: 1 to 534).
- `y`: Numeric y-coordinate (range: 1 to 534).
- `i`: Numeric single-number index (range: 1 to 285156).

### Accessing Chip Metadata
The package exposes two main environments:
- `mu11ksubacdf`: The environment containing the CDF file mapping.
- `mu11ksubadim`: The environment describing the dimensions of the Mu11KsubA chip.

## Typical Workflow Example

```r
library(mu11ksubacdf)

# 1. Convert a specific coordinate to an index
idx <- xy2i(5, 5)
print(idx)

# 2. Convert a range of indices to coordinates
indices <- 1:10
coords <- i2xy(indices)
# Returns a matrix with "x" and "y" columns
print(coords)

# 3. Verify dimensions
# The chip is 534 x 534
max_idx <- 534 * 534
print(max_idx) # 285156
```

## Tips
- The coordinate system is 1-based, consistent with R indexing.
- This package is often called internally by other Bioconductor packages like `affy`. You only need to call these functions directly if you are performing custom probe-level analysis or visualization.

## Reference documentation
- [mu11ksubacdf Reference Manual](./references/reference_manual.md)
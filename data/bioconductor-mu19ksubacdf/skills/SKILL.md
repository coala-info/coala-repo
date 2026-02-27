---
name: bioconductor-mu19ksubacdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix Mu19KsubA microarray platform. Use when user asks to map probe coordinates to indices, convert linear indices to spatial coordinates, or access the CDF environment for the Mu19KsubA chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu19ksubacdf.html
---


# bioconductor-mu19ksubacdf

name: bioconductor-mu19ksubacdf
description: A specialized skill for working with the mu19ksubacdf Bioconductor annotation package. Use this skill when you need to map probe coordinates to indices or access the CDF environment for the Affymetrix Mu19KsubA chip.

# bioconductor-mu19ksubacdf

## Overview
The `mu19ksubacdf` package is a Bioconductor annotation resource providing the Chip Definition File (CDF) environment for the Affymetrix Mu19KsubA platform. It is primarily used to map between (x, y) coordinates on the microarray chip and the single-number indices used in `AffyBatch` objects and CDF environments.

## Usage and Workflows

### Loading the Package
To use the environments and functions, load the library in R:
```r
library(mu19ksubacdf)
```

### Coordinate Mapping
The package provides two primary functions for converting between spatial coordinates and linear indices. The chip dimensions for this platform are 534 x 534 (totaling 285,156 indices).

#### Convert (x, y) to Index
Use `xy2i(x, y)` to get the linear index for specific coordinates:
```r
# Get index for x=5, y=5
idx <- xy2i(5, 5)
```

#### Convert Index to (x, y)
Use `i2xy(i)` to get the spatial coordinates for a given index:
```r
# Get coordinates for index 1000
coords <- i2xy(1000)
# Access x and y
x_val <- coords[, "x"]
y_val <- coords[, "y"]
```

### Accessing CDF Data
The package exposes two main environments:
- `mu19ksubacdf`: The environment containing the mapping of probesets to probe locations.
- `mu19ksubadim`: The environment describing the dimensions of the CDF file.

Example of checking dimensions:
```r
# View dimension information
as.list(mu19ksubadim)
```

## Typical Validation Workflow
When working with probe indices, you can verify the integrity of the mapping using the following pattern:
```r
# Create a range of indices
i <- 1:285156
# Convert to coordinates and back
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
# Verify equality
stopifnot(all(i == j))
```

## Reference documentation
- [mu19ksubacdf Reference Manual](./references/reference_manual.md)
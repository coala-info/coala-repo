---
name: bioconductor-cyp450cdf
description: This package provides the Chip Definition File (CDF) environments and coordinate mapping for the cyp450 Affymetrix microarray platform. Use when user asks to load cyp450 chip definitions, map probe coordinates to indices, or process raw Affymetrix data for the cyp450 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/cyp450cdf.html
---

# bioconductor-cyp450cdf

## Overview
The `cyp450cdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environments for the cyp450 Affymetrix platform. It is primarily used by other Bioconductor packages like `affy` to process raw expression data. It provides mapping between the physical (x,y) coordinates on the microarray and the single-number indices used in `AffyBatch` objects.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically by high-level analysis functions, but can be invoked manually:
```r
library(cyp450cdf)
```

### Accessing CDF Environments
The package provides two main environments:
- `cyp450cdf`: Contains the mapping of probe sets to probe indices.
- `cyp450dim`: Contains the dimensions of the chip (105 x 105).

### Coordinate Mapping
The package provides utility functions to convert between 2D chip coordinates and 1D indices.

**Convert (x,y) to Index:**
```r
# Get the index for a specific coordinate (e.g., x=5, y=5)
idx <- xy2i(5, 5)
```

**Convert Index to (x,y):**
```r
# Get coordinates for a range of indices
indices <- 1:10
coords <- i2xy(indices)
# Returns a matrix with columns "x" and "y"
```

### Validation Example
To verify coordinate consistency:
```r
i <- 1:11025
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))
```

## Tips
- The chip dimensions are 105 x 105, resulting in a total of 11,025 indices.
- Coordinates are 1-based in R (x and y range from 1 to 105).
- This package is a "data-only" package; it does not perform normalization or differential expression itself but provides the necessary map for the `affy` package to do so.

## Reference documentation
- [cyp450cdf Reference Manual](./references/reference_manual.md)
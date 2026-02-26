---
name: bioconductor-citruscdf
description: This package provides the Chip Description File (CDF) annotation data and coordinate mapping for the Citrus Affymetrix genome array. Use when user asks to map probe coordinates to indices, access chip dimensions, or process raw CEL files from Citrus microarrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/citruscdf.html
---


# bioconductor-citruscdf

name: bioconductor-citruscdf
description: Provides the CDF (Chip Description File) annotation data for the Citrus Affymetrix chip. Use this skill when working with Bioconductor's AffyBatch objects or CEL files derived from Citrus arrays to map probe coordinates to indices and access chip dimensions.

# bioconductor-citruscdf

## Overview
The `citruscdf` package is an annotation data package containing the Chip Description File (CDF) environment for the Citrus genome array. It is primarily used in conjunction with the `affy` package to process raw microarray data. It provides the mapping between the physical (x, y) coordinates on the chip and the probe indices used in R, as well as the overall dimensions of the array.

## Loading the Package
To use the annotation data, load the library in your R session:

```r
library(citruscdf)
```

## Key Environments and Data
The package provides two main environments:
- `citruscdf`: The environment containing the mapping of probesets to probe indices.
- `citrusdim`: The environment describing the dimensions of the Citrus chip (984 x 984).

## Coordinate Conversion
The package includes utility functions to convert between 2D chip coordinates and 1D indices.

### Convert (x,y) to Index
To convert a column (x) and row (y) coordinate to a single-number index:
```r
# Example: Get index for coordinate (5, 5)
idx <- xy2i(x = 5, y = 5)
```

### Convert Index to (x,y)
To convert a single-number index back into its physical (x,y) coordinates:
```r
# Example: Get coordinates for a range of indices
indices <- 1:10
coords <- i2xy(indices)
# Returns a matrix with "x" and "y" columns
```

## Typical Workflow
This package is usually called implicitly by other Bioconductor tools, but can be used manually for probe-level analysis:

1. **Identify Chip Dimensions**:
   Check the `citrusdim` environment to understand the grid size (984x984).
2. **Map Probes**:
   Use `i2xy` and `xy2i` when subsetting `AffyBatch` objects or when manually extracting intensity values from CEL files to ensure the correct physical probe is being referenced.
3. **Validation**:
   Ensure indices fall within the valid range of 1 to 968,256 (984 * 984).

## Reference documentation
- [citruscdf Reference Manual](./references/reference_manual.md)
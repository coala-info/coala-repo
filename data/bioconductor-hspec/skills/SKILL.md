---
name: bioconductor-hspec
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/Hspec.html
---

# bioconductor-hspec

name: bioconductor-hspec
description: Provides specialized knowledge for the Bioconductor Hspec package, an annotation data package for Affymetrix arrays. Use this skill when users need to map (x,y)-coordinates to single-number indices (and vice versa) for Hspec-specific CEL files or when working with the Hspec CDF environment and dimensions.

# bioconductor-hspec

## Overview
The `Hspec` package is a Bioconductor annotation resource providing CDF (Chip Definition File) information for Hspec-type Affymetrix microarrays. Its primary utility lies in converting between the 2D spatial coordinates (x, y) of the chip and the 1D indices used internally by `AffyBatch` objects and CDF environments.

## Core Functions

### Coordinate Conversion
The package provides two primary functions for index mapping on a 1164 x 1164 grid:

- `xy2i(x, y)`: Converts (x,y)-coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back to (x,y)-coordinates.

**Parameters:**
- `x`, `y`: Numeric coordinates ranging from 1 to 1164.
- `i`: Numeric index ranging from 1 to 1,354,896.

### Environment Objects
- `hspec`: An environment object describing the CDF file structure.
- `hspecdim`: An environment object describing the dimensions of the Hspec chip.

## Typical Workflow

### Loading the Package
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Hspec")

library(Hspec)
```

### Mapping Coordinates
To find the index for a specific probe at position (5, 5):
```r
index <- xy2i(5, 5)
# Returns the 1D index used in AffyBatch
```

To find the spatial location of a specific index:
```r
coords <- i2xy(index)
# Returns a matrix or vector with "x" and "y" columns
```

### Verifying Dimensions
```r
# Access dimension information
ls(hspecdim)
```

## Usage Tips
- The Hspec chip is square with dimensions 1164 x 1164.
- The total number of probes (indices) is 1,354,896.
- These functions are essential when manually extracting probe intensities from CEL files or when performing spatial quality control on the array.

## Reference documentation
- [Hspec Reference Manual](./references/reference_manual.md)
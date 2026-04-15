---
name: bioconductor-mgu74acdf
description: This package provides mapping between (x,y)-coordinates and probe indices for the Affymetrix Mouse Genome U74A microarray chip. Use when user asks to convert between chip coordinates and indices, access MG-U74A chip dimensions, or process CEL files using the mgu74acdf CDF environment.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74acdf.html
---

# bioconductor-mgu74acdf

name: bioconductor-mgu74acdf
description: Provides mapping between (x,y)-coordinates and single-number indices for the Affymetrix Mouse Genome U74A (MG-U74A) chip. Use when working with 'mgu74acdf' CDF environments, AffyBatch objects, or CEL file data in R/Bioconductor to identify probe locations and dimensions.

# bioconductor-mgu74acdf

## Overview
The `mgu74acdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) data for the Affymetrix Mouse Genome U74A array. It provides the necessary environment to map probe set identifiers to their physical locations on the microarray chip. This is essential for low-level analysis of Affymetrix data, such as background correction or normalization where spatial information is required.

## Installation
To install the package, use the BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mgu74acdf")
```

## Core Functions and Objects

### Coordinate Mapping
The package provides utility functions to convert between 2D chip coordinates and 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts (x,y)-coordinates (1 to 640) to a single-number index (1 to 409,600).
- `i2xy(i)`: Converts a single-number index back into (x,y)-coordinates.

### Data Environments
- `mgu74acdf`: An environment object containing the mapping of probe sets to their respective indices.
- `mgu74adim`: An environment describing the dimensions of the MG-U74A chip (640 x 640).

## Typical Workflow

### Loading the Package
```r
library(mgu74acdf)
```

### Converting Coordinates
To find the index of a specific probe at x=5, y=5:
```r
idx <- xy2i(5, 5)
# Returns the index used in the CDF environment
```

To find the coordinates for a range of indices:
```r
indices <- 1:10
coords <- i2xy(indices)
# Returns a matrix with "x" and "y" columns
```

### Accessing Chip Dimensions
To check the chip boundaries:
```r
ls(mgu74adim)
# Typically used internally by other Bioconductor packages like 'affy'
```

## Tips
- The chip dimensions for MG-U74A are 640 by 640, resulting in 409,600 total positions.
- This package is usually a dependency for higher-level packages like `affy`. You rarely need to call these functions manually unless performing custom spatial analysis or debugging probe-level data.

## Reference documentation
- [mgu74acdf Reference Manual](./references/reference_manual.md)
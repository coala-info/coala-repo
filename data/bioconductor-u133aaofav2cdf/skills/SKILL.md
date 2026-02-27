---
name: bioconductor-u133aaofav2cdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix u133aaofav2 array. Use when user asks to map (x,y)-coordinates to probe indices, access CDF environments, or determine chip dimensions for the u133aaofav2 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/u133aaofav2cdf.html
---


# bioconductor-u133aaofav2cdf

name: bioconductor-u133aaofav2cdf
description: Provides specialized functions and environment data for the Affymetrix u133aaofav2 chip. Use this skill when working with Bioconductor to map (x,y)-coordinates to probe indices, access CDF environments, or determine chip dimensions for the u133aaofav2 platform.

# bioconductor-u133aaofav2cdf

## Overview
The `u133aaofav2cdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Affymetrix u133aaofav2 array. It is primarily used to map probe locations on the physical chip to the indices used in R objects like `AffyBatch`.

## Core Functions and Usage

### Coordinate Mapping
The package provides utility functions to convert between 2D chip coordinates and 1D indices. The chip dimensions are 744 x 744, resulting in 553,536 total indices.

- `xy2i(x, y)`: Converts x and y coordinates (1 to 744) into a single-number index.
- `i2xy(i)`: Converts a single-number index (1 to 553536) back into x and y coordinates.

```r
library(u133aaofav2cdf)

# Convert specific coordinates to an index
index <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(index)
# Returns a matrix with "x" and "y" columns
```

### CDF Environments
The package exposes two main environments used by other Bioconductor tools (like `affy`):

- `u133aaofav2cdf`: The main environment describing the CDF file structure (mapping probesets to probe locations).
- `u133aaofav2dim`: An environment containing the dimensions of the chip.

## Typical Workflow
This package is rarely called directly by users for complex analysis; instead, it serves as a dependency for the `affy` package. When you load a CEL file from a u133aaofav2 chip, `affy` looks for this package to correctly interpret the probe data.

```r
# Typical implicit usage via the affy package
library(affy)
# If your CEL files are from this chip, affy will use u133aaofav2cdf automatically
data <- ReadAffy() 
```

## Reference documentation
- [u133aaofav2cdf Reference Manual](./references/reference_manual.md)
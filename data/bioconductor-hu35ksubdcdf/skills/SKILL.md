---
name: bioconductor-hu35ksubdcdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubdcdf.html
---

# bioconductor-hu35ksubdcdf

name: bioconductor-hu35ksubdcdf
description: Provides specialized environment data and coordinate mapping functions for the Affymetrix hu35ksubd chip. Use this skill when working with Bioconductor's hu35ksubdcdf package to map (x,y) coordinates to CEL file indices or to access the Chip Definition File (CDF) environment for this specific microarray.

# bioconductor-hu35ksubdcdf

## Overview
The `hu35ksubdcdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Affymetrix hu35ksubd platform. It is primarily used in the analysis of microarray data to map probe intensities to their respective gene identifiers and to handle the spatial geometry of the chip.

## Installation
To use this package in R:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hu35ksubdcdf")
```

## Core Functions and Usage

### Coordinate Mapping
The package provides utility functions to convert between the 2D spatial coordinates on the chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates (1 to 534) into a single-number index.
- `i2xy(i)`: Converts a single-number index (1 to 285,156) back into x and y coordinates.

**Example:**
```r
library(hu35ksubdcdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### CDF Environments
The package exposes two main environments:
- `hu35ksubdcdf`: The environment containing the mapping between probesets and probe locations.
- `hu35ksubddim`: The environment describing the dimensions of the chip (534 x 534).

## Typical Workflow
When analyzing `.CEL` files from the hu35ksubd platform using the `affy` package, this package is often loaded automatically to provide the necessary metadata for normalization and summarization (e.g., using RMA or MAS5).

```r
library(affy)
# If working with hu35ksubd CEL files, the affy package 
# will look for this CDF environment automatically.
# data <- ReadAffy() 
```

## Reference documentation
- [hu35ksubdcdf Reference Manual](./references/reference_manual.md)
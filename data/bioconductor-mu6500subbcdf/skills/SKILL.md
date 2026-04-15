---
name: bioconductor-mu6500subbcdf
description: This package provides the Chip Definition File (CDF) environment and coordinate mapping for the Affymetrix Mu6500subB expression array. Use when user asks to map probe set IDs to physical locations, convert between (x,y)-coordinates and probe indices, or process Mu6500subB microarray data in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu6500subbcdf.html
---

# bioconductor-mu6500subbcdf

name: bioconductor-mu6500subbcdf
description: Provides specialized knowledge for the mu6500subbcdf Bioconductor annotation package. Use this skill when working with Affymetrix Mu6500subB chip data in R, specifically for mapping (x,y)-coordinates to probe indices and accessing the CDF environment.

# bioconductor-mu6500subbcdf

## Overview
The `mu6500subbcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Mu6500subB expression array. It provides the mapping between probe set IDs and their physical locations on the microarray, as well as utility functions to convert between 2D chip coordinates and 1D indices used in `AffyBatch` objects.

## Package Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mu6500subbcdf")
library(mu6500subbcdf)
```

## Key Functions and Usage

### Coordinate Conversion
The package provides two primary functions for translating between the physical layout of the chip and the internal indexing used by Bioconductor's `affy` package.

- `xy2i(x, y)`: Converts (x,y)-coordinates (1 to 260) to a single-number index (1 to 67600).
- `i2xy(i)`: Converts a single-number index back into (x,y)-coordinates.

**Example Workflow:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices to coordinates
indices <- 1:10
coords <- i2xy(indices)

# Verify coordinates are within chip dimensions (260x260)
range(coords[, "x"])
range(coords[, "y"])
```

### CDF Environments
The package exposes two main environments:
- `mu6500subbcdf`: The environment containing the mapping of probe sets to probe locations.
- `mu6500subbdim`: The environment describing the dimensions of the Mu6500subB chip.

To list the probe sets available in the CDF:
```r
ls(mu6500subbcdf)[1:10]
```

## Typical Workflow with affy
This package is typically used automatically by the `affy` package when processing `.CEL` files from the Mu6500subB platform.

```r
library(affy)
# If you have CEL files in the working directory
# data <- ReadAffy() 
# The 'affy' package will look for mu6500subbcdf to annotate 'data'
```

## Reference documentation
- [mu6500subbcdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-ye6100subdcdf
description: This package provides the Chip Definition File (CDF) environment for the Affymetrix Yeast Genome S98 (YE6100) subarray. Use when user asks to map probe coordinates to indices, access chip dimension metadata, or process YE6100 subarray transcriptomics data in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ye6100subdcdf.html
---

# bioconductor-ye6100subdcdf

name: bioconductor-ye6100subdcdf
description: Provides specialized knowledge for the ye6100subdcdf Bioconductor annotation package. Use this skill when working with Affymetrix Yeast Genome S98 (YE6100) subarray CDF environments in R, specifically for mapping probe (x,y) coordinates to indices and accessing chip dimension metadata.

# bioconductor-ye6100subdcdf

## Overview

The `ye6100subdcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix YE6100 subarray. It is primarily used in transcriptomics workflows to map probe intensities from CEL files to their respective probesets.

## Core Functions and Usage

### Loading the Package
To use the CDF environment, load the library in R:

```r
library(ye6100subdcdf)
```

### Coordinate Conversion
The package provides utility functions to convert between 2D chip coordinates (x, y) and 1D indices (i) used in `AffyBatch` objects.

- **xy2i(x, y)**: Converts x and y coordinates to a single-number index.
- **i2xy(i)**: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinates range: 1 to 264
- Y-coordinates range: 1 to 264
- Total indices: 1 to 69,696 (264 * 264)

**Example Workflow:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns

# Verify consistency
stopifnot(all(xy2i(coords[,"x"], coords[,"y"]) == idx))
```

### Environment Objects
The package exposes two main environments:
- `ye6100subdcdf`: The main environment describing the CDF file mapping.
- `ye6100subddim`: An environment containing the dimensions of the chip.

## Typical Workflow Integration
This package is usually not called directly by the user but is required by high-level packages like `affy`. When reading CEL files that use the YE6100 subarray, `affy` will look for this package to correctly interpret the probe layout.

```r
# Example of how it is used internally by affy
# library(affy)
# data <- ReadAffy() # If the chip is YE6100sub, this package is invoked
```

## Reference documentation
- [ye6100subdcdf Reference Manual](./references/reference_manual.md)
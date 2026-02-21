---
name: bioconductor-hgu133atagcdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133atagcdf.html
---

# bioconductor-hgu133atagcdf

name: bioconductor-hgu133atagcdf
description: A specialized skill for working with the Bioconductor annotation package hgu133atagcdf. Use this skill when you need to map Affymetrix HG-U133A Tag array probe coordinates (x, y) to indices, access the CDF environment, or determine chip dimensions for this specific microarray platform.

# bioconductor-hgu133atagcdf

## Overview
The `hgu133atagcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix HG-U133A Tag array. It provides the mapping between probe set identifiers and their physical locations on the microarray, as well as utility functions to convert between 2D (x, y) coordinates and 1D indices used in `AffyBatch` objects.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hgu133atagcdf")
```

## Core Functions and Usage

### Loading the Package
```r
library(hgu133atagcdf)
```

### Coordinate Conversion
The package provides two primary functions for converting between the (x, y) grid of the CEL file and the single-number indices used in R environments.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Parameters:**
- `x`: Numeric, x-coordinate (1 to 712).
- `y`: Numeric, y-coordinate (1 to 712).
- `i`: Numeric, single-number index (1 to 506,944).

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### Accessing CDF Data
The package exposes environments that describe the chip layout:

- `hgu133atagcdf`: The environment containing the mapping of probes to probe sets.
- `hgu133atagdim`: The environment describing the dimensions of the array (712 x 712).

```r
# View dimensions
ls(hgu133atagdim)

# List probe sets in the CDF
featureNames <- ls(hgu133atagcdf)
head(featureNames)
```

## Typical Workflow
When analyzing Affymetrix data, this package is often called internally by `affy` functions. However, for manual probe-level analysis:

1. Load the `AffyBatch` data.
2. Use `hgu133atagcdf` to identify the indices of probes belonging to a specific gene or probe set.
3. Map those indices to physical (x, y) locations if performing spatial quality control or artifact detection.

## Reference documentation
- [hgu133atagcdf Reference Manual](./references/reference_manual.md)
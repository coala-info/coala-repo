---
name: bioconductor-mu6500subdcdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Mu6500subD microarray. Use when user asks to map probe coordinates to indices, access the Mu6500subD CDF environment, or process Mu6500subD chip data in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu6500subdcdf.html
---


# bioconductor-mu6500subdcdf

name: bioconductor-mu6500subdcdf
description: Provides specialized knowledge for the mu6500subdcdf Bioconductor annotation package. Use this skill when working with Affymetrix Mu6500subD chip data in R, specifically for mapping probe (x,y) coordinates to CEL file indices and accessing the CDF environment.

# bioconductor-mu6500subdcdf

## Overview
The `mu6500subdcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Mu6500subD microarray. It provides the necessary mapping between probe identifiers and their physical locations on the array, as well as coordinate conversion utilities.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mu6500subdcdf")
library(mu6500subdcdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to convert between 2D chip coordinates and 1D indices used in `AffyBatch` objects. The Mu6500subD chip has dimensions of 260x260 pixels (67,600 total indices).

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example Workflow:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices to coordinates
indices <- 1:10
coords <- i2xy(indices)

# Verify coordinates are within chip bounds (1 to 260)
range(coords[, "x"])
range(coords[, "y"])
```

### Accessing CDF Data
The package contains two main environments:
- `mu6500subdcdf`: The environment containing the mapping of probesets to probe locations.
- `mu6500subddim`: The environment describing the dimensions of the CDF file.

These are typically used internally by other Bioconductor packages like `affy`, but can be inspected directly:

```r
# List probesets in the CDF
ls(mu6500subdcdf)[1:10]

# Get dimensions
ls(mu6500subddim)
```

## Typical Workflow with 'affy'
This package is most commonly used as a dependency when loading CEL files:

```r
library(affy)
# If CEL files are for Mu6500subD, affy will automatically 
# look for this package to create the AffyBatch object.
data <- ReadAffy() 
```

## Reference documentation
- [mu6500subdcdf Reference Manual](./references/reference_manual.md)
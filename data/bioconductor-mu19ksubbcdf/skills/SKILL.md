---
name: bioconductor-mu19ksubbcdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix Mu19KsubB microarray platform. Use when user asks to map (x,y) coordinates to CEL file indices, access CDF metadata, or process Affymetrix Mu19KsubB chip data in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu19ksubbcdf.html
---


# bioconductor-mu19ksubbcdf

name: bioconductor-mu19ksubbcdf
description: Provides specialized knowledge for the mu19ksubbcdf Bioconductor annotation package. Use this skill when working with Affymetrix Mu19KsubB chip data in R, specifically for mapping (x,y) coordinates to CEL file indices and accessing the Chip Definition File (CDF) environment.

# bioconductor-mu19ksubbcdf

## Overview
The `mu19ksubbcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Mu19KsubB platform. It is primarily used in transcriptomics workflows to map probe intensities from CEL files to their respective probe sets and physical locations on the microarray.

## Core Functions and Usage

### Loading the Package
To use the CDF environment and its utility functions, load the library in R:
```r
library(mu19ksubbcdf)
```

### Coordinate Mapping
The package provides two essential functions for converting between the 2D physical grid of the microarray and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates (1 to 534) to a single-number index.
- `i2xy(i)`: Converts a single-number index (1 to 285,156) back into x and y coordinates.

**Example Workflow:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices to coordinates
indices <- 1:100
coords <- i2xy(indices)

# Verify coordinates
range(coords[, "x"])
range(coords[, "y"])
```

### Accessing CDF Data
The package provides two main environments:
- `mu19ksubbcdf`: The environment containing the mapping between probe sets and probe indices.
- `mu19ksubbdim`: The environment describing the dimensions of the Mu19KsubB chip (534 x 534).

To see the contents or dimensions:
```r
# View dimension information
as.list(mu19ksubbdim)

# List probe sets in the CDF
ls(mu19ksubbcdf)[1:10]
```

## Typical Workflow Integration
This package is rarely used in isolation. It is typically called automatically by the `affy` package when processing Mu19KsubB CEL files.

```r
library(affy)
# If you have CEL files in the working directory
# data <- ReadAffy() 
# The affy package will automatically look for mu19ksubbcdf 
# to interpret the probe intensities.
```

## Reference documentation
- [mu19ksubbcdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-mu11ksubbcdf
description: This package provides the Chip Definition File for the Affymetrix Mu11KsubB microarray to map probe locations to indices. Use when user asks to process Mu11KsubB microarray data, convert between probe indices and coordinates, or access chip metadata for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu11ksubbcdf.html
---


# bioconductor-mu11ksubbcdf

## Overview
The `mu11ksubbcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) for the Affymetrix Mu11KsubB microarray. It provides the necessary mapping between the physical (x, y) coordinates on the chip and the probe indices used in R's `AffyBatch` objects.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mu11ksubbcdf")
```

## Core Components

### 1. The CDF Environment
The primary object is `mu11ksubbcdf`, which contains the mapping of probe sets to their locations on the Mu11KsubB chip. This is typically loaded automatically by high-level functions in the `affy` package.

```r
library(mu11ksubbcdf)
# View the environment object
mu11ksubbcdf
```

### 2. Chip Dimensions
The `mu11ksubbdim` object provides the dimensions of the array.
- **Dimensions**: 534 x 534 pixels/probes.
- **Total Indices**: 285,156.

### 3. Coordinate Conversion (i2xy & xy2i)
The package provides utility functions to convert between 1D indices and 2D (x, y) coordinates. Note that coordinates in this package are 1-based.

**Convert (x, y) to Index:**
```r
# Convert x=5, y=5 to a single-number index
idx <- xy2i(5, 5)
```

**Convert Index to (x, y):**
```r
# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

## Typical Workflow
This package is usually a dependency for the `affy` package. When you load a CEL file from a Mu11KsubB array, `affy` will look for this package to correctly interpret the probe data.

```r
library(affy)
# If you have CEL files in the working directory
# data <- ReadAffy() 
# The 'data' object will automatically use mu11ksubbcdf if the chip type matches.
```

## Usage Tips
- **Coordinate Range**: Ensure x and y values are between 1 and 534.
- **Index Range**: Ensure indices are between 1 and 285,156.
- **Manual Inspection**: You can list the probe sets contained in the environment using `ls(mu11ksubbcdf)`.

## Reference documentation
- [mu11ksubbcdf Reference Manual](./references/reference_manual.md)
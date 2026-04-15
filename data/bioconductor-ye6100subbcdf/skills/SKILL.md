---
name: bioconductor-ye6100subbcdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Yeast Genome S98 (Ye6100subB) array. Use when user asks to map probe coordinates to indices, access CDF environment data, or process Ye6100subB expression data in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ye6100subbcdf.html
---

# bioconductor-ye6100subbcdf

name: bioconductor-ye6100subbcdf
description: specialized knowledge for the ye6100subbcdf Bioconductor annotation package. Use this skill when working with Affymetrix Yeast Genome S98 (Ye6100subB) expression data in R, specifically for mapping probe (x,y) coordinates to indices and accessing the Chip Definition File (CDF) environment.

# bioconductor-ye6100subbcdf

## Overview
The `ye6100subbcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Ye6100subB array. It provides the necessary mapping between probe set identifiers and their physical locations on the microarray chip. This package is primarily used by other Bioconductor tools like `affy` to process `.CEL` files.

## Installation and Loading
To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ye6100subbcdf")
library(ye6100subbcdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between 2D chip coordinates (x, y) and 1D indices used in `AffyBatch` objects. The chip dimensions for this array are 264 x 264 (total 69,696 indices).

#### Convert (x,y) to Index
Use `xy2i()` to get the single-number index for a specific probe location.
```r
# Get index for probe at x=5, y=5
idx <- xy2i(5, 5)
```

#### Convert Index to (x,y)
Use `i2xy()` to retrieve the coordinates from a single-number index.
```r
# Get coordinates for index 500
coords <- i2xy(500)
# Returns a matrix with columns "x" and "y"
```

### Accessing CDF Data
The package exposes the CDF environment directly. This is typically handled automatically by high-level functions (like `ReadAffy`), but can be accessed manually:

```r
# View the environment object
ye6100subbcdf

# List probe sets in the environment
ls(ye6100subbcdf)[1:10]

# Get dimensions of the array
ye6100subbdim
```

## Typical Workflow
This package is usually a dependency for `affy`. When you load a Ye6100subB CEL file, the `affy` package looks for this specific annotation package:

```r
library(affy)
# If working with Ye6100subB data, affy will automatically 
# load ye6100subbcdf to map probes to genes.
data <- ReadAffy() 
```

## Reference documentation
- [ye6100subbcdf Reference Manual](./references/reference_manual.md)
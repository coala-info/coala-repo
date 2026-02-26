---
name: bioconductor-hugene10stv1cdf
description: This package provides the Chip Definition File environment for the Affymetrix GeneChip Human Gene 1.0 ST v1 array. Use when user asks to map probe coordinates to indices, access chip dimensions, or analyze microarray data from the Human Gene 1.0 ST v1 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene10stv1cdf.html
---


# bioconductor-hugene10stv1cdf

name: bioconductor-hugene10stv1cdf
description: A specialized skill for working with the Bioconductor annotation package hugene10stv1cdf. Use this skill when you need to map (x,y)-coordinates to indices for the Affymetrix GeneChip Human Gene 1.0 ST v1 array, or when you need to access the CDF environment and chip dimensions for this specific platform.

# bioconductor-hugene10stv1cdf

## Overview
The `hugene10stv1cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix GeneChip Human Gene 1.0 ST v1. It is primarily used in the analysis of microarray data to map probe intensities from CEL files to their respective probe sets and physical locations on the chip.

## Installation
To use this package in R, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hugene10stv1cdf")
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinate range: 1 to 1050
- Y-coordinate range: 1 to 1050
- Total indices: 1,102,500

**Example:**
```r
library(hugene10stv1cdf)

# Convert specific coordinates to an index
index <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(index)
# coords will be a matrix with columns "x" and "y"
```

### Accessing CDF Data
The package contains two primary environments:

1.  `hugene10stv1cdf`: The main environment containing the mapping of probe sets to probe locations.
2.  `hugene10stv1dim`: An environment containing the dimensions of the chip.

```r
# Load the library
library(hugene10stv1cdf)

# View the CDF environment
ls(hugene10stv1cdf)[1:10]

# Check dimensions
ls(hugene10stv1dim)
```

## Typical Workflow
This package is usually not called directly by the user but is loaded automatically by high-level analysis packages like `affy`.

```r
library(affy)
# When reading CEL files for Human Gene 1.0 ST v1, 
# the affy package will look for this CDF package.
data <- ReadAffy() 
# If the chip type is detected as 'hugene10stv1', 
# this package provides the necessary mapping.
```

## Reference documentation
- [hugene10stv1cdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-ragene10stv1cdf
description: This package provides the Chip Definition File environment for the Affymetrix Rat Gene 1.0 ST v1 expression array. Use when user asks to access CDF environments, map probe coordinates to indices, or retrieve array dimensions for Rat Gene 1.0 ST v1 data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ragene10stv1cdf.html
---

# bioconductor-ragene10stv1cdf

name: bioconductor-ragene10stv1cdf
description: Provides specialized knowledge for the Bioconductor R package 'ragene10stv1cdf'. Use this skill when working with Affymetrix Rat Gene 1.0 ST v1 chip data, specifically for accessing the Chip Definition File (CDF) environment, mapping (x,y)-coordinates to probe indices, and retrieving array dimensions.

# bioconductor-ragene10stv1cdf

## Overview
The `ragene10stv1cdf` package is an annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Rat Gene 1.0 ST v1 expression array. It is primarily used by other Bioconductor packages like `affy` to map probe-level data to their respective probesets.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ragene10stv1cdf")
```

## Core Functions and Usage

### Accessing the CDF Environment
The package provides an environment object named `ragene10stv1cdf` which contains the mapping of probesets to probe locations.

```r
library(ragene10stv1cdf)

# View the contents of the CDF environment
ls(ragene10stv1cdf)[1:10]

# Get probe indices for a specific probeset
probeset_name <- ls(ragene10stv1cdf)[1]
get(probeset_name, envir = ragene10stv1cdf)
```

### Coordinate Mapping (i2xy and xy2i)
Affymetrix chips use both (x,y) coordinates and single-number indices to identify probe locations. This package provides utilities to convert between them. The Rat Gene 1.0 ST v1 array has dimensions of 1050 x 1050.

```r
# Convert (x,y) coordinates to a single index
# x and y range from 1 to 1050
index <- xy2i(x = 5, y = 5)

# Convert a single index back to (x,y) coordinates
coords <- i2xy(index)
# coords is a matrix with columns "x" and "y"
```

### Array Dimensions
The `ragene10stv1dim` object provides the dimensions of the array.

```r
# View dimensions
ragene10stv1dim
```

## Typical Workflow
This package is rarely used standalone. It is typically loaded automatically when reading CEL files using the `affy` package:

```r
library(affy)
# If CEL files are for Rat Gene 1.0 ST v1, ReadAffy() will 
# automatically look for and use ragene10stv1cdf
data <- ReadAffy() 
```

## Reference documentation
- [ragene10stv1cdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-hu35ksubacdf
description: This package provides the Chip Definition File (CDF) environment for the Affymetrix Hu35KsubA platform to map probe-level data to probesets. Use when user asks to map probes to probesets, convert between chip coordinates and indices, or process Affymetrix Hu35KsubA microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubacdf.html
---


# bioconductor-hu35ksubacdf

## Overview
The `hu35ksubacdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Affymetrix Hu35KsubA platform. It is primarily used by the `affy` package to map probe-level data to their respective probesets. It includes coordinate conversion functions and environment metadata defining the chip's dimensions (534x534).

## Installation and Loading
To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hu35ksubacdf")
library(hu35ksubacdf)
```

## Coordinate Conversion
The package provides utility functions to translate between the 2D grid coordinates of the chip and the 1D indices used in `AffyBatch` objects.

### Convert (x,y) to Index
To find the single-number index for a specific probe location:
```r
# Example: Get index for x=5, y=5
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
To find the grid coordinates for a given index:
```r
# Example: Get coordinates for index 100
coords <- i2xy(100)
# Returns a matrix with columns "x" and "y"
```

## Chip Dimensions and Metadata
The package contains two main environments:
- `hu35ksubacdf`: The environment containing the mapping of probes to probesets.
- `hu35ksubadim`: The environment defining the physical dimensions of the array.

To inspect the dimensions:
```r
# The chip is 534 x 534
get("hu35ksubadim", envir = hu35ksubadim)
```

## Typical Workflow
This package is usually not called directly by the user but is loaded automatically by `affy` when reading CEL files from the Hu35KsubA platform.

```r
library(affy)
# When ReadAffy() encounters a Hu35KsubA CEL file, 
# it looks for this package to create the AffyBatch object.
data <- ReadAffy() 

# To manually inspect the CDF environment
ls(hu35ksubacdf)[1:10]
```

## Reference documentation
- [hu35ksubacdf Reference Manual](./references/reference_manual.md)
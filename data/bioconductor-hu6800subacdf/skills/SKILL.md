---
name: bioconductor-hu6800subacdf
description: This package provides the Chip Definition File environment for the Hu6800subA Affymetrix microarray to map probe intensities to probe sets. Use when user asks to convert between chip coordinates and indices, access the Hu6800subA CDF environment, or process Affymetrix microarray data using the affy package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu6800subacdf.html
---


# bioconductor-hu6800subacdf

## Overview

The `hu6800subacdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Hu6800subA Affymetrix microarray. It provides the necessary mapping between probe intensities stored in CEL files and their corresponding probe sets. This skill facilitates the conversion of chip coordinates and the utilization of the CDF environment in R.

## Installation and Loading

To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hu6800subacdf")
library(hu6800subacdf)
```

## Coordinate Mapping

The package provides utility functions to convert between the 2D (x,y) coordinates on the microarray chip and the 1D indices used in `AffyBatch` objects.

### xy2i: Coordinates to Index
Converts x and y coordinates (1 to 276) to a single-number index (1 to 76176).

```r
# Convert x=5, y=5 to a single index
idx <- xy2i(5, 5)
```

### i2xy: Index to Coordinates
Converts a single-number index back into x and y coordinates.

```r
# Convert index back to coordinates
coords <- i2xy(idx)
# Access x and y
x_val <- coords[, "x"]
y_val <- coords[, "y"]
```

## Package Environments

The package exposes two primary environments used by other Bioconductor tools (like `affy`):

1.  **hu6800subacdf**: The main environment describing the CDF file structure.
2.  **hu6800subadim**: An environment containing the dimensions of the CDF (276 x 276).

These are typically accessed automatically by functions like `ReadAffy()`, but can be inspected manually:

```r
# View dimensions
ls(hu6800subadim)

# List probe sets in the CDF
ls(hu6800subacdf)[1:10]
```

## Typical Workflow

When analyzing Hu6800subA data, this package is usually a dependency for the `affy` package.

```r
library(affy)
library(hu6800subacdf)

# If you have CEL files in the working directory
# The affy package will automatically look for hu6800subacdf
data <- ReadAffy()

# To manually specify the cdfname if it's not detected
data@cdfname <- "hu6800subacdf"
```

## Reference documentation

- [hu6800subacdf Reference Manual](./references/reference_manual.md)
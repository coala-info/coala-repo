---
name: bioconductor-ye6100subacdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix Yeast Genome S98 Subarray A platform. Use when user asks to map probe coordinates to indices, access CDF metadata, or process YE6100SubA microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ye6100subacdf.html
---


# bioconductor-ye6100subacdf

name: bioconductor-ye6100subacdf
description: Provides specialized functions and environment data for the ye6100subacdf Bioconductor annotation package. Use this skill when working with Affymetrix Yeast Genome S98 (YE6100) Subarray A chip data in R, specifically for mapping (x,y) probe coordinates to CEL file indices and accessing CDF environment metadata.

# bioconductor-ye6100subacdf

## Overview

The `ye6100subacdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix YE6100SubA platform. It is primarily used to map probe intensities from CEL files to their respective probesets and to convert between spatial (x,y) coordinates on the microarray and the linear indices used in `AffyBatch` objects.

## Loading the Package

To use the environments and coordinate functions, load the library in R:

```r
library(ye6100subacdf)
```

## Coordinate Conversion

The package provides two primary functions for translating between the physical layout of the chip and the data structures used in Bioconductor's `affy` package. The chip dimensions for this subarray are 264 x 264 (69,696 total indices).

### Convert (x,y) to Index
To find the linear index `i` for a specific probe at coordinates `x` and `y`:

```r
# Example: Get index for probe at x=5, y=5
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
To find the spatial coordinates for a given linear index `i`:

```r
# Example: Get coordinates for index 1000
coords <- i2xy(1000)
# Returns a matrix with columns "x" and "y"
```

## CDF Environments

The package provides two main environments used by other Bioconductor tools (like `affy`) to process raw data:

1.  **ye6100subacdf**: The main environment mapping probes to probesets.
2.  **ye6100subadim**: An environment containing the dimensions of the chip (264 x 264).

These are typically accessed automatically by functions like `ReadAffy()`, but can be inspected manually:

```r
# View dimensions
ls(ye6100subadim)

# List probesets in the CDF
ls(ye6100subacdf)[1:10]
```

## Typical Workflow

When analyzing YE6100 Subarray A data, you usually do not call these functions directly. Instead, the `affy` package uses this skill's package in the background:

```r
library(affy)
library(ye6100subacdf)

# Read CEL files; the package will be used automatically if the chip type matches
data <- ReadAffy()

# If manual coordinate mapping is needed for QC or visualization:
all_indices <- 1:69696
coords <- i2xy(all_indices)
```

## Reference documentation

- [ye6100subacdf Reference Manual](./references/reference_manual.md)
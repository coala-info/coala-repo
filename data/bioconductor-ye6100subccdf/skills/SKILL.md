---
name: bioconductor-ye6100subccdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Yeast Genome S98 Subarray C chip. Use when user asks to map probe coordinates to CEL file indices, access CDF metadata, or analyze Affymetrix YE6100SubC array data in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ye6100subccdf.html
---

# bioconductor-ye6100subccdf

name: bioconductor-ye6100subccdf
description: Provides specialized knowledge for the ye6100subccdf Bioconductor annotation package. Use this skill when working with Affymetrix Yeast Genome S98 (YE6100) Subarray C chips in R, specifically for mapping probe (x,y) coordinates to CEL file indices and accessing CDF environment metadata.

# bioconductor-ye6100subccdf

## Overview

The `ye6100subccdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix YE6100SubC oligonucleotide array. Its primary purpose is to provide the mapping between the physical location of probes on the chip (x, y coordinates) and the index used in `AffyBatch` objects, as well as defining the probe sets.

## Installation and Loading

To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ye6100subccdf")
library(ye6100subccdf)
```

## Coordinate Mapping

The package provides utility functions to convert between 2D chip coordinates and 1D indices. The chip dimensions for this array are 264 x 264 (totaling 69,696 indices).

### Convert (x,y) to Index
Use `xy2i()` to get the single-number index used in CDF environments.
```r
# Get index for probe at x=5, y=5
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
Use `i2xy()` to retrieve the coordinates from a single-number index.
```r
# Get coordinates for index 500
coords <- i2xy(500)
# Returns a matrix with columns "x" and "y"
```

## Accessing CDF Data

The package exposes two main environments:

1.  `ye6100subccdf`: The main environment containing probe set information.
2.  `ye6100subcdim`: Contains the dimensions of the chip.

### Example Workflow
```r
# View chip dimensions
as.list(ye6100subcdim)

# List some probe sets
ls(ye6100subccdf)[1:10]

# Get probe information for a specific probe set
probe_set <- get("YAL001C", envir = ye6100subccdf)
```

## Usage Tips
- The indices range from 1 to 69,696.
- Coordinates (x, y) range from 1 to 264.
- This package is typically used internally by the `affy` package, but these functions are useful for custom low-level probe analysis.

## Reference documentation

- [ye6100subccdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-rnu34cdf
description: This package provides the Chip Definition File environment for the Affymetrix Rat Genome U34 microarray. Use when user asks to map probe coordinates to indices, retrieve chip dimensions, or perform low-level analysis on RNU34 array data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rnu34cdf.html
---

# bioconductor-rnu34cdf

name: bioconductor-rnu34cdf
description: A specialized skill for working with the Bioconductor annotation package 'rnu34cdf'. Use this skill when you need to access CDF (Chip Definition File) environments for the Rat Genome U34 (RNU34) Affymetrix array, specifically for mapping probe coordinates to indices or retrieving chip dimensions.

# bioconductor-rnu34cdf

## Overview

The `rnu34cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix RNU34 (Rat Genome U34) chip. This package is essential for low-level analysis of Affymetrix microarrays, allowing users to map between (x, y) coordinates on the physical chip and the single-number indices used in `AffyBatch` objects.

## Installation and Loading

To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rnu34cdf")
library(rnu34cdf)
```

## Core Functions and Usage

### Coordinate Conversion

The package provides utility functions to convert between 2D chip coordinates and 1D indices. The RNU34 chip has dimensions of 218 x 218 pixels (total 47,524 indices).

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### CDF Environments

The package exposes two primary environments:

1.  `rnu34cdf`: The main environment containing the mapping of probeset IDs to probe locations.
2.  `rnu34dim`: An environment containing the dimensions of the RNU34 chip.

**Example: Checking Dimensions**
```r
# View the dimension environment
rnu34dim
```

## Typical Workflow

When working with raw Affymetrix data (`.CEL` files) for the Rat Genome U34 array, the `affy` package typically loads `rnu34cdf` automatically to handle the probe-level mapping. You would manually use this skill if you are:
1.  Performing custom spatial analysis of the chip.
2.  Manually extracting probe intensities based on specific coordinates.
3.  Debugging probeset-to-index mappings.

## Reference documentation

- [rnu34cdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-rtu34cdf
description: This package provides the Chip Definition File environment for the Affymetrix Rat Toxicology U34 microarray to map probe coordinates to indices. Use when user asks to map probe coordinates to indices for the RTU34 chip, convert between 2D coordinates and 1D indices, or process AffyBatch objects requiring the RTU34 CDF environment.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rtu34cdf.html
---


# bioconductor-rtu34cdf

name: bioconductor-rtu34cdf
description: A specialized skill for working with the Bioconductor annotation package 'rtu34cdf'. Use this skill when you need to map probe coordinates to indices for the Rat Toxicology U34 (RTU34) Affymetrix chip, or when working with AffyBatch objects that require the RTU34 CDF environment.

# bioconductor-rtu34cdf

## Overview

The `rtu34cdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Rat Toxicology U34 (RTU34) array. Its primary purpose is to provide the mapping between the physical (x, y) coordinates on the chip and the 1-dimensional indices used in R's `AffyBatch` objects.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rtu34cdf")
library(rtu34cdf)
```

## Core Functions and Usage

### Coordinate Conversion

The package provides two utility functions to convert between 2D chip coordinates and 1D indices. The RTU34 chip has dimensions of 218 x 218, resulting in 47,524 total indices.

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

The package automatically loads two key environments:

1.  `rtu34cdf`: The main environment describing the CDF file structure (mapping probes to probesets).
2.  `rtu34dim`: An environment containing the dimensions of the RTU34 chip.

These are typically accessed internally by other Bioconductor packages like `affy` when processing `.CEL` files from the RTU34 platform.

## Typical Workflow

When analyzing RTU34 microarray data, you usually do not call `rtu34cdf` functions directly. Instead, the `affy` package uses this package automatically:

```r
library(affy)
library(rtu34cdf)

# When reading CEL files, the CDF environment is matched automatically
# if the chip type is recognized as RTU34.
data <- ReadAffy() 

# To manually inspect the dimensions defined in the package:
get("rtu34dim")
```

## Reference documentation

- [rtu34cdf Reference Manual](./references/reference_manual.md)
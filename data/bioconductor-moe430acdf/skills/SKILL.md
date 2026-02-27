---
name: bioconductor-moe430acdf
description: This package provides the Chip Definition File environment and coordinate mapping data for the Affymetrix Mouse Expression 430A oligonucleotide array. Use when user asks to convert between chip coordinates and indices, access array dimensions, or map probe identifiers for MOE430A genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/moe430acdf.html
---


# bioconductor-moe430acdf

name: bioconductor-moe430acdf
description: Provides mapping and environment data for the Affymetrix Mouse Expression 430A (MOE430A) oligonucleotide array. Use this skill when working with MOE430A CDF environments, converting between (x,y) chip coordinates and single-number indices, or accessing array dimensions for mouse genomic studies.

# bioconductor-moe430acdf

## Overview
The `moe430acdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Affymetrix Mouse Expression 430A array. It allows for the mapping of probe identifiers to their physical locations on the chip and provides utility functions for coordinate conversion.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("moe430acdf")
library(moe430acdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to convert between the 2D grid coordinates of the chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Parameters:**
- `x`: Numeric x-coordinate (1 to 712).
- `y`: Numeric y-coordinate (1 to 712).
- `i`: Numeric single-number index (1 to 506,944).

### Array Dimensions
The environment `moe430adim` contains the dimensions of the array.

```r
# View dimension information
as.list(moe430adim)
```

## Workflow Example

```r
library(moe430acdf)

# 1. Convert a specific coordinate to an index
idx <- xy2i(5, 5)

# 2. Convert a range of indices to coordinates
indices <- 1:10
coords <- i2xy(indices)

# 3. Verify the conversion
# coords is a matrix with "x" and "y" columns
x_vals <- coords[, "x"]
y_vals <- coords[, "y"]
original_indices <- xy2i(x_vals, y_vals)
stopifnot(all(indices == original_indices))

# 4. Check coordinate ranges
range(coords[, "x"])
range(coords[, "y"])
```

## Data Environments
- `moe430acdf`: The main environment containing the CDF mapping.
- `moe430adim`: The environment describing the array dimensions (712 x 712).

## Reference documentation
- [moe430acdf Reference Manual](./references/reference_manual.md)
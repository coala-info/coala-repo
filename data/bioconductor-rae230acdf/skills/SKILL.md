---
name: bioconductor-rae230acdf
description: This package provides the Chip Definition File (CDF) environment and coordinate mapping functions for the Affymetrix Rat Expression 230A oligonucleotide array. Use when user asks to map probe intensities to probe sets, convert between chip coordinates and indices, or access array dimensions for RAE230A data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rae230acdf.html
---


# bioconductor-rae230acdf

name: bioconductor-rae230acdf
description: Provides specialized environment and coordinate mapping functions for the Affymetrix Rat Expression 230A (RAE230A) oligonucleotide array. Use this skill when working with RAE230A CDF data, converting between (x,y) chip coordinates and AffyBatch indices, or accessing array dimensions.

# bioconductor-rae230acdf

## Overview

The `rae230acdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Affymetrix Rat Expression 230A array. It is primarily used in the analysis of microarray data to map probe intensities to their respective probe sets and to handle the physical geometry of the chip.

## Core Functions and Usage

### Coordinate Conversion

Affymetrix CEL files and `AffyBatch` objects often use different systems to identify probe locations. This package provides utilities to convert between them.

- `xy2i(x, y)`: Converts 2D (x,y) coordinates (1 to 602) into a single-number index (1 to 362,404).
- `i2xy(i)`: Converts a single-number index back into a matrix of (x,y) coordinates.

```r
library(rae230acdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# coords["x"] and coords["y"] will return 5
```

### Environment Objects

The package provides two main environments used by other Bioconductor tools (like `affy`):

1.  `rae230acdf`: The main environment describing the CDF file mapping.
2.  `rae230adim`: An environment containing the dimensions of the RAE230A array (602 x 602).

## Typical Workflow

This package is usually not called directly by the user but is loaded automatically by functions in the `affy` package when processing RAE230A data.

```r
# Typical implicit usage via the affy package
library(affy)
# When reading CEL files from a Rat 230A chip:
# data <- ReadAffy() 
# The affy package will look for and use rae230acdf automatically
```

To manually inspect the array dimensions:
```r
library(rae230acdf)
# View dimensions
as.list(rae230adim)
```

## Reference documentation

- [rae230acdf Reference Manual](./references/reference_manual.md)
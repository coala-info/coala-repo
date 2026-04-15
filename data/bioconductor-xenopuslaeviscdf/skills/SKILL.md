---
name: bioconductor-xenopuslaeviscdf
description: This package provides the Chip Definition File environment and coordinate mapping for Affymetrix Xenopus laevis expression arrays. Use when user asks to map probe coordinates to indices, access the CDF environment, or process raw intensity data from African clawed frog expression chips.
homepage: https://bioconductor.org/packages/release/data/annotation/html/xenopuslaeviscdf.html
---

# bioconductor-xenopuslaeviscdf

name: bioconductor-xenopuslaeviscdf
description: Provides specialized knowledge for the xenopuslaeviscdf Bioconductor package. Use this skill when working with Affymetrix Xenopus laevis (African clawed frog) expression arrays in R, specifically for mapping probe (x,y) coordinates to indices and accessing the Chip Definition File (CDF) environment.

# bioconductor-xenopuslaeviscdf

## Overview
The `xenopuslaeviscdf` package is an annotation package containing the Chip Definition File (CDF) environment for the Affymetrix Xenopus laevis expression array. It is primarily used by other Bioconductor packages like `affy` to map raw intensity data from CEL files to specific probesets.

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates on the chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

The chip dimensions for this array are 712 x 712, resulting in a total of 506,944 indices.

```r
library(xenopuslaeviscdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### CDF Environments
The package exposes two main environments:
- `xenopuslaeviscdf`: The environment containing the mapping of probesets to probe indices.
- `xenopuslaevisdim`: The environment containing the dimensions of the array.

```r
# View dimensions
ls(xenopuslaevisdim)

# Accessing the CDF environment directly (usually handled by 'affy')
# To see a list of probesets:
# ls(xenopuslaeviscdf)
```

## Typical Workflow
This package is rarely used in isolation. It is typically loaded automatically when you read Xenopus laevis CEL files using the `affy` package.

```r
library(affy)
# If you have CEL files in the working directory
# data <- ReadAffy() 
# The 'affy' package will look for 'xenopuslaeviscdf' to process the data.
```

## Tips
- The indices are 1-based, following standard R convention.
- The maximum value for x and y is 712.
- The maximum index value is 506,944.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
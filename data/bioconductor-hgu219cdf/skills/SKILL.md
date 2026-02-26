---
name: bioconductor-hgu219cdf
description: This package provides the Chip Definition File environment for the Affymetrix Human Genome U219 Array. Use when user asks to map probe identifiers, convert between (x,y) chip coordinates and indices, or handle CDF environments for this specific microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu219cdf.html
---


# bioconductor-hgu219cdf

name: bioconductor-hgu219cdf
description: A specialized skill for working with the Bioconductor annotation package hgu219cdf. Use this skill when you need to map Affymetrix Human Genome U219 Array probe identifiers, handle CDF environments, or convert between (x,y) chip coordinates and single-number indices for this specific microarray platform.

# bioconductor-hgu219cdf

## Overview
The `hgu219cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix Human Genome U219 Array. It is primarily used in the analysis of microarray data to map probe intensities to their respective locations and probe sets.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgu219cdf")
```

## Core Functions and Usage

### Loading the Environment
The package contains two primary environments: `hgu219cdf` (the CDF mapping) and `hgu219dim` (the chip dimensions).

```r
library(hgu219cdf)

# View the CDF environment
hgu219cdf

# View the dimensions of the array
hgu219dim
```

### Coordinate Conversion
Affymetrix chips use both (x,y) coordinates and single-number indices (i) to identify probe locations. This package provides utility functions to convert between them.

#### Convert (x,y) to Index
To convert a 2D coordinate on the chip to a single-number index:
```r
# Example: Get index for x=5, y=5
idx <- xy2i(5, 5)
```

#### Convert Index to (x,y)
To convert a single-number index back into its 2D coordinates:
```r
# Example: Get coordinates for index 500
coords <- i2xy(500)
# Returns a matrix with "x" and "y" columns
```

### Typical Workflow
When processing raw CEL files using the `affy` package, this CDF package is often loaded automatically to provide the structural mapping for the `AffyBatch` object.

```r
library(affy)
library(hgu219cdf)

# If you have CEL files in the working directory
# data <- ReadAffy() 
# The 'data' object will automatically use hgu219cdf if the chip type matches
```

## Technical Details
- **Chip Dimensions**: The U219 array typically has a grid of 744 x 744.
- **Index Range**: Indices range from 1 to 553,536 (744 * 744).
- **Coordinate Range**: x and y coordinates range from 1 to 744.

## Reference documentation
- [hgu219cdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-hgu133acdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133acdf.html
---

# bioconductor-hgu133acdf

name: bioconductor-hgu133acdf
description: Provides specialized R functions and environment data for the HG-U133A Affymetrix GeneChip. Use this skill when working with AffyBatch objects, CEL files, or CDF environments specifically for the hgu133a platform to convert between (x,y) chip coordinates and single-number indices, or to access chip dimensions.

# bioconductor-hgu133acdf

## Overview
The `hgu133acdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Affymetrix HG-U133A microarray. It is primarily used for mapping probe intensities from CEL files to their respective probe sets and managing the spatial layout of the chip.

## Installation
To use this package in R:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hgu133acdf")
library(hgu133acdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to translate between the 2D spatial coordinates on the microarray surface and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates (1 to 712) into a single-number index (1 to 506,944).
- `i2xy(i)`: Converts a single-number index back into a matrix of x and y coordinates.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices back to coordinates
coords <- i2xy(1:10)
# Returns a matrix with "x" and "y" columns
```

### CDF Environments
The package loads two primary environments into the R workspace:

1.  `hgu133acdf`: The main environment describing the CDF file structure (mapping probes to probe sets).
2.  `hgu133adim`: An environment containing the dimensions of the HG-U133A chip (712 x 712 pixels/probes).

## Typical Workflow
This package is usually a dependency for higher-level analysis packages like `affy`. When you load a CEL file from an HG-U133A chip, `affy` automatically looks for this package to correctly interpret the raw data.

```r
library(affy)
# If working with HG-U133A data, the cdfname will be "hgu133a"
# The 'hgu133acdf' package provides the underlying mapping
data <- ReadAffy() 
# You can manually inspect the dimensions
print(hgu133adim)
```

## Reference documentation
- [hgu133acdf Reference Manual](./references/reference_manual.md)
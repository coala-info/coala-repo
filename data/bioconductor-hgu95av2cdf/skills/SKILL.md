---
name: bioconductor-hgu95av2cdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95av2cdf.html
---

# bioconductor-hgu95av2cdf

name: bioconductor-hgu95av2cdf
description: Provides mapping and environment data for the Affymetrix HGU95Av2 chip. Use when working with Bioconductor to handle CDF (Chip Description File) environments, convert between (x,y) coordinates and single-number indices for CEL files, or retrieve chip dimensions for the hgu95av2 platform.

# bioconductor-hgu95av2cdf

## Overview
The `hgu95av2cdf` package is a Bioconductor annotation data package that provides the interface to the Chip Description File (CDF) for the Affymetrix HGU95Av2 microarray. It is primarily used to map probe identifiers to their physical locations on the chip and to manage the structural layout of the array during low-level data analysis (e.g., using the `affy` package).

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgu95av2cdf")
library(hgu95av2cdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

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

### Environment Objects
The package exposes two main environment objects:

1.  `hgu95av2cdf`: An environment describing the CDF file structure (mapping probes to probesets).
2.  `hgu95av2dim`: An environment containing the dimensions of the chip (640 x 640).

**Example:**
```r
# View chip dimensions
ls(hgu95av2dim)
# Get the number of rows/columns (typically 640 for this chip)
as.list(hgu95av2dim)
```

## Typical Workflow
This package is usually a dependency for higher-level analysis. When you load a CEL file from an HGU95Av2 chip using `affy::read.affybatch()`, R automatically looks for this package to organize the probe data.

Manual inspection of probeset mapping:
```r
# Get probe indices for a specific probeset
probeset_name <- ls(hgu95av2cdf)[1]
probe_indices <- get(probeset_name, envir = hgu95av2cdf)
```

## Reference documentation
- [hgu95av2cdf Reference Manual](./references/reference_manual.md)
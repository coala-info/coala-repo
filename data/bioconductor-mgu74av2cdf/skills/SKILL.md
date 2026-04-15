---
name: bioconductor-mgu74av2cdf
description: This package provides the Chip Definition File environment and coordinate mapping data for the Affymetrix Murine Genome U74v2 microarray. Use when user asks to process MG-U74Av2 CEL files, convert between chip coordinates and probe indices, or access the CDF environment for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74av2cdf.html
---

# bioconductor-mgu74av2cdf

name: bioconductor-mgu74av2cdf
description: Provides mapping and annotation data for the Affymetrix Murine Genome U74v2 chip (MG-U74Av2). Use this skill when working with R/Bioconductor to process MG-U74Av2 CEL files, convert between (x,y) chip coordinates and probe indices, or access the CDF environment for this specific array.

# bioconductor-mgu74av2cdf

## Overview

The `mgu74av2cdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix MG-U74Av2 platform. It is primarily used by the `affy` package to map probe-level data to their respective probe sets. It includes utilities for coordinate conversion on the 640x640 grid.

## Installation

To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mgu74av2cdf")
```

## Core Functions and Usage

### Loading the CDF Data
The package is typically loaded automatically by `affy` when reading CEL files, but can be accessed directly:

```r
library(mgu74av2cdf)

# View the CDF environment
mgu74av2cdf

# View chip dimensions (640 x 640)
mgu74av2dim
```

### Coordinate Conversion
Affymetrix chips use a 2D (x,y) coordinate system for probe locations, while Bioconductor's `AffyBatch` objects often use a 1D index.

**Convert (x,y) to a single index:**
```r
# Example: Get index for x=5, y=5
idx <- xy2i(5, 5)
```

**Convert a single index back to (x,y) coordinates:**
```r
# Example: Get coordinates for index 1000
coords <- i2xy(1000)
# Returns a matrix with columns "x" and "y"
```

### Typical Workflow
When analyzing MG-U74Av2 data, this package acts as a backend provider. You do not usually call its functions directly unless you are performing custom probe-level analysis.

```r
library(affy)
# When ReadAffy() encounters MG-U74Av2 data, it searches for this package
data <- ReadAffy() 
# The cdfname will be set to "mgu74av2"
```

## Tips
- **Grid Size**: The MG-U74Av2 chip is a 640x640 grid, resulting in 409,600 total probe cells.
- **Index Range**: Indices used in `i2xy` and `xy2i` range from 1 to 409,600.
- **Coordinate Range**: x and y coordinates range from 1 to 640.

## Reference documentation

- [mgu74av2cdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-hgu95ccdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95ccdf.html
---

# bioconductor-hgu95ccdf

name: bioconductor-hgu95ccdf
description: Provides specialized knowledge for the hgu95ccdf Bioconductor annotation package. Use this skill when working with Affymetrix Human Genome U95 chip data (version 2) to map between (x,y) chip coordinates and single-number indices, or when requiring the CDF environment for probe set mapping.

# bioconductor-hgu95ccdf

## Overview
The `hgu95ccdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Human Genome U95 chip. It is primarily used by other Bioconductor packages like `affy` to map probe intensities to their respective probe sets. It also provides utility functions to convert between 2D chip coordinates and 1D indices.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgu95ccdf")
library(hgu95ccdf)
```

## Core Environments
The package provides two main environments:
- `hgu95ccdf`: The environment describing the CDF file (mapping probes to probe sets).
- `hgu95cdim`: The environment describing the dimensions of the chip (640 x 640).

## Coordinate Conversion
The package includes utilities to convert between the (x,y) coordinates found in CEL files and the single-number indices used in `AffyBatch` objects.

### Convert (x,y) to Index
Use `xy2i(x, y)` to get the 1D index.
```r
# Example: Get index for coordinate (5, 5)
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
Use `i2xy(i)` to get the 2D coordinates.
```r
# Example: Get coordinates for index 100
coords <- i2xy(100)
# Returns a matrix with columns "x" and "y"
```

## Typical Workflow
This package is usually not called directly by the user but is loaded automatically by high-level analysis functions. However, for manual probe inspection:

1. **Check Dimensions**:
   ```r
   ls(hgu95cdim)
   ```
2. **Access CDF Data**:
   ```r
   # List some probe sets
   ls(hgu95ccdf)[1:10]
   
   # Get probe information for a specific probe set
   get("100_at", hgu95ccdf)
   ```

## Usage Tips
- The chip dimensions are fixed at 640 x 640, resulting in indices ranging from 1 to 409,600.
- When using `i2xy`, the returned value is a matrix. To access specific coordinates, use `coords[, "x"]` and `coords[, "y"]`.
- Ensure the package version matches your data; this package is specific to the "c" version of the HG-U95 array.

## Reference documentation
- [hgu95ccdf Reference Manual](./references/reference_manual.md)
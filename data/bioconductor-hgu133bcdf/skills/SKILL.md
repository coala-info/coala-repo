---
name: bioconductor-hgu133bcdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133bcdf.html
---

# bioconductor-hgu133bcdf

name: bioconductor-hgu133bcdf
description: Provides specialized R functions and environment data for the Affymetrix Human Genome U133 Plus 2.0 Array (HG-U133B). Use this skill when working with HG-U133B CEL files, AffyBatch objects, or when needing to map between (x,y) chip coordinates and single-number indices for this specific platform.

# bioconductor-hgu133bcdf

## Overview
The `hgu133bcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix HG-U133B array. It is primarily used by the `affy` package to map probe intensities to their respective probesets. It includes coordinate conversion functions and environment variables describing the chip dimensions.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgu133bcdf")
library(hgu133bcdf)
```

## Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates on the chip and the 1D indices used in `AffyBatch` objects.

### xy2i: Coordinates to Index
Converts x and y coordinates (1 to 712) to a single-number index (1 to 506,944).
```r
# Convert x=5, y=5 to index
idx <- xy2i(5, 5)
```

### i2xy: Index to Coordinates
Converts a single-number index back into a matrix of x and y coordinates.
```r
# Convert index back to coordinates
coords <- i2xy(idx)
# Access x: coords[, "x"]
# Access y: coords[, "y"]
```

## Package Environments
The package exposes two main environments:
- `hgu133bcdf`: The environment containing the mapping of probes to probesets.
- `hgu133bdim`: The environment describing the dimensions of the HG-U133B chip (712 x 712).

To view the contents or dimensions:
```r
# View dimension information
as.list(hgu133bdim)

# Check the number of probesets
length(ls(hgu133bcdf))
```

## Typical Workflow
This package is usually called automatically by high-level functions in the `affy` package when processing HG-U133B data.

```r
library(affy)
# If you have CEL files for HG-U133B in the working directory
data <- ReadAffy() 
# The 'affy' package will automatically look for hgu133bcdf 
# to organize the probe data into probesets.
```

## Reference documentation
- [hgu133bcdf Reference Manual](./references/reference_manual.md)
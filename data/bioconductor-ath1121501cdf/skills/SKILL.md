---
name: bioconductor-ath1121501cdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ath1121501cdf.html
---

# bioconductor-ath1121501cdf

name: bioconductor-ath1121501cdf
description: Access and use the CDF (Chip Definition File) environment for the Affymetrix ATH1-121501 (Arabidopsis thaliana) expression array. Use this skill when processing raw Affymetrix CEL files, working with AffyBatch objects, or mapping probe coordinates to probe sets for the ATH1 genome array.

## Overview

The `ath1121501cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Arabidopsis ATH1-121501 array. This environment is essential for the `affy` package to correctly interpret probe locations and group them into probe sets during normalization and expression calculation.

## Package Installation and Loading

To use this package in R:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ath1121501cdf")
library(ath1121501cdf)
```

## Core Components

### CDF Environment
The main object is `ath1121501cdf`, which contains the mapping between probe set IDs and the physical locations (indices) of probes on the chip.

### Chip Dimensions
Use `ath1121501dim` to retrieve the dimensions of the array:
- **Dimensions**: 712 x 712 pixels/probes.
- **Total Indices**: 506,944.

### Coordinate Conversion
The package provides utility functions to convert between 2D chip coordinates (x, y) and 1D indices (i) used in `AffyBatch` objects.

- **xy2i(x, y)**: Converts x and y coordinates to a single-number index.
- **i2xy(i)**: Converts a single-number index to x and y coordinates.

Note: Coordinates are 1-based (ranging from 1 to 712).

## Typical Workflows

### Implicit Usage with affy
Most users do not call this package directly. When you load raw CEL files using `read.affybatch()`, the `affy` package automatically looks for this package if the chip type is identified as "ath1121501".

```R
library(affy)
# If CEL files are in the current directory
data <- ReadAffy() 
# The ath1121501cdf package will be used automatically to structure 'data'
```

### Manual Coordinate Mapping
If performing custom probe-level analysis, use the conversion functions:

```R
# Get coordinates for a specific index
coords <- i2xy(500)
print(coords) # Returns a matrix with columns x and y

# Get index for specific coordinates
idx <- xy2i(x = 5, y = 5)
print(idx)
```

### Inspecting Probe Sets
To see how many probe sets are defined in the environment:
```R
ls(ath1121501cdf) # Lists probe set identifiers
length(ls(ath1121501cdf)) # Total number of probe sets
```

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
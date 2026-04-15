---
name: bioconductor-poplarcdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for Poplar Affymetrix microarray chips. Use when user asks to map (x,y)-coordinates to indices, convert indices to coordinates, or access CDF environments for Poplar genomic data analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/poplarcdf.html
---

# bioconductor-poplarcdf

name: bioconductor-poplarcdf
description: A specialized skill for working with the Bioconductor annotation package 'poplarcdf'. Use this skill when you need to map (x,y)-coordinates to single-number indices for Poplar Affymetrix chips, or when you need to access the CDF environment and chip dimensions for Poplar genomic data analysis in R.

# bioconductor-poplarcdf

## Overview
The `poplarcdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for Poplar Affymetrix arrays. It is primarily used to map between the physical (x,y) coordinates on a microarray chip and the 1-dimensional indices used in `AffyBatch` objects and CDF environments.

## Installation and Loading
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("poplarcdf")
library(poplarcdf)
```

## Core Functions and Usage

### Coordinate Mapping
The package provides two primary functions to convert between 2D chip coordinates and 1D indices. The Poplar chip has a dimension of 1164 x 1164, resulting in 1,354,896 total indices.

#### xy2i: (x,y) to Index
Converts column (x) and row (y) coordinates into a single-number index.
- **x**: numeric (1 to 1164)
- **y**: numeric (1 to 1164)

```r
# Example: Get index for coordinate (5, 5)
idx <- xy2i(5, 5)
```

#### i2xy: Index to (x,y)
Converts a single-number index back into (x,y) coordinates.
- **i**: numeric (1 to 1354896)

```r
# Example: Get coordinates for index 1000
coords <- i2xy(1000)
# Returns a matrix with "x" and "y" columns
```

### CDF Environments
The package exposes two main environments:
- `poplarcdf`: The environment containing the mapping of probesets to probe locations.
- `poplardim`: The environment describing the dimensions of the Poplar chip.

```r
# View dimensions
poplardim
```

## Typical Workflow
When working with raw CEL files for Poplar data, the `affy` package often uses `poplarcdf` automatically. However, manual mapping is useful for quality control or custom probe analysis:

```r
library(poplarcdf)

# 1. Define a range of indices
i <- 1:10

# 2. Convert to coordinates
coord <- i2xy(i)
print(coord)

# 3. Verify by converting back
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))

# 4. Check coordinate ranges
range(coord[, "x"])
range(coord[, "y"])
```

## Reference documentation
- [poplarcdf Reference Manual](./references/reference_manual.md)
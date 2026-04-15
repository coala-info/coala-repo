---
name: bioconductor-agcdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Agilent Affymetrix microarray platform. Use when user asks to map probe coordinates to indices, convert indices to spatial coordinates, or access CDF metadata for the ag platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/agcdf.html
---

# bioconductor-agcdf

name: bioconductor-agcdf
description: A specialized skill for working with the Bioconductor annotation package 'agcdf'. Use this skill when you need to map coordinates, handle CDF environments, or manage probe indices for the Agilent (ag) Affymetrix chip platform in R.

# bioconductor-agcdf

## Overview
The `agcdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Agilent (ag) platform. It is primarily used in transcriptomics workflows to map between (x, y) coordinates on a microarray chip and the single-number indices used in `AffyBatch` objects and CDF environments.

## Core Functions and Usage

### Loading the Package
To use the annotation data, load the library in your R session:
```r
library(agcdf)
```

### Coordinate Conversion
The package provides two essential functions for converting between 2D chip layout and 1D indices. The chip dimensions for this platform are 534 x 534 (totaling 285,156 indices).

#### Convert (x, y) to Index
To find the single-number index for a specific probe coordinate:
```r
# xy2i(x, y)
idx <- xy2i(5, 5)
```

#### Convert Index to (x, y)
To find the spatial coordinates for a given probe index:
```r
# i2xy(i)
coords <- i2xy(1000)
# Returns a matrix with columns "x" and "y"
```

### CDF Environments
The package exposes two main environments containing metadata about the chip:
- `agcdf`: The environment describing the CDF file structure.
- `agdim`: The environment describing the CDF dimensions (e.g., number of rows and columns).

## Typical Workflow Example
When validating probe locations or manually extracting intensity data from CEL files:

```r
library(agcdf)

# 1. Define a range of indices
i <- 1:1000

# 2. Convert indices to coordinates
coord <- i2xy(i)
print(head(coord))

# 3. Verify the conversion back to indices
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))

# 4. Check chip boundaries
range(coord[, "x"]) # Should be within 1 to 534
range(coord[, "y"]) # Should be within 1 to 534
```

## Tips
- The indices used in this package are 1-based, consistent with R's indexing convention.
- This package is a data-only annotation package; it is typically called internally by high-level analysis packages like `affy`, but can be used directly for custom probe-level analysis.

## Reference documentation
- [agcdf Reference Manual](./references/reference_manual.md)
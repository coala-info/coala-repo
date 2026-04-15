---
name: bioconductor-test1cdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix test1 platform. Use when user asks to map probe indices to chip coordinates, convert x and y coordinates to indices, or access the CDF environment for the test1 chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/test1cdf.html
---

# bioconductor-test1cdf

name: bioconductor-test1cdf
description: Use this skill when working with the Bioconductor annotation package 'test1cdf'. This is essential for tasks involving Affymetrix microarray data that require mapping between probe indices and (x,y) chip coordinates, or when accessing the Chip Definition File (CDF) environment for the 'test1' platform.

# bioconductor-test1cdf

## Overview
The `test1cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for a specific Affymetrix test chip. It allows for the translation between physical chip coordinates and the single-number indices used in `AffyBatch` objects and other Bioconductor tools.

## Installation and Loading
To use this package in an R session:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("test1cdf")

library(test1cdf)
```

## Coordinate Mapping
The package provides two primary functions to convert between probe indices and chip coordinates. The chip dimensions for this package are 256 x 256, resulting in 65,536 total indices.

### Convert Index to Coordinates
Use `i2xy()` to convert a single-number index into its corresponding x and y coordinates.

```R
# Convert index 500 to coordinates
coords <- i2xy(500)
# Returns a matrix with columns "x" and "y"
```

### Convert Coordinates to Index
Use `xy2i()` to convert x and y coordinates into a single-number index.

```R
# Convert x=5, y=5 to an index
idx <- xy2i(5, 5)
```

## CDF Environments
The package exposes two environment objects containing metadata about the chip layout:

- `test1cdf`: The main environment describing the CDF mapping (probeset to location).
- `test1dim`: An environment describing the dimensions of the chip (e.g., 256x256).

To inspect these environments:
```R
ls(test1cdf)
as.list(test1dim)
```

## Typical Workflow
1. Load the library.
2. Use `test1cdf` automatically via higher-level packages like `affy` by specifying `cdfname="test1"`.
3. Manually map probe locations for quality control or custom visualization using `i2xy` and `xy2i`.

## Reference documentation
- [test1cdf Reference Manual](./references/reference_manual.md)
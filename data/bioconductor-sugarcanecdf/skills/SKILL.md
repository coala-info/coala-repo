---
name: bioconductor-sugarcanecdf
description: This package provides the Chip Definition File mapping for the Sugarcane Affymetrix genome chip to convert between physical coordinates and probe indices. Use when user asks to map probe coordinates to indices, work with AffyBatch objects for sugarcane genomic data, or manage CDF environments for sugarcane microarrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/sugarcanecdf.html
---

# bioconductor-sugarcanecdf

name: bioconductor-sugarcanecdf
description: A specialized skill for working with the Bioconductor annotation package 'sugarcanecdf'. Use this skill when you need to map probe coordinates to indices for the Sugarcane Affymetrix chip, or when working with AffyBatch objects and CDF environments specifically for sugarcane genomic data.

# bioconductor-sugarcanecdf

## Overview
The `sugarcanecdf` package is a Bioconductor annotation interface for the Sugarcane Affymetrix genome chip. Its primary purpose is to provide the environment mapping between (x, y) coordinates on the physical chip and the single-number indices used in R's `AffyBatch` objects. This is essential for low-level analysis of sugarcane microarray data.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("sugarcanecdf")
```

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to convert between 2D chip coordinates and 1D indices. The chip dimensions are 478 x 478 pixels (total 228,484 indices).

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

#### Example Workflow
```r
library(sugarcanecdf)

# 1. Convert specific coordinates to an index
idx <- xy2i(5, 5)

# 2. Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"

# 3. Verify dimensions
# x and y range from 1 to 478
# i ranges from 1 to 228484
```

### CDF Environments
The package loads two main environments into the R workspace:
- `sugarcanecdf`: The main environment describing the Chip Definition File (CDF) mapping.
- `sugarcanedim`: An environment containing the dimensions of the sugarcane chip.

These are typically used internally by other Bioconductor packages like `affy` to process `.CEL` files.

```r
# View the environment details
sugarcanecdf
sugarcanedim
```

## Typical Workflow with Affy
When analyzing sugarcane microarray data, you don't usually call `sugarcanecdf` functions directly. Instead, the `affy` package detects the chip type and uses this package automatically:

```r
library(affy)
library(sugarcanecdf)

# When reading CEL files, affy looks for the corresponding cdf package
# data <- ReadAffy() 
# If the CEL files are from a Sugarcane chip, sugarcanecdf is used to map probes.
```

## Reference documentation
- [sugarcanecdf Reference Manual](./references/reference_manual.md)
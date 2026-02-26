---
name: bioconductor-ecoli2cdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix Escherichia coli antisense genome array. Use when user asks to handle E. coli antisense genome array data, map between chip coordinates and CEL file indices, or access the CDF environment for Affymetrix E. coli arrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ecoli2cdf.html
---


# bioconductor-ecoli2cdf

name: bioconductor-ecoli2cdf
description: A specialized skill for working with the Bioconductor annotation package 'ecoli2cdf'. Use this skill when you need to handle E. coli antisense genome array data in R, specifically for mapping between (x,y) chip coordinates and CEL file indices, or when accessing the CDF environment for Affymetrix E. coli arrays.

# bioconductor-ecoli2cdf

## Overview

The `ecoli2cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Escherichia coli antisense genome array. It is primarily used in transcriptomics workflows to map probe intensities to their respective genomic locations and to handle the spatial dimensions of the Affymetrix chip.

## Installation and Loading

To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ecoli2cdf")
library(ecoli2cdf)
```

## Core Components

### 1. CDF Environments
The package provides two primary environments:
- `ecoli2cdf`: The environment describing the CDF file structure.
- `ecoli2dim`: The environment describing the dimensions of the CDF (the chip layout).

### 2. Coordinate Mapping (i2xy and xy2i)
Affymetrix chips use a grid system. This package provides functions to convert between 2D (x,y) coordinates and 1D indices used in `AffyBatch` objects.

**Dimensions for ecoli2cdf:**
- **X-range:** 1 to 478
- **Y-range:** 1 to 478
- **Total Indices:** 228,484

**Usage:**
```r
# Convert (x, y) coordinates to a single index
idx <- xy2i(x = 5, y = 5)

# Convert a single index back to (x, y) coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

## Typical Workflow

When analyzing E. coli microarray data, this package is often called internally by `affy` functions, but manual coordinate mapping is useful for quality control or spatial bias visualization:

```r
library(ecoli2cdf)

# Create a vector of all possible indices
all_indices <- 1:(478 * 478)

# Convert all indices to coordinates
coord_matrix <- i2xy(all_indices)

# Verify ranges
range(coord_matrix[, "x"]) # Should be 1 478
range(coord_matrix[, "y"]) # Should be 1 478

# Convert back to indices to verify consistency
original_indices <- xy2i(coord_matrix[, "x"], coord_matrix[, "y"])
stopifnot(all(all_indices == original_indices))
```

## Tips
- The `i2xy` and `xy2i` functions are optimized for the specific dimensions of the E. coli antisense array.
- To view the underlying R code for these functions, simply type the function name without parentheses (e.g., `i2xy`) in the R console.

## Reference documentation

- [ecoli2cdf Reference Manual](./references/reference_manual.md)
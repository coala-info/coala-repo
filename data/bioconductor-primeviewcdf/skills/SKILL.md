---
name: bioconductor-primeviewcdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix PrimeView GeneChip. Use when user asks to map probe coordinates to indices, convert indices to physical chip locations, or access CDF metadata for PrimeView microarray analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/primeviewcdf.html
---


# bioconductor-primeviewcdf

name: bioconductor-primeviewcdf
description: A specialized skill for working with the Bioconductor annotation package 'primeviewcdf'. Use this skill when you need to map (x,y)-coordinates to probe indices for the Affymetrix PrimeView GeneChip, or when you need to access the CDF environment and chip dimensions for this specific platform.

# bioconductor-primeviewcdf

## Overview
The `primeviewcdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix PrimeView GeneChip. It is primarily used in the analysis of microarray data to map physical probe locations on the chip to their corresponding indices in `AffyBatch` objects and vice versa.

## Installation
To use this package in R, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("primeviewcdf")
```

## Core Functions and Usage

### Coordinate Mapping
The package provides two essential functions for converting between 2D chip coordinates and 1D indices. The chip dimensions for PrimeView are 732 x 732, resulting in 535,824 total indices.

#### Convert (x,y) to Index
Use `xy2i()` to convert column (x) and row (y) coordinates into a single-number index.
```r
library(primeviewcdf)
# Get index for a specific probe at x=5, y=5
idx <- xy2i(5, 5)
```

#### Convert Index to (x,y)
Use `i2xy()` to convert a single-number index back into its physical (x,y) coordinates.
```r
# Get coordinates for a range of indices
indices <- 1:10
coords <- i2xy(indices)
# Returns a matrix with columns "x" and "y"
```

### Accessing CDF Data
The package provides two main environments:

1.  **primeviewcdf**: The environment containing the mapping between probesets and probe indices.
2.  **primeviewdim**: The environment describing the dimensions of the PrimeView chip.

```r
# View the CDF environment
primeviewcdf

# View chip dimensions
primeviewdim
```

## Typical Workflow
When analyzing Affymetrix PrimeView data using the `affy` package, this package is often loaded automatically to provide the necessary metadata for an `AffyBatch` object.

```r
library(affy)
library(primeviewcdf)

# If you have a CEL file
# data <- ReadAffy() 
# The 'affy' package will look for primeviewcdf if the CEL header specifies it.

# Manual verification of coordinates
i <- 1000
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(i == j)
```

## Reference documentation
- [primeviewcdf Reference Manual](./references/reference_manual.md)
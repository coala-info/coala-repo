---
name: bioconductor-hgu133a2cdf
description: This package provides the Chip Definition File environment for the Affymetrix Human Genome U133A 2.0 Array. Use when user asks to map probe coordinates to indices, access array dimensions, or retrieve probeset metadata for HG-U133A 2.0 data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133a2cdf.html
---

# bioconductor-hgu133a2cdf

name: bioconductor-hgu133a2cdf
description: A specialized interface for the hgu133a2cdf Bioconductor annotation package. Use this skill when working with Affymetrix Human Genome U133A 2.0 Array data in R, specifically for mapping probe (x,y) coordinates to indices and accessing Chip Definition File (CDF) environment metadata.

# bioconductor-hgu133a2cdf

## Overview
The `hgu133a2cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix Human Genome U133A 2.0 Array. It is primarily used to map probe locations on the chip to their corresponding indices in `AffyBatch` objects and to provide dimensions for the array.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgu133a2cdf")
library(hgu133a2cdf)
```

## Core Functions and Usage

### Coordinate Conversion (i2xy and xy2i)
Affymetrix CEL files use (x,y) coordinates, while R objects like `AffyBatch` often use single-number indices. This package provides utilities to convert between them.

**Convert (x,y) to Index:**
```r
# Get the index for a probe at x=5, y=5
idx <- xy2i(5, 5)
```

**Convert Index to (x,y):**
```r
# Get coordinates for a specific index
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

**Array Dimensions:**
The array is a 732 x 732 grid.
- x-coordinates range from 1 to 732.
- y-coordinates range from 1 to 732.
- Indices range from 1 to 535,824.

### Accessing CDF Data
The package provides two main environment objects:

1.  **hgu133a2cdf**: The environment containing the mapping of probesets to probe indices.
2.  **hgu133a2dim**: The environment containing the dimensions of the array.

```r
# View dimensions
as.list(hgu133a2dim)

# List probesets (first 5)
ls(hgu133a2cdf)[1:5]

# Get probe indices for a specific probeset
get("200000_s_at", hgu133a2cdf)
```

## Typical Workflow
When analyzing Affy HG-U133A 2.0 data, this package is usually called internally by `affy` or `limma` functions. However, for manual probe-level inspection:

1.  Identify a probeset of interest.
2.  Retrieve the indices from `hgu133a2cdf`.
3.  Convert those indices to (x,y) coordinates using `i2xy` to locate them on the physical chip or in the CEL file data.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
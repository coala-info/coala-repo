---
name: bioconductor-gp53cdf
description: This package provides the Chip Definition File environment for the Affymetrix gp53 platform to map probe coordinates to indices. Use when user asks to handle gp53 chip data, convert between (x,y) coordinates and probe indices, or access the CDF environment in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/gp53cdf.html
---

# bioconductor-gp53cdf

name: bioconductor-gp53cdf
description: A specialized skill for working with the Bioconductor annotation package 'gp53cdf'. Use this skill when you need to handle Affymetrix CDF (Chip Definition File) data for the gp53 chip, specifically for mapping probe (x,y) coordinates to indices and accessing the CDF environment in R.

# bioconductor-gp53cdf

## Overview

The `gp53cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the gp53 Affymetrix platform. It is primarily used in transcriptomics workflows to map raw probe intensities from CEL files to their corresponding probe sets. The package provides tools to convert between 2D chip coordinates and 1D indices used in `AffyBatch` objects.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("gp53cdf")
library(gp53cdf)
```

## Core Functions and Usage

### Coordinate Conversion

The package provides two primary functions to convert between the (x,y) grid coordinates on the chip and the single-number indices used in R environments. The chip dimensions for gp53 are 256 x 256, resulting in 65,536 total indices.

#### Convert (x,y) to Index
Use `xy2i(x, y)` to get the 1D index.
```r
library(gp53cdf)
# Get the index for a probe at x=5, y=5
idx <- xy2i(5, 5)
```

#### Convert Index to (x,y)
Use `i2xy(i)` to get a matrix of coordinates.
```r
# Get coordinates for a specific index
coords <- i2xy(idx)
# coords will be a matrix with columns "x" and "y"
```

### Accessing CDF Data

The package contains two main environments:

1.  `gp53cdf`: The environment containing the mapping of probe sets to probe indices.
2.  `gp53dim`: The environment describing the dimensions of the gp53 chip.

```r
# View the CDF environment
ls(gp53cdf)[1:10] # List first 10 probe sets

# Get dimensions
ls(gp53dim)
```

## Typical Workflow

When working with `affy` or other Bioconductor packages, `gp53cdf` is often loaded automatically when an `AffyBatch` object identifies its chip type as "gp53". However, manual coordinate mapping is useful for quality control or custom probe analysis:

```r
# Verify coordinate round-tripping
i <- 1:65536
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))

# Check coordinate ranges
range(coord[, "x"]) # Should be 1 to 256
range(coord[, "y"]) # Should be 1 to 256
```

## Reference documentation

- [gp53cdf Reference Manual](./references/reference_manual.md)
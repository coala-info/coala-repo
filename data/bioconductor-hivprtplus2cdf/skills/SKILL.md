---
name: bioconductor-hivprtplus2cdf
description: This tool provides coordinate conversion and environment access for the HIVPRTPLUS2 Affymetrix chip annotation package. Use when user asks to map between (x,y) chip coordinates and single-number indices, access CDF environments, or process HIVPRTPLUS2 platform data in Bioconductor.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hivprtplus2cdf.html
---

# bioconductor-hivprtplus2cdf

name: bioconductor-hivprtplus2cdf
description: Provides specialized coordinate conversion and environment access for the hivprtplus2cdf Bioconductor annotation package. Use this skill when working with HIVPRTPLUS2 Affymetrix chip data in R, specifically for mapping between (x,y) chip coordinates and single-number indices used in AffyBatch objects.

# bioconductor-hivprtplus2cdf

## Overview

The `hivprtplus2cdf` package is a Bioconductor annotation interface for the HIVPRTPLUS2 Affymetrix chip. Its primary utility is providing the CDF (Chip Description File) environment and helper functions to translate between the physical 2D layout of the chip and the 1D indexing used in R's Bioconductor data structures.

The chip dimensions are 230 x 230, resulting in 52,900 total indices.

## Core Functions and Usage

### Loading the Package
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hivprtplus2cdf")

library(hivprtplus2cdf)
```

### Coordinate Conversion
The package provides two essential functions for mapping probe locations:

1.  **xy2i**: Converts (x, y) coordinates to a single-number index.
2.  **i2xy**: Converts a single-number index back to (x, y) coordinates.

```r
# Convert specific coordinates to an index
# x and y range from 1 to 230
idx <- xy2i(x = 5, y = 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

### Accessing CDF Environments
The package exposes two main environments used by other Bioconductor tools (like `affy`):

*   `hivprtplus2cdf`: The main environment describing the CDF file structure.
*   `hivprtplus2dim`: An environment containing the dimensions of the chip.

```r
# View dimension information
ls(hivprtplus2dim)
```

## Typical Workflow

When analyzing Affymetrix data, these functions are typically used to identify the physical location of specific probes identified as outliers or of interest during quality control.

```r
# Example: Validating the round-trip conversion for all probes
i <- 1:52900
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])

# Verify all indices match
stopifnot(all(i == j))

# Check coordinate ranges
range(coord[, "x"]) # Should be 1 230
range(coord[, "y"]) # Should be 1 230
```

## Tips
*   **Indexing**: Note that the indices range from 1 to 52,900.
*   **Integration**: This package is rarely used in isolation; it is usually a dependency for the `affy` package when processing `.CEL` files from the HIVPRTPLUS2 platform. You do not usually need to call `xy2i` manually unless you are performing custom spatial analysis of the chip.

## Reference documentation
- [hivprtplus2cdf Reference Manual](./references/reference_manual.md)
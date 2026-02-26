---
name: bioconductor-htmg430acdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix HT Mouse Genome 430A Array. Use when user asks to map probe coordinates to indices, access CDF environment metadata, or process HT_MG-430A microarray data in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htmg430acdf.html
---


# bioconductor-htmg430acdf

name: bioconductor-htmg430acdf
description: Provides specialized knowledge for the htmg430acdf Bioconductor annotation package. Use this skill when working with Affymetrix HT Mouse Genome 430A Array data in R, specifically for mapping probe (x,y) coordinates to indices and accessing CDF environment metadata.

# bioconductor-htmg430acdf

## Overview

The `htmg430acdf` package is a Bioconductor annotation interface for the Affymetrix HT_MG-430A chip. It provides the Chip Definition File (CDF) environment, which is essential for processing CEL files into `AffyBatch` objects. Its primary utility lies in mapping between the physical (x,y) coordinates on the microarray and the single-number indices used in R's data structures.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("htmg430acdf")
library(htmg430acdf)
```

## Core Functions and Usage

### Coordinate Mapping (i2xy and xy2i)

The package provides two utility functions to convert between 2D chip coordinates and 1D indices. The chip dimensions for htmg430a are 744 x 744, resulting in 553,536 total indices.

*   **xy2i**: Converts x and y coordinates to a single index.
*   **i2xy**: Converts a single index back into x and y coordinates.

```r
# Convert specific coordinates to an index
index <- xy2i(x = 5, y = 5)

# Convert an index back to coordinates
coords <- i2xy(index)
# Returns a matrix with columns "x" and "y"

# Validation example
all.equal(xy2i(coords[,"x"], coords[,"y"]), index)
```

### CDF Environments

The package exposes two main environment objects:

1.  `htmg430acdf`: The main environment containing the mapping of probesets to probe locations.
2.  `htmg430adim`: An environment describing the dimensions of the CDF (e.g., number of rows and columns).

```r
# View dimension information
ls(htmg430adim)

# Accessing the CDF environment directly (usually handled by affy functions)
# Example: Get probe information for a specific probeset
# probeset_info <- get("1415670_at", envir = htmg430acdf)
```

## Typical Workflow

This package is rarely used in isolation. It is typically a dependency for the `affy` package when reading CEL files:

1.  Load the `affy` library.
2.  Use `ReadAffy()` to load data.
3.  The `affy` package automatically looks for `htmg430acdf` if the CEL file headers indicate the HT_MG-430A platform.
4.  Use the coordinate functions if you need to perform custom quality control or spatial analysis on the chip surface.

## Reference documentation

- [htmg430acdf Reference Manual](./references/reference_manual.md)
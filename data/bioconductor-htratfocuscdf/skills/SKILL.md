---
name: bioconductor-htratfocuscdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htratfocuscdf.html
---

# bioconductor-htratfocuscdf

name: bioconductor-htratfocuscdf
description: Provides specialized environment data and coordinate mapping functions for the Rat Focus Genome Array (HT_Rat-Focus). Use this skill when working with Affymetrix Rat Focus microarray data in R, specifically for mapping (x,y) chip coordinates to probe indices and accessing the CDF (Chip Definition File) environment.

# bioconductor-htratfocuscdf

## Overview

The `htratfocuscdf` package is a Bioconductor annotation package that provides the Chip Definition File (CDF) environment for the Affymetrix Rat Focus Genome Array. It is primarily used in conjunction with the `affy` package to process raw CEL files. It includes mapping functions to convert between 2D chip coordinates and 1D probe indices, as well as environment objects defining the chip's layout and dimensions.

## Installation and Loading

To use this package, it must be installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("htratfocuscdf")
library(htratfocuscdf)
```

## Core Functions and Objects

### Coordinate Mapping (i2xy and xy2i)

The package provides utility functions to translate between the (x,y) coordinates on the microarray chip and the single-number indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single index `i`.
- `i2xy(i)`: Converts a single index `i` back into x and y coordinates.

**Dimensions:**
- X-coordinates: 1 to 744
- Y-coordinates: 1 to 744
- Total Indices: 1 to 553,536

**Example Usage:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# coords is a matrix with columns "x" and "y"

# Verify ranges
range(coords[, "x"])
range(coords[, "y"])
```

### CDF Environments

The package exposes two main environment objects:

1.  `htratfocuscdf`: The main environment containing the mapping of probe set IDs to probe locations.
2.  `htratfocusdim`: An environment containing the dimensions of the Rat Focus array.

These are typically accessed automatically by high-level functions in the `affy` package (e.g., `ReadAffy()`), but can be inspected directly:

```r
# List some probe sets in the CDF
ls(htratfocuscdf)[1:10]

# Get dimensions
ls(htratfocusdim)
```

## Typical Workflow

This package is usually a dependency for analyzing Rat Focus arrays. A common workflow involves:

1.  Loading raw data using `affy::ReadAffy()`.
2.  The `affy` package automatically detects and loads `htratfocuscdf` to interpret the CEL file structure.
3.  Using `i2xy` or `xy2i` if manual probe-level extraction or visualization of the chip surface is required.

## Reference documentation

- [htratfocuscdf Reference Manual](./references/reference_manual.md)
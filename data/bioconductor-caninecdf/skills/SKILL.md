---
name: bioconductor-caninecdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix Canine Genome Array. Use when user asks to access CDF environments for canine microarrays, convert between chip coordinates and indices, or retrieve chip dimensions for the Affymetrix Canine Genome Array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/caninecdf.html
---

# bioconductor-caninecdf

name: bioconductor-caninecdf
description: A specialized skill for working with the Bioconductor annotation package 'caninecdf'. Use this skill when you need to access CDF (Chip Definition File) environments for the Affymetrix Canine Genome Array, specifically for mapping probe coordinates to indices and retrieving chip dimensions in R.

# bioconductor-caninecdf

## Overview
The `caninecdf` package is a Bioconductor annotation data package that provides the CDF environment for the Affymetrix Canine Genome Array. It is primarily used in transcriptomics workflows to map between (x,y) coordinates on the microarray chip and the single-number indices used in `AffyBatch` objects and CDF environments.

## Installation and Loading
To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("caninecdf")
library(caninecdf)
```

## Key Components and Functions

### CDF Environments
The package exposes two main environments:
- `caninecdf`: The environment describing the CDF file, mapping probesets to their locations.
- `caninedim`: An environment containing the dimensions of the chip.

### Coordinate Conversion (i2xy)
The package provides utility functions to convert between 2D chip coordinates and 1D indices. The chip dimensions for this array are 732 x 732.

- `xy2i(x, y)`: Converts x and y coordinates (1 to 732) to a single-number index (1 to 535,824).
- `i2xy(i)`: Converts a single-number index back into a matrix of x and y coordinates.

#### Example Workflow
```r
library(caninecdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices back to coordinates
indices <- 1:10
coords <- i2xy(indices)

# Verify dimensions
# x-range: 1 to 732
# y-range: 1 to 732
range(coords[, "x"])
range(coords[, "y"])
```

## Usage Tips
- This package is typically used as a dependency by higher-level analysis packages like `affy`. You rarely need to call these functions manually unless you are performing custom low-level probe analysis.
- The index `i` is 1-based, following standard R indexing conventions.
- To view the underlying function definitions for the coordinate conversions, you can type `i2xy` or `xy2i` without parentheses at the R prompt.

## Reference documentation
- [caninecdf Reference Manual](./references/reference_manual.md)
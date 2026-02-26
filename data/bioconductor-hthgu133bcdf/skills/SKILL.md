---
name: bioconductor-hthgu133bcdf
description: This package provides Chip Definition File mapping and coordinate conversion for the Affymetrix HT Human Genome U133B microarray. Use when user asks to map probe coordinates to indices, access CDF environment metadata, or convert between 2D chip layouts and 1D indices for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133bcdf.html
---


# bioconductor-hthgu133bcdf

name: bioconductor-hthgu133bcdf
description: A specialized skill for working with the Bioconductor annotation package hthgu133bcdf. Use this skill when you need to map probe coordinates to indices or access CDF environment metadata for the Affymetrix HT Human Genome U133B array.

# bioconductor-hthgu133bcdf

## Overview
The `hthgu133bcdf` package is a Bioconductor Chip Definition File (CDF) package for the Affymetrix HT Human Genome U133B array. It provides the necessary mapping between the physical (x, y) coordinates on the microarray chip and the 1-dimensional indices used in `AffyBatch` objects and other Bioconductor analysis workflows.

## Core Functions and Usage

### Loading the Package
To use the environment and functions, first load the library in R:
```R
library(hthgu133bcdf)
```

### Coordinate Conversion
The package provides two primary functions to convert between 2D chip layout and 1D indexing. The chip dimensions for this array are 744 x 744.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example Workflow:**
```R
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns

# Verify consistency across the entire chip range (1 to 553,536)
i <- 1:(744*744)
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))
```

### Accessing CDF Data
The package exposes two main environments:
- `hthgu133bcdf`: The main environment containing the mapping of probesets to their constituent probe indices.
- `hthgu133bdim`: An environment containing the dimensions of the HT-HG-U133B chip.

To see the contents or keys (probeset IDs) within the CDF:
```R
# List some probeset IDs
ls(hthgu133bcdf)[1:10]

# Get probe information for a specific probeset
get("200000_s_at", hthgu133bcdf)
```

## Tips
- The indices are 1-based, following standard R convention.
- This package is typically used as a dependency by higher-level packages like `affy`. You rarely need to call `i2xy` manually unless you are performing custom low-level spatial analysis of CEL files.
- Ensure the array type of your data matches "HT-HG-U133B" before using this specific annotation package.

## Reference documentation
- [hthgu133bcdf Reference Manual](./references/reference_manual.md)
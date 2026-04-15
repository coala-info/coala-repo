---
name: bioconductor-hgu95ecdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix HG-U95E microarray platform. Use when user asks to map probe coordinates to indices, access the HG-U95E CDF environment, or retrieve chip dimension information for custom probe-level analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95ecdf.html
---

# bioconductor-hgu95ecdf

name: bioconductor-hgu95ecdf
description: A specialized skill for working with the Bioconductor annotation package hgu95ecdf. Use this skill when you need to map Affymetrix HG-U95E chip coordinates (x, y) to single-number indices, access the CDF environment for the HG-U95E platform, or retrieve chip dimension information.

# bioconductor-hgu95ecdf

## Overview
The `hgu95ecdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix HG-U95E platform. It provides the mapping between the physical location of probes on the microarray (x, y coordinates) and their corresponding indices used in `AffyBatch` objects.

## Installation
To use this package in R:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgu95ecdf")
library(hgu95ecdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to convert between 2D chip coordinates and 1D indices. The HG-U95E chip has a grid of 640 x 640 (409,600 total units).

- `xy2i(x, y)`: Converts x and y coordinates (1 to 640) into a single-number index (1 to 409,600).
- `i2xy(i)`: Converts a single-number index into a matrix containing the corresponding x and y coordinates.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

### Accessing Environments
The package loads two main environments into the R workspace:

1.  `hgu95ecdf`: The environment containing the mapping of probeset IDs to probe locations.
2.  `hgu95edim`: The environment containing the dimensions of the HG-U95E chip.

**Example:**
```r
# View dimensions
ls(hgu95edim)

# List probesets in the CDF
# ls(hgu95ecdf) |> head()
```

## Typical Workflow
When analyzing Affymetrix data, this package is usually called internally by higher-level packages like `affy`. However, manual usage is common when performing custom probe-level analysis:

1.  **Load the library**: `library(hgu95ecdf)`
2.  **Identify Probes**: Use the `hgu95ecdf` environment to find indices for a specific probeset.
3.  **Map to Coordinates**: Use `i2xy()` to find where those probes are physically located on the array for spatial quality control.
4.  **Validate**: Use `xy2i()` to ensure indices match the expected CEL file structure.

## Reference documentation
- [hgu95ecdf Reference Manual](./references/reference_manual.md)
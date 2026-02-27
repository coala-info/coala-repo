---
name: bioconductor-wheatcdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Wheat Genome Array. Use when user asks to map probe coordinates to indices, access wheat genome array CDF data, or convert between x-y coordinates and single-number indices.
homepage: https://bioconductor.org/packages/release/data/annotation/html/wheatcdf.html
---


# bioconductor-wheatcdf

name: bioconductor-wheatcdf
description: A specialized skill for working with the Bioconductor 'wheatcdf' package. Use this skill when you need to handle Affymetrix Wheat Genome Array CDF data, specifically for mapping (x,y) coordinates to probe indices and accessing the CDF environment in R.

# bioconductor-wheatcdf

## Overview
The `wheatcdf` package is an annotation package providing the Chip Definition File (CDF) environment for the Affymetrix Wheat Genome Array. It is primarily used in transcriptomics workflows to map probe intensities from CEL files to their respective probe sets. The array has a dimension of 1164 x 1164, totaling 1,354,896 indices.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("wheatcdf")
```

## Core Functions and Usage

### Loading the Package
```r
library(wheatcdf)
```

### Coordinate Mapping
The package provides utility functions to convert between 2D chip coordinates (x, y) and 1D indices (i) used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Parameters:**
- `x`: Numeric, x-coordinate (1 to 1164).
- `y`: Numeric, y-coordinate (1 to 1164).
- `i`: Numeric, single-number index (1 to 1,354,896).

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix or data frame with "x" and "y" columns
```

### CDF Environments
The package exposes two main environments:
- `wheatcdf`: The environment containing the mapping of probe sets to probe locations.
- `wheatdim`: The environment describing the dimensions of the Wheat Genome Array.

To see the contents or probe sets within the CDF:
```r
# List some probe sets
ls(wheatcdf)[1:10]

# Get dimensions
ls(wheatdim)
```

## Typical Workflow
This package is usually a dependency for higher-level analysis packages like `affy`. When you load a Wheat Genome Array CEL file using `read.affybatch()`, the `affy` package automatically looks for `wheatcdf` to organize the data.

Manual coordinate verification:
```r
# Verify mapping consistency
i <- 1:1000
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))
```

## Reference documentation
- [wheatcdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-mirna20cdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix miRNA 2.0 Array. Use when user asks to map probe coordinates to indices, access the CDF environment, or retrieve chip dimensions for miRNA 2.0 microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mirna20cdf.html
---

# bioconductor-mirna20cdf

name: bioconductor-mirna20cdf
description: A specialized skill for working with the Bioconductor annotation package 'mirna20cdf'. Use this skill when analyzing Affymetrix miRNA 2.0 Array data in R, specifically for mapping probe (x,y) coordinates to indices, accessing the CDF environment, or retrieving chip dimensions.

# bioconductor-mirna20cdf

## Overview

The `mirna20cdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix miRNA 2.0 Array. It provides the necessary mapping between probe set identifiers and their physical locations on the microarray. This skill helps in converting between 2D spatial coordinates and 1D indices used in `AffyBatch` objects, and provides access to the chip's structural metadata.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mirna20cdf")
library(mirna20cdf)
```

## Core Functions and Usage

### Coordinate Conversion

The package provides utility functions to convert between (x,y) coordinates on the chip and the single-number indices used by Affymetrix data structures.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Parameters:**
- `x`: Numeric x-coordinate (range: 1 to 478).
- `y`: Numeric y-coordinate (range: 1 to 478).
- `i`: Numeric single-number index (range: 1 to 228,484).

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix/data frame with "x" and "y" columns
```

### CDF Environments

The package exposes two primary environments:

1.  `mirna20cdf`: The main environment containing the mapping of probe sets to probe indices.
2.  `mirna20dim`: An environment containing the dimensions of the miRNA 2.0 array (478 x 478).

**Accessing Metadata:**
```r
# View dimensions
ls(mirna20dim)
# Get the number of rows/columns
get("nrow", envir = mirna20dim)
get("ncol", envir = mirna20dim)
```

## Typical Workflow

When working with raw CEL files for miRNA 2.0 arrays, the `affy` package automatically looks for this CDF package to process the data.

```r
library(affy)
library(mirna20cdf)

# Read CEL files (mirna20cdf is used automatically if the chip type matches)
data <- ReadAffy()

# Manually access probe locations for a specific probe set
probe_names <- ls(mirna20cdf)[1:5]
probes <- get(probe_names[1], envir = mirna20cdf)
```

## Reference documentation

- [mirna20cdf Reference Manual](./references/reference_manual.md)
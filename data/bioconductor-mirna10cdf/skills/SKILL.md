---
name: bioconductor-mirna10cdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix miRNA-1.0 array. Use when user asks to map probe coordinates to indices, access CDF data for the miRNA-1.0 chip, or perform low-level analysis of Affymetrix CEL files.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mirna10cdf.html
---


# bioconductor-mirna10cdf

name: bioconductor-mirna10cdf
description: A specialized skill for working with the Bioconductor annotation package 'mirna10cdf'. Use this skill when you need to map probe coordinates to indices for the Affymetrix miRNA-1.0 array, or when working with the CDF environment for this specific chip.

# bioconductor-mirna10cdf

## Overview
The `mirna10cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix miRNA-1.0 array. It is primarily used in low-level analysis of Affymetrix CEL files to map (x, y) coordinates on the chip to single-number indices used in `AffyBatch` objects and vice versa.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mirna10cdf")
```

## Core Functions and Usage

### Loading the Package
```r
library(mirna10cdf)
```

### Coordinate Conversion
The package provides utility functions to convert between the 2D grid coordinates of the chip and the 1D indices used in R environments. The miRNA-1.0 chip has dimensions of 230 x 230 (52,900 total features).

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"

# Validate the entire range
i <- 1:52900
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))
```

### Accessing CDF Data
The package contains two main environments:
- `mirna10cdf`: The main environment describing the CDF file structure (mapping probesets to probe locations).
- `mirna10dim`: An environment containing the dimensions of the array (230x230).

To see the contents of the CDF environment:
```r
# List probesets in the environment
ls(mirna10cdf)[1:10]

# Get probe information for a specific probeset
# Replace 'probeset_id' with a valid ID from the array
# get("probeset_id", envir = mirna10cdf)
```

## Typical Workflow
1. **Data Loading**: Load raw CEL files using `affy::ReadAffy()`.
2. **Automatic Integration**: If the CEL files are from the miRNA-1.0 array, the `affy` package will automatically look for `mirna10cdf` to process the data.
3. **Manual Mapping**: Use `i2xy` and `xy2i` if you are performing custom quality control or spatial analysis on the chip surface to identify specific probe locations.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
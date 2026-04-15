---
name: bioconductor-rhesuscdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Rhesus Macaque Genome Array. Use when user asks to map probe coordinates to indices, access chip dimensions, or process Rhesus Macaque expression data using the rhesuscdf annotation package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rhesuscdf.html
---

# bioconductor-rhesuscdf

name: bioconductor-rhesuscdf
description: A specialized skill for working with the 'rhesuscdf' Bioconductor annotation package. Use this skill when you need to map Affymetrix Rhesus Macaque genome array probe coordinates (x, y) to index positions, or when you need to access the CDF environment and chip dimensions for Rhesus Macaque expression data analysis in R.

# bioconductor-rhesuscdf

## Overview
The `rhesuscdf` package is a Bioconductor annotation interface for the Affymetrix Rhesus Macaque Genome Array. Its primary purpose is to provide the Chip Definition File (CDF) environment, which maps individual probes on the microarray to their respective probe sets. This is essential for low-level processing of .CEL files using packages like `affy`.

## Installation
To use this package in R, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rhesuscdf")
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between 2D chip coordinates (x, y) and 1D indices used in `AffyBatch` objects. The Rhesus chip has dimensions of 1164 x 1164.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

```r
library(rhesuscdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### Accessing CDF Data
The package automatically loads the `rhesuscdf` and `rhesusdim` environments.

- `rhesuscdf`: The environment containing the mapping of probe sets to probe locations.
- `rhesusdim`: The environment describing the dimensions of the Rhesus chip.

```r
# View the dimensions of the array
ls(rhesusdim)

# List some probe sets in the CDF
head(ls(rhesuscdf))
```

## Typical Workflow
This package is usually not called directly by the user but is loaded automatically by the `affy` package when processing Rhesus Macaque CEL files.

```r
library(affy)
# If you have CEL files in the working directory
# data <- ReadAffy() 
# The 'affy' package will look for 'rhesuscdf' if the chip type is recognized.

# Manual verification of indices
all_indices <- 1:(1164 * 1164)
coords <- i2xy(all_indices)
stopifnot(identical(xy2i(coords[, "x"], coords[, "y"]), all_indices))
```

## Reference documentation
- [rhesuscdf Reference Manual](./references/reference_manual.md)
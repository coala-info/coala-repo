---
name: bioconductor-mu19ksubccdf
description: This package provides the Chip Definition File environment for the Affymetrix mu19ksub oligonucleotide array. Use when user asks to map probe-level data to probe sets, convert between chip coordinates and indices, or process raw CEL files from the mu19ksub platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu19ksubccdf.html
---

# bioconductor-mu19ksubccdf

name: bioconductor-mu19ksubccdf
description: Provides the CDF (Chip Definition File) environment for the Affymetrix mu19ksub annotation. Use this skill when working with AffyBatch objects or raw CEL files from the mu19ksub platform to map probe coordinates to probe set identifiers and perform spatial analysis.

# bioconductor-mu19ksubccdf

## Overview
The `mu19ksubccdf` package is an annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix mu19ksub oligonucleotide array. It is primarily used by the `affy` package to map probe-level data (CEL files) to their respective probe sets.

## Installation and Loading
To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mu19ksubccdf")
library(mu19ksubccdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x, y) coordinates on the chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinates: 1 to 534
- Y-coordinates: 1 to 534
- Total indices: 1 to 285,156

### Example Workflow
```r
library(mu19ksubccdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns

# Verify dimensions
ls(mu19ksubccdf)
```

## Data Environments
- `mu19ksubccdf`: The environment containing the mapping between probes and probe sets.
- `mu19ksubcdim`: The environment describing the dimensions of the chip.

## Tips
- This package is typically loaded automatically by `affy` functions like `ReadAffy()` when it detects the mu19ksub chip type in the CEL file headers.
- Use `as.list(mu19ksubccdf)` to inspect the probe set mappings, but be aware this is a large object.

## Reference documentation
- [mu19ksubccdf Reference Manual](./references/reference_manual.md)
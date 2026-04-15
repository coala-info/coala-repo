---
name: bioconductor-mgu74bv2cdf
description: This package provides the Chip Definition File environment for the Affymetrix Murine Genome U74Bv2 oligonucleotide array. Use when user asks to map probe indices to physical coordinates, access chip dimension metadata, or process MG_U74Bv2 CEL files using AffyBatch objects.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74bv2cdf.html
---

# bioconductor-mgu74bv2cdf

name: bioconductor-mgu74bv2cdf
description: Provides mapping and annotation data for the Affymetrix MG_U74Bv2 (Murine Genome U74B version 2) oligonucleotide array. Use this skill when working with AffyBatch objects or CEL files requiring the mgu74bv2 CDF environment for probe-set to (x,y) coordinate conversion and chip dimension metadata.

# bioconductor-mgu74bv2cdf

## Overview
The `mgu74bv2cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix Murine Genome U74Bv2 array. It is primarily used to map probe indices to their physical (x,y) locations on the chip and to define the dimensions of the array.

## Core Functions and Usage

### Loading the Package
To use the CDF environment in an R session:
```r
library(mgu74bv2cdf)
```

### Coordinate Conversion
The package provides utility functions to convert between single-number indices (used in `AffyBatch` objects) and (x,y) coordinates on the 640x640 grid.

- `xy2i(x, y)`: Converts x and y coordinates to a single index.
- `i2xy(i)`: Converts a single index to x and y coordinates.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### Accessing CDF Data
The package exposes two main environments:
- `mgu74bv2cdf`: The environment containing the mapping of probe sets to probe indices.
- `mgu74bv2dim`: The environment containing the dimensions of the array (640 x 640).

**Example: Checking Dimensions**
```r
# View the dimensions environment
mgu74bv2dim
```

## Typical Workflow
This package is usually not called directly by the user but is loaded automatically by higher-level packages like `affy` when processing MG_U74Bv2 CEL files.

1. **Automatic Trigger**: When calling `ReadAffy()`, if the CEL files are from the MG_U74Bv2 platform, this package will be required.
2. **Manual Inspection**: If you need to manually find which probes belong to a specific probe set:
```r
# Get probe indices for a specific probe set
probe_set_info <- as.list(mgu74bv2cdf[["1000_at"]])
```

## Reference documentation
- [mgu74bv2cdf Reference Manual](./references/reference_manual.md)
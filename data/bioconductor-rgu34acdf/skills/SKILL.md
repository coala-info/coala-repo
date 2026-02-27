---
name: bioconductor-rgu34acdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix Rat Genome U34A array. Use when user asks to access RG-U34A probeset mappings, convert between probe (x,y) coordinates and indices, or load the rgu34acdf annotation data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgu34acdf.html
---


# bioconductor-rgu34acdf

name: bioconductor-rgu34acdf
description: Provides specialized knowledge for the Bioconductor annotation package 'rgu34acdf'. Use this skill when working with Affymetrix Rat Genome U34A (RG-U34A) Chip Definition File (CDF) data in R, specifically for mapping probe (x,y) coordinates to indices and accessing the CDF environment.

# bioconductor-rgu34acdf

## Overview

The `rgu34acdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Rat Genome U34A array. It is primarily used by other Bioconductor packages (like `affy`) to map probe-level data to their respective probesets and physical locations on the chip.

## Core Workflows

### Loading the Package
To use the CDF environment or the coordinate conversion functions, load the library in R:

```r
library(rgu34acdf)
```

### Accessing CDF Data
The package provides two main environments:
- `rgu34acdf`: The environment containing the mapping between probesets and probe indices.
- `rgu34adim`: The environment describing the physical dimensions of the RG-U34A chip.

### Coordinate Conversion
The package includes utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

**Convert (x,y) to Index:**
```r
# x and y coordinates range from 1 to 534
idx <- xy2i(x = 5, y = 5)
```

**Convert Index to (x,y):**
```r
# i ranges from 1 to 285,156 (534 * 534)
coords <- i2xy(i = 100)
# Returns a matrix with columns "x" and "y"
```

## Usage Tips
- **Dimensions**: The RG-U34A chip is a square grid of 534 x 534 cells.
- **Indexing**: R uses 1-based indexing for these coordinates.
- **Integration**: This package is rarely used standalone; it is typically called automatically by `affy::read.affybatch()` when it detects the RG-U34A chip type. However, manual coordinate mapping is useful for custom quality control or spatial analysis of chip intensity.

## Reference documentation

- [rgu34acdf Reference Manual](./references/reference_manual.md)
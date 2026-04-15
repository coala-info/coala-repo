---
name: bioconductor-test2cdf
description: This package provides a CDF environment for the Affymetrix 'test2' chip to map probe locations and manage chip metadata. Use when user asks to convert between (x,y) chip coordinates and single-number indices, access chip dimension metadata, or handle Affymetrix CDF environments for the test2 chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/test2cdf.html
---

# bioconductor-test2cdf

name: bioconductor-test2cdf
description: A specialized skill for working with the Bioconductor package 'test2cdf'. Use this skill when you need to handle Affymetrix CDF environments for the 'test2' chip, specifically for converting between (x,y) chip coordinates and single-number indices, or when accessing chip dimension metadata.

# bioconductor-test2cdf

## Overview
The `test2cdf` package is an annotation data package providing a CDF (Chip Definition File) environment for the Affymetrix 'test2' chip. It is primarily used in bioinformatics workflows involving `AffyBatch` objects to map probe locations on a physical chip to their corresponding indices in data structures.

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to translate between the 2D grid of the chip and the 1D indexing used in R environments. The 'test2' chip has a dimension of 105x105 (11,025 total indices).

**Convert (x,y) to Index:**
```r
library(test2cdf)
# Convert x=5, y=5 to a single index
idx <- xy2i(5, 5)
```

**Convert Index to (x,y):**
```r
# Convert a single index or vector of indices back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

### Accessing CDF Data
The package loads two main environments into the R session:

1.  `test2cdf`: The environment containing the mapping of probesets to their locations.
2.  `test2dim`: The environment containing the dimensions of the chip.

```r
# View dimension information
ls(test2dim)
```

## Typical Workflow
1.  **Load the library**: `library(test2cdf)`
2.  **Identify Probes**: Use `xy2i` when you have specific spatial coordinates from a CEL file and need to find the data index.
3.  **Spatial Analysis**: Use `i2xy` when you have an index (e.g., from a top-table or expression matrix) and want to visualize its physical location on the chip.
4.  **Validation**: Ensure coordinates are within the 1 to 105 range and indices are within 1 to 11025.

## Tips
- The indices are 1-based, following standard R convention.
- This package is often called internally by other Bioconductor tools like `affy`, but manual coordinate conversion is useful for custom quality control or spatial artifact detection.

## Reference documentation
- [test2cdf Reference Manual](./references/reference_manual.md)
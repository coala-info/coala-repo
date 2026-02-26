---
name: bioconductor-hgu95acdf
description: This package provides the Chip Description File environment and coordinate conversion utilities for the Affymetrix HG-U95A GeneChip. Use when user asks to map probe coordinates to indices, convert indices to spatial coordinates, or access CDF metadata for HG-U95A chip data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95acdf.html
---


# bioconductor-hgu95acdf

name: bioconductor-hgu95acdf
description: Provides specialized R programming guidance for the hgu95acdf Bioconductor annotation package. Use this skill when working with Affymetrix HG-U95A chip data, specifically for mapping probe (x,y) coordinates to indices, accessing CDF environments, and retrieving chip dimensions.

# bioconductor-hgu95acdf

## Overview
The `hgu95acdf` package is a Bioconductor annotation data package for the Affymetrix HG-U95A GeneChip. It provides the Chip Description File (CDF) environment, which maps probes to probesets, and includes utility functions for converting between 2D spatial coordinates on the chip and 1D indices used in `AffyBatch` objects.

## Core Functions and Usage

### Loading the Package
```r
library(hgu95acdf)
```

### Coordinate Conversion
The package provides two primary functions to translate between the physical layout of the chip and the numerical indices used in R:

- `xy2i(x, y)`: Converts (x, y) coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into (x, y) coordinates.

**Parameters:**
- `x`: Numeric coordinate (1 to 640).
- `y`: Numeric coordinate (1 to 640).
- `i`: Numeric index (1 to 409,600).

**Example Workflow:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices to coordinates
indices <- 1:10
coords <- i2xy(indices)

# Access x and y from the resulting matrix
x_vals <- coords[, "x"]
y_vals <- coords[, "y"]
```

### Accessing CDF Data
The package contains two main environments:
- `hgu95acdf`: The environment containing the mapping of probesets to probe indices.
- `hgu95adim`: The environment containing the dimensions of the HG-U95A chip.

```r
# View chip dimensions
ls(hgu95adim)

# List probesets in the CDF
# Note: This can be a large list
probesets <- ls(hgu95acdf)
```

## Typical Workflows
1. **Quality Control**: Use `i2xy` to map high-intensity or outlier probes back to their physical location on the array to identify spatial artifacts (e.g., "smudges" or "rings").
2. **Manual Probe Extraction**: Use `xy2i` when you have specific coordinate data from a CEL file and need to find the corresponding data point in an `AffyBatch` object.

## Reference documentation
- [hgu95acdf Reference Manual](./references/reference_manual.md)
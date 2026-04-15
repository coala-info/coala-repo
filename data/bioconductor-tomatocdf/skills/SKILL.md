---
name: bioconductor-tomatocdf
description: This package provides the Chip Definition File environment for the Affymetrix Tomato Genome Array. Use when user asks to map probe coordinates to indices, access chip dimensions, or handle metadata for tomato transcriptomics data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/tomatocdf.html
---

# bioconductor-tomatocdf

name: bioconductor-tomatocdf
description: A specialized skill for working with the Bioconductor annotation package 'tomatocdf'. Use this skill when you need to handle Affymetrix Tomato Genome Array CDF data, specifically for mapping (x,y)-coordinates to probe indices or accessing the chip environment and dimensions in R.

# bioconductor-tomatocdf

## Overview
The `tomatocdf` package is a Bioconductor annotation data package providing the Chip Definition File (CDF) environment for the Affymetrix Tomato Genome Array. It is primarily used in transcriptomics workflows to map raw intensity data from CEL files to specific probe sets.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("tomatocdf")
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utilities to convert between 2D chip coordinates (x, y) and 1D indices (i) used in `AffyBatch` objects. The chip dimensions for the Tomato array are 478 x 478.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example:**
```r
library(tomatocdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### Data Environments
The package exposes two main environments containing metadata about the array:

1.  `tomatocdf`: The environment containing the mapping of probes to probe sets.
2.  `tomatodim`: The environment describing the physical dimensions of the chip (478 x 478).

To view the contents or dimensions:
```r
# Get chip dimensions
get("tomatodim", envir = tomatocdf)

# List probe sets (first 10)
ls(tomatocdf)[1:10]
```

## Typical Workflow
1.  **Loading Data**: Usually, this package is automatically loaded when using `affy` to read Tomato array CEL files.
2.  **Manual Mapping**: If performing custom spatial analysis, use `i2xy` to map probe intensities back to their physical location on the chip to check for artifacts (e.g., "edge effects" or "bubbles").
3.  **Validation**: Ensure indices stay within the range of 1 to 228,484 (478 * 478).

## Reference documentation
- [tomatocdf Reference Manual](./references/reference_manual.md)
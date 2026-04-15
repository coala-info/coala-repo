---
name: bioconductor-rgu34ccdf
description: This package provides the Chip Definition File (CDF) environment and coordinate mapping for the Affymetrix Rat Genome U34 array. Use when user asks to map probe coordinates to indices, access RG-U34 chip dimensions, or process raw Affymetrix rat genome data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgu34ccdf.html
---

# bioconductor-rgu34ccdf

name: bioconductor-rgu34ccdf
description: Provides specialized knowledge for the rgu34ccdf Bioconductor annotation package. Use this skill when working with Affymetrix Rat Genome U34 (RG-U34) chip data, specifically for mapping (x,y)-coordinates to probe indices and accessing the Chip Definition File (CDF) environment.

# bioconductor-rgu34ccdf

## Overview
The `rgu34ccdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Rat Genome U34 (RG-U34) array. It is primarily used to map physical probe locations on the chip to the single-number indices used in `AffyBatch` objects and to describe the chip's dimensions.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rgu34ccdf")
library(rgu34ccdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates on the CEL file/chip and the 1D indices used in R.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- x-coordinates range: 1 to 534
- y-coordinates range: 1 to 534
- Total indices: 1 to 285,156 (534 * 534)

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
- `rgu34ccdf`: The environment containing the actual CDF mapping data.
- `rgu34cdim`: The environment describing the dimensions of the RG-U34 chip.

To view the contents or summary of these environments:
```r
# View dimension information
rgu34cdim

# List some identifiers in the CDF
ls(rgu34ccdf)[1:10]
```

## Typical Workflow
1. **Data Loading**: Load an `AffyBatch` object containing Rat Genome U34 data.
2. **Annotation**: The `affy` package automatically looks for `rgu34ccdf` to process the raw CEL files.
3. **Manual Probe Mapping**: Use `i2xy` and `xy2i` if you need to perform spatial analysis or quality control on specific physical regions of the chip.

## Reference documentation
- [rgu34ccdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-hu6800cdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Hu6800 microarray platform. Use when user asks to analyze Hu6800 microarray data, map probe coordinates to indices, or access CDF environment metadata.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu6800cdf.html
---


# bioconductor-hu6800cdf

name: bioconductor-hu6800cdf
description: A specialized skill for working with the hu6800cdf Bioconductor package. Use this skill when analyzing Affymetrix Hu6800 (GeneChip Human Genome 6800) microarray data in R, specifically for mapping (x,y) coordinates to probe indices and accessing CDF environment metadata.

# bioconductor-hu6800cdf

## Overview
The `hu6800cdf` package is an annotation package containing the Chip Definition File (CDF) environment for the Affymetrix Hu6800 platform. It provides the necessary mapping between the physical location of probes on the microarray chip and the probe set identifiers used in downstream analysis (like `AffyBatch` objects).

## Installation and Loading
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hu6800cdf")
library(hu6800cdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between 2D chip coordinates (x, y) and 1D indices (i) used in CEL files and AffyBatch objects. The chip dimensions for hu6800 are 536 x 536.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### CDF Environment and Dimensions
The package exposes the CDF environment and dimension information directly:

- `hu6800cdf`: The environment object containing the mapping of probes to probe sets.
- `hu6800dim`: The environment describing the dimensions of the Hu6800 chip.

To see the contents of the CDF environment:
```r
# List some probe sets in the environment
ls(hu6800cdf)[1:10]

# Get probe information for a specific probe set
get("AFFX-MurIL2_at", hu6800cdf)
```

## Typical Workflow
1. **Data Loading**: When loading Hu6800 CEL files using `affy::ReadAffy()`, the `affy` package automatically looks for `hu6800cdf` to organize the probe data.
2. **Manual Mapping**: Use `i2xy` or `xy2i` when performing custom quality control or spatial analysis on the chip surface to identify the physical location of specific probes.
3. **Validation**: Use `hu6800dim` to verify that the input data matches the expected chip geometry (536x536).

## Reference documentation
- [hu6800cdf Reference Manual](./references/reference_manual.md)
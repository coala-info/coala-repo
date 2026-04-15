---
name: bioconductor-ygs98cdf
description: This package provides the Chip Definition File environment for the Affymetrix Yeast Genome S98 array to map probe coordinates to indices. Use when user asks to map (x, y) coordinates to indices, convert indices back to coordinates, or access the CDF environment for the YGS98 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ygs98cdf.html
---

# bioconductor-ygs98cdf

name: bioconductor-ygs98cdf
description: A specialized skill for working with the Bioconductor annotation package 'ygs98cdf'. Use this skill when you need to map probe coordinates to indices for the Yeast Genome S98 (YGS98) Affymetrix chip, or when working with the CDF environment for this specific platform.

# bioconductor-ygs98cdf

## Overview
The `ygs98cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix Yeast Genome S98 (YGS98) array. It is primarily used in transcriptomics workflows to map between (x, y) coordinates on the physical chip and the single-number indices used in `AffyBatch` objects.

## Core Functions and Usage

### Loading the Package
To use the environment, first load the library in R:
```R
library(ygs98cdf)
```

### Coordinate Conversion
The package provides two primary utility functions to convert between 2D chip coordinates and 1D indices. The YGS98 chip has dimensions of 534 x 534.

- `xy2i(x, y)`: Converts x and y coordinates (1 to 534) to a single-number index (1 to 285,156).
- `i2xy(i)`: Converts a single-number index back into a matrix containing "x" and "y" columns.

**Example Workflow:**
```R
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices back to coordinates
indices <- 1:10
coords <- i2xy(indices)

# Verify dimensions
# range(coords[, "x"]) should be within 1:534
# range(coords[, "y"]) should be within 1:534
```

### Accessing CDF Environments
The package exposes two main environments:
- `ygs98cdf`: The environment containing the mapping of probesets to probe locations.
- `ygs98dim`: The environment describing the dimensions of the CDF file.

To see the contents or keys within the CDF environment:
```R
ls(ygs98cdf)[1:10] # List the first 10 probesets
```

## Typical Workflow Integration
This package is usually a dependency for higher-level analysis packages like `affy`. When you load a CEL file from a YGS98 array using `read.affybatch()`, the `affy` package automatically looks for `ygs98cdf` to correctly interpret the probe layout.

Manual usage is typically reserved for:
1. Custom probe-level analysis.
2. Quality control visualization where specific chip locations need to be identified.
3. Debugging coordinate offsets in raw data processing.

## Reference documentation
- [ygs98cdf Reference Manual](./references/reference_manual.md)
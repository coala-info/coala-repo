---
name: bioconductor-nugomm1a520177cdf
description: This package provides the Chip Definition File environment and coordinate mapping for the nugomm1a520177 Affymetrix array. Use when user asks to map coordinates to indices, access the CDF environment, or retrieve chip dimensions for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/nugomm1a520177cdf.html
---

# bioconductor-nugomm1a520177cdf

name: bioconductor-nugomm1a520177cdf
description: A skill for working with the Bioconductor annotation package nugomm1a520177cdf. Use this skill when you need to map (x,y)-coordinates to indices for the nugomm1a520177 Affymetrix chip, or when you need to access the CDF environment and chip dimensions for this specific array.

# bioconductor-nugomm1a520177cdf

## Overview
The `nugomm1a520177cdf` package is a Bioconductor annotation resource providing the Chip Definition File (CDF) environment for the nugomm1a520177 Affymetrix array. It is primarily used to map probe coordinates on the physical chip to the single-number indices used in `AffyBatch` objects and to provide structural information about the array.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("nugomm1a520177cdf")
library(nugomm1a520177cdf)
```

## Key Functions and Environments

### Coordinate Conversion (i2xy and xy2i)
The package provides utility functions to convert between 2D chip coordinates and 1D indices. The chip dimensions are 732 x 732 (total indices: 535,824).

*   `xy2i(x, y)`: Converts x and y coordinates (1 to 732) to a single-number index.
*   `i2xy(i)`: Converts a single-number index to a matrix containing "x" and "y" columns.

**Example Workflow:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices back to coordinates
coords <- i2xy(1:10)
# Access x or y
x_vals <- coords[, "x"]
y_vals <- coords[, "y"]
```

### CDF Environments
The package contains two primary environments used by other Bioconductor tools (like `affy`):

*   `nugomm1a520177cdf`: The main environment describing the CDF file structure (mapping probes to probe sets).
*   `nugomm1a520177dim`: An environment containing the dimensions of the array.

## Usage Tips
*   **Automatic Integration**: You rarely need to call these environments directly. When you load a CEL file associated with this chip into an `AffyBatch` object, the `affy` package will automatically look for and use this package if it is installed.
*   **Index Range**: Ensure indices are within the range 1 to 535,824 and coordinates are within 1 to 732.

## Reference documentation
- [nugomm1a520177cdf Reference Manual](./references/reference_manual.md)
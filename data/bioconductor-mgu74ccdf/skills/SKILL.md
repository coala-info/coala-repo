---
name: bioconductor-mgu74ccdf
description: This package provides the Chip Definition File environment for the Affymetrix MG-U74C Mouse Genome array to map raw intensity data to probe sets. Use when user asks to map Affymetrix MG-U74C probe coordinates, convert between x-y coordinates and indices, or process CEL files from this specific mouse genome chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74ccdf.html
---


# bioconductor-mgu74ccdf

## Overview
The `mgu74ccdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix MG-U74C Mouse Genome array. It is primarily used by other Bioconductor packages like `affy` to map raw intensity data from CEL files to specific probe sets and to handle the spatial layout of the chip.

## Core Functions and Usage

### Loading the Package
```r
if (!require("bioconductor-mgu74ccdf", quietly = TRUE))
    BiocManager::install("mgu74ccdf")
library(mgu74ccdf)
```

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

*   **xy2i(x, y)**: Converts x and y coordinates to a single-number index.
*   **i2xy(i)**: Converts a single-number index back into x and y coordinates.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix or data frame with "x" and "y" columns
```

### Chip Environments
The package exposes two main environments:
*   `mgu74ccdf`: The main environment mapping probe set IDs to their constituent probe indices.
*   `mgu74cdim`: Contains the dimensions of the MG-U74C array (typically 640 x 640).

**Example:**
```r
# View dimensions
ls(mgu74cdim)

# Access the CDF environment
# Usually handled automatically by affy functions like rma() or mas5()
```

## Typical Workflow
1.  **Data Loading**: Load raw `.CEL` files using `affy::ReadAffy()`.
2.  **Automatic Integration**: The `affy` package will automatically look for `mgu74ccdf` if the CEL file header identifies the chip as "MG-U74C".
3.  **Manual Coordinate Mapping**: Use `i2xy` or `xy2i` if you need to perform spatial analysis or quality control on specific regions of the chip.

## Reference documentation
- [mgu74ccdf Reference Manual](./references/reference_manual.md)
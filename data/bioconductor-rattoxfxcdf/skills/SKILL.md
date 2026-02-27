---
name: bioconductor-rattoxfxcdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Rat Tox FX Affymetrix microarray. Use when user asks to map probe coordinates to indices, access the CDF environment for the rattoxfx chip, or retrieve array dimensions for this platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rattoxfxcdf.html
---


# bioconductor-rattoxfxcdf

name: bioconductor-rattoxfxcdf
description: A specialized skill for working with the Bioconductor annotation package 'rattoxfxcdf'. Use this skill when you need to map (x,y)-coordinates to single-number indices for the rattoxfx Affymetrix chip, or when accessing the CDF environment and dimensions for this specific platform.

# bioconductor-rattoxfxcdf

## Overview
The `rattoxfxcdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Rat Tox FX array. It is primarily used in the analysis of Affymetrix microarray data to map probe intensities from CEL files to their respective probesets.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rattoxfxcdf")
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates on the microarray chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinates range: 1 to 230
- Y-coordinates range: 1 to 230
- Total indices: 1 to 52,900 (230 * 230)

### Example Workflow
```r
library(rattoxfxcdf)

# 1. Convert specific coordinates to an index
idx <- xy2i(5, 5)
print(idx)

# 2. Convert an index back to coordinates
coords <- i2xy(idx)
print(coords) # Returns a matrix with "x" and "y" columns

# 3. Verify the entire range
i <- 1:52900
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))
```

### Accessing Environments
The package exposes two main environments:
- `rattoxfxcdf`: The environment containing the mapping of probes to probesets.
- `rattoxfxdim`: The environment containing the dimensions of the array.

```r
# View the dimensions environment
ls(rattoxfxdim)

# Access the CDF environment
# This is typically handled automatically by high-level functions in 'affy'
# but can be accessed directly:
as.list(rattoxfxcdf)[1:5]
```

## Tips
- This package is a data-only package. It is usually loaded automatically by the `affy` package when processing Rat Tox FX CEL files.
- If you are performing low-level probe analysis, use `i2xy` to identify the physical location of a probe on the chip to check for spatial artifacts.

## Reference documentation
- [rattoxfxcdf Reference Manual](./references/reference_manual.md)
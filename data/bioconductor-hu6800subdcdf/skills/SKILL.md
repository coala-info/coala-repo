---
name: bioconductor-hu6800subdcdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu6800subdcdf.html
---

# bioconductor-hu6800subdcdf

name: bioconductor-hu6800subdcdf
description: Provides specialized R functions and environment data for the hu6800subdcdf Bioconductor package. Use this skill when working with Affymetrix Hu6800 (subd) microarray data to map (x,y) chip coordinates to single-number indices, or when requiring the CDF environment for low-level probe set mapping.

# bioconductor-hu6800subdcdf

## Overview

The `hu6800subdcdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Affymetrix Hu6800 (subd) microarray. It provides the necessary mapping between probe identifiers and their physical locations on the chip. This is primarily used by other Bioconductor packages like `affy` to process `.CEL` files.

## Key Functions and Usage

### Coordinate Conversion

The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinate range: 1 to 276
- Y-coordinate range: 1 to 276
- Total indices: 76,176 (276 * 276)

### Example Workflow

```r
# Load the package
library(hu6800subdcdf)

# Convert specific coordinates to an index
index <- xy2i(x = 5, y = 5)

# Convert an index back to coordinates
coords <- i2xy(index)
# Returns a matrix or data frame with "x" and "y" columns

# Verify a range of indices
i <- 1:76176
coords <- i2xy(i)
j <- xy2i(coords[, "x"], coords[, "y"])
stopifnot(all(i == j))
```

### Accessing CDF Environments

The package contains two main environments used by the `affy` engine:

1. `hu6800subdcdf`: The environment describing the CDF file (probe set mappings).
2. `hu6800subddim`: The environment describing the dimensions of the chip.

These are typically accessed automatically when you load an `AffyBatch` object that specifies `cdfname = "hu6800subd"`.

## Tips

- This package is a data-only annotation package. You rarely need to call its functions directly unless you are performing custom low-level probe analysis or manual coordinate mapping.
- Ensure the package is installed via BiocManager: `BiocManager::install("hu6800subdcdf")`.

## Reference documentation

- [hu6800subdcdf Reference Manual](./references/reference_manual.md)
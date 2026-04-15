---
name: bioconductor-rgu34bcdf
description: This package provides the Chip Definition File environment for the Affymetrix Rat Genome U34B array. Use when user asks to map probe coordinates to indices, access chip dimension metadata, or process AffyBatch objects for the rgu34b array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgu34bcdf.html
---

# bioconductor-rgu34bcdf

name: bioconductor-rgu34bcdf
description: Access and manipulate the CDF (Chip Definition File) environment for the Rat Genome U34B Affymetrix array. Use this skill when working with 'rgu34b' AffyBatch objects, mapping probe (x,y) coordinates to indices, or retrieving chip dimension metadata.

# bioconductor-rgu34bcdf

## Overview
The `rgu34bcdf` package is an annotation data package providing the Chip Definition File (CDF) environment for the Affymetrix Rat Genome U34B array. It is primarily used by the `affy` package to map raw intensity data from CEL files to specific probe sets and to handle the spatial layout of the chip.

## Key Functions and Usage

### Loading the Package
```r
library(rgu34bcdf)
```

### Coordinate Conversion
The package provides utility functions to convert between 2D chip coordinates (x, y) and 1D indices used in `AffyBatch` objects. The chip dimensions are 534 x 534.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

```r
# Example: Convert coordinate (5, 5) to index
idx <- xy2i(5, 5)

# Example: Convert index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### Accessing CDF Environments
The package exposes two main environments:
- `rgu34bcdf`: Contains the mapping of probe sets to probe locations.
- `rgu34bdim`: Contains the dimensions of the array.

```r
# View dimension information
ls(rgu34bdim)

# Access the CDF environment directly
# (Usually handled automatically by affy functions)
as.list(rgu34bcdf)[1:5]
```

## Typical Workflow
This package is rarely used standalone. It is typically triggered automatically when loading CEL files from an RGU34B array:

1. Load raw data using `affy::ReadAffy()`.
2. The `affy` package detects the chip type and loads `rgu34bcdf` to organize the probes.
3. Use `i2xy` or `xy2i` if you need to perform custom spatial analysis or quality control on the chip surface.

## Reference documentation
- [rgu34bcdf Reference Manual](./references/reference_manual.md)
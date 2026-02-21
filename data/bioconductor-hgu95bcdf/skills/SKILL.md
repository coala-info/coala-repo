---
name: bioconductor-hgu95bcdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95bcdf.html
---

# bioconductor-hgu95bcdf

name: bioconductor-hgu95bcdf
description: Provides specialized knowledge for the hgu95bcdf Bioconductor annotation package. Use this skill when working with Affymetrix HG-U95B GeneChip data in R, specifically for mapping probe (x,y)-coordinates to CEL file indices and accessing CDF environment metadata.

# bioconductor-hgu95bcdf

## Overview
The `hgu95bcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix HG-U95B oligonucleotide array. It is primarily used by other Bioconductor packages like `affy` to map raw intensity data to probe sets. It provides coordinate conversion functions and environment variables describing the chip's dimensions and layout.

## Core Functions and Usage

### Loading the Package
To use the environments and functions, load the library in R:
```R
library(hgu95bcdf)
```

### Coordinate Conversion
The package provides two essential functions for converting between 2D chip coordinates and 1D indices used in `AffyBatch` objects. The HG-U95B chip has a 640x640 grid (409,600 total points).

- `xy2i(x, y)`: Converts x and y coordinates (1 to 640) into a single-number index (1 to 409,600).
- `i2xy(i)`: Converts a single-number index back into a matrix of x and y coordinates.

**Example:**
```R
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# coords will be a matrix with "x" and "y" columns
```

### Accessing CDF Data
The package exposes two main environments:
- `hgu95bcdf`: The environment containing the mapping of probe sets to their locations on the chip.
- `hgu95bdim`: An environment describing the dimensions of the HG-U95B chip.

**Example:**
```R
# View dimension information
ls(hgu95bdim)

# Access the CDF environment directly
# (Usually handled automatically by affy functions)
as.list(hgu95bcdf)[1:5]
```

## Typical Workflow
1. **Data Loading**: When reading CEL files using `affy::ReadAffy()`, R automatically looks for `hgu95bcdf` if the chip type is detected as HG-U95B.
2. **Manual Mapping**: Use `i2xy` when you need to identify the physical location of a specific probe index identified during quality control or analysis.
3. **Validation**: Use `stopifnot(all(i == xy2i(i2xy(i))))` to verify coordinate integrity during custom data processing scripts.

## Reference documentation
- [hgu95bcdf Reference Manual](./references/reference_manual.md)
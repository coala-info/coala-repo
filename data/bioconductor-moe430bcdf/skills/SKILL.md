---
name: bioconductor-moe430bcdf
description: This package provides the Chip Definition File (CDF) environment for the Affymetrix Mouse Genome 430 2.0 Array. Use when user asks to map probe coordinates to indices, access chip dimensions, or process raw intensity data for the MOE430B platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/moe430bcdf.html
---


# bioconductor-moe430bcdf

name: bioconductor-moe430bcdf
description: Provides specialized knowledge for the moe430bcdf Bioconductor annotation package. Use this skill when working with Affymetrix Mouse Genome 430 2.0 Array (MOE430B) CDF environments, specifically for mapping probe (x,y) coordinates to indices and accessing chip dimensions.

# bioconductor-moe430bcdf

## Overview

The `moe430bcdf` package is a Bioconductor annotation interface for the Affymetrix Mouse Genome 430 2.0 Array (B-chip). Its primary purpose is to provide the Chip Definition File (CDF) environment, which maps individual probes on the array to their respective probe sets. This is essential for low-level analysis of .CEL files using packages like `affy`.

## Key Functions and Usage

### Coordinate Conversion

The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:** The MOE430B chip has a grid of 712 x 712 probes.
- **x-coordinates:** 1 to 712
- **y-coordinates:** 1 to 712
- **Indices:** 1 to 506,944 (712 * 712)

### Accessing Environments

The package loads two main environments:
- `moe430bcdf`: The main environment containing the mapping of probes to probe sets.
- `moe430bdim`: An environment containing the dimensions of the chip.

## Typical Workflow

```r
# Load the library
library(moe430bcdf)

# 1. Check chip dimensions
# This returns a list of dimensions for the MOE430B array
ls(moe430bdim)

# 2. Convert coordinates
# Example: Find the index for a probe at x=5, y=5
idx <- xy2i(5, 5)

# 3. Reverse conversion
# Convert the index back to coordinates
coords <- i2xy(idx)
# coords will be a matrix with columns "x" and "y"

# 4. Integration with affy
# Usually, this package is called automatically by the affy package
# when reading CEL files from the MOE430B platform:
# data <- ReadAffy() # If CEL files are MOE430B, this package is used
```

## Tips

- **Automatic Loading:** You rarely need to call `moe430bcdf` functions directly. High-level packages like `affy` or `limma` use this package in the background to process raw intensity data.
- **Index Range:** Always ensure indices are within the range 1 to 506,944 to avoid out-of-bounds errors.
- **Coordinate System:** Affymetrix coordinates are 1-based in R, consistent with standard R indexing.

## Reference documentation

- [moe430bcdf Reference Manual](./references/reference_manual.md)
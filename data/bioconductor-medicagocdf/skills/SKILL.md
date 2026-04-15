---
name: bioconductor-medicagocdf
description: This package provides the Chip Definition File environment for the Affymetrix Medicago truncatula genome array. Use when user asks to map probe coordinates to indices, access Medicago chip dimensions, or process Affymetrix CEL files for Medicago truncatula.
homepage: https://bioconductor.org/packages/release/data/annotation/html/medicagocdf.html
---

# bioconductor-medicagocdf

name: bioconductor-medicagocdf
description: A specialized skill for working with the Bioconductor R package 'medicagocdf'. Use this skill when you need to handle Affymetrix Medicago truncatula chip CDF (Chip Definition File) data, specifically for mapping (x,y)-coordinates to probe indices and accessing the CDF environment for Medicago arrays.

# bioconductor-medicagocdf

## Overview
The `medicagocdf` package is an annotation data package providing the Chip Definition File (CDF) environment for the Medicago truncatula genome array. It is primarily used in conjunction with the `affy` package to process and analyze Affymetrix CEL files. It provides the necessary mapping between the physical locations of probes on the chip and their corresponding indices in R's `AffyBatch` objects.

## Core Functions and Usage

### Loading the Package
To use the CDF environment, load the library in your R session:
```r
library(medicagocdf)
```

### Coordinate Mapping
The package provides utility functions to convert between 2D chip coordinates and 1D indices. The Medicago chip has dimensions of 1164 x 1164.

- `xy2i(x, y)`: Converts (x,y)-coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back to (x,y)-coordinates.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### CDF Environments
The package contains two primary environments:
- `medicagocdf`: The environment containing the mapping of probesets to probe locations.
- `medicagodim`: The environment describing the dimensions of the Medicago chip.

These are typically accessed automatically by `affy` functions like `ReadAffy()`, but can be inspected manually:
```r
# View dimensions
ls(medicagodim)

# View probeset names
ls(medicagocdf)[1:10]
```

## Typical Workflow
1. **Data Loading**: Load your raw data using `affy::ReadAffy()`. The `medicagocdf` package will be called automatically if the CEL files identify as Medicago chips.
2. **Manual Inspection**: If you need to verify specific probe locations for quality control, use `i2xy` and `xy2i`.
3. **Validation**:
```r
# Verify coordinate consistency
i <- 1:1354896
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))
```

## Tips
- The index `i` ranges from 1 to 1,354,896 (1164 * 1164).
- The x and y coordinates range from 1 to 1164.
- This package is a data-only package; for actual expression analysis, ensure `affy` or `limma` is also installed.

## Reference documentation
- [medicagocdf Reference Manual](./references/reference_manual.md)
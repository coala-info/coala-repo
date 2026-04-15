---
name: bioconductor-tinesath1cdf
description: This package provides the Chip Definition File environment for the tinesATH1 Affymetrix microarray used in Arabidopsis thaliana genomic analysis. Use when user asks to map probe locations to probe sets, convert between chip coordinates and indices, or process raw CEL files for the tinesATH1 platform.
homepage: https://bioconductor.org/packages/release/data/experiment/html/tinesath1cdf.html
---

# bioconductor-tinesath1cdf

name: bioconductor-tinesath1cdf
description: Data package providing the CDF (Chip Definition File) environment for the tinesATH1 Affymetrix chip, used for Arabidopsis thaliana Chip-on-chip data analysis. Use this skill when needing to map probe locations to probe sets or convert between (x,y) coordinates and indices for this specific microarray platform.

# bioconductor-tinesath1cdf

## Overview
The `tinesath1cdf` package is a Bioconductor annotation data package. It contains an environment representing the mapping between probe set identifiers and their physical locations on the tinesATH1 microarray. This is primarily used in conjunction with the `affy` package to process CEL files and perform low-level analysis of Arabidopsis thaliana genomic data.

## Installation and Loading
To use this data package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("tinesath1cdf")

# Load the package
library(tinesath1cdf)
```

## Core Functionality

### The CDF Environment
The main object is `tinesath1cdf`, which is an R environment. It is typically accessed automatically by functions in the `affy` package (like `ReadAffy`) when the CDF name in the CEL file matches this package.

To inspect the environment directly:
```r
# View the environment object
tinesath1cdf

# List some probe sets contained within
ls(tinesath1cdf)[1:10]
```

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates on the chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinates: 1 to 712
- Y-coordinates: 1 to 712
- Total indices: 1 to 506,944 (712 * 712)

### Usage Example
```r
library(tinesath1cdf)

# Convert a specific coordinate to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns

# Verify a range of indices
i <- 1:100
coords <- i2xy(i)
j <- xy2i(coords[, "x"], coords[, "y"])
stopifnot(all(i == j))
```

## Typical Workflow
1. **Data Loading**: Load raw CEL files using `affy::ReadAffy()`. If the CEL files specify "tinesATH1" as the chip type, this package will be used automatically.
2. **Manual Mapping**: If performing custom low-level analysis, use `i2xy` and `xy2i` to map specific probe intensities to their physical locations on the array to check for spatial artifacts.
3. **Probe Set Retrieval**: Use `get("probeset_id", envir = tinesath1cdf)` to retrieve the location matrix for a specific probe set.

## Reference documentation
- [tinesath1cdf Reference Manual](./references/reference_manual.md)
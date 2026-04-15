---
name: bioconductor-yeast2cdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Yeast Genome S98 array. Use when user asks to map probe coordinates to indices, access the CDF environment for yeast expression data, or process Affymetrix Yeast S98 microarray chips.
homepage: https://bioconductor.org/packages/release/data/annotation/html/yeast2cdf.html
---

# bioconductor-yeast2cdf

name: bioconductor-yeast2cdf
description: A specialized skill for working with the Bioconductor annotation package 'yeast2cdf'. Use this skill when you need to map Affymetrix probe (x,y) coordinates to indices for the Yeast Genome S98 array, or when you need to access the Chip Definition File (CDF) environment for yeast expression data analysis in R.

# bioconductor-yeast2cdf

## Overview
The `yeast2cdf` package is a Bioconductor annotation resource providing the Chip Definition File (CDF) environment for the Affymetrix Yeast Genome S98 array. It is primarily used in transcriptomics workflows to map physical probe locations on the microarray chip to their corresponding indices in `AffyBatch` objects and vice versa.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("yeast2cdf")
library(yeast2cdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between 2D chip coordinates (x, y) and 1D indices (i) used in downstream analysis. The Yeast S98 chip has dimensions of 496 x 496.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example Workflow:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices to coordinates
indices <- 1:10
coords <- i2xy(indices)

# Verify dimensions (Expected range: 1 to 496)
range(coords[, "x"])
range(coords[, "y"])
```

### CDF Environments
The package exposes two primary environments used by other Bioconductor packages like `affy`:

- `yeast2cdf`: The main environment describing the CDF file structure (mapping probes to probe sets).
- `yeast2dim`: An environment describing the dimensions of the Yeast S98 chip.

To view the contents or dimensions:
```r
# Get chip dimensions
get("yeast2dim", envir = yeast2dim)

# List identifiers in the CDF
ls(yeast2cdf)[1:10]
```

## Typical Workflow Integration
This package is rarely used in isolation. It is typically called automatically by the `affy` package when processing `.CEL` files from yeast experiments:

```r
library(affy)
# If you have .CEL files in the directory, ReadAffy() 
# will look for yeast2cdf automatically if the chip type matches.
data <- ReadAffy() 
```

## Reference documentation
- [yeast2cdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-rae230bcdf
description: This package provides the Chip Definition File environment and probe mapping data for the Affymetrix Rat Expression 230 2.0 array. Use when user asks to map probe coordinates to indices, access the CDF environment, or determine chip dimensions for RAE230B arrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rae230bcdf.html
---

# bioconductor-rae230bcdf

name: bioconductor-rae230bcdf
description: Access and use the rae230bcdf Bioconductor annotation package for the Rat Expression 230 2.0 (RAE230B) Affymetrix chip. Use this skill when you need to map probe (x,y) coordinates to indices, access the CDF environment, or determine chip dimensions for RAE230B arrays.

# bioconductor-rae230bcdf

## Overview
The `rae230bcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Rat Expression 230 2.0 (RAE230B) platform. It provides the necessary mapping between the physical location of probes on the array and the probe set identifiers used in downstream analysis.

## Installation and Loading
To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rae230bcdf")
library(rae230bcdf)
```

## Core Components

### 1. CDF Environment (`rae230bcdf`)
The main object is an environment containing the mapping of probe sets to their locations on the chip.
- **Usage**: This is typically used internally by packages like `affy` (e.g., when calling `ReadAffy()`), but can be accessed directly.
- **Access**: `as.list(rae230bcdf)[1:5]` to see the first few probe set mappings.

### 2. Chip Dimensions (`rae230bdim`)
This environment describes the physical dimensions of the RAE230B array.
- **Dimensions**: The chip is a 602 x 602 grid.
- **Total Probes**: 362,404.

### 3. Coordinate Conversion (`i2xy` and `xy2i`)
These functions convert between the (x,y) coordinates on the CEL file/chip and the single-number indices used in `AffyBatch` objects.

- **xy2i(x, y)**: Converts x and y coordinates to a single index.
- **i2xy(i)**: Converts a single index back to x and y coordinates.

**Example Workflow:**
```r
library(rae230bcdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices to coordinates
indices <- 1:10
coords <- i2xy(indices)

# View coordinate ranges
range(coords[, "x"]) # Should be within 1-602
range(coords[, "y"]) # Should be within 1-602
```

## Usage Tips
- **Automatic Integration**: You rarely need to call these functions manually if you are using the `affy` package. When you load a CEL file from an RAE230B chip, `affy` will automatically look for this package to handle the probe mapping.
- **Index Range**: Remember that indices are 1-based in R and range from 1 to 362,404 for this specific chip.
- **Coordinate Range**: Both x and y coordinates range from 1 to 602.

## Reference documentation
- [rae230bcdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-rat2302cdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Rat Genome 230 2.0 Array. Use when user asks to map probe coordinates to indices, access CDF environment data, or determine chip dimensions for this specific microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rat2302cdf.html
---

# bioconductor-rat2302cdf

name: bioconductor-rat2302cdf
description: A specialized skill for working with the Bioconductor annotation package 'rat2302cdf'. Use this skill when you need to map probe coordinates to indices for the Rat Genome 230 2.0 Array, access CDF environment data, or determine chip dimensions for this specific Affymetrix platform.

# bioconductor-rat2302cdf

## Overview
The `rat2302cdf` package is a Bioconductor annotation resource containing the Chip Definition File (CDF) environment for the Affymetrix Rat Genome 230 2.0 Array. It provides the mapping between the physical (x, y) coordinates on the microarray chip and the 1-dimensional indices used in R objects like `AffyBatch`.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rat2302cdf")
```

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to convert between 2D chip layout and 1D indices. The chip dimensions for this array are 834 x 834 pixels (indices 1 to 695,556).

#### xy2i: Coordinates to Index
Converts (x, y) coordinates to a single-number index.
```r
library(rat2302cdf)
# Convert x=5, y=5 to index
idx <- xy2i(5, 5)
```

#### i2xy: Index to Coordinates
Converts a single-number index back into (x, y) coordinates.
```r
# Convert index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

### Accessing CDF Data
The package loads an environment named `rat2302cdf` which contains the probe set mappings.

```r
# View the environment
rat2302cdf

# List probe sets (first 5)
ls(rat2302cdf)[1:5]

# Get probe information for a specific probe set
get("1367452_at", rat2302cdf)
```

### Chip Dimensions
The `rat2302dim` object provides the dimensions of the array.

```r
rat2302dim
```

## Typical Workflow
When analyzing Affymetrix CEL files for the Rat 230 2.0 array, the `affy` package often loads this package automatically. Use this skill manually when you need to:
1. Identify the physical location of specific probes on the chip for quality control.
2. Manually extract probe-level data from an `AffyBatch` object using indices.
3. Verify probe set membership for specific (x, y) locations.

## Reference documentation
- [rat2302cdf Reference Manual](./references/reference_manual.md)
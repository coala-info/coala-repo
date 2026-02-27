---
name: bioconductor-mirna102xgaincdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix miRNA-1.0-2G-gain array. Use when user asks to map between chip coordinates and indices, access the CDF environment, or retrieve array dimensions for miRNA-1.0-2G-gain data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mirna102xgaincdf.html
---


# bioconductor-mirna102xgaincdf

name: bioconductor-mirna102xgaincdf
description: Provides specialized R functions for the mirna102xgaincdf annotation package. Use this skill when working with Affymetrix miRNA-1.0-2G-gain array data to map between (x,y) chip coordinates and single-number indices, or when accessing the CDF environment and chip dimensions.

# bioconductor-mirna102xgaincdf

## Overview
The `mirna102xgaincdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Affymetrix miRNA-1.0-2G-gain array. It provides the necessary mapping between the physical location of probes on the chip and their corresponding indices used in `AffyBatch` objects.

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to convert between 2D chip coordinates and 1D indices. The array dimensions are 230 x 230 (totaling 52,900 indices).

- `xy2i(x, y)`: Converts x and y coordinates (1 to 230) to a single-number index (1 to 52,900).
- `i2xy(i)`: Converts a single-number index to a data frame containing the corresponding x and y coordinates.

```r
library(mirna102xgaincdf)

# Convert specific coordinates to an index
index <- xy2i(x = 5, y = 5)

# Convert an index back to coordinates
coords <- i2xy(index)
# Result is a matrix/data frame with "x" and "y" columns
```

### Accessing CDF Data
The package exposes environments that describe the chip layout:

- `mirna102xgaincdf`: The environment containing the mapping of probesets to probe indices.
- `mirna102xgaindim`: The environment containing the dimensions of the array.

```r
# View dimensions
mirna102xgaindim

# List probesets in the CDF
ls(mirna102xgaincdf)[1:10]
```

## Typical Workflow
When analyzing Affymetrix miRNA data, this package is usually loaded automatically by `affy` or `oligo` when a CEL file with the corresponding header is read. However, manual coordinate mapping is useful for quality control or custom probe-level analysis.

```r
# Validation of coordinate mapping
i <- 1:52900
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))

# Check coordinate ranges
range(coord[, "x"]) # Should be 1 to 230
range(coord[, "y"]) # Should be 1 to 230
```

## Reference documentation
- [mirna102xgaincdf Reference Manual](./references/reference_manual.md)
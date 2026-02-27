---
name: bioconductor-test3cdf
description: This tool provides annotation data and coordinate mapping functions for the Affymetrix test3 chip. Use when user asks to convert between (x,y) chip coordinates and probe indices, access the CDF environment, or retrieve dimensions for the test3 array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/test3cdf.html
---


# bioconductor-test3cdf

name: bioconductor-test3cdf
description: Provides specialized functions for the test3cdf Bioconductor annotation package. Use this skill when working with Affymetrix test3 chip data to convert between (x,y) chip coordinates and single-number indices, or when accessing the CDF environment and dimensions for this specific array type.

# bioconductor-test3cdf

## Overview
The `test3cdf` package is a Bioconductor annotation data package for the Affymetrix test3 chip. Its primary purpose is to provide the mapping between the physical (x,y) coordinates on the chip and the 1-dimensional indices used in `AffyBatch` objects and CDF environments. It also provides environment objects describing the CDF structure and dimensions.

## Installation and Loading
To use this package in R:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("test3cdf")
library(test3cdf)
```

## Coordinate Conversion
The package provides two essential functions for mapping probe locations on the 126x126 grid (total 15,876 cells).

### Convert (x,y) to Index
Use `xy2i` to convert column and row coordinates into a single index.
- **x**: numeric (1 to 126)
- **y**: numeric (1 to 126)

```R
# Get the index for a specific coordinate
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
Use `i2xy` to convert a single index back into chip coordinates.
- **i**: numeric (1 to 15876)

```R
# Get coordinates for a range of indices
indices <- 1:10
coords <- i2xy(indices)
# Result is a matrix with "x" and "y" columns
```

## CDF Environments
The package exposes two environment objects containing metadata about the array:

- `test3cdf`: An environment describing the CDF file structure (mapping probesets to probe locations).
- `test3dim`: An environment describing the dimensions of the test3 chip.

```R
# View dimensions
ls(test3dim)

# Access CDF mapping
ls(test3cdf)[1:10] # List first 10 probesets
```

## Workflow Example: Validation
A common pattern is verifying that coordinate conversions are circular and within the expected bounds of the 126x126 grid.

```R
# Create all possible indices
i <- 1:(126*126)

# Convert to coordinates
coord <- i2xy(i)

# Convert back to indices
j <- xy2i(coord[, "x"], coord[, "y"])

# Verify consistency
stopifnot(all(i == j))

# Check bounds
range(coord[, "x"]) # Should be 1 to 126
range(coord[, "y"]) # Should be 1 to 126
```

## Reference documentation
- [test3cdf Reference Manual](./references/reference_manual.md)
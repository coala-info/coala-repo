---
name: bioconductor-drosgenome1cdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/drosgenome1cdf.html
---

# bioconductor-drosgenome1cdf

name: bioconductor-drosgenome1cdf
description: Provides environment and coordinate mapping data for the Drosophila Genome 1.0 Array (Affymetrix). Use when working with drosgenome1cdf CDF data in Bioconductor, specifically for mapping (x,y)-coordinates to probe indices or accessing chip dimensions for Drosophila genomic studies.

# bioconductor-drosgenome1cdf

## Overview
The `drosgenome1cdf` package is an annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Drosophila Genome 1.0 Array. It provides the necessary mapping between probe sets and their physical locations on the microarray chip. This package is primarily used as a dependency for high-level analysis packages like `affy` to process `.CEL` files.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("drosgenome1cdf")
library(drosgenome1cdf)
```

## Core Functions and Usage

### Coordinate Mapping (i2xy and xy2i)
The package provides utility functions to convert between the physical (x,y) coordinates on the chip and the single-number indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single index.
- `i2xy(i)`: Converts a single index back into x and y coordinates.

**Dimensions:** The Drosophila Genome 1.0 Array has a grid of 640 x 640.
- x-coordinates: 1 to 640
- y-coordinates: 1 to 640
- Indices: 1 to 409,600

**Example:**
```r
library(drosgenome1cdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix/data frame with "x" and "y" columns

# Verify all indices
i <- 1:(640*640)
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))
```

### Accessing CDF Data
The package contains two main environments:
- `drosgenome1cdf`: The main environment containing the CDF mapping.
- `drosgenome1dim`: Contains the dimensions of the chip.

```r
# View dimensions
ls(drosgenome1dim)

# Access the CDF environment
ls(drosgenome1cdf)[1:10] # List first 10 probe sets
```

## Typical Workflow
This package is rarely called directly by the user for manual mapping. Instead, it is used automatically by the `affy` package:

1. Load `affy`.
2. Read CEL files using `ReadAffy()`.
3. The `affy` package detects the chip type and automatically loads `drosgenome1cdf` to organize the probe data into probe sets.

If you need to manually inspect probe locations for a specific probe set:
```r
# Get probe indices for a specific probe set
probe_set <- get("141204_at", drosgenome1cdf)
```

## Reference documentation
- [drosgenome1cdf Reference Manual](./references/reference_manual.md)
---
name: bioconductor-hcg110cdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hcg110cdf.html
---

# bioconductor-hcg110cdf

name: bioconductor-hcg110cdf
description: A specialized skill for working with the Bioconductor annotation package hcg110cdf. Use this skill when you need to map probe coordinates to indices for the Affymetrix hcg110 chip, access CDF environments, or retrieve chip dimensions for high-throughput genomic data analysis in R.

# bioconductor-hcg110cdf

## Overview

The `hcg110cdf` package is a Bioconductor annotation resource providing the Chip Definition File (CDF) environment for the Affymetrix hcg110 platform. It is primarily used to map (x, y) coordinates on the microarray chip to the single-number indices used in `AffyBatch` objects and vice versa.

## Installation

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hcg110cdf")
library(hcg110cdf)
```

## Core Functions and Usage

### Coordinate Conversion (i2xy and xy2i)

The package provides utility functions to convert between 2D chip coordinates and 1D indices. The chip dimensions for hcg110 are 336 x 336, resulting in 112,896 total indices.

**Convert (x, y) to Index:**
```r
# Get the index for a specific coordinate (e.g., x=5, y=5)
idx <- xy2i(5, 5)
```

**Convert Index to (x, y):**
```r
# Get the coordinates for a specific index
coords <- i2xy(idx)
# Access x and y
x_val <- coords[, "x"]
y_val <- coords[, "y"]
```

### Accessing Environments

The package exposes two main environments:

1.  `hcg110cdf`: The main environment containing the mapping of probesets to probe indices.
2.  `hcg110dim`: An environment containing the dimensions of the chip.

```r
# List contents of the CDF environment
ls(hcg110cdf)[1:10]

# Get dimensions
ls(hcg110dim)
```

## Typical Workflow

When working with raw Affymetrix data (.CEL files) for the hcg110 chip, the `affy` package automatically looks for this annotation package to organize the probe-level data into probesets.

```r
library(affy)
library(hcg110cdf)

# If you have an AffyBatch object 'data'
# The package allows you to verify coordinate ranges
i <- 1:(336*336)
coord <- i2xy(i)
stopifnot(all(range(coord[, "x"]) == c(1, 336)))
stopifnot(all(range(coord[, "y"]) == c(1, 336)))
```

## Reference documentation

- [hcg110cdf Reference Manual](./references/reference_manual.md)
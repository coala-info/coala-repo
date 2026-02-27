---
name: bioconductor-mouse430a2cdf
description: This package provides the Chip Definition File environment and coordinate conversion utilities for the Affymetrix Mouse Genome 430A 2.0 Array. Use when user asks to access mouse430a2 CDF data, convert between chip (x,y) coordinates and indices, or process AffyBatch objects for this specific mouse array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mouse430a2cdf.html
---


# bioconductor-mouse430a2cdf

name: bioconductor-mouse430a2cdf
description: Provides specialized R functions and environment data for the Affymetrix Mouse Genome 430A 2.0 Array (mouse430a2). Use this skill when working with mouse430a2 CDF files, converting between (x,y) chip coordinates and single-number indices, or accessing the CDF environment for AffyBatch objects.

# bioconductor-mouse430a2cdf

## Overview
The `mouse430a2cdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Mouse Genome 430A 2.0 Array. It is primarily used in transcriptomics workflows to map probe intensities to their respective probe sets and to handle spatial coordinate conversions on the chip.

## Core Functions and Usage

### Loading the Package
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mouse430a2cdf")

library(mouse430a2cdf)
```

### Coordinate Conversion
The package provides utilities to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects. The chip dimensions for mouse430a2 are 732 x 732.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example:**
```r
# Convert specific coordinates to index
idx <- xy2i(5, 5)

# Convert index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### Accessing CDF Data
The package exposes two main environments:
- `mouse430a2cdf`: The environment containing the mapping of probes to probe sets.
- `mouse430a2dim`: The environment containing the dimensions of the array.

```r
# View dimensions
get("mouse430a2dim")

# List some probe sets in the CDF
ls(mouse430a2cdf)[1:10]
```

## Typical Workflow
This package is usually a dependency for higher-level analysis packages like `affy`. When you load an `AffyBatch` object containing Mouse 430A 2.0 data, the `affy` package will automatically look for this CDF package to process the raw data.

```r
library(affy)
# If 'data' is an AffyBatch object for Mouse 430A 2.0
# The following functions utilize mouse430a2cdf internally:
# pset <- probeset(data, "1415670_at")
# plotLocation(data, "1415670_at")
```

## Reference documentation
- [mouse430a2cdf Reference Manual](./references/reference_manual.md)
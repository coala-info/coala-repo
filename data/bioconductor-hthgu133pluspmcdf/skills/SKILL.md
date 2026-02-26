---
name: bioconductor-hthgu133pluspmcdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix HT_HG-U133_Plus_PM array. Use when user asks to map probe coordinates to indices, access CDF environment metadata, or process low-level data for Human Genome U133 Plus 2.0 PM-only arrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133pluspmcdf.html
---


# bioconductor-hthgu133pluspmcdf

name: bioconductor-hthgu133pluspmcdf
description: A specialized skill for working with the Bioconductor annotation package hthgu133pluspmcdf. Use this skill when analyzing Affymetrix Human Genome U133 Plus 2.0 PM-only array data in R, specifically for mapping probe (x,y)-coordinates to indices and accessing CDF environment metadata.

## Overview

The `hthgu133pluspmcdf` package is a Bioconductor annotation resource providing the Chip Definition File (CDF) environment for the Affymetrix HT_HG-U133_Plus_PM array. This package is essential for low-level data processing of CEL files, allowing for the mapping between physical probe locations on the chip and their corresponding indices used in `AffyBatch` objects.

## Installation

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hthgu133pluspmcdf")
```

## Core Functions and Usage

### Coordinate Conversion

The package provides two primary functions to convert between 2D chip coordinates and 1D indices. The array dimensions are 744 x 744, resulting in 553,536 total indices.

#### xy2i: Coordinates to Index
Converts x and y coordinates (1 to 744) into a single-number index.

```r
library(hthgu133pluspmcdf)

# Convert x=5, y=5 to an index
idx <- xy2i(5, 5)
```

#### i2xy: Index to Coordinates
Converts a single-number index (1 to 553,536) back into x and y coordinates.

```r
# Convert index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
print(coords)
```

### Accessing CDF Environments

The package exposes environment objects that describe the chip structure:

- `hthgu133pluspmcdf`: The main environment containing the mapping of probesets to probe indices.
- `hthgu133pluspmdim`: An environment containing the dimensions of the array.

```r
# View dimension information
ls(hthgu133pluspmdim)

# Get probeset names
probesets <- ls(hthgu133pluspmcdf)
head(probesets)

# Get indices for a specific probeset
get("200000_s_at", hthgu133pluspmcdf)
```

## Typical Workflow

When working with `affy` or `oligo` packages, this package is often loaded automatically. However, for manual probe-level analysis:

1. **Load the library**: `library(hthgu133pluspmcdf)`
2. **Identify Probes**: Use `ls(hthgu133pluspmcdf)` to find probesets of interest.
3. **Retrieve Indices**: Use `get()` to extract the probe indices for those sets.
4. **Map to Physical Locations**: Use `i2xy()` if you need to analyze spatial artifacts or chip gradients based on the CEL file data.

## Reference documentation

- [hthgu133pluspmcdf Reference Manual](./references/reference_manual.md)
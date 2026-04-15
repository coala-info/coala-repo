---
name: bioconductor-htrat230pmcdf
description: This package provides the Chip Definition File (CDF) environment and coordinate mapping data for the Affymetrix HT_Rat230_PM array. Use when user asks to map probes to probesets, convert between (x,y) coordinates and indices, or perform low-level analysis of Rat Genome 230 PM expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htrat230pmcdf.html
---

# bioconductor-htrat230pmcdf

name: bioconductor-htrat230pmcdf
description: Provides specialized annotation data for the Rat Genome 230 PM Array (HT_Rat230_PM). Use this skill when working with Affymetrix HT_Rat230_PM expression data in R, specifically for mapping probe (x,y) coordinates to indices and accessing the Chip Definition File (CDF) environment.

# bioconductor-htrat230pmcdf

## Overview

The `htrat230pmcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix HT_Rat230_PM array. This package is essential for low-level analysis of CEL files using the `affy` package, as it defines the mapping between physical probe locations on the chip and their corresponding probeset identifiers.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("htrat230pmcdf")
library(htrat230pmcdf)
```

## Core Functions and Usage

### Coordinate Conversion

The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinate range: 1 to 744
- Y-coordinate range: 1 to 744
- Total indices: 553,536

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices back to coordinates
coords <- i2xy(1:10)
# Returns a matrix with "x" and "y" columns
```

### CDF Environments

The package exposes two primary environments used by other Bioconductor tools:

1.  `htrat230pmcdf`: The main environment describing the CDF file structure (mapping probes to probesets).
2.  `htrat230pmdim`: An environment containing the dimensions of the HT_Rat230_PM chip.

These are typically accessed automatically by functions like `read.affybatch()` or `rma()`, but can be inspected manually:

```r
# List probesets in the CDF
ls(htrat230pmcdf)[1:10]

# Get dimensions
ls(htrat230pmdim)
```

## Typical Workflow

This package is usually a dependency for higher-level analysis. A common workflow involves:

1.  Loading `.CEL` files using `affy::ReadAffy()`.
2.  The `affy` package automatically detects the `HT_Rat230_PM` array type and loads `htrat230pmcdf`.
3.  Performing background correction, normalization, and summarization (e.g., using `rma()`).

If you need to manually map a specific probe back to its location for quality control:
```r
# Get the index of a probe from an AffyBatch object 'abatch'
# Then find its physical location:
probe_coords <- i2xy(index_value)
```

## Reference documentation

- [htrat230pmcdf Reference Manual](./references/reference_manual.md)
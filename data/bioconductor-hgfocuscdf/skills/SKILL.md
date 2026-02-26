---
name: bioconductor-hgfocuscdf
description: This package provides the Chip Definition File (CDF) environment and coordinate mapping functions for the Affymetrix HG-Focus target array. Use when user asks to map probe coordinates to indices, access HG-Focus chip dimensions, or process transcriptomics data from HG-Focus CEL files in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgfocuscdf.html
---


# bioconductor-hgfocuscdf

name: bioconductor-hgfocuscdf
description: Provides specialized knowledge for the hgfocuscdf Bioconductor annotation package. Use this skill when working with Affymetrix HG-Focus chip data in R, specifically for mapping probe (x,y)-coordinates to indices and accessing the Chip Definition File (CDF) environment.

# bioconductor-hgfocuscdf

## Overview
The `hgfocuscdf` package is a Bioconductor annotation data package that contains the Chip Definition File (CDF) environment for the Affymetrix HG-Focus target array. It is primarily used in transcriptomics workflows to map probe intensities from CEL files to their respective probe sets and genomic locations.

## Core Functions and Usage

### Loading the Package
To use the CDF environment, the package must be loaded into the R session:

```r
library(hgfocuscdf)
```

### Coordinate Conversion (i2xy and xy2i)
Affymetrix data often represents probe locations as (x,y) coordinates on the chip grid. However, `AffyBatch` objects and CDF environments frequently use a single-number index.

- **xy2i**: Converts x and y coordinates to a single index.
- **i2xy**: Converts a single index back into x and y coordinates.

**Grid Dimensions:** The HG-Focus chip is a 448 x 448 grid.
- x-coordinates: 1 to 448
- y-coordinates: 1 to 448
- Indices: 1 to 200,704

**Example Workflow:**
```r
# Convert specific coordinates to an index
idx <- xy2i(x = 5, y = 5)

# Convert an index (or range of indices) back to coordinates
coords <- i2xy(idx)
# coords will be a matrix with columns "x" and "y"

# Verify the range of the chip
all_indices <- 1:(448 * 448)
all_coords <- i2xy(all_indices)
range(all_coords[, "x"]) # 1 448
range(all_coords[, "y"]) # 1 448
```

### Accessing CDF Environments
The package provides two main environments:

1.  **hgfocuscdf**: The main environment describing the CDF file mapping. This is typically used internally by functions like `read.affybatch` or `rma`, but can be queried directly using `ls(hgfocuscdf)`.
2.  **hgfocusdim**: An environment containing the dimensions of the HG-Focus chip.

```r
# View dimensions
ls(hgfocusdim)

# Get list of probe sets (first 10)
head(ls(hgfocuscdf), 10)
```

## Typical Workflow Integration
This package is rarely used in isolation. It is usually a dependency for the `affy` package. When you load a CEL file from an HG-Focus array using `ReadAffy()`, the `affy` package automatically looks for `hgfocuscdf` to correctly interpret the probe layout.

```r
library(affy)
# If working with HG-Focus CEL files:
# data <- ReadAffy() 
# The 'cdfname' attribute will be set to "hgfocus" and this package will be utilized.
```

## Reference documentation
- [hgfocuscdf Reference Manual](./references/reference_manual.md)
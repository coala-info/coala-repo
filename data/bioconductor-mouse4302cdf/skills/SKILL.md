---
name: bioconductor-mouse4302cdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Mouse Genome 430 2.0 Array. Use when user asks to map probes to probe sets, convert between (x,y)-coordinates and indices, or process Mouse Genome 430 2.0 Array data in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mouse4302cdf.html
---

# bioconductor-mouse4302cdf

name: bioconductor-mouse4302cdf
description: Specialized knowledge for the mouse4302cdf Bioconductor package. Use this skill when processing Affymetrix Mouse Genome 430 2.0 Array data in R, specifically for mapping probe (x,y)-coordinates to indices and accessing the Chip Definition File (CDF) environment.

# bioconductor-mouse4302cdf

## Overview

The `mouse4302cdf` package is an annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix Mouse Genome 430 2.0 Array. This array is designed to provide comprehensive coverage of the transcribed mouse genome. The package is primarily used by the `affy` package to map individual probes on the chip to their corresponding probe sets (genes).

## Installation and Loading

To use this package, it must be installed via BiocManager and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mouse4302cdf")
library(mouse4302cdf)
```

## Key Components

### The CDF Environment
The main object is `mouse4302cdf`, which is an R environment containing the mapping between probe set identifiers and the indices of the probes belonging to those sets.

### Chip Dimensions
The `mouse4302dim` object provides the dimensions of the array:
- **Rows/Columns**: 1002 x 1002
- **Total Indices**: 1,004,004

## Coordinate Conversion

The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

### xy2i: Coordinates to Index
Converts x and y coordinates (1-based) to a single-number index.
```r
# Convert x=5, y=5 to an index
idx <- xy2i(5, 5)
```

### i2xy: Index to Coordinates
Converts a single-number index back into x and y coordinates.
```r
# Convert index 500 to coordinates
coords <- i2xy(500)
# Returns a matrix with columns "x" and "y"
```

## Typical Workflows

### Integration with affy
This package is usually called automatically when reading CEL files from a Mouse 430 2.0 array. However, you can manually inspect the mapping:

```r
library(affy)
# List the first few probe sets
ls(mouse4302cdf)[1:10]

# Get probe indices for a specific probe set
probes <- get("1415670_at", mouse4302cdf)
```

### Spatial Analysis
If performing spatial quality control, use `i2xy` to map high-intensity or outlier indices back to their physical location on the chip:

```r
# Example: Find coordinates for a vector of indices
indices <- c(1, 100, 1000)
coords <- i2xy(indices)
print(coords)
```

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
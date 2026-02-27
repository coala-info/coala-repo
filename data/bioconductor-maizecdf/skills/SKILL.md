---
name: bioconductor-maizecdf
description: This package provides the Chip Definition File environment for the Affymetrix Maize Genome Array to map probe coordinates to indices. Use when user asks to convert between chip coordinates and indices, access maize CDF environments, or map probeset IDs to physical locations on the array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/maizecdf.html
---


# bioconductor-maizecdf

name: bioconductor-maizecdf
description: A specialized skill for working with the 'maizecdf' Bioconductor package. Use this skill when you need to handle Affymetrix Maize Genome Array CDF (Chip Definition File) data in R, specifically for mapping (x,y) coordinates to probe indices and accessing chip environment metadata.

# bioconductor-maizecdf

## Overview
The `maizecdf` package is an annotation data package providing the Chip Definition File (CDF) environment for the Affymetrix Maize Genome Array. It allows R users to map between the physical (x,y) coordinates on the microarray chip and the single-number indices used in `AffyBatch` objects and CDF environments.

## Loading the Package
To use the environments and functions, load the library in R:
```r
library(maizecdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to convert between 2D chip coordinates and 1D indices. The chip dimensions for this array are 732 x 732 (totaling 535,824 indices).

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example Workflow:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix or data frame with "x" and "y" columns

# Verify consistency
all.equal(xy2i(coords[,"x"], coords[,"y"]), idx)
```

### CDF Environments
The package exposes two main environments containing metadata about the Maize array:

1.  `maizecdf`: The environment containing the mapping of probeset IDs to probe locations.
2.  `maizedim`: The environment describing the dimensions of the CDF file (e.g., the number of rows and columns on the chip).

To inspect these environments:
```r
# View dimensions
ls(maizedim)
# View a sample of the CDF mapping
ls(maizecdf)[1:10]
```

## Typical Workflow
When analyzing Affymetrix maize data using the `affy` package, `maizecdf` is typically loaded automatically when an `AffyBatch` object is created from CEL files. Use this skill manually when you need to:
1.  Identify the physical location of specific probes on the array.
2.  Perform custom quality control by mapping spatial artifacts (from CEL file plots) to specific probe indices.
3.  Extract probe-level data manually from `AffyBatch` objects using coordinate-based indexing.

## Reference documentation
- [maizecdf Reference Manual](./references/reference_manual.md)
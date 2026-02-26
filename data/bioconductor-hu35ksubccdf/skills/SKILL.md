---
name: bioconductor-hu35ksubccdf
description: This package provides the Chip Definition File environment for the Affymetrix Hu35KsubC microarray. Use when user asks to map probe coordinates to indices, access CDF environment metadata, or process Affymetrix Human Genome Hu35K sub-chip C data in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubccdf.html
---


# bioconductor-hu35ksubccdf

name: bioconductor-hu35ksubccdf
description: Provides specialized knowledge for the hu35ksubccdf Bioconductor annotation package. Use this skill when working with Affymetrix Human Genome Hu35K sub-chip C (hu35ksubc) microarray data in R, specifically for mapping (x,y)-coordinates to probe indices and accessing CDF environment metadata.

# bioconductor-hu35ksubccdf

## Overview
The `hu35ksubccdf` package is a Bioconductor annotation interface for the Affymetrix Hu35KsubC chip. It provides the Chip Definition File (CDF) environment, which is essential for processing CEL files into `AffyBatch` objects. Its primary utility lies in mapping physical probe locations on the microarray grid to the single-number indices used in R's data structures.

## Core Functions and Usage

### Loading the Package
To use the annotation environment, load the library in R:
```r
library(hu35ksubccdf)
```

### Coordinate Conversion
The package provides two utility functions to convert between 2D chip coordinates and 1D indices. The chip dimensions for hu35ksubc are 534 x 534.

- `xy2i(x, y)`: Converts (x,y)-coordinates (1 to 534) to a single-number index (1 to 285,156).
- `i2xy(i)`: Converts a single-number index back into a matrix of (x,y)-coordinates.

**Example Workflow:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices to coordinates
indices <- 1:10
coords <- i2xy(indices)

# Verify coordinates are within chip bounds
range(coords[, "x"]) # Should be within 1:534
range(coords[, "y"]) # Should be within 1:534
```

### Accessing CDF Environments
The package contains two primary environments:
- `hu35ksubccdf`: The main environment describing the CDF file structure (mapping probes to probesets).
- `hu35ksubcdim`: An environment containing the dimensions of the chip.

To inspect these environments:
```r
# View dimensions
as.list(hu35ksubcdim)

# List probesets in the CDF
ls(hu35ksubccdf)[1:10]
```

## Typical Workflow
This package is usually not called directly by the user but is required by the `affy` package when reading CEL files:

1. Load `affy` and `hu35ksubccdf`.
2. Use `ReadAffy()` to create an `AffyBatch` object.
3. The `affy` package automatically looks for `hu35ksubccdf` to interpret the probe data if the chip type is identified as "Hu35KsubC".

## Reference documentation
- [hu35ksubccdf Reference Manual](./references/reference_manual.md)
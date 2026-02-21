---
name: bioconductor-hu6800subccdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu6800subccdf.html
---

# bioconductor-hu6800subccdf

## Overview
The `hu6800subccdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Hu6800 GeneChip (sub-grid version). It provides the necessary mapping between probe set identifiers and their physical locations on the microarray.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hu6800subccdf")
library(hu6800subccdf)
```

## Coordinate Mapping
The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

### Convert (x,y) to Index
To get the single-number index from chip coordinates:
```r
# Example for coordinates x=5, y=5
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
To get the chip coordinates from a single-number index:
```r
# Example for index 100
coords <- i2xy(100)
# Returns a matrix with columns "x" and "y"
```

### Chip Dimensions
The chip dimensions for the hu6800sub platform are 276 x 276 pixels, resulting in a total of 76,176 indices.
- **X-range**: 1 to 276
- **Y-range**: 1 to 276
- **Index range**: 1 to 76176

## Data Environments
The package exposes two main environments:
- `hu6800subccdf`: The main CDF environment mapping probe sets to locations.
- `hu6800subcdim`: An environment describing the dimensions of the CDF.

To view the contents of the CDF environment:
```r
ls(hu6800subccdf)[1:10] # List first 10 probe sets
```

## Typical Workflow
This package is usually not called directly by the user but is loaded automatically by the `affy` package when processing Hu6800 data:

```r
library(affy)
# When reading CEL files, affy looks for this package
data <- ReadAffy() 
# If the CEL header specifies hu6800sub, this package provides the mapping
```

## Reference documentation
- [hu6800subccdf Reference Manual](./references/reference_manual.md)
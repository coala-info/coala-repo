---
name: bioconductor-drosophila2cdf
description: This package provides the Chip Definition File environment for the Affymetrix Drosophila Genome 2.0 Array. Use when user asks to map probe identifiers to physical chip coordinates, convert between 1D indices and 2D coordinates, or manage CDF environments for Drosophila 2.0 AffyBatch objects.
homepage: https://bioconductor.org/packages/release/data/annotation/html/drosophila2cdf.html
---

# bioconductor-drosophila2cdf

name: bioconductor-drosophila2cdf
description: A specialized skill for working with the Bioconductor annotation package 'drosophila2cdf'. Use this skill when you need to map Affymetrix Drosophila Genome 2.0 Array probe identifiers to their physical coordinates (x, y) on the chip, or when working with AffyBatch objects that require the CDF environment for Drosophila 2.0.

# bioconductor-drosophila2cdf

## Overview
The `drosophila2cdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix Drosophila Genome 2.0 Array. It is primarily used in transcriptomics workflows to map probe intensities to their respective probe sets and to convert between 1D indices and 2D (x, y) coordinates on the microarray surface.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("drosophila2cdf")
```

## Core Environments and Data
The package provides two main environments:
- `drosophila2cdf`: The main environment describing the CDF file structure.
- `drosophila2dim`: Contains the dimensions of the chip (732 x 732).

## Coordinate Conversion (i2xy)
A common task is converting between the single-number indices used in `AffyBatch` objects and the physical (x, y) coordinates on the CEL file/chip.

### Convert (x, y) to Index
To get the 1D index from 2D coordinates:
```r
library(drosophila2cdf)
# Example: Get index for coordinate x=5, y=5
idx <- xy2i(5, 5)
```

### Convert Index to (x, y)
To get the 2D coordinates from a 1D index:
```r
# Example: Get coordinates for index 500
coords <- i2xy(500)
# Returns a matrix with columns "x" and "y"
```

## Typical Workflow
When analyzing Affymetrix Drosophila 2.0 data, the `affy` package will often look for this package automatically.

```r
library(affy)
library(drosophila2cdf)

# When reading CEL files, the CDF is often detected automatically
# raw_data <- ReadAffy()

# To manually inspect the CDF environment
ls(drosophila2cdf)[1:10] # List first 10 probe sets

# Get dimensions of the array
# The chip is 732 x 732, total indices = 535,824
```

## Usage Tips
- **Index Range**: The single-number indices range from 1 to 535,824.
- **Coordinate Range**: Both x and y coordinates range from 1 to 732.
- **Function Definitions**: To see the underlying logic of the conversion functions, you can type `i2xy` or `xy2i` without parentheses in the R console.

## Reference documentation
- [drosophila2cdf Reference Manual](./references/reference_manual.md)
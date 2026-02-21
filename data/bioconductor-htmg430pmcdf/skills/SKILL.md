---
name: bioconductor-htmg430pmcdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htmg430pmcdf.html
---

# bioconductor-htmg430pmcdf

name: bioconductor-htmg430pmcdf
description: Provides specialized environment data and coordinate mapping functions for the Affymetrix HT_MG-430_PM chip. Use when working with Bioconductor's htmg430pmcdf package to map (x,y) probe coordinates to indices, or when requiring the CDF environment for AffyBatch objects.

# bioconductor-htmg430pmcdf

## Overview
The `htmg430pmcdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Affymetrix HT_MG-430_PM oligonucleotide array. It is primarily used in transcriptomics workflows to map probe intensities to their respective probe sets and to handle the spatial dimensions of the chip.

## Installation and Loading
To use this package in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("htmg430pmcdf")
library(htmg430pmcdf)
```

## Core Environments
The package provides two main environments:
- `htmg430pmcdf`: The main environment describing the CDF file structure.
- `htmg430pmdim`: An environment containing the dimensions of the chip (744 x 744).

## Coordinate Mapping
The package includes utility functions to convert between 2D chip coordinates and 1D indices used in `AffyBatch` objects.

### xy2i: Coordinates to Index
Converts x and y coordinates (1 to 744) into a single-number index (1 to 553,536).
```r
# Get the index for a probe at x=5, y=5
idx <- xy2i(5, 5)
```

### i2xy: Index to Coordinates
Converts a single-number index back into x and y coordinates.
```r
# Get coordinates for index 500
coords <- i2xy(500)
# Access x and y
x_val <- coords[, "x"]
y_val <- coords[, "y"]
```

## Typical Workflow
This package is usually called implicitly by other Bioconductor packages like `affy`. However, you can use it manually to verify probe locations:

```r
library(htmg430pmcdf)

# 1. Check chip dimensions
# The dimensions are 744 x 744
ls(htmg430pmdim)

# 2. Perform a round-trip conversion check
i <- 1:10
coords <- i2xy(i)
j <- xy2i(coords[, "x"], coords[, "y"])
stopifnot(all(i == j))

# 3. Inspect the CDF environment
# List some probe sets
ls(htmg430pmcdf)[1:10]
```

## Usage Tips
- **Coordinate Range**: The x and y coordinates range from 1 to 744.
- **Index Range**: The total number of probes (indices) is 553,536.
- **Implicit Use**: When loading a CEL file from an HT_MG-430_PM chip using `read.affybatch()`, R will automatically look for this package to define the probe layout.

## Reference documentation
- [htmg430pmcdf Reference Manual](./references/reference_manual.md)
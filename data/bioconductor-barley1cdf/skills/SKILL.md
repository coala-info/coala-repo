---
name: bioconductor-barley1cdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/barley1cdf.html
---

# bioconductor-barley1cdf

name: bioconductor-barley1cdf
description: A specialized skill for working with the Bioconductor annotation package 'barley1cdf'. Use this skill when you need to access CDF (Chip Description File) environments for the Affymetrix Barley Genome Array, including mapping between (x,y) coordinates and index values for probe sets.

# bioconductor-barley1cdf

## Overview
The `barley1cdf` package is a Bioconductor annotation data package that provides the Chip Description File (CDF) environment for the Affymetrix Barley Genome Array. It is essential for low-level analysis of Affymetrix CEL files using the `affy` package, allowing for the mapping of probes to their respective probe sets and physical locations on the chip.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("barley1cdf")
library(barley1cdf)
```

## Core Components
The package provides three primary objects/functions:

1.  **barley1cdf**: An environment object containing the mapping of probe set IDs to probe locations.
2.  **barley1dim**: An environment describing the dimensions of the Barley1 chip (712 x 712).
3.  **i2xy / xy2i**: Functions to convert between 1D indices and 2D (x,y) coordinates.

## Workflows and Usage

### Coordinate Conversion
Affymetrix data often uses a single-number index to represent probe locations. You can convert these to (x,y) coordinates (and vice versa) using the provided utility functions. Note that coordinates are 1-based.

```r
# Convert (x,y) to a single index
idx <- xy2i(x = 5, y = 5)

# Convert a single index back to (x,y) coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

### Accessing CDF Data
While typically handled automatically by the `affy` package when reading CEL files, you can manually inspect the CDF environment:

```r
# List some probe sets
ls(barley1cdf)[1:10]

# Get probe indices for a specific probe set
probe_set <- get("Contig1_at", barley1cdf)
```

## Tips
- The chip dimensions are 712 x 712, resulting in a total of 506,944 indices.
- This package is a "data" package; it does not perform normalization or differential expression itself but provides the necessary metadata for packages like `affy` or `oligo` to do so.
- When using `read.affybatch()`, the `affy` package will automatically look for `barley1cdf` if the CEL file header identifies the chip as "Barley1".

## Reference documentation
- [barley1cdf Reference Manual](./references/reference_manual.md)
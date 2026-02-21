---
name: bioconductor-hgu95dcdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95dcdf.html
---

# bioconductor-hgu95dcdf

name: bioconductor-hgu95dcdf
description: A specialized skill for working with the Bioconductor annotation package hgu95dcdf. Use this skill when you need to access CDF (Chip Description File) environments for the Affymetrix Human Genome U95v2 (d) array, specifically for mapping probe (x,y) coordinates to indices and retrieving chip dimensions.

# bioconductor-hgu95dcdf

## Overview

The `hgu95dcdf` package is a Bioconductor annotation data package that provides the Chip Description File (CDF) environment for the Affymetrix HGU95d oligonucleotide array. It is primarily used in conjunction with the `affy` package to map probe-level data from CEL files to their respective probe sets and physical locations on the chip.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgu95dcdf")
library(hgu95dcdf)
```

## Key Components

### 1. The CDF Environment
The package loads an environment named `hgu95dcdf`. This environment contains the mapping of probe set identifiers to the locations of the probes on the array.

```r
# View the environment
hgu95dcdf
# List some probe sets
ls(hgu95dcdf)[1:10]
```

### 2. Chip Dimensions
The `hgu95ddim` object provides the dimensions of the HGU95d array (typically 640x640).

```r
hgu95ddim
```

### 3. Coordinate Conversion (i2xy and xy2i)
The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Note:** Coordinates are 1-based in R.

```r
# Example: Convert coordinate (5, 5) to an index
idx <- xy2i(5, 5)

# Example: Convert index back to coordinates
coords <- i2xy(idx)
# coords will be a matrix with columns "x" and "y"
```

## Typical Workflow

This package is usually called internally by high-level functions in the `affy` package, but you can use it manually for probe-level analysis:

1. **Identify Probe Locations**: Use the `hgu95dcdf` environment to find which indices belong to a specific GeneChip probe set.
2. **Coordinate Mapping**: Use `i2xy` to determine the physical location of specific probes to check for spatial artifacts on the chip.
3. **Manual Indexing**: Use `xy2i` when extracting specific intensity values from the `exprs` slot of an `AffyBatch` object.

```r
# Get indices for a specific probe set
probeset_indices <- get("100_g_at", envir = hgu95dcdf)

# Convert those indices to physical coordinates
probe_coords <- i2xy(probeset_indices[,1])
```

## Reference documentation

- [hgu95dcdf Reference Manual](./references/reference_manual.md)
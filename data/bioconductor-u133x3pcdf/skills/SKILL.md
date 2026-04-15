---
name: bioconductor-u133x3pcdf
description: This package provides the Chip Description File environment and coordinate mapping functions for the Affymetrix u133x3p microarray platform. Use when user asks to map probe intensities to probe sets, convert between chip coordinates and indices, or process CEL files for the Human Genome U133 Plus 2.0 chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/u133x3pcdf.html
---

# bioconductor-u133x3pcdf

name: bioconductor-u133x3pcdf
description: Provides specialized environment data and coordinate mapping functions for the Affymetrix u133x3p (Human Genome U133 Plus 2.0) chip. Use when processing CEL files or AffyBatch objects in R that require the u133x3p CDF (Chip Description File) for probe-to-probeset mapping and spatial coordinate conversions.

# bioconductor-u133x3pcdf

## Overview
The `u133x3pcdf` package is a Bioconductor annotation package containing the Chip Description File (CDF) environment for the Affymetrix u133x3p platform. It is primarily used by the `affy` package to map raw intensity data from CEL files to specific probe sets. It also provides utility functions to convert between 2D chip coordinates (x, y) and 1D indices used in R objects.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("u133x3pcdf")
```

## Core Functions and Usage

### Loading the CDF Environment
The package automatically creates an environment named `u133x3pcdf` when loaded. This is typically handled internally by high-level functions like `ReadAffy()`, but can be accessed directly:

```r
library(u133x3pcdf)

# View dimensions of the chip
# The u133x3p chip is 1164 x 1164
u133x3pdim
```

### Coordinate Conversion
The package provides two essential functions for mapping spatial data on the array:

1.  **xy2i**: Converts (x, y) coordinates to a single-number index.
2.  **i2xy**: Converts a single-number index back to (x, y) coordinates.

**Note:** Coordinates in this package are 1-based (ranging from 1 to 1164).

```r
# Convert specific x, y coordinates to an index
idx <- xy2i(x = 5, y = 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

### Typical Workflow with AffyBatch
This package is usually a dependency for analyzing u133x3p microarrays. When you load data using `affy`, the package is called to provide the mapping:

```r
library(affy)
# If working with .CEL files in the current directory
# data <- ReadAffy() 

# The 'cdfname' attribute of the AffyBatch object will point to "u133x3p"
# which triggers the use of this environment.
```

## Data Structures
- **u133x3pcdf**: An environment containing the mapping between probe set IDs and the indices of the probes on the chip.
- **u133x3pdim**: An environment or variable describing the physical dimensions of the array (1164 rows by 1164 columns).

## Reference documentation
- [u133x3pcdf Reference Manual](./references/reference_manual.md)
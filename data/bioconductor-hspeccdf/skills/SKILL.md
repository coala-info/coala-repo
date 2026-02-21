---
name: bioconductor-hspeccdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hspeccdf.html
---

# bioconductor-hspeccdf

name: bioconductor-hspeccdf
description: A specialized skill for working with the Bioconductor annotation package 'hspeccdf'. Use this skill when you need to map (x,y)-coordinates to indices for the hspec Affymetrix chip, access CDF environment data, or determine chip dimensions for high-throughput genomic analysis in R.

# bioconductor-hspeccdf

## Overview
The `hspeccdf` package is a Bioconductor annotation interface for the hspec chip. It provides the environment mapping between probe identifiers and their physical locations on the microarray. This skill facilitates the conversion of spatial coordinates to index values used in `AffyBatch` objects and provides access to the underlying CDF structure.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hspeccdf")
library(hspeccdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to translate between the 2D layout of the chip and the 1D indices used in R data structures.

- `xy2i(x, y)`: Converts (x,y)-coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into (x,y)-coordinates.

**Dimensions:**
- x-coordinates: 1 to 1164
- y-coordinates: 1 to 1164
- Total indices: 1 to 1,354,896

**Example Workflow:**
```r
library(hspeccdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix/data frame with "x" and "y" columns

# Verify consistency
stopifnot(all(xy2i(coords[, "x"], coords[, "y"]) == idx))
```

### Accessing CDF Data
The package contains environment objects that describe the chip layout:

- `hspeccdf`: The main environment containing the CDF file mapping.
- `hspecdim`: An environment describing the specific dimensions of the hspec array.

To list the contents or probe sets within the CDF:
```r
ls(hspeccdf)[1:10] # View first 10 probe sets
```

## Typical Workflow
1. **Loading Data**: Load a CEL file into an `AffyBatch` object.
2. **Annotation**: The `affy` package automatically looks for `hspeccdf` when processing hspec chip data.
3. **Spatial Analysis**: Use `i2xy` to identify the physical location of outliers or specific probes identified during quality control to check for regional chip artifacts (e.g., "smudges" or "halos").

## Reference documentation
- [hspeccdf Reference Manual](./references/reference_manual.md)
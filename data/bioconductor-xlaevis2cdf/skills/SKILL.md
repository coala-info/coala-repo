---
name: bioconductor-xlaevis2cdf
description: This package provides the CDF environment for the Xenopus laevis Affymetrix expression array to map probe intensities to probe sets. Use when user asks to process Xenopus laevis CEL files, map probe coordinates to indices, or analyze AffyBatch objects requiring the xlaevis2cdf annotation.
homepage: https://bioconductor.org/packages/release/data/annotation/html/xlaevis2cdf.html
---


# bioconductor-xlaevis2cdf

name: bioconductor-xlaevis2cdf
description: Provides the CDF (Chip Definition File) environment for the Xenopus laevis (African clawed frog) Affymetrix expression array. Use this skill when working with AffyBatch objects in R that require the xlaevis2cdf annotation package to map probe intensities to probe sets, or when converting between (x,y) chip coordinates and index values for this specific platform.

# bioconductor-xlaevis2cdf

## Overview
The `xlaevis2cdf` package is a Bioconductor annotation data package. It contains the CDF environment for the Affymetrix Xenopus laevis chip. This environment is essential for processing `.CEL` files using the `affy` package, as it defines the mapping between the physical location of probes on the array and their corresponding probe sets.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("xlaevis2cdf")
```

## Core Functions and Usage

### Loading the CDF Environment
The package is typically loaded automatically by functions in the `affy` package (like `ReadAffy()`), but can be accessed directly:

```r
library(xlaevis2cdf)

# View the dimensions of the chip
# The xlaevis chip is 984 x 984 probes
xlaevis2dim
```

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Note:** Coordinates are 1-based, ranging from 1 to 984.

```r
# Example: Convert coordinate (5, 5) to index
idx <- xy2i(5, 5)

# Example: Convert index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

### Integration with affy
When analyzing Xenopus laevis data, ensure this package is available so that `affy` can correctly interpret the raw data:

```r
library(affy)
# If your CEL files are for the Xenopus laevis chip:
data <- ReadAffy() 
# The 'cdfname' attribute will be set to "xlaevis"
# and 'xlaevis2cdf' will be used for mapping.
```

## Workflow Tips
- **Memory:** Like most CDF environments, this package loads data into an environment. It is lightweight compared to probe packages but necessary for the `rma()` or `mas5()` normalization pipelines.
- **Verification:** If you encounter errors regarding "compatible CDF environments," verify that your `AffyBatch` object's `cdfname` matches "xlaevis".

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
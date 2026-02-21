---
name: bioconductor-hgu133plus2cdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133plus2cdf.html
---

# bioconductor-hgu133plus2cdf

name: bioconductor-hgu133plus2cdf
description: Access and use the hgu133plus2cdf annotation package for the Affymetrix Human Genome U133 Plus 2.0 Array. Use this skill when you need to map (x,y)-coordinates from CEL files to probe indices, or when you need to access the CDF environment and chip dimensions for this specific microarray platform.

# bioconductor-hgu133plus2cdf

## Overview
The `hgu133plus2cdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Human Genome U133 Plus 2.0 Array. It provides the necessary mapping between the physical location of probes on the array (x, y coordinates) and the probe set identifiers used in downstream expression analysis.

## Installation
To use this package in R, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hgu133plus2cdf")
```

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates on the chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinate range: 1 to 1164
- Y-coordinate range: 1 to 1164
- Total indices: 1,354,896

**Example:**
```r
library(hgu133plus2cdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with "x" and "y" columns
```

### Accessing CDF Data
The package loads two primary environments into the R session:

1.  `hgu133plus2cdf`: The main environment containing the mapping of probe sets to their locations.
2.  `hgu133plus2dim`: An environment containing the dimensions of the array.

```r
# View dimensions
ls(hgu133plus2dim)

# Access the CDF environment
# This is typically used internally by packages like 'affy'
# but can be inspected manually:
ls(hgu133plus2cdf)[1:10] # List first 10 probe sets
```

## Typical Workflow
This package is rarely used standalone. It is usually a dependency for the `affy` package when processing `.CEL` files from the HGU133 Plus 2.0 platform.

```r
library(affy)
# When reading CEL files, 'affy' automatically looks for this package
# if the CEL header specifies the HGU133Plus2 chip.
data <- ReadAffy() 
```

## Reference documentation
- [hgu133plus2cdf Reference Manual](./references/reference_manual.md)
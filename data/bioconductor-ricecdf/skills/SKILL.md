---
name: bioconductor-ricecdf
description: This package provides the Chip Definition File environment for the Affymetrix Rice Genome Array to map probe intensities to probe sets. Use when user asks to handle rice microarray CDF data, convert between chip coordinates and indices, or access rice chip dimensions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ricecdf.html
---

# bioconductor-ricecdf

name: bioconductor-ricecdf
description: A specialized skill for working with the Bioconductor R package 'ricecdf'. Use this skill when you need to handle Affymetrix Rice Genome Array CDF (Chip Definition File) data, specifically for mapping (x,y) coordinates to indices, accessing CDF environments, or retrieving chip dimensions for rice microarray analysis.

# bioconductor-ricecdf

## Overview
The `ricecdf` package is an annotation data package providing the Chip Definition File (CDF) environment for the Affymetrix Rice Genome Array. It is primarily used in conjunction with the `affy` package to process CEL files and map probe intensities to their respective probe sets.

## Installation and Loading
To use this package, it must be installed via BiocManager and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ricecdf")
library(ricecdf)
```

## Core Functions and Usage

### Coordinate Mapping
The package provides utility functions to convert between the 2D (x,y) coordinates used on the physical chip/CEL file and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- **x-coordinate:** 1 to 1164
- **y-coordinate:** 1 to 1164
- **Total Indices:** 1 to 1,354,896

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix or data frame with "x" and "y" columns
```

### CDF Environments
The package contains two primary environments used by other Bioconductor tools:

1.  `ricecdf`: The main environment describing the CDF file structure (mapping probes to probe sets).
2.  `ricedim`: An environment describing the dimensions of the rice chip.

To view the contents or dimensions:
```r
# View dimension information
ricedim

# Access the CDF environment
ricecdf
```

## Typical Workflow
This package is rarely used in isolation. It is typically called automatically by the `affy` package when reading rice microarray data:

```r
library(affy)
# When ReadAffy() encounters a Rice chip, it loads ricecdf automatically
data <- ReadAffy() 
# The mapping between probes and sets is now handled by ricecdf
```

## Reference documentation
- [ricecdf Reference Manual](./references/reference_manual.md)
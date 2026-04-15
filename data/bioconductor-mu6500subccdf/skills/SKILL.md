---
name: bioconductor-mu6500subccdf
description: This package provides the Chip Definition File (CDF) environment and coordinate mapping functions for the Affymetrix Mu6500sub microarray chip. Use when user asks to map probe coordinates to indices, access the CDF environment for Mu6500sub data, or retrieve chip dimensions for low-level microarray analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu6500subccdf.html
---

# bioconductor-mu6500subccdf

name: bioconductor-mu6500subccdf
description: Provides specialized knowledge for the mu6500subccdf Bioconductor annotation package. Use this skill when working with Affymetrix Mu6500sub chip data in R, specifically for mapping probe (x,y) coordinates to indices, accessing the CDF environment, or retrieving chip dimensions.

# bioconductor-mu6500subccdf

## Overview
The `mu6500subccdf` package is an annotation resource for the Affymetrix Mu6500sub chip. It provides the CDF (Chip Definition File) environment, which maps probes to probe sets, and includes utility functions for coordinate conversion. This package is essential for low-level analysis of CEL files using the `affy` package or when manual probe-to-gene mapping is required for this specific microarray platform.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mu6500subccdf")
library(mu6500subccdf)
```

## Core Functions and Usage

### Coordinate Conversion
The package provides two primary functions to convert between the 2D grid coordinates of the chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back to x and y coordinates.

**Dimensions:** The Mu6500sub chip has a grid of 260 x 260, resulting in 67,600 total indices.

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(x = 5, y = 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix/data frame with "x" and "y" columns
```

### CDF Environments
The package contains two main environment objects:

1.  `mu6500subccdf`: The main CDF environment mapping probe set identifiers to probe locations.
2.  `mu6500subcdim`: An environment containing the dimensions of the chip.

**Accessing Data:**
```r
# View chip dimensions
ls(mu6500subcdim)

# List probe sets in the CDF
probe_sets <- ls(mu6500subccdf)
head(probe_sets)

# Get probe information for a specific probe set
# Replace 'PROBESETID' with a valid ID from the chip
get("PROBESETID", envir = mu6500subccdf)
```

## Typical Workflow
When using this package with the `affy` package, it is often loaded automatically when an `AffyBatch` object is created from Mu6500sub CEL files. Use this skill manually when you need to:
1.  Perform custom quality control by mapping specific probe indices to their physical location on the array.
2.  Extract raw intensity values for specific probe sets without using high-level wrappers.
3.  Verify chip geometry (260x260).

## Reference documentation
- [mu6500subccdf Reference Manual](./references/reference_manual.md)
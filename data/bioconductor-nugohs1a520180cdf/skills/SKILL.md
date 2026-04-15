---
name: bioconductor-nugohs1a520180cdf
description: This package provides Chip Definition File (CDF) data and coordinate mapping functions for the Affymetrix nugohs1a520180 microarray platform. Use when user asks to map (x,y) coordinates to probe indices, access the CDF environment, or perform low-level analysis on NuGO High Sensitivity Human Genome 1A chip data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/nugohs1a520180cdf.html
---

# bioconductor-nugohs1a520180cdf

name: bioconductor-nugohs1a520180cdf
description: Provides specialized functions and environment data for the nugohs1a520180cdf Bioconductor annotation package. Use this skill when working with Affymetrix NuGO High Sensitivity Human Genome 1A (nugohs1a520180) chip data to map (x,y) coordinates to probe indices or to access the CDF environment.

# bioconductor-nugohs1a520180cdf

## Overview
The `nugohs1a520180cdf` package is a Chip Definition File (CDF) package for the Affymetrix nugohs1a520180 platform. It provides the mapping between the physical location of probes on the microarray chip and the probe set identifiers. This is essential for low-level analysis of .CEL files using packages like `affy`.

## Core Functions and Usage

### Loading the Package
To use the CDF environment and associated functions, load the library in R:
```r
library(nugohs1a520180cdf)
```

### Coordinate Conversion
The package provides utility functions to convert between 2D chip coordinates (x, y) and 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index to x and y coordinates.

**Dimensions:**
- X-coordinate range: 1 to 732
- Y-coordinate range: 1 to 732
- Total indices: 535,824

**Example:**
```r
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix/data frame with "x" and "y" columns
```

### Accessing CDF Data
The package contains two primary environments:
- `nugohs1a520180cdf`: The main environment containing the mapping of probe sets to probe locations.
- `nugohs1a520180dim`: An environment containing the dimensions of the chip.

To see the contents or probe sets:
```r
# List some probe sets in the environment
ls(nugohs1a520180cdf)[1:10]

# Get dimensions
ls(nugohs1a520180dim)
```

## Typical Workflow
This package is usually not called directly by the user but is loaded automatically by the `affy` package when reading data:

```r
library(affy)
# If you have .CEL files in the directory, ReadAffy() will 
# automatically look for this package if the chip type matches.
data <- ReadAffy() 

# To manually inspect the CDF associated with an AffyBatch object:
pData(data)
```

## Reference documentation
- [nugohs1a520180cdf Reference Manual](./references/reference_manual.md)
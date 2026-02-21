---
name: bioconductor-hthgu133acdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133acdf.html
---

# bioconductor-hthgu133acdf

name: bioconductor-hthgu133acdf
description: Provides specialized knowledge for the hthgu133acdf Bioconductor annotation package. Use this skill when working with Affymetrix HT Human Genome U133A array data in R, specifically for mapping probe (x,y) coordinates to CEL file indices and accessing CDF environment metadata.

# bioconductor-hthgu133acdf

## Overview

The `hthgu133acdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix HT_HG-U133A platform. It is primarily used to map the physical location of probes on the microarray chip to their corresponding indices in `AffyBatch` objects and vice versa.

## Key Functions and Usage

### Coordinate Conversion

The package provides two essential functions for translating between 2D chip coordinates and 1D indices:

- `xy2i(x, y)`: Converts (x,y) coordinates (ranging from 1 to 744) into a single-number index (ranging from 1 to 553,536).
- `i2xy(i)`: Converts a single-number index back into its corresponding (x,y) coordinates.

```r
library(hthgu133acdf)

# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix/data frame with "x" and "y" columns
```

### Accessing CDF Environments

The package loads two main environments into the R session:

1. `hthgu133acdf`: The main environment describing the CDF file structure, mapping probesets to probe locations.
2. `hthgu133adim`: An environment containing the dimensions of the HT_HG-U133A chip.

```r
# View dimension information
hthgu133adim

# List probesets in the CDF
ls(hthgu133acdf)[1:10]
```

## Typical Workflow

When analyzing HT_HG-U133A data using the `affy` package, this CDF package is often loaded automatically. However, manual use is common when performing custom quality control or spatial analysis of the chip:

1. **Load the package**: `library(hthgu133acdf)`
2. **Identify Outliers**: If a specific area of a CEL file shows artifacts, use `xy2i` to find the indices of the affected probes.
3. **Verify Mappings**: Use `i2xy` to ensure that indices extracted from an `AffyBatch` object correspond to the expected physical locations on the HT-U133A array.

## Reference documentation

- [hthgu133acdf Reference Manual](./references/reference_manual.md)
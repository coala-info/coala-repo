---
name: bioconductor-bsubtiliscdf
description: This package provides the Chip Description File environment and coordinate mapping for the Bacillus subtilis Affymetrix microarray. Use when user asks to map probe coordinates to indices, access CDF metadata for B. subtilis, or perform low-level analysis of AffyBatch objects.
homepage: https://bioconductor.org/packages/release/data/annotation/html/bsubtiliscdf.html
---


# bioconductor-bsubtiliscdf

name: bioconductor-bsubtiliscdf
description: Provides specialized environment data and coordinate mapping for the Bacillus subtilis Affymetrix chip. Use this skill when working with B. subtilis microarray data in R, specifically for mapping CEL file (x,y) coordinates to probe indices and accessing CDF (Chip Description File) environment metadata.

# bioconductor-bsubtiliscdf

## Overview

The `bsubtiliscdf` package is a Bioconductor annotation data package. It provides the CDF (Chip Description File) environment for the *Bacillus subtilis* genome array. This package is essential for low-level analysis of Affymetrix microarrays, allowing users to map physical coordinates on the chip to probe set identifiers and indices used in `AffyBatch` objects.

## Usage and Workflows

### Loading the Package
To use the environments provided by this package, load it into your R session:

```r
library(bsubtiliscdf)
```

### Accessing CDF Data
The package provides two primary environments:
- `bsubtiliscdf`: The main environment describing the CDF file structure.
- `bsubtilisdim`: An environment containing the dimensions of the chip.

### Coordinate Mapping (i2xy and xy2i)
A core utility of this package is converting between 2D chip coordinates (x, y) and 1D indices (i) used in R's `AffyBatch` and CDF environments.

**Dimensions:**
- X-coordinate range: 1 to 454
- Y-coordinate range: 1 to 454
- Index range: 1 to 206,116

**Convert (x, y) to Index:**
```r
# Get the index for a specific coordinate
idx <- xy2i(x = 5, y = 5)
```

**Convert Index to (x, y):**
```r
# Get the coordinates for a specific index
coords <- i2xy(idx)
# Access x and y
x_val <- coords[, "x"]
y_val <- coords[, "y"]
```

### Verification Example
You can verify the mapping consistency using the following pattern:
```r
i <- 1:(454*454)
coord <- i2xy(i)
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))
```

## Tips
- This package is typically used as a dependency by higher-level packages like `affy`. You rarely need to call these functions manually unless performing custom low-level probe analysis.
- The indices are 1-based, following standard R convention.

## Reference documentation
- [bsubtiliscdf Reference Manual](./references/reference_manual.md)
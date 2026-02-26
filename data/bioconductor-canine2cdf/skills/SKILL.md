---
name: bioconductor-canine2cdf
description: This package provides the Chip Definition File environment for the Affymetrix Canine Genome 2.0 Array. Use when user asks to map probe indices to physical coordinates, access CDF data for low-level microarray analysis, or process Affymetrix Canine 2.0 CEL files.
homepage: https://bioconductor.org/packages/release/data/annotation/html/canine2cdf.html
---


# bioconductor-canine2cdf

name: bioconductor-canine2cdf
description: Provides access to the Canine Genome 2.0 Array CDF (Chip Definition File) annotation data. Use when working with Affymetrix Canine 2.0 microarrays in R/Bioconductor to map probe indices to (x,y) coordinates or to access the CDF environment for low-level data processing and normalization.

# bioconductor-canine2cdf

## Overview

The `canine2cdf` package is an annotation artifact containing the Chip Definition File (CDF) environment for the Affymetrix Canine Genome 2.0 Array. This package is essential for low-level analysis of Affymetrix CEL files using packages like `affy`. It provides the mapping between probe set identifiers and their physical locations (x, y coordinates) on the microarray.

## Usage and Workflows

### Loading the Package
To use the annotation data, load the library in your R session:

```r
library(canine2cdf)
```

### Accessing CDF Data
The package provides two primary environments:
- `canine2cdf`: Contains the mapping of probe sets to probe indices.
- `canine2dim`: Contains the dimensions of the array (984 x 984).

To list the probe sets available in the CDF:
```r
# Get a few probe set names
head(ls(canine2cdf))
```

### Coordinate Conversion
The package includes utility functions to convert between the single-number indices used in `AffyBatch` objects and the physical (x, y) coordinates on the chip.

**Convert (x, y) to Index:**
```r
# Convert x=5, y=5 to a single index
idx <- xy2i(5, 5)
```

**Convert Index to (x, y):**
```r
# Convert an index back to coordinates
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

### Typical Integration with affy
This package is usually called automatically by the `affy` package when processing Canine 2.0 CEL files. However, you can manually inspect the mapping:

```r
# Get probe indices for a specific probe set
probeset_data <- get("131_at", envir = canine2cdf)
```

## Tips
- The array dimensions are 984 by 984, resulting in 968,256 total cells.
- Coordinates are 1-based in R (1 to 984).
- Use `i2xy` and `xy2i` when you need to perform spatial analysis or quality control on the chip surface.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
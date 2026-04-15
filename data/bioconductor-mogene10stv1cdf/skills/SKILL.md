---
name: bioconductor-mogene10stv1cdf
description: This package provides the CDF environment and probe mapping data for the Affymetrix Mouse Gene 1.0 ST array. Use when user asks to perform low-level analysis of Mouse Gene 1.0 ST .CEL files, map probe locations to probe sets, or convert between probe indices and coordinates.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene10stv1cdf.html
---

# bioconductor-mogene10stv1cdf

## Overview
The `mogene10stv1cdf` package is a Bioconductor annotation data package. It contains the CDF environment for the Affymetrix Mouse Gene 1.0 ST array. This package is essential for low-level analysis of .CEL files using packages like `affy`, as it defines the mapping between physical probe locations on the chip and their corresponding probe sets.

## Usage and Workflows

### Loading the Package
To use the CDF environment, load the library in your R session:
```r
library(mogene10stv1cdf)
```

### Accessing Chip Dimensions
The package provides an environment `mogene10stv1dim` which contains the dimensions of the array (1050 x 1050).
```r
# View dimension information
mogene10stv1dim
```

### Coordinate Conversion
The package provides utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

#### Convert (x,y) to Index
To get the single-number index for a specific probe location:
```r
# Example for probe at x=5, y=5
idx <- xy2i(5, 5)
```

#### Convert Index to (x,y)
To get the physical coordinates from a probe index:
```r
# Example for index 100
coords <- i2xy(100)
# Returns a matrix with "x" and "y" columns
```

### Integration with affy
This package is typically used automatically by the `affy` package when reading CEL files. If you have Mouse Gene 1.0 ST data, `affy` will look for this specific package to create the `AffyBatch` object.

```r
library(affy)
# If CEL files are in the working directory
data <- ReadAffy() 
# The cdfname will be automatically set to "mogene10stv1cdf"
```

## Tips
- The array size is 1,102,500 probes (1050 x 1050).
- Coordinates are 1-based in R (1 to 1050).
- Ensure this package is installed if you encounter errors like "reproducible error: 'mogene10stv1cdf' package not found" when running `ReadAffy()`.

## Reference documentation
- [mogene10stv1cdf Reference Manual](./references/reference_manual.md)
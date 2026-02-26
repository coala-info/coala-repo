---
name: bioconductor-hu35ksubbcdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix Hu35KsubB microarray platform. Use when user asks to map probe coordinates to indices, access CDF metadata, or process Affymetrix Human Genome U35K Subset B chip data in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubbcdf.html
---


# bioconductor-hu35ksubbcdf

name: bioconductor-hu35ksubbcdf
description: Provides specialized knowledge for the hu35ksubbcdf Bioconductor annotation package. Use this skill when working with Affymetrix Human Genome U35K Subset B chip data in R, specifically for mapping (x,y)-coordinates to CEL file indices and accessing CDF environment metadata.

# bioconductor-hu35ksubbcdf

## Overview
The `hu35ksubbcdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix Hu35KsubB platform. It is primarily used in transcriptomics workflows to map probe intensities from CEL files to their respective probe sets and physical locations on the microarray.

## Core Functions and Usage

### Coordinate Conversion
The package provides utility functions to convert between the 2D physical coordinates on the microarray chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinate range: 1 to 534
- Y-coordinate range: 1 to 534
- Index range: 1 to 285,156 (534 * 534)

### Accessing CDF Data
To use the CDF environment in an analysis (typically with the `affy` package):

```r
library(hu35ksubbcdf)

# View the CDF environment
hu35ksubbcdf

# View the dimensions of the chip
hu35ksubbdim
```

### Example Workflow
```r
library(hu35ksubbcdf)

# 1. Convert a specific coordinate to an index
idx <- xy2i(5, 5)

# 2. Convert that index back to coordinates
coords <- i2xy(idx)
# coords will be a matrix with columns "x" and "y"

# 3. Verify all indices in the range
i <- 1:(534*534)
coord_matrix <- i2xy(i)
j <- xy2i(coord_matrix[, "x"], coord_matrix[, "y"])
stopifnot(all(i == j))
```

## Tips
- This package is a data-only package. It is usually loaded automatically by high-level functions in the `affy` package when processing Hu35KsubB CEL files.
- The indices are 1-based, following standard R convention.
- Use `ls(hu35ksubbcdf)` to list the probe sets defined within the environment.

## Reference documentation
- [hu35ksubbcdf Reference Manual](./references/reference_manual.md)
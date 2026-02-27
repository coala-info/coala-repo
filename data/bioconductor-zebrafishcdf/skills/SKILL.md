---
name: bioconductor-zebrafishcdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix Zebrafish Genome Array. Use when user asks to map between (x,y)-coordinates and indices, access the zebrafish CDF environment, or retrieve chip dimensions for zebrafish genomic data analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/zebrafishcdf.html
---


# bioconductor-zebrafishcdf

name: bioconductor-zebrafishcdf
description: A specialized skill for working with the Bioconductor annotation package 'zebrafishcdf'. Use this skill when you need to map between (x,y)-coordinates and single-number indices for the Affymetrix Zebrafish Genome Array, or when you need to access the CDF environment and chip dimensions for zebrafish genomic data analysis in R.

# bioconductor-zebrafishcdf

## Overview
The `zebrafishcdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix Zebrafish Genome Array. It is primarily used in the analysis of microarray data to map probe intensities from CEL files to their corresponding probe sets.

## Installation and Loading
To use this package in an R session:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("zebrafishcdf")
library(zebrafishcdf)
```

## Core Functions and Usage

### Coordinate Mapping
The package provides utility functions to convert between the 2D (x,y) coordinates on the microarray chip and the 1D indices used in `AffyBatch` objects.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Dimensions:**
- X-coordinates range: 1 to 712
- Y-coordinates range: 1 to 712
- Total indices: 1 to 506,944

**Example Workflow:**
```R
# Convert specific coordinates to an index
idx <- xy2i(5, 5)

# Convert a range of indices to coordinates
indices <- 1:10
coords <- i2xy(indices)

# Verify the mapping
back_to_indices <- xy2i(coords[, "x"], coords[, "y"])
stopifnot(all(indices == back_to_indices))
```

### CDF Environments
The package contains two primary environments used by other Bioconductor tools (like `affy`):

1.  `zebrafishcdf`: The main environment describing the CDF file structure.
2.  `zebrafishdim`: An environment containing the dimensions of the zebrafish chip.

To view the contents or dimensions:
```R
# View the dimension environment
zebrafishdim

# List objects in the CDF environment
ls(zebrafishcdf)[1:10]
```

## Typical Workflow
This package is rarely used standalone. It is typically called automatically by the `affy` package when loading zebrafish CEL files:

```R
library(affy)
# If zebrafish CEL files are in the working directory
data <- ReadAffy() 
# The 'affy' package will look for 'zebrafishcdf' to interpret the data
```

## Reference documentation
- [zebrafishcdf Reference Manual](./references/reference_manual.md)
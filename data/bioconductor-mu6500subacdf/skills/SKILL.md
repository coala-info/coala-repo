---
name: bioconductor-mu6500subacdf
description: This package provides the Chip Definition File environment and coordinate mapping functions for the Affymetrix Mu6500sub platform. Use when user asks to map probe coordinates to indices, access CDF environments, or determine chip dimensions for Mu6500sub data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu6500subacdf.html
---

# bioconductor-mu6500subacdf

name: bioconductor-mu6500subacdf
description: Provides specialized knowledge for the mu6500subacdf Bioconductor annotation package. Use this skill when working with Affymetrix Mu6500sub chip data in R, specifically for mapping probe (x,y) coordinates to indices, accessing CDF environments, or determining chip dimensions.

## Overview

The `mu6500subacdf` package is an annotation resource containing the Chip Definition File (CDF) environment for the Affymetrix Mu6500sub platform. It is primarily used in transcriptomics workflows to map raw probe intensities from CEL files to their corresponding probe sets.

## Core Functions and Usage

### Coordinate Conversion

The package provides utility functions to convert between 2D chip coordinates and 1D indices used in `AffyBatch` objects. The Mu6500sub chip has a dimension of 260x260 (67,600 total indices).

```r
library(mu6500subacdf)

# Convert x,y coordinates to a single index
# x and y range from 1 to 260
index <- xy2i(x = 5, y = 5)

# Convert a single index back to x,y coordinates
coords <- i2xy(index)
# Returns a matrix with columns "x" and "y"
```

### Accessing CDF Data

The package exposes environment objects that are automatically called by higher-level packages like `affy`.

```r
# View the CDF environment
mu6500subacdf

# View the dimension environment
mu6500subadim
```

## Typical Workflow

When analyzing Mu6500sub data, you typically do not call these functions manually. Instead, the `affy` package uses this library internally when you load CEL files.

```r
library(affy)
library(mu6500subacdf)

# When reading CEL files, 'affy' looks for this package
# data <- ReadAffy() 

# To manually verify dimensions
# Get number of probes
total_probes <- 260 * 260
```

## Tips and Constraints

- **Coordinate Range**: The x and y coordinates are 1-based and range from 1 to 260.
- **Index Range**: The single-number index ranges from 1 to 67,600.
- **Dependency**: This package is a data-only annotation package. It requires the `affy` or `makecdfenv` packages for most practical bioinformatics applications.

## Reference documentation

- [mu6500subacdf Reference Manual](./references/reference_manual.md)
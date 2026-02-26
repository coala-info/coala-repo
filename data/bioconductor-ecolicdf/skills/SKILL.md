---
name: bioconductor-ecolicdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix E. coli antisense genome array. Use when user asks to map between chip coordinates and CEL file indices, process E. coli GeneChip data in R, or provide the CDF environment for AffyBatch objects.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ecolicdf.html
---


# bioconductor-ecolicdf

name: bioconductor-ecolicdf
description: Provides the interface and coordinate mapping for the E. coli antisense genome array (Affymetrix). Use this skill when working with E. coli GeneChip data in R, specifically for mapping between (x,y) chip coordinates and CEL file indices, or when requiring the CDF environment for AffyBatch objects.

# bioconductor-ecolicdf

## Overview
The `ecolicdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the E. coli antisense genome array. It is primarily used by other Bioconductor packages like `affy` to correctly interpret and process raw CEL file data from E. coli experiments. It provides the mapping between physical (x,y) coordinates on the microarray and the single-number indices used in R data structures.

## Installation and Loading
To use this package, it must be installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ecolicdf")

# Load the package
library(ecolicdf)
```

## Core Components
The package provides three main objects/functions:

1.  **ecolicdf**: An environment containing the mapping of probes to probe sets.
2.  **ecolidim**: An environment describing the dimensions of the E. coli chip (544 x 544).
3.  **Coordinate Mapping Functions**: `i2xy` and `xy2i` for converting between spatial coordinates and linear indices.

## Coordinate Mapping
The chip uses a 544 x 544 grid (total 295,936 indices).

### Convert (x,y) to Index
To find the linear index used in an `AffyBatch` object from a specific row and column:
```r
# Get index for x=5, y=5
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
To find where a specific data point is physically located on the chip:
```r
# Get coordinates for index 500
coords <- i2xy(500)
# Returns a matrix with columns "x" and "y"
```

## Typical Workflow
This package is usually not called directly by the user but is loaded automatically when an `AffyBatch` object containing E. coli data is processed.

```r
library(affy)
# If you have E. coli CEL files in the directory:
# data <- ReadAffy() 
# The 'data' object will automatically look for 'ecolicdf' to define its structure.

# To manually inspect dimensions:
ls(ecolidim)
# To see the probe set mappings:
ls(ecolicdf)[1:10]
```

## Usage Tips
- **Index Range**: Indices range from 1 to 295,936.
- **Coordinate Range**: Both x and y coordinates range from 1 to 544.
- **Integration**: Ensure this package is installed if you encounter errors like "relying on 'ecolicdf' package" when using `ReadAffy()` or `rma()`.

## Reference documentation
- [ecolicdf Reference Manual](./references/reference_manual.md)
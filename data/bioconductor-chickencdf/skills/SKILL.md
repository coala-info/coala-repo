---
name: bioconductor-chickencdf
description: This package provides the Chip Definition File environment for the Affymetrix Chicken Genome Array to map probe identifiers to genomic locations. Use when user asks to map probe sets to array indices, convert between chip coordinates and index sequences, or retrieve dimensions for chicken expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/chickencdf.html
---

# bioconductor-chickencdf

name: bioconductor-chickencdf
description: A specialized skill for working with the 'chickencdf' Bioconductor annotation package. Use this skill when you need to map probe identifiers to locations on the Affymetrix Chicken Genome Array, convert between (x,y) coordinates and index sequences, or retrieve chip dimensions for chicken expression data.

# bioconductor-chickencdf

## Overview
The `chickencdf` package is a Bioconductor annotation interface providing the Chip Definition File (CDF) environment for the Affymetrix Chicken Genome Array. It is primarily used in transcriptomics workflows to map raw intensity data (CEL files) to specific probe sets and genomic locations.

## Installation and Loading
To use this package in R, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("chickencdf")
library(chickencdf)
```

## Core Components
The package provides three primary objects/functions:

1.  **chickencdf**: An environment object containing the mapping between probe set IDs and the indices of the probes on the array.
2.  **chickendim**: An environment describing the physical dimensions of the chip (984 x 984).
3.  **i2xy / xy2i**: Utility functions to convert between 2D chip coordinates and 1D indices.

## Usage Examples

### Accessing Chip Dimensions
To check the grid size of the Chicken array:
```r
library(chickencdf)
ls(chickendim)
# Typically returns dimensions like 984x984
```

### Coordinate Conversion
AffyBatch objects often use single-number indices. You can convert these to (x,y) coordinates for spatial quality control:

```r
# Convert index to (x,y)
coords <- i2xy(500)
print(coords)

# Convert (x,y) back to index
idx <- xy2i(x = 5, y = 5)
print(idx)
```

### Mapping Probes
To see how many probes are associated with a specific probe set or to inspect the environment structure:
```r
# List a few probe sets
head(ls(chickencdf))

# Get probe indices for a specific probe set
probes <- get("Gga.1.1.S1_at", chickencdf)
```

## Workflow Tips
- **Integration with affy**: This package is rarely used standalone; it is automatically called by the `affy` package when loading CEL files from the Chicken Genome Array using `read.affybatch()`.
- **Index Range**: The indices range from 1 to 968,256 (984 * 984).
- **Coordinate Range**: Both x and y coordinates range from 1 to 984.

## Reference documentation
- [chickencdf Reference Manual](./references/reference_manual.md)
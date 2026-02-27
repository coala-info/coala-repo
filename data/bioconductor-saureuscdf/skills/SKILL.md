---
name: bioconductor-saureuscdf
description: This package provides the Chip Definition File environment for mapping Staphylococcus aureus GeneChip probe intensities to probe sets in R. Use when user asks to analyze Staphylococcus aureus GeneChip data, map between chip coordinates and indices, or access the CDF environment.
homepage: https://bioconductor.org/packages/release/data/annotation/html/saureuscdf.html
---


# bioconductor-saureuscdf

name: bioconductor-saureuscdf
description: A specialized skill for working with the Bioconductor annotation package 'saureuscdf'. Use this skill when analyzing Affymetrix S. aureus (Staphylococcus aureus) GeneChip data in R, specifically for mapping between (x,y) chip coordinates and single-number indices, or when accessing the CDF environment and chip dimensions.

# bioconductor-saureuscdf

## Overview
The `saureuscdf` package is a Bioconductor annotation interface for the Staphylococcus aureus GeneChip. It provides the environment mapping for the Chip Definition File (CDF), allowing R users to link probe intensities in CEL files to their respective probe sets. It is primarily used internally by the `affy` package but can be accessed directly for coordinate transformations.

## Loading the Package
To use the environment and functions, load the library in R:
```R
library(saureuscdf)
```

## Core Environments
The package provides two main environments:
- `saureuscdf`: Contains the mapping of probe set IDs to the location of probes on the array.
- `saureusdim`: Contains the physical dimensions of the S. aureus array (602 x 602 pixels).

## Coordinate Transformations
The package includes utility functions to convert between the 2D (x,y) coordinates used in CEL files and the 1D indices used in `AffyBatch` objects.

### Convert (x,y) to Index
To get the 1D index from a specific chip location:
```R
# Example: Get index for x=5, y=5
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
To get the 2D coordinates from a 1D index:
```R
# Example: Get coordinates for index 500
coords <- i2xy(500)
# Returns a matrix with columns "x" and "y"
```

## Typical Workflow
When working with `AffyBatch` objects for S. aureus, the `affy` package typically handles this package automatically. However, for manual probe-level analysis:

1. **Identify Dimensions**: Check `saureusdim` to understand the grid size.
2. **Map Probes**: Use `saureuscdf` to find which indices belong to a specific GeneID or ProbeSet.
3. **Extract Intensities**: Use the indices to subset intensity data from the `AffyBatch` or `ExpressionSet`.

## Reference documentation
- [saureuscdf Reference Manual](./references/reference_manual.md)
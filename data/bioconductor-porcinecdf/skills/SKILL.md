---
name: bioconductor-porcinecdf
description: This package provides the Chip Description File environment and coordinate mapping for the Affymetrix Porcine Genome Array. Use when user asks to map probe coordinates to indices, access porcine CDF environments, or process Affymetrix Porcine microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/porcinecdf.html
---


# bioconductor-porcinecdf

name: bioconductor-porcinecdf
description: A specialized skill for working with the Bioconductor annotation package 'porcinecdf'. Use this skill when you need to map probe coordinates to indices for the Affymetrix Porcine Genome Array, or when working with CDF environments and AffyBatch objects involving porcine genomic data.

# bioconductor-porcinecdf

## Overview
The `porcinecdf` package is a Bioconductor annotation interface for the Affymetrix Porcine Genome Array. Its primary purpose is to provide the Chip Description File (CDF) environment, which maps individual probes on the microarray to their respective probe sets. This is essential for low-level analysis of CEL files, such as background correction and normalization using the `affy` package.

## Core Functions and Usage

### Loading the Package
To use the CDF environment, the package must be loaded in the R session:
```r
library(porcinecdf)
```

### Coordinate Conversion
The package provides utility functions to convert between 2D chip coordinates (x, y) and 1-dimensional indices (i) used in `AffyBatch` objects. The chip dimensions for this array are 732 x 732.

- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

**Example:**
```r
# Convert specific coordinates to an index
index <- xy2i(5, 5)

# Convert an index back to coordinates
coords <- i2xy(index)
# Returns a matrix with "x" and "y" columns
```

### Accessing CDF Environments
The package contains two main environments:
- `porcinecdf`: The main environment describing the CDF structure (mapping probes to probe sets).
- `porcinedim`: An environment describing the dimensions of the array.

These are typically accessed automatically by functions in the `affy` package when processing Porcine CEL files, but can be inspected manually:
```r
# List probe sets in the environment
ls(porcinecdf)[1:10]

# Get dimensions
ls(porcinedim)
```

## Typical Workflow
1. **Data Loading**: Load raw CEL files using `affy::ReadAffy()`. The `affy` package will automatically look for `porcinecdf` if the CEL file header identifies the Porcine array.
2. **Coordinate Mapping**: Use `i2xy` or `xy2i` if you need to identify the physical location of a specific outlier probe identified during quality control.
3. **Expression Analysis**: The CDF environment is used internally by functions like `rma()` or `gcrma()` to aggregate probe-level intensities into probe-set expression values.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
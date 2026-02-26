---
name: bioconductor-bovinecdf
description: This package provides the Chip Definition File environment for the Affymetrix Bovine Genome Array to map probe identifiers to chip coordinates. Use when user asks to map probe sets to indices, convert between (x,y) coordinates and index values, or retrieve chip dimensions for bovine genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/bovinecdf.html
---


# bioconductor-bovinecdf

name: bioconductor-bovinecdf
description: A specialized skill for working with the Bioconductor annotation package 'bovinecdf'. Use this skill when you need to map Affymetrix Bovine Genome Array probe identifiers to their physical coordinates on the chip, convert between (x,y) coordinates and index values, or retrieve CDF environment dimensions for bovine genomic data analysis.

## Overview

The `bovinecdf` package is a Bioconductor annotation data package that provides the Chip Definition File (CDF) environment for the Affymetrix Bovine Genome Array. It is primarily used in transcriptomics workflows to map probe intensities from CEL files to their respective probe sets.

## Installation and Loading

To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("bovinecdf")
library(bovinecdf)
```

## Core Functions and Usage

### 1. Accessing CDF Environments
The package provides two main environments:
- `bovinecdf`: The main environment containing the mapping of probe sets to probe indices.
- `bovinedim`: Contains the dimensions of the chip (732 x 732).

```r
# View the dimensions
bovinedim
```

### 2. Coordinate Conversion (i2xy and xy2i)
Affymetrix data often requires converting between 2D chip coordinates (x, y) and 1D indices (i) used in `AffyBatch` objects.

**Convert (x,y) to Index:**
```r
# Get the index for a probe at x=5, y=5
idx <- xy2i(5, 5)
```

**Convert Index to (x,y):**
```r
# Get coordinates for a specific index
coords <- i2xy(idx)
# Returns a matrix with columns "x" and "y"
```

### 3. Typical Workflow Example
Validating coordinate consistency across the chip:

```r
# Create a vector of all possible indices
i <- 1:(732 * 732)

# Convert to coordinates
coord <- i2xy(i)

# Convert back to indices
j <- xy2i(coord[, "x"], coord[, "y"])

# Verify identity
stopifnot(all(i == j))

# Check coordinate ranges
range(coord[, "x"]) # Should be 1 to 732
range(coord[, "y"]) # Should be 1 to 732
```

## Tips for AI Agents
- The chip size is fixed at 732x732. Any coordinate outside 1-732 or index outside 1-535824 is invalid.
- This package is a "data" package; it does not perform normalization or differential expression itself but provides the necessary metadata for packages like `affy`.
- When working with `AffyBatch` objects, the `cdfName` slot should be set to "bovine" to automatically utilize this package.

## Reference documentation
- [bovinecdf Reference Manual](./references/reference_manual.md)
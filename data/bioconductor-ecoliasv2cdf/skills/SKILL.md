---
name: bioconductor-ecoliasv2cdf
description: This package provides the Chip Description File environment and coordinate mapping for the Affymetrix E. coli Antisense Genome Array v2. Use when user asks to process E. coli v2 CEL files, map probe coordinates to indices, or access CDF metadata for the ecoliasv2 chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ecoliasv2cdf.html
---

# bioconductor-ecoliasv2cdf

name: bioconductor-ecoliasv2cdf
description: Provides specialized environment data and coordinate mapping for the E. coli Antisense Genome Array v2 (ecoliasv2). Use this skill when working with Affymetrix GeneChip data for E. coli in R, specifically for mapping CEL file (x,y) coordinates to probe indices and accessing CDF (Chip Description File) environment metadata.

# bioconductor-ecoliasv2cdf

## Overview
The `ecoliasv2cdf` package is a Bioconductor annotation package that provides the Chip Description File (CDF) environment for the Affymetrix E. coli Antisense Genome Array v2. It is primarily used by other Bioconductor packages like `affy` to process raw expression data (CEL files). It includes mapping functions to convert between spatial coordinates on the chip and the single-number indices used in R's `AffyBatch` objects.

## Installation and Loading
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ecoliasv2cdf")
library(ecoliasv2cdf)
```

## Core Environments
The package provides two main environments containing chip metadata:

- `ecoliasv2cdf`: The main environment describing the CDF file structure (mapping probes to probesets).
- `ecoliasv2dim`: Contains the dimensions of the chip (544 x 544 pixels/probes).

## Coordinate Mapping (i2xy)
A critical feature of this package is the ability to convert between (x,y) coordinates on the physical chip and the linear indices used in R data structures.

### Functions
- `xy2i(x, y)`: Converts x and y coordinates to a single-number index.
- `i2xy(i)`: Converts a single-number index back into x and y coordinates.

### Usage Example
```r
# Load the library
library(ecoliasv2cdf)

# 1. Convert specific coordinates to an index
idx <- xy2i(5, 5)
print(idx)

# 2. Convert an index back to coordinates
coords <- i2xy(idx)
print(coords) # Returns a matrix with "x" and "y" columns

# 3. Verify chip ranges
# The E. coli v2 chip is 544 x 544
all_indices <- 1:(544 * 544)
all_coords <- i2xy(all_indices)
range(all_coords[, "x"]) # 1 to 544
range(all_coords[, "y"]) # 1 to 544
```

## Typical Workflow
This package is rarely used standalone. It is typically triggered automatically when you load E. coli v2 CEL files using the `affy` package:

```r
library(affy)
# If you have CEL files in the directory, ReadAffy() will 
# automatically look for ecoliasv2cdf to organize the data.
data <- ReadAffy() 

# You can manually inspect the CDF environment if needed:
ls(ecoliasv2cdf)[1:10] # List first 10 probesets
```

## Reference documentation
- [ecoliasv2cdf Reference Manual](./references/reference_manual.md)
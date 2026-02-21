---
name: bioconductor-htmg430bcdf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htmg430bcdf.html
---

# bioconductor-htmg430bcdf

name: bioconductor-htmg430bcdf
description: Provides specialized knowledge for the Bioconductor R package 'htmg430bcdf'. Use this skill when working with Affymetrix HT Mouse Genome 430B CDF annotation data, specifically for converting between (x,y) chip coordinates and single-number indices, or when accessing CDF environment dimensions for the HT_MG-430B platform.

# bioconductor-htmg430bcdf

## Overview
The `htmg430bcdf` package is a Bioconductor annotation package containing the Chip Definition File (CDF) environment for the Affymetrix HT Mouse Genome 430B array. It is primarily used in transcriptomics workflows to map probe intensities from CEL files to their respective probe sets. It provides coordinate transformation functions and environment metadata necessary for low-level data processing in `AffyBatch` objects.

## Installation and Loading
To use this package in R, it must be installed via `BiocManager`:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("htmg430bcdf")
library(htmg430bcdf)
```

## Coordinate Transformations
The package provides two essential functions for mapping probe locations on the HT_MG-430B chip. The chip dimensions are 744 x 744, with indices ranging from 1 to 553,536.

### Convert (x,y) to Index
Use `xy2i` to convert 2D chip coordinates into the single-number index used by `affy` methods.
```R
# Convert x=5, y=5 to a single index
idx <- xy2i(5, 5)
```

### Convert Index to (x,y)
Use `i2xy` to retrieve the original 2D coordinates from a single-number index.
```R
# Convert index back to coordinates
coords <- i2xy(idx)
# Access x and y
x_val <- coords[, "x"]
y_val <- coords[, "y"]
```

## Accessing CDF Data
The package exposes environment objects that describe the chip layout:

- `htmg430bcdf`: The main environment containing the mapping of probe sets to probe indices.
- `htmg430bdim`: An environment or variable describing the dimensions of the HT_MG-430B chip (typically 744x744).

To see the contents of the CDF environment:
```R
ls(htmg430bcdf)[1:10] # List the first 10 probe set IDs
```

## Typical Workflow Example
When validating coordinate integrity or performing custom probe-level analysis:

```R
# 1. Define a range of indices
i <- 1:1000

# 2. Get coordinates
coord <- i2xy(i)

# 3. Verify consistency by converting back
j <- xy2i(coord[, "x"], coord[, "y"])
stopifnot(all(i == j))

# 4. Check coordinate boundaries
range(coord[, "x"]) # Should be within 1:744
range(coord[, "y"]) # Should be within 1:744
```

## Reference documentation
- [htmg430bcdf Reference Manual](./references/reference_manual.md)
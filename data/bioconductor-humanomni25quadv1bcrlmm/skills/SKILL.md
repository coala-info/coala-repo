---
name: bioconductor-humanomni25quadv1bcrlmm
description: This package provides metadata and calibration data for performing genotype calling and copy number analysis on Illumina Omni2.5 Quad arrays using the crlmm algorithm. Use when user asks to perform genotyping, conduct copy number analysis, or process raw intensity data from Illumina Omni2.5 Quad platforms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/humanomni25quadv1bCrlmm.html
---


# bioconductor-humanomni25quadv1bcrlmm

name: bioconductor-humanomni25quadv1bcrlmm
description: Support for the humanomni25quadv1bCrlmm Bioconductor package. Use when performing genotype calling or copy number analysis using the 'crlmm' package for Illumina Omni2.5 Quad arrays.

# bioconductor-humanomni25quadv1bcrlmm

## Overview

The `humanomni25quadv1bCrlmm` package is a specialized Bioconductor data package designed for use with the `crlmm` (Corrected Robust Linear Model with Mixture) algorithm. It provides the necessary metadata, probe information, and calibration data specifically for the **Illumina Omni2.5 Quad** array platform.

This package is typically not called directly by the user for data manipulation but is required as a dependency by the `crlmm` package to process raw intensity data from this specific array type.

## Installation

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("humanomni25quadv1bCrlmm")
```

## Usage in R

### Loading the Package

While `crlmm` often loads the required annotation packages automatically, you can load it manually to verify its presence:

```r
library(humanomni25quadv1bCrlmm)
```

### Integration with crlmm

The primary use case is providing the infrastructure for genotyping. When using functions in the `crlmm` package, you specify the platform, and `crlmm` looks for this annotation package.

```r
library(crlmm)

# Example workflow:
# 1. Identify paths to your IDAT files or intensity data
# 2. The crlmm functions will utilize humanomni25quadv1bCrlmm internally
# when the array type is identified as Illumina Omni2.5 Quad.

# To see the contents/environment provided by the package:
ls("package:humanomni25quadv1bCrlmm")
```

## Typical Workflow

1.  **Data Preparation**: Obtain raw intensity files (e.g., .idat) from Illumina Omni2.5 Quad arrays.
2.  **Environment Setup**: Ensure both `crlmm` and `humanomni25quadv1bCrlmm` are installed.
3.  **Genotyping**: Use the `crlmmIllumina` or `genotype` functions from the `crlmm` package. The `crlmm` package will automatically detect and use the data within `humanomni25quadv1bCrlmm` to perform background correction, normalization, and genotype calling.

## Tips

- **Internal Use**: If you encounter errors in `crlmm` regarding "missing annotation packages" while working with Omni2.5 Quad data, ensure this package is installed.
- **Version Matching**: Ensure that the version of this package matches the Bioconductor release you are using for your main analysis.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
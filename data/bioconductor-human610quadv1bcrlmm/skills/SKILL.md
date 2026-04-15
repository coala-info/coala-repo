---
name: bioconductor-human610quadv1bcrlmm
description: This package provides metadata and annotation support for performing genotype calling and copy number analysis on Illumina 610k Quad (v1b) arrays using the crlmm algorithm. Use when user asks to perform genotype calling, estimate copy number, or process Illumina 610k Quad platform data with the crlmm package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/human610quadv1bCrlmm.html
---

# bioconductor-human610quadv1bcrlmm

name: bioconductor-human610quadv1bcrlmm
description: Metadata and annotation support for Illumina 610k Quad arrays. Use this skill when performing genotype calling or copy number analysis with the 'crlmm' package on Illumina 610k Quad (v1b) platform data.

# bioconductor-human610quadv1bcrlmm

## Overview

The `human610quadv1bCrlmm` package is a specialized Bioconductor data package. It provides the necessary metadata, probe sequences, and calibration parameters required by the `crlmm` (Corrected Robust Linear Model with Maximum likelihood) package to perform genotype calling and copy number estimation specifically for Illumina 610k Quad (v1b) arrays.

This package is designed to be used internally by the `crlmm` workflow and is rarely accessed directly by the user, though it must be installed and available in the R library for the analysis of this specific array type.

## Usage

### Installation

To use this data package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("human610quadv1bCrlmm")
```

### Integration with CRLMM

The primary use case is providing the infrastructure for the `crlmm` package to process Illumina IDAT files or preprocessed intensities.

1.  **Loading the package**:
    While `crlmm` often loads the required annotation package automatically, you can load it explicitly:
    ```r
    library(human610quadv1bCrlmm)
    ```

2.  **Genotype Calling**:
    When running the `crlmm` pipeline on Illumina 610k Quad data, the algorithm will look for this package to retrieve SNP-specific information.

    ```r
    library(crlmm)
    # Assuming 'samples' is a character vector of paths to IDAT files
    # The package is utilized when the array type is identified as 610k Quad
    # result <- crlmmIllumina(samples)
    ```

### Package Contents

The package contains internal data objects that `crlmm` uses for:
- Mapping probes to physical locations.
- Identifying SNP alleles (A/B).
- Applying platform-specific normalization constants.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
---
name: bioconductor-human370v1ccrlmm
description: This package provides annotation data and metadata for the Illumina 370k array to support the CRLMM algorithm. Use when user asks to perform genotype calling, estimate copy numbers, or preprocess Illumina human370v1 chip data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/human370v1cCrlmm.html
---


# bioconductor-human370v1ccrlmm

name: bioconductor-human370v1ccrlmm
description: Provides data and annotation support for the Illumina 370k array to be used with the crlmm package. Use this skill when performing genotype calling, copy number estimation, or preprocessing of Illumina human370v1 chip data using the CRLMM (Corrected Robust Linear Model with Multiple-distance Priors) algorithm.

# bioconductor-human370v1ccrlmm

## Overview
The `human370v1cCrlmm` package is a specialized annotation data package for Bioconductor. It contains the specific metadata, probe sequences, and calibration parameters required by the `crlmm` package to process Illumina 370k (human370v1) arrays. It is not intended for standalone analysis but acts as a critical dependency for the `crlmm` workflow.

## Usage and Workflow

### Loading the Package
The package is typically loaded automatically by `crlmm` functions when the array type is detected, but it can be initialized manually:

```r
library(human370v1cCrlmm)
```

### Integration with crlmm
The primary use case is providing the underlying data for genotype calling. When using the `crlmm` function, ensure this package is installed so the algorithm can access the 370k-specific constants.

```r
library(crlmm)

# Example workflow:
# 1. List IDAT files
# 2. Call genotypes (crlmm will look for human370v1cCrlmm if the platform matches)
# res <- crlmm(filenames, pkgname="human370v1cCrlmm")
```

### Accessing Internal Data
While most users interact with this via `crlmm`, you can inspect the package content if necessary to verify versioning or platform compatibility:

```r
# Check package metadata
packageDescription("human370v1cCrlmm")
```

## Tips
- **Automatic Detection**: If your `CEL` or `IDAT` files are from the Illumina 370k platform, `crlmm` usually identifies the need for this package automatically.
- **Installation**: Ensure this package is installed alongside `crlmm`. Because it is a data package, it may be large.
- **Platform Specificity**: This package is strictly for the "v1" version of the Illumina 370k array. Using it with other versions or different Illumina chips will result in incorrect normalization and genotype calls.

## Reference documentation
- [human370v1cCrlmm Reference Manual](./references/reference_manual.md)
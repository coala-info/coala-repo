---
name: bioconductor-human650v3acrlmm
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/human650v3aCrlmm.html
---

# bioconductor-human650v3acrlmm

name: bioconductor-human650v3acrlmm
description: Use this skill when performing genotype calling or copy number analysis on Illumina 650k (v3a) arrays using the crlmm package. This package provides the required annotation data and platform-specific constants for the CRLMM algorithm.

# bioconductor-human650v3acrlmm

## Overview

The `human650v3aCrlmm` package is a specialized Bioconductor data package. It contains the metadata and annotation information required by the `crlmm` package to process Illumina 650k (version 3a) SNP arrays. It is not intended for standalone use but serves as a critical dependency for the Corrected Robust Linear Model with Multiple-outliers (CRLMM) workflow.

## Usage and Workflow

### Internal Integration with crlmm
The primary use case for this package is providing the underlying data structure for the `crlmm` or `genotype` functions. When processing Illumina 650k raw data (IDAT files or green/red channel intensities), the `crlmm` package will look for this specific annotation package.

### Loading the Package
While usually loaded automatically by `crlmm`, you can load it explicitly to verify its presence:

```r
library(human650v3aCrlmm)
```

### Typical Workflow
1.  **Data Preparation**: Obtain raw intensity data from Illumina 650k arrays.
2.  **Genotyping**: Use the `crlmm` package functions. The algorithm will automatically detect or require the specification of the `human650v3aCrlmm` package to map probes and apply platform-specific corrections.

```r
library(crlmm)
# Example of specifying the package name in a crlmm workflow
# result <- crlmmIllumina(filenames, pkgname="human650v3aCrlmm")
```

## Tips
- **Platform Specificity**: Ensure the array version matches exactly. This package is specifically for the **650k v3a** variant. Using it with other 650k versions or different Illumina densities will result in incorrect mappings.
- **Memory Management**: As a data package, it loads large objects into memory. Ensure the R session has sufficient RAM when performing genotyping on large cohorts.
- **Dependency**: If you encounter errors in `crlmm` regarding missing annotation data for Illumina 650k, ensure this package is installed via `BiocManager::install("human650v3aCrlmm")`.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
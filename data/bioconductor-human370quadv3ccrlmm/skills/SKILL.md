---
name: bioconductor-human370quadv3ccrlmm
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/human370quadv3cCrlmm.html
---

# bioconductor-human370quadv3ccrlmm

name: bioconductor-human370quadv3ccrlmm
description: Data and annotation support for Illumina 370kQuad arrays. Use this skill when performing genotype calling, copy number estimation, or preprocessing of Illumina Human370-Quad BeadChip data using the crlmm package.

# bioconductor-human370quadv3ccrlmm

## Overview

The `human370quadv3cCrlmm` package is a specialized Bioconductor data package. It provides the necessary metadata, probe sequences, and calibration data required by the `crlmm` (Corrected Robust Linear Model with Maximum likelihood distance) algorithm to process Illumina 370kQuad arrays. 

This package is typically not used for direct data analysis by the user but serves as a critical internal dependency for the `crlmm` package when handling this specific array platform.

## Installation and Loading

To use this package within an R session, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("human370quadv3cCrlmm")
library(human370quadv3cCrlmm)
```

## Typical Workflow

The primary use case for this package is providing the underlying annotation for the `crlmm` genotyping pipeline.

### 1. Automated Integration
When using the `crlmm` package to process IDAT files or SNP summary files from an Illumina 370kQuad array, the `crlmm` functions will automatically search for and load this package if the platform is correctly identified.

### 2. Manual Specification
If you are working with a `crlmm` workflow and need to ensure the correct annotation is used, you can verify the package is available:

```r
# Check if the package is loaded
if("package:human370quadv3cCrlmm" %in% search()) {
    message("Annotation package for Illumina 370kQuad is ready.")
}
```

### 3. Usage in crlmm
When calling `crlmm` functions (like `crlmmIllumina` or `genotype`), the algorithm uses the data stored in this package to map probes to physical locations and perform normalization.

```r
# Example of where this package fits in the crlmm workflow
# library(crlmm)
# samples <- readIDAT(sampleSheet)
# result <- crlmm(samples, pkgname="human370quadv3cCrlmm")
```

## Tips
- **Internal Data**: This package contains SQLite databases or environments that store probe-level information. You can explore the package contents using `ls("package:human370quadv3cCrlmm")`, though direct manipulation is rarely required.
- **Version Matching**: Ensure that the version of `human370quadv3cCrlmm` matches the version of the `crlmm` package you are using to avoid compatibility issues during genotype calling.

## Reference documentation

- [human370quadv3cCrlmm Reference Manual](./references/reference_manual.md)
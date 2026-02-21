---
name: bioconductor-genomewidesnp6crlmm
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/genomewidesnp6Crlmm.html
---

# bioconductor-genomewidesnp6crlmm

name: bioconductor-genomewidesnp6crlmm
description: Provides annotation data for Affymetrix Genome-Wide Human SNP Array 6.0. Use this skill when performing genotyping, copy number estimation, or processing .CEL files from Affymetrix SNP 6.0 platforms using the crlmm package.

# bioconductor-genomewidesnp6crlmm

## Overview

The `genomewidesnp6Crlmm` package is a specialized Bioconductor annotation data package. It contains the metadata, probe information, and pre-calculated parameters required by the `crlmm` (Corrected Robust Linear Model with Maximum likelihood) algorithm to process Affymetrix Genome-Wide Human SNP Array 6.0 data.

This package is designed for internal use by the `crlmm` package. Users do not typically call functions directly from `genomewidesnp6Crlmm`; instead, its presence is required in the R library for `crlmm` to successfully genotype and analyze SNP 6.0 arrays.

## Usage in R

### Installation and Loading

The package must be installed via `BiocManager` to ensure all dependencies are met.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("genomewidesnp6Crlmm")
```

While you can load the package using `library(genomewidesnp6Crlmm)`, it is usually loaded automatically when you call `crlmm` functions on SNP 6.0 data.

### Typical Workflow

The primary role of this package is to support the `crlmm` workflow. When you have a set of CEL files from a SNP 6.0 array, the workflow looks like this:

1.  **Identify CEL files**: Collect the paths to your Affymetrix SNP 6.0 .CEL files.
2.  **Run Genotyping**: Use the `crlmm` function. The algorithm will detect the array type and look for the `genomewidesnp6Crlmm` data package.

```r
library(crlmm)

# Path to CEL files
celFiles <- list.files(path = "path/to/cel/files", pattern = "\\.CEL$", full.names = TRUE)

# The crlmm package uses genomewidesnp6Crlmm internally here
# for SNP 6.0 arrays
crlmm_results <- crlmm(celFiles)
```

### Troubleshooting

If you encounter an error stating that the annotation package for SNP 6.0 is missing, ensure that `genomewidesnp6Crlmm` is correctly installed:

```r
# Check if the package is available
find.package("genomewidesnp6Crlmm")
```

## Reference documentation

- [genomewidesnp6Crlmm Reference Manual](./references/reference_manual.md)
---
name: bioconductor-human660quadv1acrlmm
description: This package provides annotation data for Illumina 660kQuad arrays required by the crlmm package. Use when user asks to perform genotype calling, estimate copy number, or process Illumina 660kQuad platform data using the crlmm algorithm.
homepage: https://bioconductor.org/packages/release/data/annotation/html/human660quadv1aCrlmm.html
---


# bioconductor-human660quadv1acrlmm

name: bioconductor-human660quadv1acrlmm
description: Annotation data package for Illumina 660kQuad arrays. Use when performing genotype calling or copy number analysis using the 'crlmm' package on Illumina 660kQuad platform data.

# bioconductor-human660quadv1acrlmm

## Overview

The `human660quadv1aCrlmm` package is a specialized Bioconductor data package designed to be used internally by the `crlmm` (Corrected Robust Linear Model with Maximum likelihood) package. It contains the platform-specific annotation data required to process Illumina 660kQuad arrays.

This package provides the necessary metadata for:
- Genotype calling.
- Copy number estimation.
- Tool-specific probe information for the 660kQuad v1a platform.

## Installation and Loading

To use this package within an R session, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("human660quadv1aCrlmm")
library(human660quadv1aCrlmm)
```

## Typical Workflow

This package is rarely called directly by the user. Instead, it serves as a dependency for the `crlmm` workflow. When processing Illumina IDAT files or preprocessed data from the 660kQuad platform, `crlmm` will look for this package to retrieve SNP-specific parameters.

### Using with crlmm

When using the `crlmm` package, ensure this annotation package is installed so that the genotyping functions can identify the array type:

```r
library(crlmm)

# Example: Genotyping Illumina arrays
# The crlmm functions will automatically detect and load human660quadv1aCrlmm 
# if the input data corresponds to this platform.
# res <- crlmmIllumina(filenames = my_idat_files)
```

## Usage Tips

- **Internal Dependency**: If you encounter errors in `crlmm` stating that annotation data for "human660quadv1a" is missing, installing this package is the primary solution.
- **Platform Specificity**: This package is strictly for the "v1a" version of the Illumina 660kQuad array. Ensure your array version matches this package to avoid incorrect genotyping results.
- **Memory Management**: As a data package, it may load significant metadata into memory when invoked by `crlmm`.

## Reference documentation

- [human660quadv1aCrlmm Reference Manual](./references/reference_manual.md)
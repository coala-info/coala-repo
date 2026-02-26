---
name: bioconductor-human1mv1ccrlmm
description: This package provides data annotation and calibration metadata for processing Illumina 1M arrays using the CRLMM algorithm. Use when user asks to perform genotyping or copy number analysis on Illumina 1M platform data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/human1mv1cCrlmm.html
---


# bioconductor-human1mv1ccrlmm

name: bioconductor-human1mv1ccrlmm
description: Data annotation package for Illumina 1M arrays. Use when performing genotyping or copy number analysis with the 'crlmm' package on Illumina 1M platform data. This package provides the internal calibration and metadata required by the CRLMM algorithm.

## Overview

The `human1mv1cCrlmm` package is a specialized Bioconductor data package. It does not typically contain user-facing functions for direct data analysis; instead, it serves as a critical infrastructure component for the `crlmm` package. It contains the specific information needed to process Illumina 1M (version 1) arrays using the Corrected Robust Linear Model with Multiple-outliers (CRLMM) algorithm.

## Usage in R

### Installation and Loading

This package is usually required as a dependency when processing specific Illumina datasets. To ensure it is available:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("human1mv1cCrlmm")
library(human1mv1cCrlmm)
```

### Integration with crlmm

The primary workflow involves the `crlmm` package. When calling functions like `crlmmIllumina`, the algorithm identifies the array type and searches for the corresponding "cCrlmm" data package.

```r
library(crlmm)

# Example of where this package is utilized internally
# 'samples' would be a character vector of paths to IDAT files
# 'arrayNames' would specify the Illumina 1M platform
# result <- crlmmIllumina(filenames = samples, arrayNames = "human1mv1")
```

### Key Points
- **Internal Use**: Most users will not call functions directly from `human1mv1cCrlmm`. Its presence in the R library is what allows `crlmm` to function for this specific array type.
- **Array Specificity**: This package is strictly for the Illumina 1M platform. Using it with other Illumina versions (like 550k or 610k) will result in errors or incorrect mapping.
- **Data Content**: It contains the necessary constants and probe information required for the normalization and base-calling steps of the CRLMM pipeline.

## Reference documentation

- [human1mv1cCrlmm Reference Manual](./references/reference_manual.md)
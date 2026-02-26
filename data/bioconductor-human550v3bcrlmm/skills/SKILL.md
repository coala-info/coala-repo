---
name: bioconductor-human550v3bcrlmm
description: This package provides platform-specific constants and SNP mapping data for processing Illumina Human550-v3b BeadChips using the CRLMM algorithm. Use when user asks to perform genotype calling, process Illumina 550k v3b array data, or resolve missing annotation errors in the crlmm package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/human550v3bCrlmm.html
---


# bioconductor-human550v3bcrlmm

## Overview
The `human550v3bCrlmm` package is a specialized data package within the Bioconductor ecosystem. It is designed to be used internally by the `crlmm` package to facilitate Corrected Robust Linear Model with Multiple-distance Priors (CRLMM) processing. Specifically, it contains the platform-specific constants, SNP identifiers, and mapping data required to process Illumina Human550-v3b BeadChips.

## Typical Workflow

This package is rarely called directly by the user. Instead, it is loaded automatically by `crlmm` functions when the software detects the Illumina 550k v3b array type.

### 1. Loading the Package
To ensure the annotation data is available in your R environment:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("human550v3bCrlmm")
library(human550v3bCrlmm)
```

### 2. Integration with CRLMM
When using the `crlmm` package to call genotypes from IDAT files or summary intensities, specify the platform if it is not automatically detected:

```r
library(crlmm)

# Example of genotype calling where this package is utilized
# The 'human550v3b' string tells crlmm to look for this specific data package
res <- crlmmIllumina(filenames = myIdatFiles, chipType = "human550v3b")
```

### 3. Accessing Package Metadata
You can check the package version and basic information using standard R help commands:

```r
packageDescription("human550v3bCrlmm")
```

## Usage Tips
- **Internal Dependency**: If you encounter errors in `crlmm` stating that annotation data for "human550v3b" is missing, installing this package is the primary solution.
- **Memory Management**: As a data-heavy package, ensure your R session has sufficient memory when performing the actual genotype calling, though the data package itself is primarily a container for reference constants.
- **Version Matching**: Ensure that your version of `crlmm` and `human550v3bCrlmm` are both from the same Bioconductor release to maintain compatibility in the calibration values.

## Reference documentation
- [human550v3bCrlmm Reference Manual](./references/reference_manual.md)
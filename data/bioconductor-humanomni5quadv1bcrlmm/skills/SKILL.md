---
name: bioconductor-humanomni5quadv1bcrlmm
description: This package provides annotation data for the Illumina HumanOmni5-Quad BeadChip to support the crlmm algorithm. Use when user asks to perform genotype calling, estimate copy number, or preprocess data from Illumina HumanOmni5-Quad v1.0 BeadChips.
homepage: https://bioconductor.org/packages/release/data/annotation/html/humanomni5quadv1bCrlmm.html
---

# bioconductor-humanomni5quadv1bcrlmm

name: bioconductor-humanomni5quadv1bcrlmm
description: Provides annotation data for the Illumina HumanOmni5-Quad BeadChip. Use this skill when performing genotype calling or copy number analysis with the 'crlmm' package for this specific microarray platform.

# bioconductor-humanomni5quadv1bcrlmm

## Overview
The `humanomni5quadv1bCrlmm` package is a specialized Bioconductor annotation data package. It is designed to be used internally by the `crlmm` (Correct Robust Linear Model with Mixture-outliers) package to facilitate preprocessing, genotyping, and copy number estimation for Illumina HumanOmni5-Quad v1.0 BeadChips.

## Usage and Workflow

### Loading the Package
This package is typically not called directly by the user but must be installed and loaded for `crlmm` to recognize the array platform.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("humanomni5quadv1bCrlmm")
library(humanomni5quadv1bCrlmm)
```

### Integration with crlmm
When processing IDAT files or intensity data from the Omni5-Quad array, the `crlmm` package automatically looks for this annotation package to map probes and retrieve necessary constants for the CRLMM algorithm.

```r
library(crlmm)

# Example: Genotype calling for Illumina IDAT files
# The package will be used internally when the platform is detected
# or specified as 'humanomni5quadv1b'
crlmm_results <- crlmm(filenames = my_idat_files)
```

### Accessing Package Metadata
You can check the package version and basic information using standard R commands:

```r
packageVersion("humanomni5quadv1bCrlmm")
help(package = "humanomni5quadv1bCrlmm")
```

## Tips
- **Automatic Detection**: The `crlmm` package usually detects the correct annotation package based on the chip type found in the raw data. Ensure this package is installed if you are working with Omni5-Quad v1b data.
- **Memory Management**: Like most SNP array annotation packages, this package contains large data objects. Ensure your R session has sufficient RAM when performing genotype calling on large cohorts.
- **Data Source**: This package is specific to the "v1b" version of the Omni5-Quad array. Using it with different versions of the Omni5 chip may lead to incorrect probe mapping.

## Reference documentation
- [humanomni5quadv1bCrlmm Reference Manual](./references/reference_manual.md)
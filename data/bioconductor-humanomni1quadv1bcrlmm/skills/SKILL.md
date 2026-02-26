---
name: bioconductor-humanomni1quadv1bcrlmm
description: This package provides annotation data for Illumina Omni1 Quad v1b arrays to support genotype calling and copy number analysis. Use when user asks to perform genotype calling, conduct copy number analysis, or process Illumina HumanOmni1-Quad v1b BeadChip data using the crlmm package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/humanomni1quadv1bCrlmm.html
---


# bioconductor-humanomni1quadv1bcrlmm

name: bioconductor-humanomni1quadv1bcrlmm
description: Data annotation package for Illumina Omni1 Quad arrays. Use when performing Genotype Calling or Copy Number Analysis with the 'crlmm' package for HumanOmni1-Quad v1b BeadChips.

# bioconductor-humanomni1quadv1bcrlmm

## Overview
The `humanomni1quadv1bCrlmm` package is a specialized Bioconductor annotation data package. It is designed to be used internally by the `crlmm` (Correct Robust Linear Model with Mixture-model) package to provide the necessary metadata, probe sequences, and platform-specific parameters required for processing Illumina Omni1 Quad v1b arrays.

## Usage
This package is rarely called directly by the user. Instead, it serves as a dependency that must be installed and loaded for `crlmm` to recognize and process HumanOmni1-Quad v1b data.

### Loading the Package
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("humanomni1quadv1bCrlmm")
library(humanomni1quadv1bCrlmm)
```

### Integration with crlmm
When using the `crlmm` package to call genotypes from IDAT files or pre-processed intensities, specify the platform if it is not automatically detected:

```r
library(crlmm)

# Example workflow: Genotype calling
# The crlmm function will look for humanomni1quadv1bCrlmm 
# when processing Omni1-Quad v1b arrays.
res <- crlmm(filenames, pkgname = "humanomni1quadv1bCrlmm")
```

### Accessing Package Metadata
To verify the package content or versioning information:
```r
# Check package information
packageDescription("humanomni1quadv1bCrlmm")

# List objects contained in the package (internal data)
ls("package:humanomni1quadv1bCrlmm")
```

## Tips
- **Automatic Invocation**: Most `crlmm` functions will automatically attempt to load this package based on the array type found in the raw data headers.
- **Memory Management**: As this is a data-heavy annotation package, ensure sufficient RAM is available when initializing `crlmm` workflows.
- **Installation**: If you encounter "package not found" errors during `crlmm` execution, manually install this package using `BiocManager::install()`.

## Reference documentation
- [humanomni1quadv1bCrlmm Reference Manual](./references/reference_manual.md)
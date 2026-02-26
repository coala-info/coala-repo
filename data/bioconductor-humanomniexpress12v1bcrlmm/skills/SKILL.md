---
name: bioconductor-humanomniexpress12v1bcrlmm
description: This package provides metadata and annotation data for the Illumina HumanOmniExpress-12v1-B chip required by the crlmm algorithm. Use when user asks to perform genotype calling, estimate copy number, or process IDAT files for this specific Illumina array platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/humanomniexpress12v1bCrlmm.html
---


# bioconductor-humanomniexpress12v1bcrlmm

name: bioconductor-humanomniexpress12v1bcrlmm
description: Metadata and annotation data package for the Illumina HumanOmniExpress-12v1-B chip. Use when performing genotype calling or copy number estimation using the crlmm package for this specific array platform.

# bioconductor-humanomniexpress12v1bcrlmm

## Overview

The humanomniexpress12v1bCrlmm package is a specialized Bioconductor data package. It provides the necessary annotation and calibration data required by the crlmm (Corrected Robust Linear Model with Multiple-distance Priors) package to process Illumina HumanOmniExpress-12v1-B arrays.

This package is not intended for standalone functional analysis but serves as a dependency for the crlmm workflow, providing platform-specific information such as probe sequences, fragment lengths, and GC content used in normalization and base calling.

## Usage

### Installation and Loading

To use this data package within an R session, it must be installed via BiocManager:

if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("humanomniexpress12v1bCrlmm")

library(humanomniexpress12v1bCrlmm)

### Integration with crlmm

The primary use case is providing the underlying data for the crlmm genotype calling algorithm. When processing IDAT files or SNP summary data from Illumina OmniExpress-12v1-B arrays, the crlmm package will automatically search for this package.

Example workflow:

1. Load the crlmm library.
2. Provide the path to your raw data (IDAT files).
3. The crlmm functions (like crlmm() or genotype()) will utilize this package internally based on the array type detected in the intensity files or specified by the user.

library(crlmm)
# Assuming 'path_to_idats' contains Illumina HumanOmniExpress-12v1-B data
# result <- crlmm(filenames, pkgname="humanomniexpress12v1bCrlmm")

### Accessing Package Metadata

While users rarely interact with the objects directly, you can check the package version and basic information:

packageVersion("humanomniexpress12v1bCrlmm")

## Tips

- Ensure this package version matches the version of the crlmm package you are using to avoid compatibility issues with data object schemas.
- This package is specific to the "12v1-B" version of the OmniExpress chip. Using it with other versions (like 12v1-C or 12v1-A) may lead to incorrect genotype calls or errors.
- If you encounter "package not found" errors during a crlmm run, verify that this package is installed in your R library path.

## Reference documentation

- [humanomniexpress12v1bCrlmm Reference Manual](./references/reference_manual.md)
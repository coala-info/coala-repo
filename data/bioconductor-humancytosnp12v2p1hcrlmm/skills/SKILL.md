---
name: bioconductor-humancytosnp12v2p1hcrlmm
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/humancytosnp12v2p1hCrlmm.html
---

# bioconductor-humancytosnp12v2p1hcrlmm

## Overview

The `humancytosnp12v2p1hCrlmm` package is a specialized Bioconductor annotation data package. It is designed to be used internally by the `crlmm` (Corrected Robust Linear Model with Multiple-distance Priors) package to process Illumina HumanCytoSNP-12 v2.1 arrays. It contains the necessary metadata, probe sequences, and physical mapping required for preprocessing and genotype calling.

## Typical Workflow

This package is rarely called directly by the user. Instead, it is automatically loaded by `crlmm` functions when the software detects the HumanCytoSNP-12 v2.1 platform.

### 1. Loading the Package
To ensure the annotation data is available in your R environment:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("humancytosnp12v2p1hCrlmm")
library(humancytosnp12v2p1hCrlmm)
```

### 2. Integration with crlmm
When processing IDAT files or intensity data from Illumina CytoSNP-12 arrays, the `crlmm` package uses this data package to map probes to genomic locations and apply platform-specific corrections.

```r
library(crlmm)

# Example: Genotype calling where 'filenames' are paths to IDAT files
# The crlmm function will identify the array type and look for this package
# res <- crlmm(filenames)
```

### 3. Accessing Package Metadata
You can check the version and basic information of the loaded annotation data:

```r
packageVersion("humancytosnp12v2p1hCrlmm")
```

## Usage Tips
- **Automatic Discovery**: You do not usually need to pass this package name as an argument; `crlmm` uses the "chip type" metadata within the raw data files to find the matching `...Crlmm` package.
- **Dependency**: Ensure the `crlmm` package is installed, as this package contains data but no executable logic for analysis on its own.
- **Memory**: Annotation packages can be large. Ensure your R session has sufficient memory when performing genome-wide analysis.

## Reference documentation
- [humancytosnp12v2p1hCrlmm Reference Manual](./references/reference_manual.md)
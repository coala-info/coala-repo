---
name: bioconductor-genomewidesnp5crlmm
description: This package provides data and annotation support for processing Affymetrix Genome-Wide Human SNP Array 5.0 data using the crlmm algorithm. Use when user asks to perform genotype calling, copy number analysis, or preprocess SNP 5.0 CEL files.
homepage: https://bioconductor.org/packages/release/data/annotation/html/genomewidesnp5Crlmm.html
---

# bioconductor-genomewidesnp5crlmm

name: bioconductor-genomewidesnp5crlmm
description: Provides data and annotation support for the Affymetrix Genome-Wide Human SNP Array 5.0. Use this skill when performing genotype calling, copy number analysis, or preprocessing of SNP 5.0 data using the crlmm package.

# bioconductor-genomewidesnp5crlmm

## Overview

The `genomewidesnp5Crlmm` package is a specialized data annotation package designed to be used internally by the `crlmm` (Corrected Robust Linear Model with Maximum likelihood) package. It contains the specific metadata, probe sequences, and calibration data required to process Affymetrix SNP 5.0 arrays. 

This package does not typically require direct function calls by the user; instead, it serves as a dependency that must be installed and loaded for `crlmm` to recognize and process SNP 5.0 CEL files.

## Workflow and Usage

### 1. Installation and Loading
Ensure the package is installed alongside `crlmm`. While `crlmm` usually loads this automatically when it detects SNP 5.0 data, you can load it manually to verify availability.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("genomewidesnp5Crlmm")
library(genomewidesnp5Crlmm)
```

### 2. Integration with crlmm
The primary use case is providing the underlying data for the `crlmm` function. When you have a directory of CEL files from a SNP 5.0 chip, `crlmm` will look for this package.

```r
library(crlmm)

# Path to SNP 5.0 .CEL files
celFiles <- list.celfiles("path/to/cel/files", full.names = TRUE)

# crlmm will automatically utilize genomewidesnp5Crlmm for SNP 5.0 data
crlmm_results <- crlmm(celFiles)
```

### 3. Accessing Annotation Data
If you need to inspect the annotation metadata manually (though rarely required for standard workflows), you can explore the package namespace or the objects it provides to the `oligo` or `crlmm` infrastructure.

## Tips
- **Automatic Detection**: You do not need to call specific functions from this package. Its presence in your R library allows `crlmm` to handle the "genomewidesnp5" platform string.
- **Memory Management**: Like all SNP annotation packages, this can be large. Ensure your R session has sufficient RAM when processing large batches of CEL files.
- **Version Consistency**: Ensure that `genomewidesnp5Crlmm` and `crlmm` are both updated to their latest Bioconductor release versions to avoid schema mismatches.

## Reference documentation
- [genomewidesnp5Crlmm Reference Manual](./references/reference_manual.md)
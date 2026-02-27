---
name: bioconductor-rat2302frmavecs
description: This package provides pre-computed vectors and parameter estimates for Frozen Robust Multi-array Analysis (fRMA) of Rat Genome 230 2.0 Array microarrays. Use when user asks to perform fRMA preprocessing on rat2302 Affymetrix data, normalize microarrays individually, or ensure consistent expression values across different rat datasets.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rat2302frmavecs.html
---


# bioconductor-rat2302frmavecs

name: bioconductor-rat2302frmavecs
description: Provides vectors and parameter estimates for the Frozen Robust Multi-array Analysis (fRMA) of Rat Genome 230 2.0 Array (rat2302) microarrays. Use this skill when performing fRMA preprocessing on rat2302 Affymetrix data to ensure consistent normalization across different datasets or single-array processing.

# bioconductor-rat2302frmavecs

## Overview

The `rat2302frmavecs` package is a data-only annotation package for R. It contains the pre-computed probe-specific effects and variances required by the `frma` package to process Rat Genome 230 2.0 Array (rat2302) microarrays. 

The fRMA algorithm allows for the preprocessing of microarrays individually or in small batches while maintaining the advantages of multi-array preprocessing (like RMA). This is achieved by using these pre-calculated "vectors" derived from a large, diverse training set of 1,023 samples across 11 different rat tissues.

## Typical Workflow

To use these vectors, you must have the `frma` and `affy` packages installed. The `frma` function automatically detects and loads `rat2302frmavecs` when it encounters an AffyBatch object with the `rat2302` annotation.

### Basic fRMA Preprocessing

```r
library(affy)
library(frma)
library(rat2302frmavecs)

# 1. Load CEL files
# Ensure the cdfname is set to 'rat2302cdf'
affybatch <- ReadAffy(filenames = "path/to/your/sample.CEL", cdfname = "rat2302cdf")

# 2. Run fRMA
# The frma function will use the vectors from this package by default
eset <- frma(affybatch)

# 3. Access expression data
expression_matrix <- exprs(eset)
```

## Usage Tips

- **Platform Specificity**: This package is strictly for the **Rat Genome 230 2.0 Array**. Do not use it for other rat platforms (like rat4302) as the probe sets and sequences differ.
- **Memory Efficiency**: fRMA is particularly useful when you have a large number of samples that cannot be processed simultaneously using standard RMA due to memory constraints.
- **Single Array Processing**: You can use this package to normalize a single CEL file and obtain expression values that are comparable to other arrays processed with the same vectors.
- **CDF Requirement**: Ensure your `AffyBatch` object is using the standard `rat2302cdf`. If using custom CDFs (like Brainarray), fRMA may require different vector packages.

## Reference documentation

- [Vector used by frma for microarrays of type rat2302](./references/rat2302frmavecs-vignette.md)
---
name: bioconductor-hgu133a2frmavecs
description: This package provides frozen parameter vectors for the Affymetrix Human Genome U133A 2.0 platform to be used with fRMA and barcode algorithms. Use when user asks to normalize gene expression data, perform frozen robust multiarray analysis, or run barcode algorithms for hgu133a2 microarrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133a2frmavecs.html
---

# bioconductor-hgu133a2frmavecs

name: bioconductor-hgu133a2frmavecs
description: Provides frozen parameter vectors for the hgu133a2 platform to be used with the fRMA (Frozen Robust Multiarray Analysis) and barcode algorithms. Use this skill when performing gene expression normalization, preprocessing, or barcode analysis for Affymetrix Human Genome U133A 2.0 arrays.

# bioconductor-hgu133a2frmavecs

## Overview

The `hgu133a2frmavecs` package is a data-annotation package containing the frozen parameter vectors required to run the `frma` and `barcode` functions from the `frma` and `barcode` Bioconductor packages, specifically for the Affymetrix Human Genome U133A 2.0 (hgu133a2) platform. These vectors allow for the preprocessing of single microarrays or small batches by leveraging information from a large database of previously analyzed arrays.

## Usage and Workflows

### Loading the Vectors

The package contains two primary data objects: `hgu133a2frmavecs` (for fRMA) and `hgu133a2barcodevecs` (for the barcode algorithm).

```r
# Load the package
library(hgu133a2frmavecs)

# Load fRMA vectors
data(hgu133a2frmavecs)

# Load barcode vectors
data(hgu133a2barcodevecs)

# Load alternative Entrez Gene CDF vectors (if applicable)
data(hgu133a2hsentrezgfrmavecs)
```

### Integration with fRMA

The primary use case is passing these vectors to the `frma` function. While `frma` often detects the correct vectors automatically based on the CDF environment of the input `AffyBatch` object, they can be explicitly provided.

```r
library(frma)
library(hgu133a2frmavecs)

# Assuming 'affyBatchObject' is an AffyBatch for hgu133a2
# The frma function will use these vectors to normalize the data
expressionSet <- frma(affyBatchObject)
```

### Data Structures

- **hgu133a2frmavecs**: A list containing normalization vectors (`normVec`), probe effects (`probeVec`), within/between batch probe variance, and probeset standard deviations.
- **hgu133a2barcodevecs**: A list containing parameters for the background distribution, including means (`mu`), standard deviations (`tau`), and observed gene entropy.

### Checking Vector Metadata

To verify the version or contents of the vectors:

```r
str(hgu133a2frmavecs)
str(hgu133a2barcodevecs)
```

## Tips

- **Platform Specificity**: Ensure the data being processed is specifically from the **hgu133a2** platform. Using these vectors on standard hgu133a or hgu133plus2 data will result in incorrect normalization.
- **Memory Efficiency**: These packages are data-heavy. Only load them when performing the actual preprocessing step.
- **GNUSE**: These vectors are also utilized by the `GNUSE` function (Global Normalized Unscaled Standard Error) to assess the quality of individual arrays.

## Reference documentation

- [hgu133a2frmavecs Reference Manual](./references/reference_manual.md)
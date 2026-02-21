---
name: bioconductor-hgu133plus2frmavecs
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133plus2frmavecs.html
---

# bioconductor-hgu133plus2frmavecs

name: bioconductor-hgu133plus2frmavecs
description: Provides frozen parameter vectors for the fRMA (Frozen Robust Multi-array Analysis) algorithm and gene expression barcode calculations specifically for the Affymetrix Human Genome U133 Plus 2.0 Array (hgu133plus2). Use this skill when performing preprocessing, normalization, or quality assessment of hgu133plus2 microarray data using the `frma` or `barcode` packages.

# bioconductor-hgu133plus2frmavecs

## Overview

The `hgu133plus2frmavecs` package is a data-annotation package containing the "frozen" parameter vectors required to run the Frozen Robust Multi-array Analysis (fRMA) algorithm on Affymetrix Human Genome U133 Plus 2.0 arrays. Unlike standard RMA, which requires all chips to be processed simultaneously, fRMA uses these pre-computed vectors (derived from a large database of arrays) to allow for the normalization of single microarrays or small batches while maintaining consistency with a larger training set.

This package also includes vectors for the `barcode` function, which estimates the probability of a gene being "expressed" or "unexpressed" based on the distribution of observed intensities.

## Usage and Workflows

### Loading the Vectors

The package contains two primary data objects: `hgu133plus2frmavecs` (for standard fRMA) and `hgu133plus2barcodevecs` (for the barcode algorithm).

```r
library(hgu133plus2frmavecs)

# Load fRMA vectors
data(hgu133plus2frmavecs)

# Load Barcode vectors
data(hgu133plus2barcodevecs)
```

### Using with the frma Package

The most common use case is passing these vectors to the `frma` function from the `frma` package. While `frma` often detects the correct vectors automatically based on the CDF environment, you can specify them explicitly.

```r
library(frma)
library(hgu133plus2cdf) # Ensure the appropriate CDF is loaded

# Assuming 'affyBatch' is your raw data object
# fRMA normalization using the frozen vectors
eset <- frma(affyBatch, target = "core")
```

### Data Structures

#### fRMA Vectors (`hgu133plus2frmavecs`)
This is a list containing parameters used for normalization and summarization:
- `normVec`: The reference distribution for quantile normalization.
- `probeVec`: Individual probe effects.
- `probeVarWithin`: Within-batch probe variance.
- `probeVarBetween`: Between-batch probe variance.
- `probesetSD`: Standard deviation within probesets.
- `medianSE`: Median standard errors for expression estimates.

#### Barcode Vectors (`hgu133plus2barcodevecs`)
This list contains parameters for the Gene Expression Barcode (version 3.0):
- `mu`: Background means.
- `tau`: Background standard deviations.
- `entropy`: Observed gene entropy.

### Alternative CDFs
The package also provides `hgu133plus2hsentrezgfrmavecs` for users utilizing the Entrez Gene alternative CDF versions.

```r
data(hgu133plus2hsentrezgfrmavecs)
```

## Tips and Best Practices
- **Consistency**: Ensure that the version of the `frmavecs` package matches the array type (hgu133plus2). Using vectors from a different array type will result in incorrect normalization.
- **GNUSE**: These vectors are also required for calculating the GNUSE (Generalized Normalized Unscaled Standard Error) quality metric for single arrays.
- **Memory**: These objects are data-heavy; only load them when performing the preprocessing step.

## Reference documentation
- [hgu133plus2frmavecs Reference Manual](./references/reference_manual.md)
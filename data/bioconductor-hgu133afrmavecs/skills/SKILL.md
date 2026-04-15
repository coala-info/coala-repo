---
name: bioconductor-hgu133afrmavecs
description: This package provides frozen parameter vectors for the Affymetrix Human Genome U133A Array to be used with fRMA and barcode algorithms. Use when user asks to perform single-array normalization, calculate GNUSE quality scores, or determine gene expression status using the barcode algorithm for hgu133a microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133afrmavecs.html
---

# bioconductor-hgu133afrmavecs

name: bioconductor-hgu133afrmavecs
description: Provides frozen parameter vectors for the Affymetrix Human Genome U133 Plus 2.0 Array (hgu133a) to be used with the fRMA (Frozen Robust Multi-array Analysis) and barcode algorithms. Use this skill when performing single-array normalization, gene expression barcoding, or calculating GNUSE scores for hgu133a microarray data.

# bioconductor-hgu133afrmavecs

## Overview

The `hgu133afrmavecs` package is a data-annotation package containing pre-computed vectors required to run the `frma` and `barcode` functions from the `frma` and `barcode` Bioconductor packages. These vectors allow for the preprocessing of individual Affymetrix hgu133a arrays by leveraging information from a large training database, bypassing the need for a large batch of new chips for normalization.

## Usage in R

### Loading the Vectors

To use these vectors, you must load the package and then use the `data()` function to load the specific vector sets into your R environment.

```r
library(hgu133afrmavecs)

# Load vectors for standard fRMA preprocessing
data(hgu133afrmavecs)

# Load vectors for the barcode function (background distribution parameters)
data(hgu133abarcodevecs)

# Load vectors for Entrez Gene alternative CDF version (if applicable)
data(hgu133ahsentrezgfrmavecs)
```

### Integration with fRMA

The primary use case is passing these vectors to the `frma` package to process `AffyBatch` objects.

```r
library(frma)
library(hgu133afrmavecs)

# Assuming 'affyBatchObject' is an AffyBatch object for hgu133a
# fRMA automatically detects the correct vectors if the package is installed,
# but they can be inspected manually:
data(hgu133afrmavecs)
str(hgu133afrmavecs)
```

### Vector Components

The `hgu133afrmavecs` object is a list containing:
- `normVec`: Normalization vector.
- `probeVec`: Probe effect vector.
- `probeVarWithin`: Within-batch probe variance.
- `probeVarBetween`: Between-batch probe variance.
- `probesetSD`: Within-probeset standard deviation.
- `medianSE`: Median standard error for gene expression estimates.

The `hgu133abarcodevecs` object is a list containing:
- `mu`: Background means.
- `tau`: Background standard deviations.
- `entropy`: Observed gene entropy.

## Typical Workflow

1. **Load Data**: Load your hgu133a raw data (.CEL files) using `affy::ReadAffy()`.
2. **Preprocess**: Run `frma()` on the data. The `frma` function will utilize the vectors in this package to perform background correction, normalization, and summarization.
3. **Quality Control**: Use the `GNUSE()` function (which also utilizes these vectors) to assess the quality of individual arrays.
4. **Barcoding**: Use the `barcode()` function with `hgu133abarcodevecs` to determine which genes are expressed (1) or unexpressed (0) relative to the background distribution.

## Reference documentation

- [hgu133afrmavecs Reference Manual](./references/reference_manual.md)
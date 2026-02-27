---
name: bioconductor-mogene.1.0.st.v1frmavecs
description: This package provides frozen parameter vectors for the Mouse Gene 1.0 ST v1 oligonucleotide array. Use when user asks to perform Frozen Robust Multi-array Analysis (fRMA) or Gene Expression Barcoding on mogene.1.0.st.v1 microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene.1.0.st.v1frmavecs.html
---


# bioconductor-mogene.1.0.st.v1frmavecs

name: bioconductor-mogene.1.0.st.v1frmavecs
description: Provides frozen parameter vectors for the Mouse Gene 1.0 ST v1 oligonucleotide array. Use this skill when performing Frozen Robust Multi-array Analysis (fRMA) or Gene Expression Barcoding on mogene.1.0.st.v1 microarrays to ensure consistent normalization and summarization across different datasets.

# bioconductor-mogene.1.0.st.v1frmavecs

## Overview

The `mogene.1.0.st.v1frmavecs` package is a data-only Bioconductor annotation package. It contains the "frozen" parameter vectors required by the `frma` and `barcode` functions (from the `frma` and `barcode` packages, respectively) for the Mouse Gene 1.0 ST v1 array. These vectors allow for the preprocessing of individual arrays or small batches by leveraging information from a large training database, ensuring that results are comparable across different studies.

## Usage

### Loading the Data

To use these vectors, you must load the package and then use the `data()` function to load the specific list of parameters into your R environment.

```r
library(mogene.1.0.st.v1frmavecs)

# Load vectors for fRMA
data(mogene.1.0.st.v1frmavecs)

# Load vectors for Gene Expression Barcoding
data(mogene.1.0.st.v1barcodevecs)
```

### Workflow: Frozen RMA (fRMA)

The primary use case is passing these vectors to the `frma` function. This is useful when you want to process arrays one-at-a-time or in small groups while maintaining the normalization standards of a larger cohort.

```r
library(frma)
library(mogene.1.0.st.v1frmavecs)

# Assuming 'affyBatch' is your loaded Mouse Gene 1.0 ST v1 data
# The frma function automatically detects the correct vectors if the package is installed,
# but they can be inspected manually:
data(mogene.1.0.st.v1frmavecs)
str(mogene.1.0.st.v1frmavecs)

# Run fRMA
eset <- frma(affyBatch, target="core") 
```

### Workflow: Gene Expression Barcode

The barcode vectors are used to estimate the probability of a gene being "expressed" (on) or "unexpressed" (off) based on the background distribution of the platform.

```r
library(barcode)
data(mogene.1.0.st.v1barcodevecs)

# The barcode function uses mu, tau, and entropy from this list
# to calculate expression probabilities.
```

## Data Structures

### mogene.1.0.st.v1frmavecs
A list containing 8 elements used for normalization and summarization:
- `normVec`: Normalization vector.
- `probeVec`: Probe effect vector.
- `probeVarWithin`: Within-batch probe variance.
- `probeVarBetween`: Between-batch probe variance.
- `probesetSD`: Within-probeset standard deviation.
- `medianSE`: Median standard error for expression estimates.
- `probeVecCore`: Exon effect vector for core transcript summarization.
- `mapCore`: Mapping between exons and core transcripts.

### mogene.1.0.st.v1barcodevecs
A list containing 3 elements for the barcode algorithm:
- `mu`: Background means.
- `tau`: Background standard deviations.
- `entropy`: Observed gene entropy.

## Reference documentation

- [mogene.1.0.st.v1frmavecs Reference Manual](./references/reference_manual.md)
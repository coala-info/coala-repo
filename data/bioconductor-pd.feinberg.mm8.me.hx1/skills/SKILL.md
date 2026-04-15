---
name: bioconductor-pd.feinberg.mm8.me.hx1
description: This package provides annotation data for the Feinberg Mouse MM8 ME HX1 microarray platform. Use when user asks to process raw CEL files, map probe sequences, or perform high-level analysis of this specific mouse epigenetics array using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.feinberg.mm8.me.hx1.html
---

# bioconductor-pd.feinberg.mm8.me.hx1

name: bioconductor-pd.feinberg.mm8.me.hx1
description: Provides annotation data for the Feinberg Mouse MM8 ME HX1 microarray platform. Use this skill when working with the Bioconductor package 'pd.feinberg.mm8.me.hx1' to process, analyze, or map probe sequences for this specific mouse epigenetics/methylation array using the 'oligo' package.

# bioconductor-pd.feinberg.mm8.me.hx1

## Overview

The `pd.feinberg.mm8.me.hx1` package is a specialized annotation data package for the Feinberg Mouse MM8 ME HX1 microarray. It was built using `pdInfoBuilder` and is designed to be used primarily with the `oligo` package for high-level analysis of oligonucleotide arrays. It contains the platform design information, including probe sequences and their physical locations (fids).

## Installation and Loading

To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pd.feinberg.mm8.me.hx1")

# Load the package
library(pd.feinberg.mm8.me.hx1)
```

## Typical Workflow

This package is usually not called directly by the user but is loaded automatically by the `oligo` package when reading raw CEL files from this platform.

### Using with oligo

When reading data, `oligo` identifies the platform and looks for this annotation package:

```r
library(oligo)

# Read CEL files (ensure they are from the Feinberg mm8 me hx1 platform)
raw_data <- read.celfiles(filenames = list.celfiles())

# The annotation slot will be set to "pd.feinberg.mm8.me.hx1"
# You can then proceed with normalization (e.g., RMA)
eset <- rma(raw_data)
```

### Accessing Probe Sequences

If you need to inspect the Perfect Match (PM) probe sequences manually:

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
head(pmSequence)

# The object is a DataFrame with 'fid' (feature ID) and 'sequence' columns
```

## Key Data Objects

- **pmSequence**: A `DataFrame` containing the sequences for the Perfect Match probes.
- **mmSequence**: (If available) Sequence data for Mismatch probes.
- **bgSequence**: (If available) Sequence data for background probes.

## Tips

- **Platform Specificity**: This package is specific to the MM8 (Mouse Genome Build 36) version of the Feinberg ME HX1 array. Ensure your genomic coordinates or downstream analysis align with the mm8 assembly.
- **Memory Management**: Annotation packages can be large. If you are only performing standard normalization, let `oligo` handle the package loading internally.
- **Feature IDs**: The `fid` column in the sequence data links the sequences to the intensity values found in the `ExpressionSet` or `FeatureSet` objects.

## Reference documentation

- [pd.feinberg.mm8.me.hx1 Reference Manual](./references/reference_manual.md)
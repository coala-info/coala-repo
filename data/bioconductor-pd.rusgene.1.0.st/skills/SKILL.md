---
name: bioconductor-pd.rusgene.1.0.st
description: This package provides annotation and platform design information for the Affymetrix RusGene 1.0 ST microarray. Use when user asks to process RusGene 1.0 ST CEL files, perform RMA normalization on this platform, or access probe sequences and feature-level mapping.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rusgene.1.0.st.html
---

# bioconductor-pd.rusgene.1.0.st

name: bioconductor-pd.rusgene.1.0.st
description: Annotation package for the Affymetrix RusGene 1.0 ST array. Use when processing RusGene 1.0 ST microarray data using the oligo package to provide platform design information, probe sequences, and feature-level mapping.

# bioconductor-pd.rusgene.1.0.st

## Overview

The `pd.rusgene.1.0.st` package is a Bioconductor annotation resource specifically designed for the Affymetrix RusGene 1.0 ST array. It was built using the `pdInfoBuilder` system and serves as a backend for the `oligo` package. It contains the necessary mapping between probe identifiers and their physical locations/sequences on the array, which is essential for preprocessing and analyzing "ST" (Sense Target) family microarrays.

## Usage in R

This package is primarily used as a dependency for the `oligo` package. You rarely need to call its functions directly, but it must be installed for `oligo` to process RusGene 1.0 ST CEL files.

### Loading the Package
```R
library(pd.rusgene.1.0.st)
```

### Typical Workflow with oligo
When reading CEL files, `oligo` will automatically detect and load this package if the metadata in the CEL files matches this platform.

```R
library(oligo)

# Read CEL files in the current directory
raw_data <- read.celfiles(list.celfiles())

# The resulting object (GeneFeatureSet) uses pd.rusgene.1.0.st for annotation
show(raw_data)

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
If you need to analyze the actual sequences of the Perfect Match (PM) probes:

```R
library(pd.rusgene.1.0.st)
data(pmSequence)

# View the first few sequences
head(pmSequence)

# pmSequence is a DataFrame with 'fid' (feature ID) and 'sequence' columns
```

## Tips
- **Automatic Triggering**: You do not usually need to load this library manually with `library()` if you are using `read.celfiles()`; `oligo` handles the attachment.
- **Memory**: Like most `pdInfo` packages, this uses an SQLite database backend to store annotation data efficiently.
- **Compatibility**: Ensure this package version matches your Bioconductor release to avoid schema mismatches with the `oligo` package.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
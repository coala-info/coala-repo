---
name: bioconductor-pd.bovine
description: This package provides annotation data and platform design information for the Affymetrix Bovine Genome Array. Use when user asks to preprocess raw CEL files from cow genome microarrays, map probe identifiers to sequences, or load platform metadata for use with the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.bovine.html
---

# bioconductor-pd.bovine

name: bioconductor-pd.bovine
description: Annotation package for the Affymetrix Bovine (Cow) Genome Array. Use when processing Affymetrix bovine microarray data with the 'oligo' or 'xps' packages to map probe identifiers to sequences and genomic coordinates.

# bioconductor-pd.bovine

## Overview

The `pd.bovine` package is a Bioconductor annotation data package specifically designed for the Affymetrix Bovine Genome Array. It was built using the `pdInfoBuilder` infrastructure and is primarily intended to work as a backend for the `oligo` package. It contains the platform design information required to preprocess raw CEL files, including probe sequences and feature identifiers.

## Typical Workflow

The most common use case for `pd.bovine` is automatic. When you load raw Affymetrix data using `oligo`, the package is called internally.

### 1. Loading Data with oligo
When reading CEL files, `oligo` will look for `pd.bovine` if the samples are from the Bovine Genome Array.

```r
library(oligo)
# Assuming .CEL files are in the current directory
celFiles <- list.celfiles()
rawData <- read.celfiles(celFiles)
# The 'pd.bovine' package is automatically used to annotate 'rawData'
```

### 2. Accessing Probe Sequences
You can manually load and inspect the probe sequence data contained within the package.

```r
library(pd.bovine)
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence')
head(pmSequence)

# Access specific columns
# 'fid' is the feature ID, 'sequence' is the DNA sequence
pm_fids <- pmSequence$fid
pm_seqs <- pmSequence$sequence
```

### 3. Background and Mismatch Sequences
The package also contains data for background (bg) and mismatch (mm) probes if applicable to the array design, accessible via the same dataset.

```r
# These are typically aliases or subsets within the pmSequence data object
data(pmSequence)
# To see available objects in the namespace:
ls("package:pd.bovine")
```

## Usage Tips
- **Automatic Triggering**: You do not usually need to call `library(pd.bovine)` directly; `oligo::read.celfiles()` will prompt for its installation or load it automatically based on the CEL file header.
- **Memory Management**: The `pmSequence` object can be large. Only load it if you need to perform sequence-specific analysis (e.g., GC-content normalization or probe-level alignment).
- **Compatibility**: Ensure the version of `pd.bovine` matches your Bioconductor release to maintain compatibility with the `oligo` package.

## Reference documentation
- [pd.bovine Reference Manual](./references/reference_manual.md)
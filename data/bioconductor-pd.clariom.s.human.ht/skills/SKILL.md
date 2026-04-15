---
name: bioconductor-pd.clariom.s.human.ht
description: This package provides platform design and annotation data for the Affymetrix Clariom S Human HT microarray. Use when user asks to process Clariom S Human HT microarray data, map probe identifiers to sequences, or provide platform metadata for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.clariom.s.human.ht.html
---

# bioconductor-pd.clariom.s.human.ht

name: bioconductor-pd.clariom.s.human.ht
description: Annotation and platform design information for the Affymetrix Clariom S Human HT array. Use this skill when processing Clariom S Human HT microarray data in R, specifically for mapping probe identifiers to sequences and providing platform metadata for the oligo package.

# bioconductor-pd.clariom.s.human.ht

## Overview
The `pd.clariom.s.human.ht` package is a Bioconductor annotation package built using `pdInfoBuilder`. It provides the necessary platform design information for the Clariom S Human HT (High Throughput) microarray. It is primarily designed to work as a backend for the `oligo` package to enable the preprocessing, normalization, and analysis of .CEL files from this specific platform.

## Usage in R

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but can be loaded manually:

```r
library(pd.clariom.s.human.ht)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, which is essential for algorithms like RMA or GCRMA that utilize probe sequence data.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with oligo
This package provides the infrastructure for `read.celfiles()`. When analyzing Clariom S Human HT data, ensure this package is installed so `oligo` can correctly map the feature identifiers.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(filenames = list.celfiles())

# The 'pd.clariom.s.human.ht' package will be used to 
# provide the annotation slot for the resulting FeatureSet object.
```

## Data Structures
- **pmSequence**: A `DataFrame` object containing:
  - `fid`: Feature identifier.
  - `sequence`: The actual nucleotide sequence for the probe.
- **bgSequence / mmSequence**: Depending on the specific array layout, background or mismatch sequences may be accessed via the same `data(pmSequence)` call if defined in the platform design.

## Reference documentation
- [pd.clariom.s.human.ht Reference Manual](./references/reference_manual.md)
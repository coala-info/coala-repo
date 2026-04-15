---
name: bioconductor-pd.sugar.cane
description: This package provides platform design and annotation data for the Affymetrix Sugar Cane (Saccharum officinarum) genome array. Use when user asks to process raw CEL files from Sugar Cane arrays, map probe identifiers to sequences, or provide platform information for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.sugar.cane.html
---

# bioconductor-pd.sugar.cane

name: bioconductor-pd.sugar.cane
description: Annotation data package for the Sugar Cane (Saccharum officinarum) platform. Use this skill when working with Affymetrix Sugar Cane arrays in R, specifically for mapping probe identifiers to sequences and providing platform design information for the oligo package.

# bioconductor-pd.sugar.cane

## Overview
The `pd.sugar.cane` package is a Bioconductor annotation package built using `pdInfoBuilder`. It provides the necessary platform design information for the Sugar Cane genome array. It is primarily designed to be used as a backend for the `oligo` package to process raw CEL files, enabling the mapping of feature identifiers to physical sequences and probe types.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo::read.celfiles()`, but it can be loaded manually:

```r
library(pd.sugar.cane)
```

### 2. Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific columns
fids <- pmSequence$fid
seqs <- pmSequence$sequence
```

### 3. Integration with oligo
This package provides the infrastructure for `oligo` to perform preprocessing (like RMA or GCRMA). You do not usually call functions within `pd.sugar.cane` directly; instead, you ensure it is installed so `oligo` can identify the array vendor and design.

```r
library(oligo)
# Assuming .CEL files are in the working directory
raw_data <- read.celfiles(list.celfiles())

# The 'pd.sugar.cane' package is used here to provide the annotation 
# slot for the resulting ExpressionFeatureSet or GeneFeatureSet.
```

## Data Objects
- `pmSequence`: A `DataFrame` object containing the feature ID (`fid`) and the corresponding nucleotide sequence for PM probes.
- `bgSequence`: Background probe sequences (if applicable, accessed via `data(pmSequence)`).
- `mmSequence`: Mismatch probe sequences (if applicable, accessed via `data(pmSequence)`).

## Tips
- **Memory Management**: Annotation packages can be large. If you only need probe sequences, load the data object specifically using `data(pmSequence)`.
- **Platform Matching**: Ensure the CEL files you are analyzing were generated from the Sugar Cane chip; otherwise, `oligo` will throw an error regarding the pd (platform design) package mismatch.

## Reference documentation
- [pd.sugar.cane Reference Manual](./references/reference_manual.md)
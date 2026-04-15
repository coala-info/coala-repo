---
name: bioconductor-pd.clariom.s.mouse.ht
description: This package provides platform design and probe sequence information for the Clariom S Mouse HT microarray. Use when user asks to process Clariom S Mouse HT CEL files, map raw intensity data to probes, or access probe sequences for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.clariom.s.mouse.ht.html
---

# bioconductor-pd.clariom.s.mouse.ht

## Overview

The `pd.clariom.s.mouse.ht` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the essential platform design information for the Clariom S Mouse HT microarray. This package is primarily a dependency for the `oligo` package, which uses it to map raw intensity data (CEL files) to specific probes and genes during preprocessing and normalization.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be invoked manually:

```r
library(pd.clariom.s.mouse.ht)
```

### 2. Integration with oligo
When analyzing Clariom S Mouse HT data, use `read.celfiles` from the `oligo` package. The `oligo` package will identify the correct `pd` (platform design) package to use for the specific chip type.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(filenames = list.celfiles())

# The 'raw_data' object will now use pd.clariom.s.mouse.ht for mapping
# To perform RMA normalization:
eset <- rma(raw_data)
```

### 3. Accessing Probe Sequences
You can access the sequence data for Perfect Match (PM) probes, which is useful for custom quality control or sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID in the platform design
```

## Data Objects

- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes. It includes the feature ID (`fid`) and the actual nucleotide `sequence`.
- **bgSequence**: Sequence data for background probes (if available).
- **mmSequence**: Sequence data for Mismatch probes (if applicable to the design).

## Tips for Usage

- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient RAM when working with high-throughput (HT) datasets.
- **Annotation Mapping**: While this package provides the physical layout and probe sequences, for gene-level annotations (symbols, GO terms, etc.), you should typically use the corresponding `clariomsmouseht.db` package in conjunction with `limma` or `annotate`.
- **Platform Verification**: If `oligo` fails to recognize the array, verify that the `pkgname` in the CEL file headers matches "pd.clariom.s.mouse.ht".

## Reference documentation

- [pd.clariom.s.mouse.ht Reference Manual](./references/reference_manual.md)
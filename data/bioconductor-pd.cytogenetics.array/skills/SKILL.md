---
name: bioconductor-pd.cytogenetics.array
description: This package provides annotation data and platform design information for Affymetrix Cytogenetics arrays. Use when user asks to process Affymetrix Cytogenetics array data, map probe identifiers to sequences, or provide the annotation backend for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.cytogenetics.array.html
---


# bioconductor-pd.cytogenetics.array

name: bioconductor-pd.cytogenetics.array
description: Annotation package for the pd.cytogenetics.array platform. Use when processing Affymetrix Cytogenetics array data with the oligo package to map probe identifiers to sequences and genomic coordinates.

# bioconductor-pd.cytogenetics.array

## Overview

The `pd.cytogenetics.array` package is a specialized annotation data package built using `pdInfoBuilder`. It provides the necessary infrastructure to analyze Affymetrix Cytogenetics arrays within the Bioconductor ecosystem. It is designed to work seamlessly with the `oligo` package, which handles the preprocessing and analysis of oligonucleotide arrays.

This package primarily contains the platform design information, including probe sequences and feature identifiers required for low-level analysis.

## Workflow and Usage

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be invoked directly:

```r
library(pd.cytogenetics.array)
```

### Accessing Probe Sequences
The package stores sequence data for Perfect Match (PM) probes. This is essential for algorithms that account for sequence-specific binding affinities.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with oligo
The most common use case is providing the annotation backend for `oligo` functions like `read.celfiles`.

```r
library(oligo)

# Read CEL files; oligo uses pd.cytogenetics.array to interpret the platform
affyRaw <- read.celfiles(filenames = list.celfiles())

# The annotation slot will refer to this package
annotation(affyRaw)
```

### Data Structures
- **pmSequence**: A `DataFrame` containing:
  - `fid`: Feature identifier.
  - `sequence`: The actual nucleotide sequence for the probe.
- **bgSequence / mmSequence**: Depending on the specific array design, background or mismatch sequences may also be accessible via the same data loading mechanism.

## Tips
- Ensure the version of `pd.cytogenetics.array` matches the specific array hardware used in the experiment.
- This package is a "data package" and does not contain high-level analysis functions; use it as a dependency for `oligo` or `crlmm`.
- If you need to find the physical location of probes on the array, use the `getGeometry()` functions provided by the `oligo` package while this annotation is loaded.

## Reference documentation
- [pd.cytogenetics.array Reference Manual](./references/reference_manual.md)
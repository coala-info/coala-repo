---
name: bioconductor-pd.porcine
description: This package provides platform design information and probe sequences for the Affymetrix Porcine Genome Array. Use when user asks to process porcine microarray data, map probe identifiers to sequences, or load platform design information for the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.porcine.html
---


# bioconductor-pd.porcine

name: bioconductor-pd.porcine
description: Annotation package for the Affymetrix Porcine Genome Array. Use this skill when processing porcine (pig) microarray data using the oligo or xps packages, specifically for mapping probe identifiers to sequences and managing chip layout information.

# bioconductor-pd.porcine

## Overview
The `pd.porcine` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Porcine Genome Array. It is primarily designed to work as a backend for the `oligo` package to enable preprocessing, normalization, and analysis of porcine-specific oligonucleotide microarrays.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be invoked manually:

```r
library(pd.porcine)
```

### 2. Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID on the array
```

### 3. Integration with oligo
The most common use case is providing the annotation database for `read.celfiles`.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(filenames = list.celfiles(), pkgname = "pd.porcine")

# Perform RMA normalization using the platform design info
eset <- rma(raw_data)
```

## Data Structures
- **pmSequence**: A `DataFrame` object.
  - `fid`: Feature identifier.
  - `sequence`: The actual nucleotide sequence for the probe.
- **bgSequence / mmSequence**: Depending on the specific array design, background or mismatch sequences may be available via the same `data()` mechanism if defined in the platform design.

## Tips
- This package is a "pdInfoPackage." It does not contain functional annotations (like Gene Symbols or GO terms); for those, use the corresponding organic annotation package such as `porcine.db`.
- Ensure the `oligo` package is installed to make full use of the platform design objects contained here.

## Reference documentation
- [pd.porcine Reference Manual](./references/reference_manual.md)
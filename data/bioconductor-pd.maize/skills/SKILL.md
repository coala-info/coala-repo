---
name: bioconductor-pd.maize
description: This package provides platform design and annotation information for the Affymetrix Maize Genome Array. Use when user asks to process maize microarray data, map probe IDs to sequences, or perform preprocessing and normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.maize.html
---

# bioconductor-pd.maize

name: bioconductor-pd.maize
description: Annotation package for the Affymetrix Maize Genome Array. Use when processing maize microarray data with the oligo package, specifically for mapping probe IDs to sequences and managing platform design information.

# bioconductor-pd.maize

## Overview
The `pd.maize` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the platform design information required to analyze Affymetrix Maize Genome Arrays. It is designed to work seamlessly with the `oligo` package to facilitate high-level analysis of oligonucleotide arrays, including preprocessing, normalization, and quality control.

## Typical Workflow

### 1. Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo::read.celfiles()`, but can be loaded manually:

```r
library(pd.maize)
```

### 2. Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is useful for sequence-specific preprocessing methods or GC-content analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)
```

### 3. Integration with oligo
The primary use case is providing the underlying database for `FeatureSet` objects created from maize arrays.

```r
library(oligo)

# Example: Reading CEL files (assuming .CEL files are in the working directory)
# The pd.maize package must be installed for this to succeed
affyData <- read.celfiles(filenames = list.celfiles())

# The annotation slot will be set to "pd.maize"
annotation(affyData)
```

## Usage Tips
- **Memory Management**: Annotation packages like `pd.maize` use SQLite databases internally. Ensure you have sufficient disk space in your R temporary directory.
- **Probe Types**: While the package primarily focuses on `pmSequence`, it also contains placeholders or data for background (`bgSequence`) and mismatch (`mmSequence`) probes where applicable to the platform design.
- **Compatibility**: Always ensure the version of `pd.maize` matches the Bioconductor release used for the `oligo` package to avoid schema mismatches.

## Reference documentation
- [pd.maize Reference Manual](./references/reference_manual.md)
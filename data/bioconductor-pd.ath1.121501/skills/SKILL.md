---
name: bioconductor-pd.ath1.121501
description: This package provides annotation data and infrastructure for processing Affymetrix ATH1-121501 Arabidopsis Thaliana microarray chips. Use when user asks to preprocess CEL files, map probes to sequences, or perform sequence-level analysis for the ATH1-121501 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ath1.121501.html
---


# bioconductor-pd.ath1.121501

## Overview

The `pd.ath1.121501` package is a specialized Bioconductor annotation data package. It provides the necessary infrastructure to process Affymetrix ATH1-121501 (Arabidopsis Thaliana) microarray chips. It is primarily designed to work as a backend for the `oligo` package, enabling the preprocessing, feature selection, and sequence-level analysis of CEL files.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be invoked directly:

```r
library(pd.ath1.121501)
```

### 2. Integration with oligo
When analyzing ATH1-121501 data, this package provides the platform design information required by `read.celfiles()`:

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
# The 'pd.ath1.121501' package is used internally to map probes
```

### 3. Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific probe sequence by feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

## Key Data Objects

- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes. It includes:
    - `fid`: The feature identifier.
    - `sequence`: The actual nucleotide sequence.
- **bgSequence / mmSequence**: Depending on the specific chip architecture, background or Mismatch (MM) sequences may be referenced via the same data interface.

## Usage Tips

- **Memory Management**: These annotation packages can be large. Ensure you have sufficient RAM when loading large datasets with `oligo`.
- **Platform Specificity**: This package is strictly for the ATH1-121501 array. For other Arabidopsis arrays (like the AG array), different `pd.db` packages are required.
- **Database Connection**: The package acts as an interface to a SQLite database. Advanced users can access the underlying DB using `db(pd.ath1.121501)` if needed for complex SQL queries on probe locations.

## Reference documentation

- [pd.ath1.121501 Reference Manual](./references/reference_manual.md)
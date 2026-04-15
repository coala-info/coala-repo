---
name: bioconductor-pd.mirna.3.1
description: This package provides annotation and platform design metadata for the Affymetrix miRNA 3.1 array. Use when user asks to process miRNA 3.1 expression data, map probe IDs to sequences, or perform normalization and feature-level analysis using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mirna.3.1.html
---

# bioconductor-pd.mirna.3.1

name: bioconductor-pd.mirna.3.1
description: Annotation package for the Affymetrix miRNA 3.1 array. Use when processing miRNA 3.1 expression data in R, specifically for mapping probe IDs to sequences or when using the oligo package for preprocessing, normalization, and feature-level analysis.

# bioconductor-pd.mirna.3.1

## Overview
The `pd.mirna.3.1` package is a Bioconductor annotation (Platform Design) package for the Affymetrix miRNA 3.1 array. It was built using the `pdInfoBuilder` package and is primarily designed to work in tandem with the `oligo` package to provide the necessary metadata for analyzing microRNA expression data.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.mirna.3.1")
```

## Typical Workflow

### 1. Loading Data with oligo
The most common use case for this package is as a backend for the `oligo` package when reading CEL files. You do not usually need to call functions from `pd.mirna.3.1` directly; `oligo` detects and loads it automatically.

```r
library(oligo)

# Read CEL files; the package will be used automatically if the array type matches
raw_data <- read.celfiles(filenames = list.celfiles())

# Inspect the object to ensure the correct pd package is assigned
print(raw_data)
```

### 2. Accessing Probe Sequences
If you need to retrieve the actual nucleotide sequences for the Perfect Match (PM) probes on the array, you can load the `pmSequence` dataset.

```r
library(pd.mirna.3.1)
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with columns 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### 3. Manual Assignment
If `oligo` fails to automatically detect the platform, you can specify it manually:

```r
raw_data <- read.celfiles(filenames = list.celfiles(), pkgname = "pd.mirna.3.1")
```

## Key Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for PM probes.
- **bgSequence**: Sequence data for background probes (if available).
- **mmSequence**: Sequence data for Mismatch (MM) probes (if available).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when loading large sets of CEL files.
- **Dependency**: This package is a "data" package. It does not contain analysis functions, only the mapping and sequence information required by analysis engines like `oligo`.

## Reference documentation
- [pd.mirna.3.1 Reference Manual](./references/reference_manual.md)
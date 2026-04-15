---
name: bioconductor-pd.soybean
description: This package provides annotation data and probe sequences for the Affymetrix Soybean Genome Array. Use when user asks to process soybean microarray CEL files, map probe identifiers to sequences, or perform platform-specific preprocessing using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.soybean.html
---

# bioconductor-pd.soybean

name: bioconductor-pd.soybean
description: Annotation data package for the Soybean Genome Array. Use when processing Affymetrix soybean microarray data with the oligo package, specifically for mapping probe identifiers to sequences and performing platform-specific preprocessing.

# bioconductor-pd.soybean

## Overview
The `pd.soybean` package is a specialized annotation dataset built using `pdInfoBuilder`. It provides the necessary infrastructure for the `oligo` package to analyze Affymetrix Soybean Genome Arrays. It contains probe sequence information and feature-level metadata required for background correction, normalization, and summarization of soybean CEL files.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be invoked manually:
```r
library(pd.soybean)
```

### 2. Integration with oligo
The primary use case is providing the platform design information to `oligo` functions:
```r
library(oligo)
# Read CEL files - oligo uses pd.soybean automatically if the chip type is recognized
raw_data <- read.celfiles(filenames = list.celfiles())

# The annotation slot will refer to pd.soybean
annotation(raw_data)
```

### 3. Accessing Probe Sequences
You can access Perfect Match (PM) probe sequences for custom analysis or validation:
```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
pmSequence[pmSequence$fid == 12345, ]
```

### 4. Data Objects
The package provides several data objects containing sequence information:
- `pmSequence`: Sequences for Perfect Match probes.
- `mmSequence`: Sequences for Mismatch probes (if present on the array).
- `bgSequence`: Sequences for background probes.

## Usage Tips
- **Memory Management**: These annotation objects can be large. Only load `pmSequence` if you specifically need to analyze the nucleotide sequences.
- **Automatic Selection**: Ensure `pd.soybean` is installed; `oligo` will search for it by name based on the CEL file header. If `oligo` cannot find it, install it via `BiocManager::install("pd.soybean")`.
- **Compatibility**: This package is designed for the `oligo` and `DBI` frameworks, not the older `affy` package (which uses CDF environments).

## Reference documentation
- [pd.soybean Reference Manual](./references/reference_manual.md)
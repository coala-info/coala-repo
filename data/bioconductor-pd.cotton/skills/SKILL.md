---
name: bioconductor-pd.cotton
description: This package provides platform design metadata and probe sequence information for Affymetrix cotton microarrays. Use when user asks to preprocess cotton microarray data, access probe sequences for cotton arrays, or analyze Affymetrix cotton CEL files using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.cotton.html
---


# bioconductor-pd.cotton

## Overview
The `pd.cotton` package is a Bioconductor annotation package specifically built using `pdInfoBuilder`. It serves as a platform design (PD) package for cotton microarrays. Its primary role is to provide the necessary metadata and sequence information required by the `oligo` package to preprocess and analyze Affymetrix cotton arrays.

## Typical Workflow

### 1. Loading the Package
The package is typically loaded automatically when using `oligo` functions like `read.celfiles()`, but it can be loaded manually:

```r
library(pd.cotton)
```

### 2. Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific columns
# fid: Feature ID
# sequence: The actual nucleotide sequence
```

### 3. Integration with oligo
This package is designed to work behind the scenes. When you read CEL files for cotton arrays, `oligo` looks for `pd.cotton` to understand the chip layout.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(filenames = list.celfiles())

# The annotation slot of the resulting object will be set to "pd.cotton"
annotation(raw_data)
```

## Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for the Perfect Match probes.
- `bgSequence`: Background sequences (if applicable, accessed via `data(pmSequence)`).
- `mmSequence`: Mismatch sequences (if applicable, accessed via `data(pmSequence)`).

## Tips
- **Memory Management**: These annotation objects can be large. Only load `pmSequence` if you specifically need to analyze the probe sequences.
- **Dependencies**: Ensure the `oligo` package is installed, as `pd.cotton` is functionally dependent on it for microarray data processing.

## Reference documentation
- [pd.cotton Reference Manual](./references/reference_manual.md)
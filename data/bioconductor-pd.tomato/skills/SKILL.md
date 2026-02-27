---
name: bioconductor-pd.tomato
description: This package provides annotation data and platform design information for the Affymetrix Tomato Genome Array. Use when user asks to process tomato microarray data, map probe identifiers to sequences, or manage metadata for the Solanum lycopersicum genome array using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.tomato.html
---


# bioconductor-pd.tomato

name: bioconductor-pd.tomato
description: Provides annotation data for the Solanum lycopersicum (Tomato) Genome Array. Use this skill when working with the 'oligo' package to process Affymetrix tomato microarrays, specifically for mapping probe identifiers to sequences and managing platform-specific metadata.

# bioconductor-pd.tomato

## Overview
The `pd.tomato` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It serves as the platform design (PD) package for the Affymetrix Tomato Genome Array. Its primary role is to provide the `oligo` package with the necessary mapping between feature identifiers (fids), probe sequences, and their physical locations on the microarray.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.tomato")
```

## Typical Workflow
This package is rarely called directly by the user; instead, it is automatically loaded by the `oligo` package when reading CEL files from the Tomato Genome Array.

### 1. Loading the Package
```r
library(pd.tomato)
```

### 2. Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for sequence-specific background correction or quality control.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

### 3. Integration with oligo
When analyzing tomato microarray data, ensure `pd.tomato` is installed so `read.celfiles` can correctly annotate the resulting `FeatureSet` object.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The 'annotation' slot of raw_data will be set to "pd.tomato"
print(annotation(raw_data))
```

## Data Objects
- `pmSequence`: A `DataFrame` containing the probe sequences.
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable to the array design).
- `bgSequence`: Sequence data for background probes.

## Tips
- **Memory Management**: These annotation objects can be large. Only load `pmSequence` if you need to perform manual sequence analysis.
- **Platform Consistency**: Ensure the CEL files you are analyzing were actually produced by the Affymetrix Tomato Genome Array; using the wrong `pd` package will result in incorrect mapping.

## Reference documentation
- [pd.tomato Reference Manual](./references/reference_manual.md)
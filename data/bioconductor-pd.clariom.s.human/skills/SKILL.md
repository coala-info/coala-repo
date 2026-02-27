---
name: bioconductor-pd.clariom.s.human
description: This package provides annotation data and probe-to-sequence mappings for the Affymetrix Clariom S Human microarray platform. Use when user asks to process Clariom S Human CEL files, map probe identifiers to sequences, or provide platform-specific metadata for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.clariom.s.human.html
---


# bioconductor-pd.clariom.s.human

name: bioconductor-pd.clariom.s.human
description: Annotation package for the Affymetrix Clariom S Human array. Use when processing Clariom S Human microarray data with the oligo package to map probe identifiers to sequences and provide platform-specific metadata.

# bioconductor-pd.clariom.s.human

## Overview
The `pd.clariom.s.human` package is a Bioconductor annotation data package specifically designed for the Affymetrix Clariom S Human platform. It is built using `pdInfoBuilder` and is intended to be used as a backend for the `oligo` package to facilitate the preprocessing and analysis of Clariom S CEL files. It contains essential mapping information between feature identifiers (fids) and probe sequences.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but can be loaded manually:

```r
library(pd.clariom.s.human)
```

### Integration with oligo
The primary use case is during the initialization of a FeatureSet object. When you use `read.celfiles()`, `oligo` looks for this package to understand the chip layout.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
# The annotation slot will be set to "pd.clariom.s.human"
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Filter for a specific feature ID
specific_probe <- pmSequence[pmSequence$fid == 12345, ]
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Background probe sequences (if applicable, accessed via the same data call).
- `mmSequence`: Mismatch probe sequences (if applicable).

## Tips
- **Memory Management**: These annotation objects can be large. Ensure your R session has sufficient memory when working with high-density Clariom S arrays.
- **Automatic Detection**: If `read.celfiles()` fails to find the annotation, manually set the `pkgname` argument or ensure this package is installed via `BiocManager::install("pd.clariom.s.human")`.
- **Platform Specificity**: This package is strictly for the "S" (Standard) version of the Clariom Human array. Do not use it for Clariom D (Deep) or other species.

## Reference documentation
- [pd.clariom.s.human Reference Manual](./references/reference_manual.md)
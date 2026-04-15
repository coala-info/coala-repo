---
name: bioconductor-pd.bsubtilis
description: This package provides annotation data and probe sequence mappings for Bacillus subtilis oligonucleotide microarrays to support analysis with the oligo package. Use when user asks to analyze Bacillus subtilis microarray data, access probe sequences for background correction, or map feature identifiers to nucleotide sequences.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.bsubtilis.html
---

# bioconductor-pd.bsubtilis

## Overview
The `pd.bsubtilis` package is a specialized annotation data package for *Bacillus subtilis*. It was built using the `pdInfoBuilder` framework and is designed to be used primarily with the `oligo` package to facilitate the analysis of oligonucleotide microarrays. It provides the necessary mapping between feature identifiers (fids) and their corresponding nucleotide sequences.

## Typical Workflow

### Loading the Package
To use the annotation data, load the package alongside the `oligo` package:

```r
library(oligo)
library(pd.bsubtilis)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is often used for background correction or sequence-specific analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific columns
# pmSequence$fid
# pmSequence$sequence
```

### Integration with oligo
When reading CEL files for *B. subtilis* arrays, the `oligo` package automatically looks for this package to create a FeatureSet object.

```r
# Example of reading CEL files (assuming they are in the working directory)
# celFiles <- list.celfiles()
# data <- read.celfiles(celFiles)
# The 'data' object will automatically use pd.bsubtilis for annotation
```

## Key Data Objects
- **pmSequence**: A `DataFrame` object containing the sequences for PM probes. It has two primary columns:
    - `fid`: The feature identifier.
    - `sequence`: The actual nucleotide sequence of the probe.
- **bgSequence / mmSequence**: Depending on the specific array design, background or mismatch sequences may also be accessible via the same data loading mechanism if present in the platform design.

## Tips
- This package is a "Platform Design" (PD) package. It is not intended for manual browsing of gene annotations but rather as a backend for the `oligo` package's preprocessing functions (like `rma`).
- Ensure the version of `pd.bsubtilis` matches the array type used in your experiment to avoid mapping errors.

## Reference documentation
- [pd.bsubtilis Reference Manual](./references/reference_manual.md)
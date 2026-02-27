---
name: bioconductor-pd.celegans
description: This package provides platform design and annotation data for the C. elegans genome array. Use when user asks to process Affymetrix GeneChip data for C. elegans, retrieve probe sequences, or map feature IDs using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.celegans.html
---


# bioconductor-pd.celegans

name: bioconductor-pd.celegans
description: Annotation package for the C. elegans (Caenorhabditis elegans) genome array. Use this skill when processing Affymetrix GeneChip data for C. elegans using the oligo or biostrings packages, specifically for retrieving probe sequences, mapping feature IDs (fid), and managing platform design information.

# bioconductor-pd.celegans

## Overview
The `pd.celegans` package is a specialized annotation dataset built with `pdInfoBuilder`. It provides the necessary platform design information for the C. elegans genome array. It is primarily designed to work as a backend for the `oligo` package to facilitate the preprocessing and analysis of oligonucleotide microarrays.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.celegans")
```

## Typical Workflow

### Loading the Package
```r
library(pd.celegans)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for sequence-specific background correction or probe effect modeling.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' refers to the feature ID on the array
```

### Integration with oligo
This package is usually not called directly by the user for high-level analysis but is loaded automatically by the `oligo` package when reading CEL files for C. elegans.

```r
library(oligo)

# When reading CEL files, oligo identifies the platform and looks for pd.celegans
# celfiles <- read.celfiles(filenames)
# fit <- rma(celfiles)
```

## Data Structures
- **pmSequence**: A `DataFrame` object.
  - `fid`: Feature Identifier (numeric).
  - `sequence`: The actual nucleotide sequence (character).

## Tips
- **Memory Management**: Annotation packages can be large. If you only need probe sequences, you can load `pmSequence` specifically, but for full normalization, ensure you have enough RAM for the `oligo` objects.
- **Platform Matching**: Ensure your CEL files are indeed from the C. elegans platform; otherwise, `oligo` will throw an error if it cannot find the matching `pd.package`.

## Reference documentation
- [pd.celegans Reference Manual](./references/reference_manual.md)
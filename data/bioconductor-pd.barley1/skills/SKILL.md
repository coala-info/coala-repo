---
name: bioconductor-pd.barley1
description: This package provides platform design and annotation data for the Affymetrix Barley1 Genome Array. Use when user asks to process Barley1 microarray data, map probe identifiers to sequences, or perform preprocessing and normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.barley1.html
---


# bioconductor-pd.barley1

name: bioconductor-pd.barley1
description: Annotation package for the Affymetrix Barley1 Genome Array. Use this skill when processing Barley1 microarray data in R, specifically for mapping probe identifiers to sequences and providing platform-specific annotation for the 'oligo' package.

# bioconductor-pd.barley1

## Overview
The `pd.barley1` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Barley1 Genome Array. It is primarily designed to work as a backend for the `oligo` package to enable the preprocessing, normalization, and analysis of Barley1 microarrays.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.barley1")
```

## Typical Workflow
The package is usually loaded automatically when reading CEL files using the `oligo` package. However, you can interact with its data directly.

### Loading the Package
```r
library(pd.barley1)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, which is essential for sequence-specific background correction methods (like RMA or GCRMA).

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific columns
# 'fid' corresponds to the feature ID on the array
# 'sequence' provides the 25bp oligonucleotide sequence
```

### Integration with oligo
When analyzing Barley1 data, the `oligo` package uses `pd.barley1` to create a `FeatureSet` object.

```r
library(oligo)

# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The 'pd.barley1' package provides the annotation slot automatically
# You can verify the annotation:
annotation(raw_data)
```

## Data Objects
- `pmSequence`: A `DataFrame` object containing the sequences for the PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Memory Management**: Annotation packages can be large. If you only need probe sequences, load `data(pmSequence)` rather than the entire `oligo` workflow.
- **Platform Matching**: Ensure your CEL files are specifically from the Affymetrix Barley1 array; using this package with other barley arrays (like Barley GeneChip) will result in incorrect mapping.

## Reference documentation
- [pd.barley1 Reference Manual](./references/reference_manual.md)
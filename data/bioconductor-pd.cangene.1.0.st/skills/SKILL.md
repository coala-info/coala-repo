---
name: bioconductor-pd.cangene.1.0.st
description: This package provides platform design and annotation data for the Affymetrix CanGene 1.0 ST microarray. Use when user asks to process CanGene 1.0 ST microarray data, map probe identifiers to sequences, or perform normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.cangene.1.0.st.html
---

# bioconductor-pd.cangene.1.0.st

name: bioconductor-pd.cangene.1.0.st
description: Annotation package for the Affymetrix CanGene 1.0 ST array. Use when processing CanGene 1.0 ST microarray data in R, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.cangene.1.0.st

## Overview

The `pd.cangene.1.0.st` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix CanGene 1.0 ST array. This package is primarily designed to work as a backend for the `oligo` package to facilitate the preprocessing, normalization, and analysis of ST (Sense Target) gene expression microarrays.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.cangene.1.0.st)
```

### Integration with oligo
The most common use case is providing the annotation database for `oligo` functions like `read.celfiles()`.

```r
library(oligo)

# Read CEL files; oligo uses pd.cangene.1.0.st automatically if the platform is detected
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is useful for sequence-specific analysis or quality control.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID in the featureData
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the feature ID (`fid`) and the corresponding nucleotide sequence for PM probes.
- `bgSequence`: Background probe sequences (if applicable, accessed via the same dataset).
- `mmSequence`: Mismatch probe sequences (if applicable, though ST arrays primarily use PM probes).

## Tips
- **Memory Management**: Annotation packages can be large. Ensure you have sufficient RAM when processing large batches of CEL files.
- **Platform Matching**: This package is specific to the "cangene.1.0.st" array. If you are using a different Affymetrix ST array (like Human, Mouse, or Rat Gene ST), you will need the corresponding `pd.gene.x.x.st` package.
- **Database Connection**: The package stores metadata in an SQLite database. You can access the underlying connection if advanced querying is required using `db(pd.cangene.1.0.st)`.

## Reference documentation

- [pd.cangene.1.0.st Reference Manual](./references/reference_manual.md)
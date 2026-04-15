---
name: bioconductor-pd.cyrgene.1.0.st
description: This package provides annotation data and metadata for the Affymetrix CyrGene-1_0-st expression array. Use when user asks to process CyrGene ST array data, map probe identifiers to sequences, or perform normalization and background correction using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.cyrgene.1.0.st.html
---

# bioconductor-pd.cyrgene.1.0.st

name: bioconductor-pd.cyrgene.1.0.st
description: Annotation package for the CyrGene-1_0-st array. Use when processing Affymetrix/CyrGene ST (Sense Target) expression data in R, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.cyrgene.1.0.st

## Overview
The `pd.cyrgene.1.0.st` package is a Bioconductor annotation data package. It provides the necessary infrastructure to process and analyze raw data from the CyrGene-1_0-st array. It is designed to work seamlessly with the `oligo` package to handle platform-specific tasks such as background correction, normalization, and summarization of ST-type arrays.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.cyrgene.1.0.st)
```

### Integration with oligo
The primary use case is providing the annotation backend for `FeatureSet` objects. When reading CEL files, `oligo` identifies the chip type and looks for this package.

```r
library(oligo)

# Read CEL files (the pd package is used internally)
raw_data <- read.celfiles(filenames = list.celfiles())

# The annotation slot will refer to pd.cyrgene.1.0.st
annotation(raw_data)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, which is essential for algorithms that account for sequence-specific binding effects (like GCRMA or specific probe-level models).

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID on the array
```

### Key Data Objects
- `pmSequence`: A `DataFrame` containing the feature ID (`fid`) and the corresponding nucleotide sequence for PM probes.
- `bgSequence`: (If available) Sequence data for background probes.
- `mmSequence`: (If available) Sequence data for Mismatch probes (rare in ST arrays).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when performing probe-level preprocessing.
- **Database Connection**: The package uses an SQLite database to store mappings. You can interact with the underlying database using `db(pd.cyrgene.1.0.st)` if advanced metadata extraction is required.
- **ST Array Specifics**: As an "ST" (Sense Target) array package, it is optimized for the whole-transcriptome approach where probes are spread across the entire length of the gene.

## Reference documentation
- [pd.cyrgene.1.0.st Reference Manual](./references/reference_manual.md)
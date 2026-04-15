---
name: bioconductor-pd.cyrgene.1.1.st
description: This package provides platform design and annotation data for the CyrGene 1.1 ST Affymetrix microarray. Use when user asks to process CyrGene 1.1 ST expression data, map probe identifiers to sequences, or provide backend design information for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.cyrgene.1.1.st.html
---

# bioconductor-pd.cyrgene.1.1.st

name: bioconductor-pd.cyrgene.1.1.st
description: Annotation package for the CyrGene-1_1-st Affymetrix array. Use when processing CyrGene 1.1 ST expression data with the oligo package, specifically for mapping probe identifiers to sequences and managing platform-specific design information.

# bioconductor-pd.cyrgene.1.1.st

## Overview
The `pd.cyrgene.1.1.st` package is a Bioconductor annotation data package built using `pdInfoBuilder`. It provides the necessary platform design information for the CyrGene 1.1 ST array. This package is primarily intended to be used as a backend for the `oligo` package to enable the preprocessing and analysis of CEL files from this specific microarray platform.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be called directly:

```r
library(pd.cyrgene.1.1.st)
```

### Integration with oligo
The most common workflow involves using this package to provide the annotation environment for feature-level preprocessing (like RMA):

```r
library(oligo)
# Assuming .CEL files are in the working directory
raw_data <- read.celfiles(filenames = list.celfiles())
# oligo uses pd.cyrgene.1.1.st to identify probe locations and types
```

### Accessing Sequence Data
The package contains sequence information for Perfect Match (PM) probes, which is useful for sequence-specific background correction or quality control.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID on the array
```

### Data Objects
- `pmSequence`: A `DataFrame` object containing the sequences for PM probes.
- `bgSequence`: Background probe sequences (if available via the `data(pmSequence)` call).
- `mmSequence`: Mismatch probe sequences (if applicable to the design).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when loading large datasets with `oligo`.
- **Platform Matching**: This package is specific to the "CyrGene-1_1-st" design. Ensure your CEL files match this platform by checking the `notes(raw_data)` or the header of the CEL files.
- **Annotation**: For higher-level annotation (mapping probes to Gene Symbols or Entrez IDs), use this package in conjunction with the corresponding transcript-level annotation packages (e.g., `cyrgene11sttranscriptcluster.db`).

## Reference documentation
- [pd.cyrgene.1.1.st Reference Manual](./references/reference_manual.md)
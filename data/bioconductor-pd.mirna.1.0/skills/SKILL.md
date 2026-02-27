---
name: bioconductor-pd.mirna.1.0
description: This package provides platform design and annotation data for the Affymetrix miRNA 1.0 Array. Use when user asks to analyze miRNA microarray data, map probes to physical locations, or access probe sequence information using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mirna.1.0.html
---


# bioconductor-pd.mirna.1.0

name: bioconductor-pd.mirna.1.0
description: Annotation package for the Affymetrix miRNA 1.0 Array. Use when analyzing miRNA microarray data to provide platform-specific design information, probe sequences, and feature mapping, typically in conjunction with the oligo package.

# bioconductor-pd.mirna.1.0

## Overview
The `pd.mirna.1.0` package is a Bioconductor annotation resource providing the platform design information for the Affymetrix miRNA 1.0 Array. It was generated using the `pdInfoBuilder` package and is specifically designed to work with the `oligo` package for the analysis of high-density oligonucleotide arrays.

This package contains the mapping between probe identifiers and their physical locations on the array, as well as sequence information for perfect match (PM) probes.

## Usage

### Loading the Package
The package is typically loaded automatically by `oligo` when processing miRNA 1.0 CEL files, but it can be loaded manually:

```r
library(pd.mirna.1.0)
```

### Integration with oligo
The primary workflow involves using this package as a backend for `oligo` functions. When reading CEL files, `oligo` identifies the array type and searches for this annotation package:

```r
library(oligo)
# Read CEL files; pd.mirna.1.0 is used automatically if the platform matches
raw_data <- read.celfiles(filenames = list.celfiles())
```

### Accessing Probe Sequences
You can access the sequence data for the Perfect Match (PM) probes stored within the package. This is useful for custom sequence-based filtering or analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences by feature ID
# pmSequence is a DataFrame object
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the feature ID (`fid`) and the corresponding nucleotide sequence for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for mismatch probes (if applicable).

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
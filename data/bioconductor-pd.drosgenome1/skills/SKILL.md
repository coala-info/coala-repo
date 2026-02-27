---
name: bioconductor-pd.drosgenome1
description: This package provides platform design annotation data for the Affymetrix Drosophila Genome 1.0 Array. Use when user asks to process Drosophila Genome 1.0 Array expression data, perform low-level preprocessing with the oligo package, or access probe-specific sequence information.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.drosgenome1.html
---


# bioconductor-pd.drosgenome1

name: bioconductor-pd.drosgenome1
description: Annotation package for the Affymetrix Drosophila Genome 1.0 Array. Use when processing Drosophila Genome 1.0 Array expression data using the oligo package, specifically for low-level preprocessing, probe-to-sequence mapping, and platform-specific annotation.

# bioconductor-pd.drosgenome1

## Overview

The `pd.drosgenome1` package is a platform design (pdInfo) annotation package for the Affymetrix Drosophila Genome 1.0 Array. It was built using the `pdInfoBuilder` infrastructure and is designed to work seamlessly with the `oligo` package for the analysis of oligonucleotide arrays. It contains the mapping between probe identifiers, their physical locations on the chip, and their nucleotide sequences.

## Package Usage

### Integration with oligo

This package is rarely called directly by the user. Instead, it serves as a backend dependency for the `oligo` package. When you load CEL files from the Drosophila Genome 1.0 platform, `oligo` will automatically detect and use this package.

```r
library(oligo)

# Read CEL files; pd.drosgenome1 is automatically utilized
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences

If you need to perform sequence-specific analysis (such as GC-content correction or probe-level studies), you can load the probe sequence data directly.

```r
library(pd.drosgenome1)

# Load the PM (Perfect Match) sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)
```

### Key Data Objects

- **pmSequence**: A `DataFrame` object containing the sequences for Perfect Match probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (if applicable).

## Workflow Tips

1. **Automatic Loading**: Ensure `pd.drosgenome1` is installed. The `oligo` package will attempt to load it automatically when it encounters Drosophila Genome 1.0 Array data.
2. **Memory Management**: These annotation objects can be large. If working with limited RAM, ensure you only load the data objects (like `pmSequence`) when necessary.
3. **Feature IDs**: The `fid` column in the sequence data frames corresponds to the feature identifiers used in the `FeatureSet` objects created by `oligo`.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
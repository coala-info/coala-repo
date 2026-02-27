---
name: bioconductor-pd.medgene.1.1.st
description: This package provides annotation and platform design information for the Affymetrix MedGene 1.1 ST array. Use when user asks to process MedGene 1.1 ST expression data, map probe identifiers to sequences, or perform feature-level preprocessing using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.medgene.1.1.st.html
---


# bioconductor-pd.medgene.1.1.st

name: bioconductor-pd.medgene.1.1.st
description: Annotation and platform design information for the MedGene 1.1 ST array. Use when processing Affymetrix/Thermo Fisher MedGene 1.1 ST expression data, specifically for mapping probe identifiers to sequences and managing chip layout information within the oligo or biomaRt frameworks.

# bioconductor-pd.medgene.1.1.st

## Overview
The `pd.medgene.1.1.st` package is a Bioconductor annotation package built using `pdInfoBuilder`. It provides the essential platform design (PD) information required to analyze MedGene 1.1 ST arrays. It is primarily designed to work as a backend for the `oligo` package to facilitate feature-level preprocessing, normalization, and sequence-specific analysis.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be invoked directly:
```r
library(pd.medgene.1.1.st)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, which is critical for background correction methods like RMA or GCRMA that utilize sequence composition.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific probe sequences by feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

### Integration with oligo
This package provides the infrastructure for `read.celfiles()`. When analyzing MedGene 1.1 ST data, ensure this package is installed so `oligo` can correctly map the intensities to the genomic features.

```r
library(oligo)

# Read CEL files (the pd package is used automatically)
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the feature ID (`fid`) and the corresponding nucleotide sequence for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Memory Management**: These annotation objects can be large. If you only need probe-to-gene mappings and not sequences, consider using the corresponding `.db` annotation package (e.g., `medgene11sttranscriptcluster.db`) for lighter-weight metadata queries.
- **Platform Consistency**: Ensure the version of the `pd` package matches the array version used in the experiment to avoid coordinate or mapping shifts.

## Reference documentation
- [pd.medgene.1.1.st Reference Manual](./references/reference_manual.md)
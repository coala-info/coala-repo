---
name: bioconductor-pd.2006.10.31.rn34.refseq.promoter
description: This package provides platform design and annotation data for the NimbleGen rn34 RefSeq promoter microarray. Use when user asks to process raw Rat promoter array data, map probe sequences to physical locations, or perform normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.2006.10.31.rn34.refseq.promoter.html
---

# bioconductor-pd.2006.10.31.rn34.refseq.promoter

name: bioconductor-pd.2006.10.31.rn34.refseq.promoter
description: Annotation package for the NimbleGen rn34 RefSeq promoter microarray. Use when processing or analyzing Rat (rn34) RefSeq promoter array data with the oligo package to provide platform-specific design information, probe sequences, and feature mapping.

# bioconductor-pd.2006.10.31.rn34.refseq.promoter

## Overview
The `pd.2006.10.31.rn34.refseq.promoter` package is a Platform Design (PD) annotation package for the Rat (rn34) RefSeq promoter microarray. It was built using `pdInfoBuilder` and is specifically designed to work with the `oligo` package to facilitate the analysis of high-density oligonucleotide arrays. It contains the necessary metadata to map probe identifiers to their physical locations and sequences.

## Usage

### Loading the Package
Load the package into the R environment:
```R
library(pd.2006.10.31.rn34.refseq.promoter)
```

### Integration with oligo
This package is primarily used as a backend for the `oligo` package. When reading raw data files (such as .xys or .cel files), `oligo` will automatically detect and load this package if the array header matches this platform.

```R
library(oligo)
# Assuming raw data files are in the current directory
rawData <- readSignals() # or read.celfiles()
# The pd package is utilized here to structure the FeatureSet object
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored in the package:

```R
data(pmSequence)
head(pmSequence)
```
The resulting `DataFrame` contains:
- `fid`: Feature identifier.
- `sequence`: The nucleotide sequence of the probe.

Similar datasets may be available for background (`bgSequence`) or mismatch (`mmSequence`) probes depending on the array design.

## Typical Workflow
1. **Data Import**: Use `oligo::readSignals()` to import raw microarray data.
2. **Platform Identification**: The `oligo` package identifies `pd.2006.10.31.rn34.refseq.promoter` as the required annotation.
3. **Preprocessing**: Perform normalization (e.g., RMA) using the `oligo` functions which rely on this PD package for probe geometry.
4. **Sequence Analysis**: Extract probe sequences using `data(pmSequence)` if performing sequence-specific bias correction or probe-level analysis.

## Reference documentation
- [pd.2006.10.31.rn34.refseq.promoter Reference Manual](./references/reference_manual.md)
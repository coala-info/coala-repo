---
name: bioconductor-pd.rg.u34c
description: This package provides platform design and annotation data for the Affymetrix Rat Genome U34C microarray. Use when user asks to process RG-U34C microarray data, map probe identifiers to sequences, or provide platform metadata for the oligo or eeR packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rg.u34c.html
---

# bioconductor-pd.rg.u34c

name: bioconductor-pd.rg.u34c
description: Annotation package for the Rat Genome U34C (RG-U34C) Affymetrix array. Use this skill when processing RG-U34C microarray data in R, specifically for mapping probe identifiers to sequences and providing platform design information for the 'oligo' or 'eeR' packages.

# bioconductor-pd.rg.u34c

## Overview
The `pd.rg.u34c` package is a Bioconductor annotation package (Platform Design) for the Affymetrix Rat Genome U34C array. It is primarily used as a backend for the `oligo` package to facilitate the preprocessing, normalization, and analysis of high-density oligonucleotide arrays. It contains the sequence information and feature-level metadata required to map intensities to specific probes.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when using `oligo` functions on raw CEL files from this platform, but it can be loaded manually:

```r
library(pd.rg.u34c)
```

### Integration with oligo
The most common workflow involves reading CEL files. The `oligo` package uses `pd.rg.u34c` to understand the chip layout:

```r
library(oligo)
# Assuming .CEL files for RG-U34C are in the working directory
raw_data <- read.celfiles(filenames = list.celfiles())

# The platform design is automatically linked
show(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package. This is useful for custom sequence-based analysis or GC-content calculations.

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)

# Access specific columns
sequences <- pmSequence$sequence
fids <- pmSequence$fid
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for Perfect Match probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch probes (if present on the array).

## Tips
- **Memory Management**: These annotation objects can be large. Ensure you have sufficient RAM when loading multiple platform design packages.
- **Compatibility**: This package is specifically for the **U34C** version of the Rat Genome array. Ensure your CEL files match this specific revision (not U34A or U34B).
- **Annotation Mapping**: For mapping probe sets to gene symbols or Entrez IDs, use this package in conjunction with the functional annotation package `rat2302.db` or similar, depending on the specific mapping requirements.

## Reference documentation
- [pd.rg.u34c Reference Manual](./references/reference_manual.md)
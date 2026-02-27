---
name: bioconductor-pd.rhesus
description: This package provides platform design and probe sequence information for Affymetrix Rhesus Macaque microarray data. Use when user asks to process Rhesus GeneChip expression data, map probe identifiers to sequences, or provide platform design information for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rhesus.html
---


# bioconductor-pd.rhesus

name: bioconductor-pd.rhesus
description: Annotation package for the Rhesus Macaque (Macaca mulatta) genome. Use this skill when working with Affymetrix Rhesus GeneChip expression data in R, specifically for mapping probe identifiers to sequences and providing platform design information for the 'oligo' package.

# bioconductor-pd.rhesus

## Overview
The `pd.rhesus` package is a Bioconductor annotation data package built using `pdInfoBuilder`. It provides the necessary platform design information for processing Rhesus Macaque microarray data. It is primarily designed to work as a backend for the `oligo` package to enable preprocessing, normalization, and analysis of Affymetrix Rhesus arrays.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.rhesus")
```

## Typical Workflow

### Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.rhesus)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, and potentially Mismatch (MM) or Background (BG) probes, stored in `DataFrame` objects.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (columns: 'fid' and 'sequence')
head(pmSequence)

# Access specific sequences by feature ID
# pmSequence[pmSequence$fid == <feature_id>, ]
```

### Integration with oligo
The most common use case is providing the annotation environment for `read.celfiles`. The `oligo` package identifies the correct `pd.rhesus` package based on the CEL file header.

```r
library(oligo)
# Assuming CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The 'raw_data' object will now use pd.rhesus for platform-specific geometry
# You can then proceed to RMA normalization
eset <- rma(raw_data)
```

## Data Objects
- `pmSequence`: A `DataFrame` containing the probe sequences.
  - `fid`: Feature identifier (integer).
  - `sequence`: The actual nucleotide sequence (character).
- `mmSequence`: Mismatch sequences (if applicable to the specific array design).
- `bgSequence`: Background probe sequences (if applicable).

## Tips
- This package is a "Platform Design" (PD) package. It does not contain functional annotations (like Gene Symbols or GO terms). For functional mapping, use the corresponding organism-specific package (e.g., `org.Mm.eg.db` for Macaca mulatta, though often Rhesus researchers use human ortholog mapping via `org.Hs.eg.db`).
- Ensure that the version of `pd.rhesus` matches the Bioconductor release you are using to maintain compatibility with the `oligo` package.

## Reference documentation
- [pd.rhesus Reference Manual](./references/reference_manual.md)
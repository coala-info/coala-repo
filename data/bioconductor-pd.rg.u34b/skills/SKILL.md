---
name: bioconductor-pd.rg.u34b
description: This package provides platform design and annotation data for the Affymetrix Rat Genome U34B microarray. Use when user asks to process RG-U34B CEL files, map probe identifiers to sequences, or perform normalization using the oligo framework.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rg.u34b.html
---

# bioconductor-pd.rg.u34b

name: bioconductor-pd.rg.u34b
description: Annotation package for the Affymetrix Rat Genome U34B (RG-U34B) array. Use when processing RG-U34B microarray data with the 'oligo' or 'biocLite' frameworks, specifically for mapping probe identifiers to sequences and managing platform-specific design information.

# bioconductor-pd.rg.u34b

## Overview
The `pd.rg.u34b` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Rat Genome U34B array. This package is primarily designed to work as a backend for the `oligo` package to enable preprocessing, normalization, and analysis of .CEL files.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but can be loaded manually:

```r
library(pd.rg.u34b)
```

### Integration with oligo
The most common workflow involves using this package to provide the platform design for an ExpressionFeatureSet:

```r
library(oligo)

# Read CEL files (pd.rg.u34b will be required)
raw_data <- read.celfiles(filenames = list.celfiles())

# The platform design is automatically linked
show(raw_data)
```

### Accessing Sequence Data
The package contains sequence information for Perfect Match (PM) probes, which is useful for sequence-specific background correction or probe-level analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific probe sequences
# 'fid' corresponds to the feature identifier in the oligo object
```

### Available Data Objects
- `pmSequence`: Sequence data for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Memory Management**: Annotation packages can be large. Ensure you have sufficient RAM when working with large sets of U34B arrays.
- **Database Connection**: The package uses an SQLite database to store mapping information. You can inspect the underlying database using `db(pd.rg.u34b)`, though direct manipulation is rarely required.
- **Version Consistency**: Ensure that the version of `pd.rg.u34b` matches the Bioconductor release used for your version of `oligo`.

## Reference documentation
- [pd.rg.u34b Reference Manual](./references/reference_manual.md)
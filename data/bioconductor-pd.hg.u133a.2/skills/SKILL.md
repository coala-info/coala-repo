---
name: bioconductor-pd.hg.u133a.2
description: This package provides annotation data and probe sequences for the Affymetrix Human Genome U133A 2.0 Array. Use when user asks to process HG-U133A_2 microarray data, retrieve probe sequences, or map feature identifiers for low-level analysis with the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u133a.2.html
---

# bioconductor-pd.hg.u133a.2

name: bioconductor-pd.hg.u133a.2
description: Annotation package for the Affymetrix Human Genome U133A 2.0 Array. Use when processing or analyzing HG-U133A_2 microarray data with the 'oligo' package, specifically for retrieving probe sequences (PM, MM, or background) and mapping feature identifiers to sequences.

# bioconductor-pd.hg.u133a.2

## Overview
The `pd.hg.u133a.2` package is a specialized annotation data package for the Affymetrix Human Genome U133A 2.0 Array. It was built using `pdInfoBuilder` and is designed to work seamlessly with the `oligo` package for low-level analysis of oligonucleotide microarrays. Its primary role is providing the platform-specific design information required to preprocess raw CEL files.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files from this platform, but it can be loaded manually:

```r
library(pd.hg.u133a.2)
```

### Accessing Probe Sequences
The package stores sequence information for Perfect Match (PM), Mismatch (MM), and background (BG) probes. This data is stored in `DataFrame` objects.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (columns: 'fid' and 'sequence')
head(pmSequence)

# Accessing other sequence types (if applicable to the design)
data(mmSequence)
data(bgSequence)
```

### Integration with oligo
The most common workflow involves using this package as a backend for `oligo` functions. You do not usually call functions within `pd.hg.u133a.2` directly; instead, you pass the platform name or let `oligo` detect it.

```r
library(oligo)

# Read CEL files (pd.hg.u133a.2 will be used for annotation)
affyData <- read.celfiles(filenames)

# Get probe sequences via the oligo interface
pm_seqs <- getSeq(affyData)
```

## Tips
- **Memory Management**: These annotation objects can be large. Only load `pmSequence` if you specifically need to analyze probe-level sequences (e.g., for GC-content correction or custom background models).
- **Feature IDs**: The `fid` column in the sequence data frames corresponds to the feature identifiers used in the `ExpressionFeatureSet` objects created by `oligo`.

## Reference documentation
- [pd.hg.u133a.2 Reference Manual](./references/reference_manual.md)
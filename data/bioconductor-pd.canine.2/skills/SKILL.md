---
name: bioconductor-pd.canine.2
description: This package provides annotation data and probe mappings for the Affymetrix Canine Genome 2.0 Array. Use when user asks to process Canine 2.0 microarrays, map probe identifiers to sequences, or perform high-level analysis of oligonucleotide microarrays using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.canine.2.html
---

# bioconductor-pd.canine.2

name: bioconductor-pd.canine.2
description: Annotation data package for the Affymetrix Canine Genome 2.0 Array. Use when processing Canine 2.0 microarrays with the 'oligo' or 'biocXras' packages to map probe identifiers to sequences and genomic coordinates.

# bioconductor-pd.canine.2

## Overview
The `pd.canine.2` package is a platform design (pd) annotation package for the Affymetrix Canine Genome 2.0 Array. It is built using the `pdInfoBuilder` infrastructure and is specifically designed to work with the `oligo` package for high-level analysis of oligonucleotide microarrays. It provides the necessary mapping between feature identifiers (fids) and probe sequences.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files using `oligo::read.celfiles()`, but can be loaded manually:

```r
library(pd.canine.2)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for background correction or sequence-specific analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific probe sequences by feature ID
# pmSequence[pmSequence$fid == some_id, ]
```

### Integration with oligo
The primary use case is providing the annotation backend for `oligo` objects (ExpressionFeatureSet).

```r
library(oligo)

# When reading CEL files, oligo identifies the pd.canine.2 package
# rawData <- read.celfiles(filenames)

# To manually assign or check the annotation
# annotation(rawData) <- "pd.canine.2"
```

### Data Objects
- `pmSequence`: A `DataFrame` containing sequences for PM probes.
- `bgSequence`: Background probe sequences (if applicable).
- `mmSequence`: Mismatch probe sequences (if applicable).

## Tips
- Ensure the version of `pd.canine.2` matches the array version used in your experiment (Canine 2.0).
- This package is a data-only annotation package; most functional analysis is performed via the `oligo` or `limma` packages.
- If you encounter "package not found" errors during `read.celfiles`, install this package via `BiocManager::install("pd.canine.2")`.

## Reference documentation
- [pd.canine.2 Reference Manual](./references/reference_manual.md)
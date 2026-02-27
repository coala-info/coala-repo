---
name: bioconductor-pd.ht.hg.u133.plus.pm
description: This package provides platform design and annotation data for the Affymetrix HT HG-U133 Plus PM microarray. Use when user asks to process HT Human Genome U133 Plus PM CEL files, perform RMA normalization on this platform, or access probe sequences for these arrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ht.hg.u133.plus.pm.html
---


# bioconductor-pd.ht.hg.u133.plus.pm

name: bioconductor-pd.ht.hg.u133.plus.pm
description: Annotation package for the Affymetrix HT HG-U133 Plus PM platform. Use this skill when processing High-Throughput (HT) Human Genome U133 Plus PM microarray data using the oligo package, specifically for feature-level annotation, probe sequences, and platform design information.

# bioconductor-pd.ht.hg.u133.plus.pm

## Overview

The `pd.ht.hg.u133.plus.pm` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix HT HG-U133 Plus PM (Perfect Match) array. This package is primarily intended to be used as a dependency for the `oligo` package to enable the preprocessing and analysis of CEL files from this specific microarray platform.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but it can be loaded manually:

```r
library(pd.ht.hg.u133.plus.pm)
```

### Integration with oligo
The most common workflow involves using this package to provide the platform geometry and annotation during data import:

```r
library(oligo)

# Read CEL files (the package is identified via the CEL header)
raw_data <- read.celfiles(filenames = list.celfiles())

# The 'pd.ht.hg.u133.plus.pm' package provides the mapping for:
# 1. Background correction
# 2. Normalization (e.g., RMA)
# 3. Summarization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

### Data Structures
- **pmSequence**: A `DataFrame` containing the feature ID (`fid`) and the corresponding nucleotide sequence for PM probes.
- **Platform Design**: The package contains SQLite-based mappings between probes, probesets, and genomic coordinates used internally by `oligo` functions.

## Tips
- **Memory Management**: Annotation packages can be large. Ensure you have sufficient RAM when processing large HT (High-Throughput) datasets.
- **Automatic Detection**: If `read.celfiles()` fails to find this package, ensure it is installed via `BiocManager::install("pd.ht.hg.u133.plus.pm")`.
- **PM-Only**: This specific package is designed for "PM-only" arrays; if you are working with older arrays containing Mismatch (MM) probes, different `pd` packages may be required.

## Reference documentation

- [pd.ht.hg.u133.plus.pm Reference Manual](./references/reference_manual.md)
---
name: bioconductor-pd.hg.u133.plus.2
description: This package provides annotation data and probe sequences for the Affymetrix Human Genome U133 Plus 2.0 Array. Use when user asks to process HG-U133 Plus 2.0 CEL files, map probe sequences to feature identifiers, or perform low-level preprocessing and normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u133.plus.2.html
---

# bioconductor-pd.hg.u133.plus.2

name: bioconductor-pd.hg.u133.plus.2
description: Annotation package for the Affymetrix Human Genome U133 Plus 2.0 Array. Use when processing GeneChip HG-U133 Plus 2.0 expression data, specifically for mapping probe sequences and providing platform-specific metadata required by the 'oligo' package for preprocessing and normalization.

# bioconductor-pd.hg.u133.plus.2

## Overview

The `pd.hg.u133.plus.2` package is a Bioconductor annotation data package specifically designed for the Affymetrix Human Genome U133 Plus 2.0 Array. It was built using the `pdInfoBuilder` infrastructure and is primarily intended to be used as a backend for the `oligo` package. It contains the mapping between feature identifiers (fids), probe sequences, and their physical locations on the chip, which is essential for low-level analysis of CEL files.

## Typical Workflow

### Loading the Package
The package is usually loaded automatically when using `oligo` to read CEL files, but it can be loaded manually:

```r
library(pd.hg.u133.plus.2)
```

### Using with oligo
When analyzing HG-U133 Plus 2.0 data, the `oligo` package uses this annotation to create a FeatureSet object:

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
# oligo will automatically look for pd.hg.u133.plus.2
```

### Accessing Probe Sequences
The package provides sequence information for Perfect Match (PM) probes. This is useful for custom sequence-specific analysis or background correction methods.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific sequence by feature ID
# pmSequence[pmSequence$fid == 123, ]
```

## Key Data Objects

- **pmSequence**: A `DataFrame` containing the sequences for the Perfect Match probes. It includes:
    - `fid`: The feature identifier.
    - `sequence`: The actual nucleotide sequence of the probe.
- **bgSequence / mmSequence**: Depending on the specific build, these may contain background or Mismatch probe sequences if applicable to the platform design.

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R environment has sufficient memory when loading large datasets with `oligo`.
- **Platform Specificity**: This package is strictly for the "Plus 2.0" version of the HG-U133 array. For the standard HG-U133A or HG-U133B, different `pd.hg.u133...` packages are required.
- **Integration**: This package is a "Platform Design" (pd) package. It does not contain gene-level annotations (like gene symbols or GO terms); for those, use the corresponding `hgu133plus2.db` package after summarizing the data to the probeset level.

## Reference documentation
- [pd.hg.u133.plus.2 Reference Manual](./references/reference_manual.md)
---
name: bioconductor-pd.pae.g1a
description: This package provides annotation and platform design metadata for the Affymetrix Pseudomonas aeruginosa PAE-G1a microarray. Use when user asks to preprocess CEL files with the oligo package, perform RMA normalization, or access probe sequence information for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.pae.g1a.html
---


# bioconductor-pd.pae.g1a

name: bioconductor-pd.pae.g1a
description: Use when analyzing Affymetrix Pseudomonas aeruginosa (pae.g1a) microarray data in R. This skill provides guidance on using the pd.pae.g1a annotation package, which is required by the oligo package for preprocessing, feature-level extraction, and probe sequence mapping for this specific platform.

## Overview
The `pd.pae.g1a` package is a Bioconductor annotation (Platform Design) package for the *Pseudomonas aeruginosa* PAE-G1a GeneChip. It was built using the `pdInfoBuilder` package and is specifically designed to work with the `oligo` package to provide the necessary metadata for low-level analysis of microarray data.

## Usage and Workflows

### Integration with oligo
The primary use of `pd.pae.g1a` is transparent; when you load CEL files using the `oligo` package, it automatically searches for this package to identify the chip layout.

```r
library(oligo)

# Read CEL files; oligo will automatically use pd.pae.g1a if the files are from that platform
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can manually inspect the Perfect Match (PM) probe sequences stored within the package. The data is stored in a `DataFrame` object.

```r
library(pd.pae.g1a)

# Load the PM sequence data
data(pmSequence)

# View the structure (columns: fid and sequence)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Key Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

### Typical Workflow
1. **Installation**: Ensure the package is installed via `BiocManager::install("pd.pae.g1a")`.
2. **Data Loading**: Use `oligo::read.celfiles()` to create a `FeatureSet` object.
3. **Annotation**: The `FeatureSet` object will link to `pd.pae.g1a` for probe-to-genome mapping.
4. **Sequence Analysis**: Use `pmSequence` if you need to perform sequence-specific bias corrections or probe-level filtering.

## Reference documentation
- [pd.pae.g1a Reference Manual](./references/reference_manual.md)
---
name: bioconductor-pd.equgene.1.1.st
description: This package provides annotation and platform-specific design information for the Affymetrix EquGene 1.1 ST horse gene expression array. Use when user asks to map probe identifiers to sequences, process Equus caballus microarray data, or provide platform support for the oligo and xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.equgene.1.1.st.html
---

# bioconductor-pd.equgene.1.1.st

name: bioconductor-pd.equgene.1.1.st
description: Annotation package for the Affymetrix EquGene 1.1 ST array. Use this skill when processing Equus caballus (horse) gene expression data using the oligo or xps packages, specifically for mapping probe identifiers to sequences and managing platform-specific design information.

# bioconductor-pd.equgene.1.1.st

## Overview
The `pd.equgene.1.1.st` package is a Bioconductor annotation data package specifically designed for the Affymetrix EquGene 1.1 ST (Sense Target) array. It was built using the `pdInfoBuilder` infrastructure and is intended to work seamlessly with the `oligo` package to facilitate the preprocessing and analysis of horse genomic microarrays. Its primary role is to provide the necessary mapping between feature identifiers (fids) and probe sequences.

## Typical Workflow

### Loading the Package
To use the annotation data, load the package alongside the `oligo` library:

```r
library(oligo)
library(pd.equgene.1.1.st)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is often used internally by `oligo` functions (like `rma()` or `backgroundCorrect()`), but can be accessed manually:

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with Expression FeatureSets
When reading CEL files for the EquGene 1.1 ST platform, the `oligo` package automatically looks for this package to create a `GeneFeatureSet` object:

```r
# Assuming CEL files are in the current directory
raw_data <- read.celfiles(filenames = list.celfiles())

# The annotation slot will be set to "pd.equgene.1.1.st"
annotation(raw_data)
```

## Key Data Objects
- **pmSequence**: A `DataFrame` object containing the probe sequences. It includes:
  - `fid`: The feature identifier.
  - `sequence`: The actual nucleotide sequence of the probe.
- **bgSequence / mmSequence**: Depending on the specific array design, background or mismatch sequences may be mapped to the same internal data structure.

## Usage Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when processing large batches of Equine ST arrays.
- **Platform Specificity**: This package is strictly for the 1.1 ST version of the Equine gene chip. Ensure your CEL files match this specific platform version to avoid mapping errors.
- **Dependency**: Always ensure the `oligo` package is installed, as `pd.equgene.1.1.st` is a data support package and does not contain analysis functions itself.

## Reference documentation
- [pd.equgene.1.1.st Reference Manual](./references/reference_manual.md)
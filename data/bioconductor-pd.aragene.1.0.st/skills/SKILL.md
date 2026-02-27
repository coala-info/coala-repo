---
name: bioconductor-pd.aragene.1.0.st
description: This package provides annotation and platform design data for the Affymetrix Arabidopsis Gene 1.0 ST microarray. Use when user asks to process Arabidopsis thaliana microarray data, map probe identifiers to sequences, or perform normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.aragene.1.0.st.html
---


# bioconductor-pd.aragene.1.0.st

name: bioconductor-pd.aragene.1.0.st
description: Annotation package for the Affymetrix GeneChip Arabidopsis Gene 1.0 ST array. Use when processing Arabidopsis thaliana microarray data with the oligo package to map probe identifiers to sequences and perform platform-specific data normalization.

# bioconductor-pd.aragene.1.0.st

## Overview

The `pd.aragene.1.0.st` package is a Bioconductor annotation data package specifically designed for the Affymetrix Arabidopsis Gene 1.0 ST array. It is built using the `pdInfoBuilder` infrastructure and is intended to be used as a backend for the `oligo` package. It provides the necessary mapping between feature identifiers (fids) and probe sequences, which is essential for background correction, normalization, and summarization of ST-type (Sense Target) arrays.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be manually loaded:

```r
library(pd.aragene.1.0.st)
```

### Integration with oligo
The primary use case is providing the platform design information to the `oligo` package during data preprocessing.

```r
library(oligo)

# Read CEL files (the pd package is identified from the CEL file header)
raw_data <- read.celfiles(filenames = list.celfiles())

# The pd.aragene.1.0.st package allows for RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package. This is useful for custom sequence-based analysis or verifying probe properties.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get sequence for a specific feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

### Data Structures
- **pmSequence**: A `DataFrame` containing the sequences for PM probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (rarely present in ST arrays but defined in the object structure).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when processing large batches of Arabidopsis ST arrays.
- **Automatic Selection**: If `read.celfiles()` fails to find the package, ensure it is installed via `BiocManager::install("pd.aragene.1.0.st")`.
- **ST Array Specifics**: Unlike older 3' IVT arrays, the Gene 1.0 ST array probes are distributed across the entire length of the gene. The `pd` package ensures that `oligo` correctly handles this "whole-transcript" geometry.

## Reference documentation

- [pd.aragene.1.0.st Reference Manual](./references/reference_manual.md)
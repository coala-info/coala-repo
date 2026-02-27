---
name: bioconductor-pd.zebgene.1.1.st
description: This package provides annotation and platform design metadata for the Affymetrix ZebGene 1.1 ST array. Use when user asks to process raw CEL files from ZebGene 1.1 ST arrays, map probe identifiers to sequences, or perform low-level analysis using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.zebgene.1.1.st.html
---


# bioconductor-pd.zebgene.1.1.st

name: bioconductor-pd.zebgene.1.1.st
description: Annotation package for the Affymetrix ZebGene 1.1 ST array. Use this skill when performing low-level analysis of ZebGene 1.1 ST expression data in R, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.zebgene.1.1.st

## Overview
The `pd.zebgene.1.1.st` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary infrastructure to process Affymetrix ZebGene 1.1 ST arrays. Its primary role is to serve as a platform design (pd) package that the `oligo` package uses to map raw intensity data to probe sequences and genomic features.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.zebgene.1.1.st)
```

### Integration with oligo
This package is designed to work behind the scenes when using the `oligo` package to process Gene ST arrays.

```r
library(oligo)

# Read CEL files (the pd package is identified and loaded automatically)
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package. This is useful for custom sequence-level analysis or quality control.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the feature IDs (`fid`) and the corresponding nucleotide sequences for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when loading large datasets with `oligo`.
- **Platform Specificity**: This package is specific to the "ZebGene 1.1 ST" array. Using it with other zebrafish arrays (like the older Zebrafish Genome Array) will result in errors.
- **Annotation Hub**: For higher-level annotations (gene symbols, GO terms), use this package in conjunction with `zebgene11sttranscriptcluster.db`.

## Reference documentation
- [pd.zebgene.1.1.st Reference Manual](./references/reference_manual.md)
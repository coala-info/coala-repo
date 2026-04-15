---
name: bioconductor-pd.chigene.1.1.st
description: This Bioconductor package provides platform design and probe sequence information for the Affymetrix Chigene 1.1 ST microarray. Use when user asks to preprocess Chigene 1.1 ST expression data, map probe IDs to sequences, or perform low-level microarray analysis with the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.chigene.1.1.st.html
---

# bioconductor-pd.chigene.1.1.st

name: bioconductor-pd.chigene.1.1.st
description: Annotation package for the Affymetrix GeneChip Chigene 1.1 ST array. Use when processing Chigene 1.1 ST expression data in R, specifically for mapping probe IDs to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.chigene.1.1.st

## Overview
The `pd.chigene.1.1.st` package is a Bioconductor annotation data package built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Chigene 1.1 ST (Saccharomyces cerevisiae/Yeast) array. It is designed to work seamlessly with the `oligo` package for low-level analysis (preprocessing, normalization, and summarization) of microarray data.

## Typical Workflow

### Loading the Package
The package is typically loaded automatically when using `oligo` functions on CEL files from this platform, but can be loaded manually:

```r
library(pd.chigene.1.1.st)
```

### Integration with oligo
When reading CEL files, `oligo` uses this package to understand the chip layout:

```r
library(oligo)
# Assuming .CEL files are in the working directory
raw_data <- read.celfiles(filenames = list.celfiles())
# The 'pd.chigene.1.1.st' package provides the annotation for 'raw_data'
```

### Accessing Sequence Data
The package contains sequence information for the Perfect Match (PM) probes, which is useful for sequence-specific background correction methods (like GCRMA).

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Accessing specific sequences
# 'fid' corresponds to the feature ID on the array
```

## Key Data Objects
- **pd.chigene.1.1.st**: The main annotation object containing the chip layout.
- **pmSequence**: A `DataFrame` object containing probe sequences. It has two primary columns:
    - `fid`: Feature identifier.
    - `sequence`: The actual nucleotide sequence for the probe.

## Usage Tips
- This package is a "Platform Design" (PD) package. It is not a high-level annotation package (like `chigene11sttranscriptcluster.db`). Use this for preprocessing and the `.db` packages for mapping probes to Gene Symbols or Entrez IDs.
- Ensure `oligo` is installed to make full use of the objects provided by this package.

## Reference documentation
- [pd.chigene.1.1.st Reference Manual](./references/reference_manual.md)
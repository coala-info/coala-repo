---
name: bioconductor-pd.fingene.1.1.st
description: This package provides annotation data and platform-specific metadata for the FinGene 1.1 ST microarray. Use when user asks to process FinGene 1.1 ST expression data, map probe identifiers to sequences, or perform low-level analysis using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.fingene.1.1.st.html
---

# bioconductor-pd.fingene.1.1.st

name: bioconductor-pd.fingene.1.1.st
description: Annotation package for the FinGene 1.1 ST array. Use this skill when processing Affymetrix/FinGene 1.1 ST expression data in R, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.fingene.1.1.st

## Overview
The `pd.fingene.1.1.st` package is a Bioconductor annotation data package built using `pdInfoBuilder`. It provides the necessary infrastructure to analyze FinGene 1.1 ST arrays within the R environment. It is designed to work seamlessly with the `oligo` package for low-level processing (preprocessing, normalization, and summarization) of microarrays.

## Typical Workflow

### Loading the Package
To use the annotation data, load the package alongside the `oligo` package:

```r
library(oligo)
library(pd.fingene.1.1.st)
```

### Data Processing
When reading CEL files from a FinGene 1.1 ST platform, the `oligo` package automatically detects and uses this package if it is installed.

```r
# Example: Reading CEL files
# celFiles <- list.celfiles()
# affyData <- read.celfiles(celFiles)
# The 'affyData' object will automatically reference pd.fingene.1.1.st
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is useful for sequence-specific background correction or probe-level analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)
```

## Key Data Objects
- **pmSequence**: A `DataFrame` object containing the feature ID (`fid`) and the corresponding nucleotide sequence for PM probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Integration**: This package is a "Platform Design" (pd) package. You rarely call its functions directly; instead, you pass the package name or let `oligo` functions like `rma()` or `read.celfiles()` handle the interaction.
- **Memory**: Annotation packages can be large. Ensure your R session has sufficient memory when loading large sequence DataFrames.

## Reference documentation
- [pd.fingene.1.1.st Reference Manual](./references/reference_manual.md)
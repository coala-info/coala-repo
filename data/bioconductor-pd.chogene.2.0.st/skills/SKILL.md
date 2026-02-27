---
name: bioconductor-pd.chogene.2.0.st
description: This package provides annotation and platform design data for the Affymetrix CHOgene 2.0 ST array. Use when user asks to process raw CEL files, map probe identifiers to sequences, or perform RMA normalization on Chinese Hamster Gene 2.0 ST expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.chogene.2.0.st.html
---


# bioconductor-pd.chogene.2.0.st

name: bioconductor-pd.chogene.2.0.st
description: Annotation package for the Affymetrix CHOgene 2.0 ST array. Use this skill when processing or analyzing CHOgene 2.0 ST expression data in R, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.chogene.2.0.st

## Overview

The `pd.chogene.2.0.st` package is a specialized annotation data package for the Chinese Hamster (CHO) Gene 2.0 ST array. It was built using the `pdInfoBuilder` infrastructure and is designed to work seamlessly with the `oligo` package for the analysis of Affymetrix Gene ST arrays. Its primary role is to provide the platform design information required to preprocess raw CEL files.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when using `oligo` functions on CHOgene 2.0 ST data, but it can be loaded manually:

```r
library(pd.chogene.2.0.st)
```

### Integration with oligo
This package is a dependency for reading and normalizing CHOgene 2.0 ST CEL files. When you use `read.celfiles()`, `oligo` identifies the platform and searches for this annotation package.

```r
library(oligo)

# Read CEL files
celFiles <- list.celfiles(full.names = TRUE)
rawData <- read.celfiles(celFiles)

# The rawData object will now use pd.chogene.2.0.st for its annotation slot
# You can then proceed to RMA normalization
eset <- rma(rawData)
```

### Accessing Probe Sequences
The package contains sequence information for the Perfect Match (PM) probes on the array. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific probe sequence by feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the feature ID (`fid`) and the corresponding nucleotide sequence for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch probes (if applicable; ST arrays primarily use PM probes).

## Tips
- **Memory Management**: Annotation packages can be large. If you are working with many samples, ensure your R session has sufficient memory to hold the platform design information.
- **Platform Matching**: Ensure your CEL files are specifically from the CHOgene 2.0 ST array; using this package with other CHO arrays (like the older CHOgene 1.0) will result in errors or incorrect mapping.

## Reference documentation
- [pd.chogene.2.0.st Reference Manual](./references/reference_manual.md)
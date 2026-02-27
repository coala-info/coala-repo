---
name: bioconductor-pd.ecoli.asv2
description: This package provides annotation data and probe sequence mappings for the Affymetrix E. coli ASV2 microarray platform. Use when user asks to analyze E. coli microarray data, map feature IDs to probe sequences, or provide platform design information for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ecoli.asv2.html
---


# bioconductor-pd.ecoli.asv2

name: bioconductor-pd.ecoli.asv2
description: Annotation data package for the Affymetrix E. coli ASV2 (Ecoli_ASV2) platform. Use when working with E. coli microarray data in R, specifically for identifying probe sequences, mapping feature IDs (fid) to sequences, and providing platform-specific metadata for the oligo package.

# bioconductor-pd.ecoli.asv2

## Overview
The `pd.ecoli.asv2` package is a Bioconductor annotation interface for the Affymetrix E. coli ASV2 microarray. It is built using `pdInfoBuilder` and is designed to work seamlessly with the `oligo` package to facilitate the preprocessing and analysis of oligonucleotide arrays. Its primary role is to provide the mapping between physical features on the chip and their corresponding nucleotide sequences.

## Usage and Workflows

### Loading the Package
To use the annotation data, load the package alongside the `oligo` package:

```r
library(oligo)
library(pd.ecoli.asv2)
```

### Accessing Probe Sequences
The package provides sequence data for Perfect Match (PM) probes. This is often used for background correction or sequence-specific analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific columns
fids <- pmSequence$fid
sequences <- pmSequence$sequence
```

### Integration with oligo
When reading CEL files for E. coli ASV2 arrays, the `oligo` package automatically looks for this package to provide the necessary platform design information.

```r
# Example workflow for reading CEL files
# celFiles <- list.celfiles()
# rawData <- read.celfiles(celFiles, pkgname = "pd.ecoli.asv2")

# The resulting object will use pd.ecoli.asv2 for feature mapping
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the feature ID (`fid`) and the actual probe sequence for Perfect Match probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch probes (if applicable).

## Tips
- **Memory Management**: Annotation packages can be large. Only load the `pmSequence` data if you need to perform sequence-level calculations (like GC-content normalization).
- **Feature IDs**: The `fid` column is the primary key used to link sequences back to the expression intensities found in `ExpressionSet` or `FeatureSet` objects.

## Reference documentation
- [pd.ecoli.asv2 Reference Manual](./references/reference_manual.md)
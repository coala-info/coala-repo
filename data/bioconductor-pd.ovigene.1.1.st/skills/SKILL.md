---
name: bioconductor-pd.ovigene.1.1.st
description: This package provides annotation data and platform design information for the OviGene 1.1 ST microarray. Use when user asks to process Affymetrix OviGene 1.1 ST array data, map probe identifiers to sequences, or perform low-level analysis using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ovigene.1.1.st.html
---


# bioconductor-pd.ovigene.1.1.st

name: bioconductor-pd.ovigene.1.1.st
description: Annotation data package for the OviGene 1.1 ST array. Use when processing Affymetrix/OviGene ST expression data with the oligo package to map probe identifiers to sequences and provide platform-specific metadata.

# bioconductor-pd.ovigene.1.1.st

## Overview
The `pd.ovigene.1.1.st` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary infrastructure to process and analyze OviGene 1.1 ST arrays. It is designed to work seamlessly with the `oligo` package for low-level analysis (preprocessing, normalization, and summarization) of ST-type microarrays.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be called directly:

```r
library(pd.ovigene.1.1.st)
```

### Integration with oligo
The primary use case is providing the platform design information for `FeatureSet` objects. When you read CEL files using `read.celfiles()`, `oligo` uses this package to understand the chip layout.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The platform design will be automatically assigned if the CEL header matches
# You can then proceed to RMA or other preprocessing
eset <- rma(raw_data)
```

### Accessing Sequence Data
The package contains sequence information for Perfect Match (PM) probes, which is useful for sequence-specific background correction or probe-level analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Accessing specific probe sequences by feature ID
# pmSequence[pmSequence$fid == some_id, ]
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the feature IDs (`fid`) and the corresponding nucleotide sequences for PM probes.
- `bgSequence`: Background probe sequences (if applicable, accessed via the same dataset).
- `mmSequence`: Mismatch probe sequences (if applicable).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure you have sufficient RAM when processing large batches of ST arrays.
- **Platform Matching**: This package is specific to the "ovigene.1.1.st" design. If your CEL files are for a different version (e.g., OviGene 1.0), this package will not be compatible.
- **Annotation Mapping**: This package provides the physical layout and sequences. For functional annotation (gene symbols, GO terms), use the corresponding `.db` package if available (e.g., `ovigene11sttranscriptcluster.db`).

## Reference documentation
- [pd.ovigene.1.1.st Reference Manual](./references/reference_manual.md)
---
name: bioconductor-pd.bovgene.1.0.st
description: This package provides annotation and platform design metadata for the Affymetrix BovGene 1.0 ST expression array. Use when user asks to preprocess raw CEL files from Bovine Gene 1.0 ST arrays, perform RMA normalization, or access probe sequence information using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.bovgene.1.0.st.html
---

# bioconductor-pd.bovgene.1.0.st

name: bioconductor-pd.bovgene.1.0.st
description: Annotation and platform design information for the Affymetrix BovGene-1_0-st expression array. Use when processing Bovine (cow) Gene 1.0 ST arrays with the oligo package to map probes to sequences and genomic coordinates.

# bioconductor-pd.bovgene.1.0.st

## Overview
The `pd.bovgene.1.0.st` package is a Bioconductor annotation package specifically designed for the Affymetrix BovGene 1.0 ST array. It serves as a platform design (PD) package, providing the necessary metadata, probe sequences, and feature identifiers required by the `oligo` package to preprocess and analyze raw CEL files.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when using `oligo` functions on BovGene 1.0 ST data, but can be loaded manually:

```r
library(pd.bovgene.1.0.st)
```

### Integration with oligo
This package is essential for reading CEL files. The `oligo` package uses it to create a FeatureSet object.

```r
library(oligo)

# Read CEL files (automatically detects pd.bovgene.1.0.st)
celFiles <- list.celfiles(full.names = TRUE)
rawData <- read.celfiles(celFiles)

# Perform RMA normalization
eset <- rma(rawData)
```

### Accessing Sequence Data
You can access the Perfect Match (PM) probe sequences stored within the package. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID in the FeatureSet
```

### Data Structures
- **pmSequence**: A `DataFrame` containing the sequences for PM probes.
- **bgSequence**: Background probe sequences (if applicable).
- **mmSequence**: Mismatch probe sequences (if applicable).

## Tips
- **Memory Management**: PD packages can be large. Ensure your R session has sufficient memory when processing large batches of Bovine ST arrays.
- **Annotation Mapping**: This package provides the physical layout and sequences. For mapping probes to Gene Symbols or Entrez IDs, use the corresponding chip-specific annotation package (e.g., `bovgene10stprobeset.db` or `bovgene10sttranscriptcluster.db`) in conjunction with this one.
- **Platform Verification**: Ensure your array type is exactly "BovGene-1_0-st". Using this package with different bovine arrays (like the older Bovine Genome Array) will result in incorrect mapping.

## Reference documentation
- [pd.bovgene.1.0.st Reference Manual](./references/reference_manual.md)
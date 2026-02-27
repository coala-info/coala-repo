---
name: bioconductor-pd.rabgene.1.0.st
description: This package provides annotation and probe-level mapping data for the Affymetrix RabGene 1.0 ST array. Use when user asks to process RabGene 1.0 ST CEL files, map probes to genomic features, or perform RMA normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rabgene.1.0.st.html
---


# bioconductor-pd.rabgene.1.0.st

name: bioconductor-pd.rabgene.1.0.st
description: Annotation package for the Affymetrix pd.rabgene.1.0.st platform. Use when processing RabGene 1.0 ST array data, specifically for low-level processing, probe-to-feature mapping, and sequence-level analysis using the oligo package.

# bioconductor-pd.rabgene.1.0.st

## Overview
The `pd.rabgene.1.0.st` package is a Bioconductor annotation data package built with `pdInfoBuilder`. It provides the necessary infrastructure to map probes to their corresponding genomic features for the RabGene 1.0 ST array. It is designed to work seamlessly with the `oligo` package for preprocessing and analysis of Affymetrix ST (Gene/Exon) style arrays.

## Typical Workflow

### Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be called directly:

```r
library(pd.rabgene.1.0.st)
```

### Integration with oligo
When analyzing RabGene 1.0 ST data, use this package to provide the platform-specific geometry and annotation to `read.celfiles`:

```r
library(oligo)

# Read CEL files - the pd.rabgene.1.0.st package provides the platform info
affyData <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(affyData)
```

### Accessing Sequence Data
The package contains sequence information for the probes on the array, which is useful for GC-content calculations or custom probe-level modeling.

```r
# Load the probe sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Accessing specific sequences
# 'fid' corresponds to the feature ID in the oligo object
```

## Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for Perfect Match (PM) probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Usage Tips
- **Memory Management**: These annotation packages can be large. Ensure you have sufficient RAM when processing large batches of CEL files.
- **Platform Matching**: This package is specific to the "rabgene.1.0.st" design. If your CEL files are from a different version (e.g., human or mouse-specific ST arrays), ensure you use the corresponding `pd.hugene...` or `pd.mogene...` package instead.
- **Database Connection**: The package uses an SQLite backend. You can access the underlying database directly if needed using `db(pd.rabgene.1.0.st)`, though this is rarely necessary for standard workflows.

## Reference documentation
- [pd.rabgene.1.0.st Reference Manual](./references/reference_manual.md)
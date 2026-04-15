---
name: bioconductor-pd.margene.1.0.st
description: This package provides annotation data and probe-level infrastructure for the Affymetrix MarGene 1.0 ST array. Use when user asks to process MarGene 1.0 ST expression microarrays, map probe identifiers to sequences, or perform low-level analysis using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.margene.1.0.st.html
---

# bioconductor-pd.margene.1.0.st

name: bioconductor-pd.margene.1.0.st
description: Annotation data package for the Affymetrix MarGene 1.0 ST array. Use when processing MarGene 1.0 ST expression microarrays with the 'oligo' package to map probe identifiers to sequences and perform low-level analysis.

# bioconductor-pd.margene.1.0.st

## Overview
The `pd.margene.1.0.st` package is a Bioconductor annotation platform (pdInfoPackage) specifically designed for the Affymetrix MarGene 1.0 ST array. It provides the necessary infrastructure for the `oligo` package to handle probe-level data, including probe sequences and feature-to-identifier mappings. It is primarily used as a backend dependency during the preprocessing of `.CEL` files.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be called directly:
```r
library(pd.margene.1.0.st)
```

### 2. Integration with oligo
When analyzing MarGene 1.0 ST data, use `read.celfiles` from the `oligo` package. The `pd.margene.1.0.st` package provides the required geometry and annotation information.

```r
library(oligo)
# Read CEL files - the pd.margene.1.0.st package is used internally
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### 3. Accessing Sequence Data
You can access the Perfect Match (PM) probe sequences stored within the package for sequence-specific analysis (e.g., GC content calculations).

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific sequence by feature ID
# pmSequence[pmSequence$fid == 123, ]
```

## Usage Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient RAM when processing large batches of ST arrays.
- **Platform Specificity**: This package is specific to the "MarGene 1.0 ST" array. Do not use it for "Gene 1.0 ST" or "Exon 1.0 ST" arrays, as the probe layouts differ.
- **Database Connection**: The package uses an SQLite backend. You can interact with the underlying database using `db(pd.margene.1.0.st)` if advanced metadata extraction is required.

## Reference documentation
- [pd.margene.1.0.st Reference Manual](./references/reference_manual.md)
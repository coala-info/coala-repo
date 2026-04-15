---
name: bioconductor-pd.mogene.2.0.st
description: This package provides annotation and platform design data for the Affymetrix Mouse Gene 2.0 ST microarray. Use when user asks to process MoGene 2.0 ST CEL files, perform RMA normalization, or access probe sequence information for mouse genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mogene.2.0.st.html
---

# bioconductor-pd.mogene.2.0.st

name: bioconductor-pd.mogene.2.0.st
description: Annotation package for the Affymetrix Mouse Gene 2.0 ST array. Use when processing MoGene 2.0 ST microarray data with the oligo package, specifically for reading CEL files, performing RMA normalization, or accessing probe sequence information for mouse genomic studies.

# bioconductor-pd.mogene.2.0.st

## Overview

The `pd.mogene.2.0.st` package is a Platform Design (PD) annotation package for the Affymetrix Mouse Gene 2.0 ST array. It is built using the `pdInfoBuilder` system and is specifically designed to work with the `oligo` package. It provides the necessary mapping between physical grid coordinates on the microarray and the feature identifiers (fids), as well as probe sequence data required for low-level preprocessing.

## Usage in R

This package is rarely called directly by the user; instead, it is automatically loaded by the `oligo` package when processing Mouse Gene 2.0 ST CEL files.

### Loading the Package
```r
library(pd.mogene.2.0.st)
```

### Integration with oligo
When analyzing CEL files, the `oligo` package uses this library to understand the chip layout:

```r
library(oligo)

# Read CEL files (pd.mogene.2.0.st is triggered automatically)
celFiles <- list.celfiles(full.names = TRUE)
rawData <- read.celfiles(celFiles)

# Perform RMA normalization
eset <- rma(rawData)
```

### Accessing Probe Sequences
If you need to retrieve the sequences for the Perfect Match (PM) probes:

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get sequence for a specific feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

## Workflow Tips

1. **Automatic Detection**: You do not usually need to call `library(pd.mogene.2.0.st)` manually if you are using `read.celfiles()`. The `oligo` package reads the chip type from the CEL file header and attempts to load the corresponding `pd.package`.
2. **Memory Management**: These annotation objects can be large. If you encounter memory issues during `read.celfiles`, ensure you are using a 64-bit R environment.
3. **Database Connection**: The package stores layout information in an SQLite database. You can explore the underlying metadata using `db(pd.mogene.2.0.st)` if you need to perform custom SQL queries on the chip design.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
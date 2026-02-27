---
name: bioconductor-pd.porgene.1.1.st
description: This package provides platform design and annotation data for the Affymetrix Porcine Gene 1.1 ST Array. Use when user asks to process porcine microarray .CEL files, perform RMA normalization with the oligo package, or access probe sequence information for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.porgene.1.1.st.html
---


# bioconductor-pd.porgene.1.1.st

name: bioconductor-pd.porgene.1.1.st
description: Annotation package for the Affymetrix Porcine Gene 1.1 ST Array. Use when analyzing porcine (pig) gene expression data to provide platform design information, probe sequences, and feature-level annotation required by the oligo package.

# bioconductor-pd.porgene.1.1.st

## Overview

The `pd.porgene.1.1.st` package is a Bioconductor annotation resource built with `pdInfoBuilder`. It provides the platform design information for the Affymetrix Porcine Gene 1.1 ST Array. This package is not typically used in isolation but serves as a critical dependency for the `oligo` package to correctly process and normalize .CEL files from this specific microarray platform.

## Usage

### Loading the Package

Load the package in R to make the annotation data available:

```r
library(pd.porgene.1.1.st)
```

### Integration with oligo

The most common use case is during the initial reading of Affymetrix .CEL files. The `oligo` package automatically detects and loads this package if the CEL files are from the Porcine Gene 1.1 ST platform.

```r
library(oligo)

# Read CEL files; oligo will use pd.porgene.1.1.st automatically
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences

You can access the Perfect Match (PM) probe sequences stored within the package for sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

## Workflows

### Standard Expression Analysis

1. **Data Import**: Use `oligo::read.celfiles()` to import .CEL files. The `pd.porgene.1.1.st` package provides the mapping between physical coordinates on the array and feature IDs.
2. **Preprocessing**: Use `oligo::rma()` to perform background correction, normalization, and summarization.
3. **Annotation**: Once the `ExpressionSet` is created, use higher-level annotation packages (like `porgene11sttranscriptcluster.db`) to map IDs to gene symbols or Entrez IDs.

### Manual Metadata Inspection

If you need to inspect the underlying database structure (e.g., to check probe distributions or types):

```r
# Get the database connection
conn <- db(pd.porgene.1.1.st)

# List tables in the platform design database
dbListTables(conn)
```

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
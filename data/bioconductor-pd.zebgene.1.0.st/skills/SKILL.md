---
name: bioconductor-pd.zebgene.1.0.st
description: This package provides platform design information and probe sequences for the Affymetrix ZebGene 1.0 ST array. Use when user asks to preprocess .CEL files, map probe identifiers to physical locations, or access probe sequence data for zebrafish gene expression studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.zebgene.1.0.st.html
---


# bioconductor-pd.zebgene.1.0.st

## Overview
The `pd.zebgene.1.0.st` package is a Bioconductor annotation package specifically designed for the Affymetrix ZebGene 1.0 ST array. It provides the necessary infrastructure to map probe identifiers to their physical locations and sequences. This package is not intended for standalone analysis but serves as a vital dependency for the `oligo` package during the preprocessing (normalization and summarization) of .CEL files.

## Usage in R

### Loading the Package
The package is typically loaded automatically when using `oligo` to read CEL files, but it can be invoked directly:

```r
library(pd.zebgene.1.0.st)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is useful for quality control or custom sequence-based analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with oligo
The primary workflow involves using this package as the `pkgname` or `platform` argument when reading raw data:

```r
library(oligo)

# Read CEL files (the pd package is used internally to build the featureSet)
raw_data <- read.celfiles(filenames = list.celfiles())

# The platform design information is now linked to the raw_data object
show(raw_data)
```

### Database Connection
The package stores annotation data in an SQLite database. You can access the underlying metadata if needed:

```r
# Get the connection object
conn <- db(pd.zebgene.1.0.st)

# List tables in the annotation database
dbListTables(conn)
```

## Workflow Tips
- **Memory Management**: These "pd" (platform design) packages can be large. Ensure your R session has sufficient memory when processing large batches of ZebGene 1.0 ST arrays.
- **Compatibility**: This package is built using `pdInfoBuilder` and is strictly for the "ST" (Sense Target) architecture. Do not use it for older 3' IVT Zebrafish arrays.
- **Annotation**: For mapping probesets to Gene Symbols or Entrez IDs, use this package in conjunction with the high-level annotation package `zebgene10sttranscriptcluster.db`.

## Reference documentation
- [pd.zebgene.1.0.st Reference Manual](./references/reference_manual.md)
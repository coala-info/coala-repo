---
name: bioconductor-pd.hugene.2.0.st
description: This package provides annotation and platform design information for the Affymetrix Human Gene 2.0 ST array. Use when user asks to process CEL files, perform RMA normalization, or map probe identifiers for Human Gene 2.0 ST expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hugene.2.0.st.html
---

# bioconductor-pd.hugene.2.0.st

name: bioconductor-pd.hugene.2.0.st
description: Annotation and platform design information for the Affymetrix GeneChip Human Gene 2.0 ST array. Use when processing, normalizing, or annotating Human Gene 2.0 ST expression data, specifically when using the 'oligo' or 'xps' packages for low-level analysis.

# bioconductor-pd.hugene.2.0.st

## Overview

The `pd.hugene.2.0.st` package is a Bioconductor annotation data package. It provides the necessary SQLite-based mapping between probe identifiers, sequences, and genomic locations for the Affymetrix Human Gene 2.0 ST array. This package is a dependency for high-level analysis packages like `oligo`, which use it to correctly identify probe sets and perform background correction and normalization (e.g., RMA).

## Usage in R

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.hugene.2.0.st)
```

### Integration with oligo
The primary workflow involves using this package as the `pkgname` or `pd` argument when reading raw data:

```r
library(oligo)

# Read CEL files; oligo automatically detects and loads pd.hugene.2.0.st
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Sequence Data
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-specific analysis:

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Database Connection
Since the package is built on an SQLite database, you can inspect the underlying mappings if needed:

```r
# Get the connection to the annotation database
con <- db(pd.hugene.2.0.st)

# List tables (e.g., feature, gene_level, probe_set)
dbListTables(con)

# Example: Query the feature table
features <- dbGetQuery(con, "SELECT * FROM feature LIMIT 10")
```

## Tips
- **Memory Management**: This package contains large mapping tables. Ensure your R session has sufficient RAM when processing large batches of Human Gene 2.0 ST CEL files.
- **Version Matching**: Ensure this package version matches your Bioconductor release to maintain compatibility with the `oligo` package.
- **Gene-Level vs. Probe-Level**: The "ST" (Sense Target) arrays have a different architecture than older 3' IVT arrays. This package handles the complex mapping of multiple probes across the entire length of the gene.

## Reference documentation
- [pd.hugene.2.0.st Reference Manual](./references/reference_manual.md)
---
name: bioconductor-pd.elegene.1.1.st
description: This package provides annotation data and platform design information for the Affymetrix C. elegans Gene 1.1 ST expression microarray. Use when user asks to process CEL files from the Elegene 1.1 ST platform, map probe identifiers to sequences, or perform RMA normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.elegene.1.1.st.html
---

# bioconductor-pd.elegene.1.1.st

name: bioconductor-pd.elegene.1.1.st
description: Provides annotation data for the Affymetrix Elegen.1.1.ST (Caenorhabditis elegans) array. Use when processing C. elegans Gene 1.1 ST expression microarrays with the oligo package to map probe identifiers to sequences and genomic features.

# bioconductor-pd.elegene.1.1.st

## Overview

The `pd.elegene.1.1.st` package is a Platform Design (PD) annotation package for the Affymetrix C. elegans Gene 1.1 ST array. It is built using `pdInfoBuilder` and is specifically designed to work as a backend for the `oligo` package. It contains the mapping between feature identifiers (fids), probe sequences, and their physical locations on the array.

## Usage in R

This package is rarely called directly by the user; instead, it is automatically loaded by the `oligo` package when reading CEL files from the Elegene 1.1 ST platform.

### Loading the Package
```r
library(pd.elegene.1.1.st)
```

### Integration with oligo
When analyzing C. elegans ST arrays, use `read.celfiles` from the `oligo` package. The `oligo` package will look for `pd.elegene.1.1.st` to create the FeatureSet object.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The platform design information is now linked to the raw_data object
# You can proceed with RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)

# To get the number of probes
nrow(pmSequence)
```

### Database Connection
The package stores its metadata in a SQLite database. You can access the underlying connection if you need to perform low-level SQL queries on the probe annotations.

```r
# Get the connection object
conn <- db(pd.elegene.1.1.st)

# List tables in the annotation database
dbListTables(conn)

# Example: Query the feature table
# dbGetQuery(conn, "SELECT * FROM feature LIMIT 10")
```

## Tips
- **Memory Management**: PD packages can be large. If you encounter memory issues, ensure you are only loading the necessary objects.
- **Compatibility**: Ensure that the version of `pd.elegene.1.1.st` matches the array type used in your experiment. This package is specific to the "1.1.ST" version for C. elegans.
- **Workflow**: Always use this package in tandem with `oligo`. For older Affymetrix arrays (IVT), the `affy` package and `.db` (CDF-based) packages are used, but for ST (Sense Target) arrays like this one, `oligo` and `pd` packages are required.

## Reference documentation
- [pd.elegene.1.1.st Reference Manual](./references/reference_manual.md)
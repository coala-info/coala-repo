---
name: bioconductor-pd.ht.mg.430a
description: This package provides annotation data and platform design information for the Affymetrix HT_MG-430A expression array. Use when user asks to preprocess HT_MG-430A microarray data, map probe identifiers to sequences, or perform platform-specific normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ht.mg.430a.html
---

# bioconductor-pd.ht.mg.430a

name: bioconductor-pd.ht.mg.430a
description: Annotation data package for the Affymetrix HT_MG-430A (High-Throughput Mouse Genome 430A) expression array. Use when processing HT_MG-430A microarray data with the 'oligo' or 'DBI' packages to map probe identifiers to sequences, perform background correction, or conduct platform-specific normalization.

# bioconductor-pd.ht.mg.430a

## Overview

The `pd.ht.mg.430a` package is a Bioconductor annotation interface built using `pdInfoBuilder`. It provides the essential platform design information for the Affymetrix HT Mouse Genome 430A array. This package is primarily a data dependency for the `oligo` package, enabling the preprocessing of .CEL files by providing probe sequences, locations, and feature identifiers.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pd.ht.mg.430a")
```

## Usage and Workflows

### Integration with oligo
The most common use case is implicit. When reading CEL files from the HT_MG-430A platform, `oligo` automatically searches for and loads this package.

```r
library(oligo)

# Read CEL files; pd.ht.mg.430a will be loaded automatically if the 
# CEL file headers identify this platform.
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can manually inspect the Perfect Match (PM) probe sequences stored within the package.

```r
library(pd.ht.mg.430a)
library(Biostrings)

# Load the PM sequence data
data(pmSequence)

# View the first few sequences
# The data is stored in a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)

# Example: Convert to DNAStringSet for sequence analysis
pm_dna <- DNAStringSet(pmSequence$sequence)
```

### Database Connectivity
The package contains an underlying SQLite database mapping probes to their physical locations and types.

```r
library(pd.ht.mg.430a)

# Get the connection to the annotation database
conn <- db(pd.ht.mg.430a)

# List tables in the annotation database
dbListTables(conn)

# Query the feature table (contains probe x/y coordinates and types)
features <- dbGetQuery(conn, "SELECT * FROM feature LIMIT 10")
```

## Tips
- **Memory Management**: This package loads large annotation objects into memory. If working with limited RAM, ensure you clear unused objects using `rm()` and `gc()`.
- **Platform Verification**: Ensure your array is specifically the "HT" (High-Throughput) version of the Mouse Genome 430A. The standard "MG-430A" uses a different annotation package (`pd.mg.u430a`).
- **Sequence Analysis**: Use the `pmSequence` data if you need to perform GC-content based background correction or probe-level sequence analysis.

## Reference documentation

- [pd.ht.mg.430a Reference Manual](./references/reference_manual.md)
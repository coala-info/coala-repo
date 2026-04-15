---
name: bioconductor-pd.hg.u95a
description: This package provides annotation and platform design data for the Affymetrix Human Genome U95A microarray. Use when user asks to preprocess raw CEL files using the oligo package, map probe identifiers to sequences, or query HG-U95A metadata via SQLite.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u95a.html
---

# bioconductor-pd.hg.u95a

name: bioconductor-pd.hg.u95a
description: Annotation package for the Affymetrix Human Genome U95A (HG-U95A) platform. Use this skill when processing or analyzing HG-U95A microarray data in R, specifically when using the 'oligo' or 'DBI' packages to map probe identifiers to sequences or perform low-level preprocessing.

# bioconductor-pd.hg.u95a

## Overview
The `pd.hg.u95a` package is a Platform Design (PD) annotation package for the Affymetrix HG-U95A microarray. It provides the necessary SQLite-based infrastructure for the `oligo` package to handle feature-level data, including probe sequences and genomic locations. It is primarily used for preprocessing raw CEL files.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pd.hg.u95a")
library(pd.hg.u95a)
```

## Typical Workflows

### 1. Preprocessing with oligo
The most common use case is providing the annotation backend for the `read.celfiles` function in the `oligo` package.

```r
library(oligo)
# Read CEL files; oligo automatically detects and uses pd.hg.u95a
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### 2. Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence' columns
head(pmSequence)

# Access specific sequences
my_seqs <- pmSequence$sequence[1:10]
```

### 3. Database Connectivity
Since the package is built on SQLite, you can query the underlying metadata directly using `DBI`.

```r
library(DBI)
# Get the connection object
conn <- dbconn(pd.hg.u95a)

# List tables in the annotation database
dbListTables(conn)

# Query the feature table (example)
features <- dbGetQuery(conn, "SELECT * FROM feature LIMIT 10")
```

## Tips and Best Practices
- **Automatic Detection**: You rarely need to call `pd.hg.u95a` functions directly; the `oligo` package is designed to find and load this package automatically based on the CEL file header.
- **Memory Management**: Sequence data objects can be large. Only load `data(pmSequence)` if you specifically need to analyze probe-level sequences.
- **Compatibility**: Ensure this package version matches your Bioconductor release to avoid schema mismatches with the `oligo` package.

## Reference documentation
- [pd.hg.u95a Reference Manual](./references/reference_manual.md)
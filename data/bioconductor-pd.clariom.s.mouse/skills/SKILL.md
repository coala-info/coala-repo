---
name: bioconductor-pd.clariom.s.mouse
description: This package provides annotation metadata and SQLite-based mapping for the Affymetrix Clariom S Mouse microarray. Use when user asks to process Clariom S Mouse CEL files, perform RMA normalization using the oligo package, or access probe sequence information for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.clariom.s.mouse.html
---

# bioconductor-pd.clariom.s.mouse

name: bioconductor-pd.clariom.s.mouse
description: Annotation package for the Clariom S Mouse array. Use this skill when processing Affymetrix/Thermo Fisher Clariom S Mouse microarray data, specifically for providing platform-specific annotation metadata to the 'oligo' or 'affy' packages during data preprocessing and normalization.

# bioconductor-pd.clariom.s.mouse

## Overview
The `pd.clariom.s.mouse` package is a Bioconductor annotation data package. It provides the necessary SQLite-based mapping and sequence information for the Clariom S Mouse array. It is primarily designed to work as a backend for the `oligo` package to enable the preprocessing (e.g., RMA normalization) of .CEL files.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.clariom.s.mouse")
```

## Typical Workflow

### 1. Loading Data with oligo
The most common use case is loading .CEL files. The `oligo` package automatically detects and loads `pd.clariom.s.mouse` if the CEL files are from that platform.

```r
library(oligo)
library(pd.clariom.s.mouse)

# List CEL files
celFiles <- list.celfiles(full.names = TRUE)

# Read intensity data
# The pd.clariom.s.mouse package is used internally here
rawData <- read.celfiles(celFiles)

# Perform RMA normalization
eset <- rma(rawData)
```

### 2. Accessing Sequence Data
You can access the Perfect Match (PM) probe sequences stored within the package for sequence-specific analysis.

```r
library(pd.clariom.s.mouse)
data(pmSequence)

# View the first few sequences
head(pmSequence)

# Structure: 'fid' (feature ID) and 'sequence'
# fid: 1, 2, 3...
# sequence: ATGC...
```

### 3. Inspecting the Annotation Database
The package contains an SQLite database mapping probes to genomic locations and feature types.

```r
# Get the connection to the annotation database
conn <- db(pd.clariom.s.mouse)

# List tables in the database
dbListTables(conn)

# Example: Query the featureSet table
dbGetQuery(conn, "SELECT * FROM featureSet LIMIT 5")
```

## Tips
- **Memory Management**: Microarray annotation packages can be large. Ensure you have sufficient RAM when loading large batches of CEL files.
- **Automatic Triggering**: You rarely need to call functions inside `pd.clariom.s.mouse` directly; simply having it installed and loaded is usually enough for `oligo::read.celfiles()` to function correctly.
- **Compatibility**: This package is specifically for the "S" (Standard) version of the Clariom mouse array. Ensure your chip type matches exactly.

## Reference documentation
- [pd.clariom.s.mouse Reference Manual](./references/reference_manual.md)
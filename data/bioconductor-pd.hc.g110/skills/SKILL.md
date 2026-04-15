---
name: bioconductor-pd.hc.g110
description: This package provides platform design annotation data for the Affymetrix Human Genome G110 microarray. Use when user asks to perform low-level analysis of CEL files, normalize data using the oligo package, or access probe sequence information for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hc.g110.html
---

# bioconductor-pd.hc.g110

name: bioconductor-pd.hc.g110
description: Annotation package for the Affymetrix Human Genome G110 (hc.g110) microarray. Use when performing low-level analysis of .CEL files from this platform, specifically when using the oligo package for preprocessing, normalization, or probe-level sequence analysis.

# bioconductor-pd.hc.g110

## Overview

The `pd.hc.g110` package is a Platform Design (PD) annotation package for the Affymetrix Human Genome G110 array. It was generated using the `pdInfoBuilder` package and is primarily designed to work with the `oligo` package to provide the necessary mapping between probe identifiers, sequences, and physical locations on the chip.

This package contains the SQLite database that defines the chip layout and provides access to probe sequence data (Perfect Match, Mismatch, and Background).

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.hc.g110)
```

### 2. Using with the oligo Package
When analyzing Affymetrix CEL files, specify this package as the `pkgname` if it is not automatically detected:

```r
library(oligo)

# List CEL files
celFiles <- list.celfiles(full.names = TRUE)

# Read CEL files using the pd.hc.g110 annotation
rawData <- read.celfiles(celFiles, pkgname = "pd.hc.g110")

# Perform RMA normalization
eset <- rma(rawData)
```

### 3. Accessing Probe Sequences
You can access the sequence data for the probes on the array using the `data()` function. The sequences are stored in `DataFrame` objects.

```r
# Load Perfect Match (PM) sequences
data(pmSequence)

# View the first few sequences
# Columns include 'fid' (feature ID) and 'sequence'
head(pmSequence)

# Similarly for Mismatch (MM) or Background (BG) if available
# data(mmSequence)
# data(bgSequence)
```

### 4. Database Interaction
Since the package stores information in an SQLite database, you can inspect the underlying metadata if needed:

```r
# Get the connection to the SQLite database
conn <- db(pd.hc.g110)

# List tables in the annotation database
dbListTables(conn)

# Example: Query the feature table
dbGetQuery(conn, "SELECT * FROM feature LIMIT 10")
```

## Tips and Usage Notes

- **Memory Management**: PD packages can be large. If working with many CEL files, ensure your R session has sufficient memory for the `oligo` objects.
- **Compatibility**: This package is specifically for the `hc.g110` array. Using it with CEL files from other arrays (like HG-U133 Plus 2.0) will result in errors or incorrect mappings.
- **Feature IDs**: The `fid` column in the sequence dataframes corresponds to the feature indices used by the `oligo` package during low-level processing.

## Reference documentation

- [pd.hc.g110 Reference Manual](./references/reference_manual.md)
---
name: bioconductor-pd.hu6800
description: This package provides platform design and annotation information for the Affymetrix Hu6800 array. Use when user asks to preprocess .CEL files using the oligo package, access probe sequence data, or query the underlying SQLite database for this specific microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hu6800.html
---


# bioconductor-pd.hu6800

## Overview

The `pd.hu6800` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Hu6800 array. This package is primarily designed to work in tandem with the `oligo` package to facilitate the preprocessing (background correction, normalization, and summarization) of .CEL files.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.hu6800")

library(pd.hu6800)
```

## Typical Workflows

### Integration with oligo

The most common use case is automatic invocation by the `oligo` package when reading CEL files. You do not usually need to call `pd.hu6800` functions directly when using `read.celfiles()`.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
# oligo will automatically look for and use pd.hu6800 for annotation
```

### Accessing Probe Sequences

The package contains sequence information for Perfect Match (PM) probes. This is useful for sequence-specific analysis or custom normalization methods.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
sequences <- pmSequence$sequence
```

### Database Inspection

The package stores its mapping data in an underlying SQLite database. You can interact with this database directly for advanced queries.

```r
# Get the connection object
conn <- db(pd.hu6800)

# List tables in the annotation database
dbListTables(conn)

# Example: Query the feature table
# Note: Table names typically include 'feature', 'pmfeature', etc.
dbGetQuery(conn, "SELECT * FROM feature LIMIT 5")
```

## Usage Tips

- **Memory Management**: PD objects can be large. If you are finished with low-level preprocessing and have moved to expression-level analysis (e.g., using a `SummarizedExperiment` or `ExpressionSet`), you can detach the package to free memory.
- **Compatibility**: Ensure that the version of `pd.hu6800` matches your Bioconductor release to avoid schema mismatches with the `oligo` package.
- **Probe Types**: While `pmSequence` is the primary dataset, the package structure (via `pdInfoBuilder`) supports `bgSequence` (background) and `mmSequence` (mismatch) if they were defined for the platform.

## Reference documentation

- [pd.hu6800 Reference Manual](./references/reference_manual.md)
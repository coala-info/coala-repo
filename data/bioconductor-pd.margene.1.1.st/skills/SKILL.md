---
name: bioconductor-pd.margene.1.1.st
description: This package provides platform design and annotation information for the Affymetrix MarGene 1.1 ST microarray. Use when user asks to process MarGene 1.1 ST CEL files, map probe identifiers to sequences, or provide platform metadata for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.margene.1.1.st.html
---

# bioconductor-pd.margene.1.1.st

name: bioconductor-pd.margene.1.1.st
description: Annotation and platform design information for the Affymetrix MarGene 1.1 ST array. Use when processing MarGene 1.1 ST microarray data in R, specifically for mapping probe identifiers to sequences and providing platform metadata for the oligo package.

# bioconductor-pd.margene.1.1.st

## Overview

The `pd.margene.1.1.st` package is a Bioconductor annotation package built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix MarGene 1.1 ST array. This package is primarily designed to work as a backend for the `oligo` package to facilitate the preprocessing, normalization, and analysis of "ST" (Sense Target) family microarrays.

## Usage and Workflow

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo::read.celfiles()`, but it can be loaded manually:

```r
library(pd.margene.1.1.st)
```

### Integration with oligo
The most common use case is providing the annotation database for an `ExpressionFeatureSet` or `GeneFeatureSet`:

```r
library(oligo)

# Read CEL files; oligo uses pd.margene.1.1.st automatically if the headers match
raw_data <- read.celfiles(filenames = list.celfiles())

# Inspect the platform design information
show(raw_data)
```

### Accessing Sequence Data
The package contains sequence information for Perfect Match (PM) probes, which is essential for algorithms like GC-RMA that require probe sequence context.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific sequence by feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Database Connection
The package stores annotation data in an SQLite database. You can access the underlying connection if you need to perform custom SQL queries on probe geometries or feature mappings:

```r
# Get the connection object
conn <- db(pd.margene.1.1.st)

# List tables in the annotation database
dbListTables(conn)

# Example: Querying the feature table
# dbGetQuery(conn, "SELECT * FROM feature LIMIT 5")
```

## Tips
- **Memory Management**: Annotation packages can be large. Ensure you have sufficient RAM when processing large batches of CEL files.
- **ST Array Architecture**: This package is specific to the "Sense Target" (ST) design. Ensure your array type is exactly MarGene 1.1 ST; otherwise, `oligo` may throw a mismatch error.
- **Dependencies**: Always ensure the `oligo` package is installed, as `pd.margene.1.1.st` provides the data but `oligo` provides the functional methods.

## Reference documentation
- [pd.margene.1.1.st Reference Manual](./references/reference_manual.md)
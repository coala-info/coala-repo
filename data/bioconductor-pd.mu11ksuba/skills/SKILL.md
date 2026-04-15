---
name: bioconductor-pd.mu11ksuba
description: This package provides platform design and annotation data for the Affymetrix MU11KsubA microarray chip. Use when user asks to process Affymetrix MU11KsubA microarray data, map probe identifiers to sequences, or provide platform metadata for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mu11ksuba.html
---

# bioconductor-pd.mu11ksuba

name: bioconductor-pd.mu11ksuba
description: Annotation package for the Affymetrix MU11KsubA chip. Use when processing Affymetrix MU11KsubA microarray data in R, specifically for mapping probe identifiers to sequences and providing platform design information for the 'oligo' or 'eeR' packages.

# bioconductor-pd.mu11ksuba

## Overview
The `pd.mu11ksuba` package is a Bioconductor annotation package (Platform Design) specifically built for the Affymetrix MU11KsubA microarray. It is primarily used as a backend dependency for the `oligo` package to facilitate the preprocessing, normalization, and analysis of expression data from this specific chip architecture.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.mu11ksuba)
```

### Integration with oligo
The most common workflow involves using this package to provide the necessary platform geometry and annotation for `ExpressionFeatureSet` objects.

```r
library(oligo)

# Read CEL files (pd.mu11ksuba is used automatically if the chip is detected)
raw_data <- read.celfiles(filenames = list.celfiles())

# The platform design information is now linked to the raw_data object
show(raw_data)
```

### Accessing Sequence Data
The package contains sequence information for Perfect Match (PM) probes, which is essential for algorithms that account for probe-specific effects (like GC content).

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Accessing specific probe sequences
# 'fid' corresponds to the feature ID in the oligo object
```

### Database Connection
The package stores its metadata in an SQLite database. You can access the underlying database connection if you need to perform custom SQL queries on the probe mappings.

```r
# Get the DB connection
conn <- db(pd.mu11ksuba)

# List tables (e.g., feature, pmfeature, mmfeature)
dbListTables(conn)

# Example: Query the feature table
dbGetQuery(conn, "SELECT * FROM feature LIMIT 5")
```

## Tips
- **Memory Management**: These annotation packages can be large. If you are working with many samples, ensure your R session has sufficient memory to hold the platform design object.
- **Mismatch Probes**: While primarily used for PM probes, the package structure supports background and mismatch (MM) sequences if they are defined for this specific array design.
- **Version Consistency**: Ensure that `pd.mu11ksuba` is used with a compatible version of the `oligo` package for stable preprocessing results.

## Reference documentation
- [pd.mu11ksuba Reference Manual](./references/reference_manual.md)
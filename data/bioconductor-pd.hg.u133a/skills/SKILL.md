---
name: bioconductor-pd.hg.u133a
description: This package provides platform design annotation and probe-level metadata for the Affymetrix Human Genome U133A microarray. Use when user asks to perform low-level preprocessing of HG-U133A CEL files, access probe sequences, or map probe identifiers to physical array locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u133a.html
---

# bioconductor-pd.hg.u133a

name: bioconductor-pd.hg.u133a
description: Annotation package for the Affymetrix Human Genome U133A (HG-U133A) microarray. Use when performing low-level preprocessing, normalization, or sequence-level analysis of HG-U133A CEL files, particularly in conjunction with the 'oligo' or 'pdInfoBuilder' packages.

# bioconductor-pd.hg.u133a

## Overview
The `pd.hg.u133a` package is a platform design (pd) annotation package for the Affymetrix HG-U133A microarray. It provides the necessary mapping between probe identifiers, sequences, and physical locations on the array. It is built using a SQLite database backend and is designed to work seamlessly with the `oligo` package for high-level microarray analysis.

## Usage

### Loading the Package
The package is typically loaded automatically when reading CEL files, but can be invoked manually:
```r
library(pd.hg.u133a)
```

### Integration with oligo
When analyzing HG-U133A data, the `oligo` package uses this skill to identify the array layout:
```r
library(oligo)
# Assuming .CEL files are in the working directory
raw_data <- read.celfiles(list.celfiles())
# The 'pd.hg.u133a' package will be used to provide the platform metadata
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences directly for sequence-specific analysis (e.g., GC content calculation or motif searching):
```r
# Load the sequence data
data(pmSequence)

# View the first few entries
# Returns a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Database Interaction
Since the package is based on a SQLite database, you can query the underlying tables for specific probe information:
```r
# Get the database connection
con <- db(pd.hg.u133a)

# List tables in the annotation database
dbListTables(con)

# Example: Querying the feature table
# dbGetQuery(con, "SELECT * FROM feature LIMIT 10")
```

## Workflow Tips
- **Memory Management**: These annotation packages can be large. Ensure your R environment has sufficient memory when loading multiple platform design packages.
- **Automatic Detection**: If `read.celfiles()` fails to find the package, ensure it is installed via `BiocManager::install("pd.hg.u133a")`.
- **Data Types**: The `pmSequence` object is a `DataFrame` from the `S4Vectors` package, not a standard R `data.frame`.

## Reference documentation
- [pd.hg.u133a Reference Manual](./references/reference_manual.md)
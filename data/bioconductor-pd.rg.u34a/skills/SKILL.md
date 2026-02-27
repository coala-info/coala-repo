---
name: bioconductor-pd.rg.u34a
description: This package provides annotation and platform design data for the Affymetrix Rat Genome U34A microarray. Use when user asks to preprocess .CEL files from this array using the oligo package, retrieve probe sequence information, or access chip metadata for rat genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rg.u34a.html
---


# bioconductor-pd.rg.u34a

name: bioconductor-pd.rg.u34a
description: Annotation and platform design data for the Affymetrix Rat Genome U34A (RG-U34A) microarray. Use this skill when preprocessing .CEL files from this specific array using the oligo package, or when retrieving probe sequence information for rat genomic studies.

## Overview

The `pd.rg.u34a` package is a Bioconductor annotation package built using `pdInfoBuilder`. It provides the necessary infrastructure to analyze Affymetrix Rat Genome U34A arrays. It is primarily designed to work as a backend for the `oligo` package, providing mapping between probe identifiers, x/y coordinates on the chip, and probe sequences.

## Usage

### Loading the Package
While you can load the package directly, it is most commonly loaded automatically by the `oligo` package when it detects the RG-U34A chip type in raw data.

```r
library(pd.rg.u34a)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes, as well as Mismatch (MM) and Background (BG) probes if applicable.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with oligo
When analyzing .CEL files, `oligo` uses this package to create a FeatureSet object.

```r
library(oligo)

# Assuming .CEL files are in the current directory
raw_data <- read.celfiles()

# The platform design information is automatically linked
# You can verify the annotation slot
annotation(raw_data)
```

### Database Connection
The package stores metadata in an SQLite database. You can access this directly for advanced queries using the `DBI` interface.

```r
# Get the connection object
con <- db(pd.rg.u34a)

# List tables (e.g., feature, pmfeature, probe)
dbListTables(con)

# Example: Querying the feature table
features <- dbGetQuery(con, "SELECT * FROM feature LIMIT 10")
```

## Workflows

### Standard Preprocessing
1. Load the `oligo` library.
2. Read CEL files using `read.celfiles()`.
3. Perform RMA normalization: `eset <- rma(raw_data)`.
4. The `pd.rg.u34a` package ensures that probes are correctly grouped into probesets during this process.

### Sequence Analysis
If you need to perform sequence-specific analysis (like GC-content correction or probe-level filtering):
1. Load `pmSequence`.
2. Merge the sequence data with your expression data using the `fid` (Feature ID).

## Reference documentation

- [pd.rg.u34a Reference Manual](./references/reference_manual.md)
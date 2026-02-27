---
name: bioconductor-pd.medgene.1.0.st
description: This package provides annotation and platform design metadata for the Affymetrix MedGene 1.0 ST array. Use when user asks to process MedGene 1.0 ST CEL files, perform low-level preprocessing with the oligo package, or access probe sequence information for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.medgene.1.0.st.html
---


# bioconductor-pd.medgene.1.0.st

name: bioconductor-pd.medgene.1.0.st
description: Annotation package for the MedGene 1.0 ST array. Use when processing Affymetrix/GeneChip MedGene 1.0 ST expression data in R, specifically for low-level preprocessing, feature mapping, and probe sequence analysis using the oligo or biostrings packages.

# bioconductor-pd.medgene.1.0.st

## Overview
The `pd.medgene.1.0.st` package is a platform design (pd) annotation package for the MedGene 1.0 ST array. It is built using `pdInfoBuilder` and is specifically designed to work with the `oligo` package to provide the necessary mapping between physical probe locations on the chip and their corresponding sequences or feature identifiers.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be called directly:
```r
library(pd.medgene.1.0.st)
```

### Integration with oligo
This package provides the underlying database for preprocessing MedGene 1.0 ST arrays. When using `read.celfiles()`, `oligo` identifies the correct `pd` package to use for background correction, normalization (RMA), and summarization.

```r
library(oligo)
# Read CEL files
affyRaw <- read.celfiles(filenames = list.celfiles())

# The pd.medgene.1.0.st package is used here behind the scenes
eset <- rma(affyRaw)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is useful for sequence-specific analysis or custom quality control.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence')
head(pmSequence)

# Example: Convert to DNAStringSet for Biostrings analysis
library(Biostrings)
pmSeqs <- DNAStringSet(pmSequence$sequence)
names(pmSeqs) <- pmSequence$fid
```

### Database Connection
The package stores annotation metadata in an SQLite database. You can access the connection directly for advanced querying of probe-to-feature mappings:

```r
# Get the DB connection
conn <- db(pd.medgene.1.0.st)

# List tables (e.g., feature, pmfeature, mmfeature)
dbListTables(conn)

# Example: Query the feature table
features <- dbGetQuery(conn, "SELECT * FROM feature LIMIT 10")
```

## Tips
- **Memory Management**: These annotation objects can be large. Ensure you have sufficient RAM when loading `pmSequence`.
- **Compatibility**: This package is intended for "ST" (Sense Target) arrays. Ensure your CEL files match the MedGene 1.0 ST platform; otherwise, `oligo` will throw an error regarding mismatched platform designs.
- **Annotation**: For higher-level gene annotations (symbols, GO terms), use this package in conjunction with the corresponding transcript-cluster or gene-level annotation packages (e.g., `medgene10sttranscriptcluster.db`).

## Reference documentation
- [pd.medgene.1.0.st Reference Manual](./references/reference_manual.md)
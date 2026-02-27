---
name: bioconductor-pd.rhegene.1.1.st
description: This package provides annotation data and platform design information for the Affymetrix RheGene-1_1-st-v1 expression array. Use when user asks to process Rhesus Macaque CEL files, perform RMA normalization on RheGene 1.1 ST data, or access probe sequences and feature mappings for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rhegene.1.1.st.html
---


# bioconductor-pd.rhegene.1.1.st

name: bioconductor-pd.rhegene.1.1.st
description: Annotation data package for the Affymetrix RheGene-1_1-st-v1 (Rhesus Gene 1.1 ST) expression array. Use when processing, normalizing, or annotating Rhesus Macaque genomic data using the oligo or xps packages.

# bioconductor-pd.rhegene.1.1.st

## Overview
The `pd.rhegene.1.1.st` package is a platform design (PD) annotation package for the Affymetrix RheGene 1.1 ST array. It provides the necessary mapping between probe identifiers, physical locations on the chip, and probe sequences. It is primarily designed to work as a backend dependency for the `oligo` package to enable the analysis of Rhesus Macaque whole-transcriptome expression data.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be loaded manually:
```r
library(pd.rhegene.1.1.st)
```

### Integration with oligo
The most common workflow involves using this package to provide the platform geometry for raw data processing:
```r
library(oligo)

# Read CEL files; oligo automatically detects and loads pd.rhegene.1.1.st
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for sequence-specific analysis:
```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence' columns
head(pmSequence)
```

### Database Connection
The package stores its mapping information in an SQLite database. You can inspect the underlying metadata:
```r
# Get the connection object
conn <- db(pd.rhegene.1.1.st)

# List tables (e.g., featureSet, pmfeature, mmfeature)
dbListTables(conn)

# Example: Query the featureSet table
dbGetQuery(conn, "SELECT * FROM featureSet LIMIT 5")
```

## Tips
- **Memory Management**: These annotation objects can be large. If you encounter memory issues, ensure you are only loading the necessary components.
- **Automatic Detection**: Ensure the `pd.rhegene.1.1.st` package is installed; `oligo` will fail to read RheGene 1.1 ST CEL files if this specific annotation package is missing.
- **ST Arrays**: As an "ST" (Sense Target) array, the probes are distributed across the entire length of the gene, not just the 3' end.

## Reference documentation
- [pd.rhegene.1.1.st Reference Manual](./references/reference_manual.md)
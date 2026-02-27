---
name: bioconductor-pd.hugene.2.1.st
description: This package provides annotation and platform design infrastructure for the Affymetrix Human Gene 2.1 ST microarray. Use when user asks to process CEL files, perform RMA normalization, or map probe identifiers for HuGene 2.1 ST expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hugene.2.1.st.html
---


# bioconductor-pd.hugene.2.1.st

name: bioconductor-pd.hugene.2.1.st
description: Annotation package for the Affymetrix GeneChip Human Gene 2.1 ST array. Use when processing, normalizing, or annotating HuGene 2.1 ST expression data, specifically when using the 'oligo' or 'xps' packages for low-level microarray analysis.

# bioconductor-pd.hugene.2.1.st

## Overview
The `pd.hugene.2.1.st` package is a platform design (PD) annotation package for the Affymetrix Human Gene 2.1 ST array. It provides the necessary SQLite-based infrastructure for the `oligo` package to map probe identifiers to their physical locations, sequences, and feature types. This package is essential for performing background correction, normalization (like RMA), and summarization of .CEL files for this specific array generation.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but can be loaded manually:
```r
library(pd.hugene.2.1.st)
```

### Integration with oligo
The primary use case is providing the annotation backend for `read.celfiles`. The `oligo` package identifies the correct `pd` package from the CEL file header.

```r
library(oligo)

# Read CEL files - pd.hugene.2.1.st is used automatically if the chips are HuGene 2.1 ST
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-specific analysis.

```r
library(pd.hugene.2.1.st)
data(pmSequence)

# View the first few sequences
head(pmSequence)

# Structure: 'fid' (feature ID) and 'sequence'
# fid corresponds to the row index in the feature level data
```

### Database Connection
The package stores mapping information in an SQLite database. You can access the underlying database connection if advanced metadata extraction is required:

```r
# Get the DB connection object
conn <- db(pd.hugene.2.1.st)

# List tables (e.g., feature, pmfeature, probeset)
dbListTables(conn)

# Example: Querying the feature table
features <- dbGetQuery(conn, "SELECT * FROM feature LIMIT 10")
```

## Tips
- **Memory Management**: This package loads a large SQLite database. Ensure sufficient RAM when processing large batches of HuGene 2.1 ST arrays.
- **Compatibility**: This package is designed for the "ST" (Sense Target) version of the array. Ensure your samples are indeed 2.1 ST and not the older 1.0 ST or 1.1 ST versions, which require different `pd` packages.
- **Annotation**: While this package provides the physical layout, use the `hugene21sttranscriptcluster.db` or `hugene21stprobeset.db` packages for mapping probesets to Gene Symbols, Entrez IDs, and GO terms.

## Reference documentation
- [pd.hugene.2.1.st Reference Manual](./references/reference_manual.md)
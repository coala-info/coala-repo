---
name: bioconductor-pd.rhegene.1.0.st
description: This package provides annotation and platform design information for the Affymetrix RheGene 1.0 ST array. Use when user asks to process Rhesus Macaque gene expression data, map probe identifiers to sequences, or perform RMA normalization using the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rhegene.1.0.st.html
---

# bioconductor-pd.rhegene.1.0.st

name: bioconductor-pd.rhegene.1.0.st
description: Annotation and platform design information for the Affymetrix RheGene 1.0 ST array. Use when processing Rhesus Macaque (Macaca mulatta) gene expression data using the oligo or xps packages, specifically for mapping probe identifiers to sequences and genomic coordinates.

# bioconductor-pd.rhegene.1.0.st

## Overview

The `pd.rhegene.1.0.st` package is a Platform Design (PD) annotation package for the Affymetrix RheGene 1.0 ST Array. It is built using the `pdInfoBuilder` infrastructure and is primarily designed to work in tandem with the `oligo` package to facilitate the preprocessing and analysis of Rhesus Macaque Whole Transcript (WT) expression data.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo::read.celfiles()`, provided the package is installed. To load it manually:

```r
library(pd.rhegene.1.0.st)
```

### Integration with oligo
The most common workflow involves using this package as the annotation backend for an `ExpressionFeatureSet` or `GeneFeatureSet`.

```r
library(oligo)

# Read CEL files (the pd package is detected from the CEL header)
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization using the pd.rhegene.1.0.st mapping
eset <- rma(raw_data)
```

### Accessing Sequence Data
The package contains probe sequence information stored in a `DataFrame` object. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the PM (Perfect Match) sequence data
data(pmSequence)

# View the structure (columns: fid, sequence)
head(pmSequence)

# Access specific sequences by feature ID
# Example: Get sequence for feature ID 100
pmSequence[pmSequence$fid == 100, ]
```

### Database Connection
The package stores annotation metadata in an SQLite database. You can interact with it directly for advanced queries:

```r
# Get the connection object
con <- db(pd.rhegene.1.0.st)

# List tables (e.g., feature, pmfeature, mmfeature, probe)
dbListTables(con)

# Example: Query the feature table
features <- dbGetQuery(con, "SELECT * FROM feature LIMIT 10")
```

## Tips and Best Practices
- **Memory Management**: PD packages can be large. Ensure your R session has sufficient memory when processing large batches of ST arrays.
- **Compatibility**: This package is specifically for the "ST" (Sense Target) version of the RheGene array. Ensure your array type matches this platform exactly.
- **Annotation Updates**: While `pd.rhegene.1.0.st` provides the physical mapping of probes on the chip, use the `rhegene10stprobeset.db` or `rhegene10sttranscriptcluster.db` packages for higher-level biological annotations (Gene Symbols, GO terms, Entrez IDs).

## Reference documentation
- [pd.rhegene.1.0.st Reference Manual](./references/reference_manual.md)
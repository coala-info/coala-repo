---
name: bioconductor-pd.guigene.1.1.st
description: This package provides annotation and platform design information for the Affymetrix Guigene 1.1 ST array. Use when user asks to process Guigene 1.1 ST microarray data, perform RMA normalization on CEL files, or access probe sequences and platform layout information.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.guigene.1.1.st.html
---


# bioconductor-pd.guigene.1.1.st

name: bioconductor-pd.guigene.1.1.st
description: Annotation and platform design information for the Affymetrix Guigene 1.1 ST array. Use when processing Guigene 1.1 ST microarray data with the 'oligo' or 'DBI' packages to map probe identifiers to sequences or to provide the necessary platform design information for preprocessing (normalization, background correction).

# bioconductor-pd.guigene.1.1.st

## Overview

The `pd.guigene.1.1.st` package is a Bioconductor annotation package specifically designed for the Affymetrix Guigene 1.1 ST array. It provides the infrastructure required by the `oligo` package to handle the specific layout and probe sequences of this platform. It is primarily used as a backend database during the preprocessing of .CEL files.

## Typical Workflow

### Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo::read.celfiles()`, but can be invoked directly:

```r
library(pd.guigene.1.1.st)
```

### Usage with oligo
When analyzing Guigene 1.1 ST data, this package provides the platform design (pd) information needed for robust multi-array analysis (RMA):

```r
library(oligo)
# Read CEL files (the pd package is identified from the CEL header)
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
# oligo uses pd.guigene.1.1.st in the background
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-level analysis:

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get sequence for a specific feature ID
# pmSequence is a DataFrame object
target_seq <- pmSequence[pmSequence$fid == 12345, "sequence"]
```

### Database Interaction
The package stores mapping information in an SQLite database. You can interact with it directly for advanced queries:

```r
# Get the connection to the underlying SQLite database
conn <- db(pd.guigene.1.1.st)

# List tables (e.g., feature, pmfeature, probe)
dbListTables(conn)

# Example: Query the feature table
features <- dbGetQuery(conn, "SELECT * FROM feature LIMIT 10")
```

## Tips
- **Memory Management**: This package loads a large SQLite database. Ensure your R environment has sufficient memory when processing large batches of CEL files.
- **Compatibility**: This package is specifically for the "Guigene 1.1 ST" version. Ensure your array type matches exactly; otherwise, `oligo` will throw an error regarding the platform design.
- **Annotation**: While this package provides the physical layout and sequences, use the corresponding "db" annotation package (e.g., `guigene11sttranscriptcluster.db`) for mapping probe sets to gene symbols or Entrez IDs.

## Reference documentation
- [pd.guigene.1.1.st Reference Manual](./references/reference_manual.md)
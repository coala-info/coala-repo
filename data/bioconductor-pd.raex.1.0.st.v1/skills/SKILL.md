---
name: bioconductor-pd.raex.1.0.st.v1
description: This package provides annotation and platform design information for the Affymetrix Rat Exon 1.0 ST microarray. Use when user asks to process, normalize, or annotate Rat Exon 1.0 ST array data using the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.raex.1.0.st.v1.html
---

# bioconductor-pd.raex.1.0.st.v1

name: bioconductor-pd.raex.1.0.st.v1
description: Annotation and platform design information for the Affymetrix raex10st (Rat Exon 1.0 ST) array. Use when processing, normalizing, or annotating Rat Exon 1.0 ST microarrays using the oligo or xps packages.

# bioconductor-pd.raex.1.0.st.v1

## Overview

The `pd.raex.1.0.st.v1` package is a Bioconductor annotation package specifically designed for the Affymetrix Rat Exon 1.0 ST Array. It provides the necessary platform design information (probe sequences, locations, and feature identifiers) required by high-level analysis packages like `oligo` to map raw intensity data (.CEL files) to genomic features.

## Usage and Workflows

### Primary Integration with oligo
This package is rarely called directly by the user. Instead, it is automatically loaded by the `oligo` package when reading CEL files from the Rat Exon 1.0 ST platform.

```r
library(oligo)

# The oligo package will automatically detect and use pd.raex.1.0.st.v1
# if the CEL files are from the Rat Exon 1.0 ST array.
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can manually inspect the probe sequences stored within the package using the `pmSequence` dataset.

```r
library(pd.raex.1.0.st.v1)
data(pmSequence)

# View the first few probe sequences and their feature IDs (fid)
head(pmSequence)
```

### Database Connection
The package stores its mapping information in an SQLite database. You can access the underlying connection if you need to perform custom SQL queries on the probe geometry.

```r
library(pd.raex.1.0.st.v1)

# Get the connection object
conn <- db(pd.raex.1.0.st.v1)

# List tables in the annotation database
dbListTables(conn)
```

## Tips
- **Memory Management**: Exon arrays are large. Ensure you have sufficient RAM when processing these datasets with `oligo`.
- **Installation**: If `oligo` fails to find the platform design, install this package via `BiocManager::install("pd.raex.1.0.st.v1")`.
- **Target Levels**: When using `rma()` on exon arrays, you can specify the target level (e.g., `target = "core"`, `target = "probeset"`, or `target = "full"`) to determine the granularity of the summarization.

## Reference documentation

- [pd.raex.1.0.st.v1 Reference Manual](./references/reference_manual.md)
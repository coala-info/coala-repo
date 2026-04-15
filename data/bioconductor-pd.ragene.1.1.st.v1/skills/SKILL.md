---
name: bioconductor-pd.ragene.1.1.st.v1
description: This package provides annotation and platform design information for the Affymetrix GeneChip Rat Gene 1.1 ST Array. Use when user asks to process .CEL files, perform RMA normalization, or access probe sequence data for this specific rat microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ragene.1.1.st.v1.html
---

# bioconductor-pd.ragene.1.1.st.v1

name: bioconductor-pd.ragene.1.1.st.v1
description: Annotation and platform design information for the Affymetrix GeneChip Rat Gene 1.1 ST Array. Use this skill when processing or analyzing .CEL files from this specific microarray platform using the oligo or biostrings packages.

# bioconductor-pd.ragene.1.1.st.v1

## Overview
The `pd.ragene.1.1.st.v1` package is a Bioconductor annotation package specifically designed for the Affymetrix Rat Gene 1.1 ST platform. It provides the necessary mapping between probe identifiers, physical locations on the array, and nucleotide sequences. It is primarily used as a backend dependency for the `oligo` package to enable preprocessing, normalization (like RMA), and quality control of rat genomic data.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but can be invoked directly:

```r
library(pd.ragene.1.1.st.v1)
```

### Integration with oligo
The most common workflow involves using this package to provide the platform design information for raw data objects (FeatureSet):

```r
library(oligo)

# Read CEL files; oligo uses pd.ragene.1.1.st.v1 automatically if the header matches
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Sequence Data
You can access the Perfect Match (PM) probe sequences for sequence-specific analysis (e.g., GC content calculations or custom filtering).

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific sequence by feature ID
# pmSequence is a DataFrame object
```

### Database Connection
The package stores mapping information in an SQLite database. You can inspect the underlying mappings if needed:

```r
# Get the connection object
conn <- db(pd.ragene.1.1.st.v1)

# List tables in the annotation database
dbListTables(conn)
```

## Tips
- **Memory Management**: Annotation packages for ST (Sense Target) arrays can be memory-intensive. Ensure your R session has sufficient RAM when processing large batches of CEL files.
- **Platform Matching**: This package is specific to version 1 (`.v1`) of the Rat Gene 1.1 ST array. Ensure your experimental metadata matches this specific platform version to avoid incorrect probe mapping.
- **Background Probes**: The package also contains background sequence information (`bgSequence`) accessible via the same mechanism as `pmSequence`.

## Reference documentation
- [pd.ragene.1.1.st.v1 Reference Manual](./references/reference_manual.md)
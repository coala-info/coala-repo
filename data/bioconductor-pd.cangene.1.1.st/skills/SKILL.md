---
name: bioconductor-pd.cangene.1.1.st
description: This package provides annotation and platform design data for the Affymetrix cangene.1.1.st Gene ST array. Use when user asks to process CEL files, perform RMA normalization, or access probe sequences for this specific microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.cangene.1.1.st.html
---


# bioconductor-pd.cangene.1.1.st

name: bioconductor-pd.cangene.1.1.st
description: Annotation package for the Affymetrix cangene.1.1.st platform. Use when processing, normalizing, or annotating Gene ST array data from this specific platform, typically in conjunction with the 'oligo' or 'xps' packages.

# bioconductor-pd.cangene.1.1.st

## Overview

The `pd.cangene.1.1.st` package is a Bioconductor annotation package (Platform Design) for the Affymetrix cangene.1.1.st array. It provides the necessary mapping between probe identifiers, sequences, and physical locations on the chip. It is primarily used as a backend dependency for high-level analysis packages like `oligo` to enable feature-level preprocessing.

## Usage and Workflows

### Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.cangene.1.1.st)
```

### Integration with oligo
The most common workflow involves using this package to provide the platform design information for an `ExpressionFeatureSet`:

```r
library(oligo)

# Read CEL files; oligo will look for pd.cangene.1.1.st automatically
raw_data <- read.celfiles(filenames = list.celfiles())

# If the annotation needs to be set manually
annotation(raw_data) <- "pd.cangene.1.1.st"

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Sequence Data
You can access the Perfect Match (PM) probe sequences stored within the package for sequence-specific analysis:

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific sequence by feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Database Connection
The package stores annotation mapping in an SQLite database. You can access the underlying connection if advanced querying is required:

```r
# Get the DB connection object
con <- pd.cangene.1.1.st@con

# List tables in the annotation database
dbListTables(con)
```

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when processing large batches of ST arrays.
- **Platform Specificity**: This package is specific to the `cangene.1.1.st` layout. Ensure your CEL files match this platform by checking the `chipType` metadata in the CEL header.
- **Dependencies**: Ensure the `oligo` package is installed to make full use of this annotation data.

## Reference documentation
- [pd.cangene.1.1.st Reference Manual](./references/reference_manual.md)
---
name: bioconductor-pd.fingene.1.0.st
description: This package provides annotation and platform design information for the FinGene 1.0 ST microarray. Use when user asks to analyze Affymetrix FinGene 1.0 ST microarray data, map probe identifiers to sequences, or perform low-level preprocessing using the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.fingene.1.0.st.html
---


# bioconductor-pd.fingene.1.0.st

name: bioconductor-pd.fingene.1.0.st
description: Annotation and platform design information for the FinGene 1.0 ST array. Use this skill when analyzing Affymetrix/GeneChip ST (Sense Target) microarray data that requires the pd.fingene.1.0.st annotation package, specifically for use with the oligo or xps packages to map probe identifiers to sequences and genomic locations.

# bioconductor-pd.fingene.1.0.st

## Overview
The `pd.fingene.1.0.st` package is a Bioconductor annotation package (Platform Design) specifically built for the FinGene 1.0 ST microarray. It provides the necessary SQLite-based infrastructure to map feature identifiers (fids) to probe sequences and is designed to work seamlessly with the `oligo` package for low-level analysis of ST arrays.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be called directly:

```r
library(pd.fingene.1.0.st)
```

### Integration with oligo
The primary use case is providing the platform design information during data preprocessing.

```r
library(oligo)

# Read CEL files - oligo will automatically look for pd.fingene.1.0.st
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-level analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get sequence for a specific feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

### Database Connection
Since this is a `PDInfo` object package, you can interact with the underlying SQLite database if advanced mapping is required.

```r
# Get the DB connection
conn <- db(pd.fingene.1.0.st)

# List tables (e.g., feature, pmfeature, probe)
dbListTables(conn)

# Query specific information
# dbGetQuery(conn, "SELECT * FROM feature LIMIT 10")
```

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when processing large batches of CEL files.
- **ST Array Specifics**: As an "ST" (Sense Target) array, the probes are designed against the sense strand. Ensure your downstream functional analysis accounts for this orientation.
- **Compatibility**: This package is built using `pdInfoBuilder` and is strictly for use with the `oligo` or `xps` packages, not the older `affy` package.

## Reference documentation
- [pd.fingene.1.0.st Reference Manual](./references/reference_manual.md)
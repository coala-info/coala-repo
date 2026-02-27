---
name: bioconductor-pd.mogene.1.1.st.v1
description: This package provides annotation and platform design information for the Affymetrix Mouse Gene 1.1 ST v1 microarray. Use when user asks to process MoGene-1_1-st-v1 CEL files, map probes to genomic locations, or access probe sequences using the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mogene.1.1.st.v1.html
---


# bioconductor-pd.mogene.1.1.st.v1

name: bioconductor-pd.mogene.1.1.st.v1
description: Annotation and platform design information for the Affymetrix Mouse Gene 1.1 ST v1 array. Use when processing Affymetrix MoGene-1_1-st-v1 CEL files using the oligo or xps packages to map probes to genomic locations and sequences.

# bioconductor-pd.mogene.1.1.st.v1

## Overview

The `pd.mogene.1.1.st.v1` package is a Bioconductor annotation data package specifically designed for the Affymetrix Mouse Gene 1.1 ST v1 microarray. It provides the necessary SQLite database mapping between probe identifiers, x/y coordinates on the chip, and probe sequences. This package is a "Platform Design" (PD) package, primarily intended to be used as a backend for the `oligo` package during data preprocessing and normalization.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.mogene.1.1.st.v1)
```

### Integration with oligo
The most common workflow involves using this package to provide the platform geometry for `read.celfiles`.

```r
library(oligo)

# List CEL files
celFiles <- list.celfiles(full.names = TRUE)

# Read files - oligo will automatically detect and use pd.mogene.1.1.st.v1
rawData <- read.celfiles(celFiles)

# Inspect the object to ensure the correct PD package is assigned
print(rawData)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for sequence-specific analysis (e.g., GC content calculations).

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence' columns
head(pmSequence)
```

### Database Connection
For advanced users needing to query the underlying annotation database directly:

```r
# Get the connection to the SQLite database
conn <- db(pd.mogene.1.1.st.v1)

# List tables in the annotation database
dbListTables(conn)

# Example: Query the feature table
# dbGetQuery(conn, "SELECT * FROM feature LIMIT 10")
```

## Tips
- **Memory Management**: PD packages can be memory-intensive. Ensure you have sufficient RAM when processing large batches of Mouse Gene 1.1 ST arrays.
- **Annotation Mapping**: This package provides the physical layout. For mapping probesets to Gene Symbols or Entrez IDs, use the corresponding transcript-level annotation package (e.g., `mogene11sttranscriptcluster.db`).
- **Automatic Detection**: If `read.celfiles` fails to find the package, ensure it is installed via `BiocManager::install("pd.mogene.1.1.st.v1")`.

## Reference documentation

- [pd.mogene.1.1.st.v1 Reference Manual](./references/reference_manual.md)
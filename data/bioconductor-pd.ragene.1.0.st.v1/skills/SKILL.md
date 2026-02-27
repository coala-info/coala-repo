---
name: bioconductor-pd.ragene.1.0.st.v1
description: This package provides platform design annotation for the Affymetrix Rat Gene 1.0 ST Array. Use when user asks to process, normalize, or map probe identifiers for Rat Gene 1.0 ST expression data using the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ragene.1.0.st.v1.html
---


# bioconductor-pd.ragene.1.0.st.v1

name: bioconductor-pd.ragene.1.0.st.v1
description: Annotation package for the Affymetrix Gene 1.0 ST Array for Rat (RaGene-1_0-st-v1). Use this skill when processing, normalizing, or annotating Rat Gene 1.0 ST expression data using the oligo or xps packages in R.

# bioconductor-pd.ragene.1.0.st.v1

## Overview

The `pd.ragene.1.0.st.v1` package is a Platform Design (PD) annotation package for the Affymetrix Rat Gene 1.0 ST Array. It provides the necessary mapping between probe identifiers, sequences, and physical locations on the array. This package is primarily used as a backend dependency for the `oligo` package to enable the preprocessing of .CEL files.

## Typical Workflow

### 1. Loading the Package and Data
The package is typically loaded automatically when reading CEL files with `oligo`, but can be invoked manually to inspect probe sequences.

```r
library(pd.ragene.1.0.st.v1)
library(oligo)

# Load probe sequence data
data(pmSequence)

# Inspect the first few sequences
head(pmSequence)
```

### 2. Preprocessing CEL Files
The most common use case is providing the annotation metadata for Robust Multi-array Average (RMA) normalization.

```r
# Assuming .CEL files are in the current directory
celFiles <- list.celfiles()
rawData <- read.celfiles(celFiles)

# The oligo package automatically detects and uses pd.ragene.1.0.st.v1
# to map probes to probesets during normalization
eset <- rma(rawData)
```

### 3. Accessing Annotation Database
The package contains an SQLite database mapping probes to features.

```r
# Get the connection to the annotation database
conn <- db(pd.ragene.1.0.st.v1)

# List tables in the database (e.g., featureSet, pmfeature)
dbListTables(conn)

# Example: Query the featureSet table
head(dbGetQuery(conn, "SELECT * FROM featureSet LIMIT 10"))
```

## Usage Tips
- **Memory Management**: PD packages can be large. Ensure your R session has sufficient memory when processing large batches of Rat Gene 1.0 ST arrays.
- **Compatibility**: This package is designed for the "v1" version of the Rat Gene 1.0 ST array. Ensure your array version matches this specific package to avoid incorrect probe mapping.
- **Downstream Annotation**: While this package provides the physical platform design, use the `ragene10stprobeset.db` or `ragene10sttranscriptcluster.db` packages for mapping probesets to Gene Symbols, Entrez IDs, and GO terms.

## Reference documentation
- [pd.ragene.1.0.st.v1 Reference Manual](./references/reference_manual.md)
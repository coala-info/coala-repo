---
name: bioconductor-pd.e.coli.2
description: This package provides annotation and platform design data for the Affymetrix E. coli Genome 2.0 Array. Use when user asks to process raw CEL files, map probes to sequences, or perform low-level analysis of E. coli 2.0 microarrays using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.e.coli.2.html
---

# bioconductor-pd.e.coli.2

name: bioconductor-pd.e.coli.2
description: Annotation data package for the Affymetrix E. coli Genome 2.0 Array. Use when performing low-level analysis of E. coli 2.0 microarrays using the 'oligo' or 'pdInfoBuilder' packages, specifically for mapping probe identifiers to sequences and managing chip layout metadata.

# bioconductor-pd.e.coli.2

## Overview
The `pd.e.coli.2` package is a Bioconductor annotation platform data package. It provides the necessary infrastructure to process Affymetrix E. coli Genome 2.0 Array data. Unlike standard annotation packages that provide gene-level metadata (like GO terms or symbols), "pd" (Platform Design) packages contain the SQLite database mapping probes to their physical locations on the chip and their nucleotide sequences. It is primarily used as a dependency by the `oligo` package for preprocessing (e.g., RMA, GCRMA).

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be invoked manually:

```r
library(pd.e.coli.2)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is essential for algorithms that account for hybridization efficiency based on GC content.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence')
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Integration with oligo
The most common workflow involves using this package implicitly to create a FeatureSet object from raw CEL files.

```r
library(oligo)

# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The 'pd.e.coli.2' package provides the layout information 
# for the 'raw_data' object if it was generated from the E. coli 2.0 chip.
# You can verify the annotation slot:
annotation(raw_data)
```

### Database Connection
Since the package stores layout information in an SQLite database, you can access the underlying metadata directly if needed for custom probe filtering.

```r
# Get the connection to the annotation database
conn <- db(pd.e.coli.2)

# List tables (e.g., feature, pmfeature, probe)
dbListTables(conn)

# Query example
# dbGetQuery(conn, "SELECT * FROM feature LIMIT 5")
```

## Tips
- **Memory Management**: The `pmSequence` object can be large. Only load it if you are performing sequence-specific analysis.
- **Compatibility**: Ensure this package version matches your Bioconductor release to avoid schema mismatches with the `oligo` package.
- **Mismatch Probes**: While the package index mentions `mmSequence`, modern Affymetrix designs often focus on PM probes; check the `pmSequence` object first for available data.

## Reference documentation
- [pd.e.coli.2 Reference Manual](./references/reference_manual.md)
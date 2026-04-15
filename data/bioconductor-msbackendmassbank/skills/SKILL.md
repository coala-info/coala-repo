---
name: bioconductor-msbackendmassbank
description: This tool provides backends for the Spectra package to import, manage, and analyze MassBank MS/MS spectral data from text files or SQL databases. Use when user asks to import MassBank record files, query local MassBank SQL databases, retrieve compound metadata, or perform spectral similarity searches against MassBank libraries.
homepage: https://bioconductor.org/packages/release/bioc/html/MsBackendMassbank.html
---

# bioconductor-msbackendmassbank

name: bioconductor-msbackendmassbank
description: Comprehensive handling of MassBank MS/MS spectral data within the R Spectra framework. Use this skill when you need to: (1) Import MassBank text files (.txt) into a Spectra object, (2) Connect to and query local MassBank SQL databases, (3) Retrieve compound annotations and metadata from MassBank records, or (4) Perform spectral similarity searches using MassBank as a reference library.

# bioconductor-msbackendmassbank

## Overview

The `MsBackendMassbank` package provides backends for the `Spectra` package to handle mass spectrometry data from [MassBank](https://massbank.eu/MassBank/). It supports two primary data sources: individual MassBank text files (one spectrum per file) and local MassBank SQL database installations. By using these backends, MassBank data becomes fully compatible with the standard `Spectra` API for analysis, visualization, and comparison.

## Core Workflows

### Importing MassBank Text Files

To import data from MassBank record files (.txt), use the `MsBackendMassbank` backend as the source for a `Spectra` object.

```r
library(Spectra)
library(MsBackendMassbank)

# Get paths to MassBank text files
fls <- dir(system.file("extdata", package = "MsBackendMassbank"),
           full.names = TRUE, pattern = "txt$")

# Create Spectra object
# Use nonStop = TRUE to skip problematic files during batch import
sps <- Spectra(fls, source = MsBackendMassbank(), nonStop = TRUE)
```

### Managing Metadata Blocks

By default, only core metadata is imported. To include additional information (like instrument details or chromatography settings), use `metaDataBlocks()`.

```r
# Define which blocks to import (e.g., AC and MS fields)
mdb <- metaDataBlocks(ac = TRUE, ms = TRUE)

# Import with specific metadata blocks
sps <- Spectra(fls, source = MsBackendMassbank(), metaBlock = mdb)

# Clean up: remove variables that contain only NA values
sps <- dropNaSpectraVariables(sps)
```

### Accessing MassBank SQL Databases

For large-scale access, use the `MsBackendMassbankSql` backend. This requires a connection to a local MySQL/MariaDB or SQLite version of the MassBank database.

```r
library(RSQLite)
# Connect to the database
con <- dbConnect(SQLite(), "path_to_massbank.sqlite")

# Initialize the backend
mb <- Spectra(con, source = MsBackendMassbankSql())

# Access compound-specific information (unique to the SQL backend)
compound_info <- compounds(mb)
```

## Data Analysis and Manipulation

Once loaded into a `Spectra` object, use standard `Spectra` functions to process the data.

### Filtering and Subsetting
```r
# Subset by metadata (e.g., ionization mode)
sps_esi <- mb[mb$ionization == "ESI"]

# Access specific variables
names_list <- sps$name # MassBank names are returned as lists
```

### Spectral Similarity
Compare MassBank spectra against experimental data or other library entries.

```r
library(MsCoreUtils)

# Calculate similarity (e.g., normalized dot product)
sims <- compareSpectra(query_spectrum, mb, FUN = ndotproduct, ppm = 40)

# Visualize the match
plotSpectraMirror(query_spectrum, mb[which.max(sims)], ppm = 40)
```

## Important Considerations

*   **Parallel Processing**: The `MsBackendMassbankSql` backend does **not** support parallel processing because database connections cannot be shared across parallel workers. Functions will automatically revert to serial execution.
*   **Memory Management**: The SQL backend is memory-efficient as it fetches peak data (m/z and intensity) on demand rather than loading everything into RAM.
*   **File Format**: MassBank text files typically contain a single spectrum. If importing thousands of files, the SQL backend is significantly faster than the text-based backend.

## Reference documentation

- [Description and Usage of MsBackendMassbank](./references/MsBackendMassbank.Rmd)
- [Description and Usage of MsBackendMassbank](./references/MsBackendMassbank.md)
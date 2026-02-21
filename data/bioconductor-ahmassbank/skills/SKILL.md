---
name: bioconductor-ahmassbank
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/AHMassBank.html
---

# bioconductor-ahmassbank

## Overview

The `AHMassBank` package serves as a metadata provider that links MassBank, an open-access community database for small chemical compounds, with the Bioconductor `AnnotationHub` infrastructure. It allows users to easily download and cache MassBank releases as `CompDb` objects. These objects are compatible with the `CompoundDb` package, enabling seamless integration into mass spectrometry (MS) annotation workflows, metabolite identification, and spectral matching.

## Key Workflows

### 1. Retrieving MassBank Data from AnnotationHub

The primary use case is fetching a specific version of the MassBank database.

```r
library(AnnotationHub)
library(CompoundDb)
library(AHMassBank)

# Initialize AnnotationHub
ah <- AnnotationHub()

# Query for available MassBank records
mb_records <- query(ah, "MassBank")
print(mb_records)

# Fetch a specific release (e.g., release 2021.03) by its AH ID or tags
cdb <- ah[["AH107048"]] 
# Alternatively:
# qr <- query(ah, c("MassBank", "2021.03"))
# cdb <- qr[[1]]
```

### 2. Using the CompDb Object

Once the `CompDb` object (`cdb`) is loaded, you can use `CompoundDb` functions to explore the data.

```r
# List available tables in the database
tables(cdb)

# Extract compound information
compounds(cdb)

# Extract MS/MS fragment spectra
spectra(cdb)
```

### 3. Creating a CompDb from a Local MassBank MySQL Dump

If you have a local MySQL/MariaDB instance of MassBank, you can convert it to a portable SQLite `CompDb` file.

```r
library(RMariaDB)
library(CompoundDb)

# Connect to your local MassBank MySQL database
con <- dbConnect(MariaDB(), host = "localhost", user = "your_user", 
                 pass = "your_password", dbname = "MassBank")

# Load the conversion script provided by CompoundDb
source(system.file("scripts", "massbank_to_compdb.R", package = "CompoundDb"))

# Perform the conversion
massbank_to_compdb(con)
```

## Tips and Best Practices

*   **Caching**: `AnnotationHub` caches downloads locally. Subsequent calls to the same AH ID will be much faster as they won't require a re-download.
*   **Version Selection**: Always check `query(ah, "MassBank")` to ensure you are using the most recent release for your annotation tasks, as MassBank is frequently updated with new compounds and spectra.
*   **Integration**: Use the retrieved `CompDb` object with the `Spectra` package for advanced spectral matching and MS2 data analysis.

## Reference documentation

- [Creating MassBank CompDbs](./references/creating-MassBank-CompDbs.md)
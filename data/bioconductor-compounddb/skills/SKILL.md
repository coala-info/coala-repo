---
name: bioconductor-compounddb
description: The CompoundDb package provides a flexible infrastructure for managing and querying small molecule annotations, MS/MS spectra, and experimental ion data using a SQLite backend. Use when user asks to create or query compound databases, retrieve MS/MS spectra, manage lab-specific retention times and adducts, or calculate m/z values from exact masses.
homepage: https://bioconductor.org/packages/release/bioc/html/CompoundDb.html
---


# bioconductor-compounddb

## Overview

The `CompoundDb` package provides a flexible infrastructure for managing small molecule annotations. It centers around the `CompDb` object, which interfaces with a SQLite backend to store compound metadata (mass, formula, InChIKey) and MS/MS spectra. It also supports `IonDb` for lab-specific resources including retention times and adduct-specific m/z values.

## Core Workflows

### 1. Loading and Querying a CompDb
Load an existing database and retrieve compound information using filters.

```r
library(CompoundDb)

# Load database
cdb <- CompDb("path/to/database.sql")

# List available variables
compoundVariables(cdb)

# Extract compounds with filters
# Filters use formula syntax (~ variable == value)
res <- compounds(cdb, 
                 columns = c("name", "formula", "exactmass"),
                 filter = ~ name == "Mellein" & exactmass > 170)

# Get supported filter types
supportedFilters(cdb)
```

### 2. Creating a CompDb from Sources
Build databases from SDF files (HMDB, ChEBI, LipidMaps) or custom data frames.

```r
# 1. Extract compound data from SDF
cmps <- compound_tbl_sdf(system.file("sdf/HMDB_sub.sdf.gz", package = "CompoundDb"))

# 2. Load MS/MS spectra (e.g., from HMDB XMLs)
spctra <- msms_spectra_hmdb("path/to/xml_folder")

# 3. Define metadata
metad <- make_metadata(source = "HMDB", url = "http://www.hmdb.ca",
                       source_version = "4.0", source_date = "2017-09",
                       organism = "Hsapiens")

# 4. Create SQLite database
db_file <- createCompDb(cmps, metadata = metad, msms_spectra = spctra, path = tempdir())
```

### 3. Working with MS/MS Spectra
`CompoundDb` integrates with the `Spectra` package for on-the-fly data retrieval.

```r
library(Spectra)

# Create Spectra object from CompDb
sps <- Spectra(cdb, filter = ~ name == "Mellein")

# Access spectra variables
sps$collisionEnergy
mz(sps)
intensity(sps)

# Compare spectra against the whole database
all_sps <- Spectra(cdb)
compareSpectra(sps, all_sps, ppm = 40)
```

### 4. Ion Databases (IonDb)
Use `IonDb` to store experimental m/z and retention times for specific adducts.

```r
library(RSQLite)
# Convert CompDb to IonDb (requires write access)
con <- dbConnect(SQLite(), "my_ion_db.sql")
idb <- IonDb(con, cdb)

# Insert experimental ion data
ion_df <- data.frame(compound_id = "1",
                     ion_adduct = "[M+H]+",
                     ion_mz = 123.34,
                     ion_rt = 196)
idb <- insertIon(idb, ion_df)

# Query ions
ions(idb, columns = c("ion_adduct", "name", "ion_rt"))
```

### 5. Utility Functions
*   **Adduct Calculation**: Use `mass2mz(cdb, adduct = "[M+H]+")` to calculate expected m/z values for all compounds in the database.
*   **Manual Filling**: Use `emptyCompDb()` followed by `insertCompound()` and `insertSpectra()` to build a database from scratch.
*   **Database Extension**: Use `addJoinDefinition()` to link custom user tables to the core compound/spectra tables.

## Tips and Best Practices
*   **Read-Only by Default**: `CompDb()` loads databases as read-only. To modify (insert/delete), use `flags = RSQLite::SQLITE_RW`.
*   **Filtering Performance**: Apply filters directly in the `Spectra(cdb, filter = ...)` call rather than subsetting the resulting object; this is significantly faster as it happens at the SQL level.
*   **Redundancy**: Some sources (like MoNa) are spectrum-centric. The `ms_compound` table may contain redundant entries if the source data isn't normalized.

## Reference documentation
- [Usage of Annotation Resources with the CompoundDb Package](./references/CompoundDb-usage.md)
- [Creating CompoundDb annotation resources](./references/create-compounddb.md)
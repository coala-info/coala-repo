---
name: bioconductor-biodb
description: This tool provides a unified API to access, search, and manage chemical, biological, and mass spectra databases within R. Use when user asks to retrieve database entries, search by name or mass, annotate LCMS/MS spectra, or manage local CSV and SQLite databases.
homepage: https://bioconductor.org/packages/release/bioc/html/biodb.html
---


# bioconductor-biodb

name: bioconductor-biodb
description: Access chemical, biological, and mass spectra databases using a unified API. Use this skill to retrieve database entries, search by name or mass, annotate LCMS/MS spectra, and manage local in-house databases (CSV/SQLite) within R.

## Overview
The `biodb` package provides a standardized framework for interacting with diverse biological and chemical databases. It uses an Object-Oriented Programming (OOP) approach (R6/RC) where methods are called directly on object instances using the `$` operator. The package handles caching, request scheduling, and data conversion, making it efficient for large-scale metabolite annotation and database merging.

## Core Workflow

### 1. Initialization and Termination
Always start by creating a `BiodbMain` instance and terminate it when finished to release resources.
```r
library(biodb)
mybiodb <- biodb::newInst()
# ... perform tasks ...
mybiodb$terminate()
```

### 2. Connecting to Databases
Connect to remote or local databases using the factory.
```r
# Connect to a local CSV compound database
compUrl <- system.file("extdata", "chebi_extract.tsv", package='biodb')
conn <- mybiodb$getFactory()$createConn('comp.csv.file', url=compUrl)

# List available connector classes
mybiodb$getDbsInfo()
```

### 3. Retrieving and Searching Entries
Retrieve entries by ID or search using specific fields like name or mass.
```r
# Get specific entries
entries <- conn$getEntry(c('1018', '1549'))

# Search by name and mass
ids <- conn$searchForEntries(list(
    name = 'guanosine', 
    monoisotopic.mass = list(value = 283.0917, delta = 0.1)
))

# Access field values from an entry object
entry <- entries[[1]]
formula <- entry$getFieldValue('formula')
```

### 4. Data Conversion
Convert entries into standard R data frames for analysis.
```r
# Convert a list of entries to a data frame
df <- mybiodb$entriesToDataframe(entries)

# Convert to JSON
json_data <- mybiodb$entriesToJson(entries)
```

### 5. Mass Spectra Annotation
Annotate experimental M/Z values using a compound or mass spectra database.
```r
# Annotate LCMS peaks (negative mode)
mzdf <- data.frame(mz=c(282.0839, 346.0546), rt=c(334, 536))
annotated <- conn$annotateMzValues(mzdf, mz.tol=1e-3, ms.mode='neg')

# MS/MS matching
msms_match <- conn$msmsSearch(input_spec, precursor.mz=286.1438, mz.tol=0.1)
```

### 6. Managing Local Databases
Create, edit, and write to local SQLite or CSV files.
```r
# Create a new writable SQLite database
new_conn <- mybiodb$getFactory()$createConn('comp.sqlite', url="my_db.sqlite")
new_conn$allowEditing()
new_conn$allowWriting()

# Copy entries from one DB to another
mybiodb$copyDb(source_conn, new_conn)
new_conn$write()
```

## Tips for Success
- **Field Mapping**: If using custom CSV headers, use `conn$setField('biodb_field_name', 'csv_column_name')` to map them correctly.
- **Memory Management**: Use `conn$deleteAllEntriesFromVolatileCache()` to free RAM if processing thousands of entries.
- **Caching**: `biodb` caches web requests by default. Use `conn$deleteWholePersistentCache()` if you need to force a fresh download from a remote server.
- **Logging**: Control verbosity using `biodb::getLogger()$set_threshold(300)` (silence info) or `400` (show info).

## Reference documentation
- [An introduction to biodb](./references/biodb.md)
- [Details on biodb](./references/details.md)
- [Manipulating entry objects](./references/entries.md)
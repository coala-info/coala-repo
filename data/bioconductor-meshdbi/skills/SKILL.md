---
name: bioconductor-meshdbi
description: This tool provides a unified interface for managing, querying, and constructing MeSH-based annotation databases in Bioconductor. Use when user asks to map genes to Medical Subject Headings, query MeSH database objects, or construct custom Gene-MeSH annotation packages.
homepage: https://bioconductor.org/packages/release/bioc/html/MeSHDbi.html
---


# bioconductor-meshdbi

name: bioconductor-meshdbi
description: Interface for MeSH (Medical Subject Headings) database objects in Bioconductor. Use this skill when you need to manage, construct, or query Gene-MeSH annotation packages (MeSH.XXX.eg.db), or when working with MeSH.db, MeSH.AOR.db, and MeSH.PCR.db SQLite files to map genes to medical subject headings.

# bioconductor-meshdbi

## Overview
The `MeSHDbi` package provides a unified framework for handling MeSH-based annotation data in R. It serves as the engine for constructing and interfacing with `MeSHDb` objects, which map Entrez Gene IDs to MeSH terms across various organisms. It is primarily used to create custom Gene-MeSH annotation packages or to load existing MeSH SQLite databases for functional analysis.

## Typical Workflow

### 1. Loading a MeSH Database
To use MeSH annotations, you typically load a specific MeSH database package or use the `loadMeSHDbiPkg` function to import a SQLite file.

```r
library(MeSHDbi)
# Example: Loading a pre-built MeSH database for Human
# library(MeSH.Hsa.eg.db) 
```

### 2. Querying the Database
`MeSHDb` objects follow the standard Bioconductor `AnnotationDbi` interface using `columns`, `keytypes`, `keys`, and `select`.

```r
# List available columns
columns(MeSH.Hsa.eg.db)

# List available keytypes
keytypes(MeSH.Hsa.eg.db)

# Retrieve mapping for specific Gene IDs
keys <- c("1", "2", "3")
select(MeSH.Hsa.eg.db, keys = keys, columns = c("MESHID", "MESHTERM"), keytype = "GENEID")
```

### 3. Constructing a Gene-MeSH Package
If a pre-built package is not available, `MeSHDbi` can be used to generate a new `MeSH.XXX.eg.db` package from SQLite files.

```r
# Basic structure for package construction
# loadMeSHDbiPkg(sqlitefile)
```

## Key Functions
- `columns(x)`: Lists the types of data that can be retrieved.
- `keytypes(x)`: Lists the types of identifiers that can be used as query keys.
- `keys(x, keytype)`: Returns all keys of a specific type in the database.
- `select(x, keys, columns, keytype)`: The primary retrieval function to map between identifiers and MeSH terms.
- `dbfile(x)`: Returns the path to the underlying SQLite database file.
- `species(x)`: Returns the species name for the database object.

## Tips for Success
- **Integration with meshr**: For performing MeSH enrichment analysis (similar to GO enrichment), use this package in conjunction with the `meshr` package.
- **Database Naming**: MeSH annotation packages typically follow the naming convention `MeSH.XXX.eg.db`, where `XXX` is a three-letter organism code (e.g., `Hsa` for Homo sapiens, `Mmu` for Mus musculus).
- **Memory Management**: If working with large-scale mappings, use the `keys` argument in `select` to limit the data returned rather than loading the entire table.

## Reference documentation
- [MeSHDbi](./references/MeSHDbi.md)
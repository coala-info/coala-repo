---
name: bioconductor-ahensdbs
description: This package provides metadata for discovering and retrieving Ensembl annotation databases from AnnotationHub for use with the ensembldb framework. Use when user asks to query available EnsDb resources, retrieve genomic features like genes and transcripts for specific species, or generate custom SQLite databases from Ensembl MySQL dumps.
homepage: https://bioconductor.org/packages/release/data/annotation/html/AHEnsDbs.html
---

# bioconductor-ahensdbs

## Overview
The `AHEnsDbs` package serves as a metadata provider for `EnsDb` SQLite databases stored in `AnnotationHub`. It allows users to programmatically discover and retrieve comprehensive Ensembl annotations without needing to manually build databases. Once retrieved, these objects are processed using the `ensembldb` package to extract genomic features like genes, transcripts, and exons.

## Fetching EnsDb Databases
To use these annotations, you must first interface with `AnnotationHub`.

### 1. Initialize AnnotationHub
```r
library(AnnotationHub)
ah <- AnnotationHub()
```

### 2. Query for EnsDb Resources
You can search the hub using the "EnsDb" tag along with species names or specific Ensembl release versions.
```r
# List all available EnsDb records
query(ah, "EnsDb")

# Search for a specific species and release (e.g., Mouse, Ensembl 102)
qr <- query(ah, c("EnsDb", "Mus musculus", "102"))
```

### 3. Retrieve and Load the Database
Retrieve the object using its AnnotationHub ID (e.g., "AH12345") or by indexing the query result. This returns an `EnsDb` object.
```r
edb <- qr[[1]]
# Or specifically by ID
# edb <- ah[["AH117052"]]
```

## Working with EnsDb Objects
Once the `EnsDb` object is loaded, use standard `ensembldb` functions to extract data.

### Extracting Genomic Features
```r
library(ensembldb)

# Get all genes as a GRanges object
gns <- genes(edb)

# Get transcripts
txs <- transcripts(edb)

# Filter for specific biotypes (e.g., protein coding)
pc_genes <- genes(edb, filter = ~ gene_biotype == "protein_coding")
```

## Creating Custom EnsDbs
While `AHEnsDbs` provides pre-built databases, the package also includes scripts for generating new `EnsDb` SQLite files from Ensembl MySQL dumps. This requires a local MySQL setup and the Ensembl Perl API.

```r
library(ensembldb)
# Locate the generation script provided by the package
scr <- system.file("scripts/generate-EnsDBs.R", package = "ensembldb")
source(scr)

# Example: Create databases for Ensembl release 112
# Requires local MySQL credentials
# createEnsDbForSpecies(ens_version = 112, user = "user", host = "localhost", pass = "pass")
```

## Tips and Best Practices
- **Caching**: `AnnotationHub` caches downloaded databases locally. Subsequent calls for the same resource will be much faster.
- **Version Matching**: Always check that the Ensembl release version of the `EnsDb` matches the version used in your upstream bioinformatics pipeline (e.g., the version used for read mapping).
- **Metadata**: Use `metadata(edb)` to check the genome build (e.g., GRCh38), Ensembl version, and organism details of the retrieved database.

## Reference documentation
- [Creating EnsDbs](./references/creating-EnsDbs.md)
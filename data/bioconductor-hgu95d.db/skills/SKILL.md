---
name: bioconductor-hgu95d.db
description: This package provides annotation data for the Affymetrix Human Genome U95 Set (hgu95d) platform. Use when user asks to map manufacturer probe identifiers to biological identifiers like Gene Symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95d.db.html
---


# bioconductor-hgu95d.db

name: bioconductor-hgu95d.db
description: Provides annotation data for the Affymetrix Human Genome U95 Set (hgu95d) platform. Use this skill when working in R to map manufacturer probe identifiers to biological identifiers such as Entrez Gene IDs, Gene Symbols, RefSeq accessions, GO terms, and KEGG pathways.

## Overview

The hgu95d.db package is a Bioconductor annotation data package for the Affymetrix Human Genome U95 Set. It provides a stable SQLite-based interface to map probe-set identifiers to various genomic and functional annotations. The package is primarily accessed using the standard AnnotationDbi interface.

## Core Workflows

### Loading the Package and Exploring Metadata

Load the library and inspect available columns and keys:

library(hgu95d.db)
# List all available annotation types
columns(hgu95d.db)
# List the first few probe identifiers
head(keys(hgu95d.db))
# Get the organism name
hgu95dORGANISM

### Using the select() Interface

The select() function is the recommended way to retrieve data. It requires the database object, the keys (probe IDs), and the columns you wish to retrieve.

# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
select(hgu95d.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")

### Mapping to Functional Annotations

Retrieve Gene Ontology (GO) or KEGG Pathway information:

# Get GO terms for specific probes
select(hgu95d.db, 
       keys = probes, 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")

# Get KEGG pathway IDs
select(hgu95d.db, 
       keys = probes, 
       columns = "PATH", 
       keytype = "PROBEID")

### Using the Legacy Bimap Interface

While select() is preferred, you can still use the Bimap interface for quick list conversions:

# Convert Symbol map to a list
sym_list <- as.list(hgu95dSYMBOL)
# Access a specific probe
sym_list[["1000_at"]]

# Get all mapped keys
mapped_probes <- mappedkeys(hgu95dSYMBOL)

### Accessing Chromosomal Information

Retrieve chromosome locations and lengths:

# Get chromosome for probes
select(hgu95d.db, keys = probes, columns = "CHR")

# Get chromosome start positions
select(hgu95d.db, keys = probes, columns = "CHRLOC")

# Get total chromosome lengths
hgu95dCHRLENGTHS

## Tips and Best Practices

- Use `hgu95dALIAS2PROBE` if you have common gene symbols and need to find the corresponding manufacturer probe IDs.
- For GO mappings, `hgu95dGO2ALLPROBES` includes annotations to child terms in the GO hierarchy, making it more inclusive than `hgu95dGO2PROBE`.
- Use `hgu95d_dbconn()` to get a DBIConnection object if you need to perform custom SQL queries against the underlying SQLite database.
- Always check for NAs in the output, as not every probe identifier maps to every type of biological identifier.

## Reference documentation

- [hgu95d.db Reference Manual](./references/reference_manual.md)
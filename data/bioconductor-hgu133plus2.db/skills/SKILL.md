---
name: bioconductor-hgu133plus2.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133plus2.db.html
---

# bioconductor-hgu133plus2.db

name: bioconductor-hgu133plus2.db
description: Provides annotation data for the Affymetrix Human Genome U133 Plus 2.0 Array. Use this skill when you need to map manufacturer probe IDs to biological identifiers like Gene Symbols, Entrez IDs, Ensembl IDs, GO terms, or KEGG pathways in R.

## Overview

The hgu133plus2.db package is a Bioconductor annotation data package for the Affymetrix Human Genome U133 Plus 2.0 Array. It provides a SQLite-based interface to map probe set identifiers (manufacturer IDs) to various gene-centric annotations. The primary way to interact with this data is through the AnnotationDbi interface.

## Basic Usage

### Loading the Package
To begin, load the library in your R session:
library(hgu133plus2.db)

### Exploring the Database
Check available annotation types (columns) and the central identifier (keys):
# View available columns
columns(hgu133plus2.db)

# View the first few probe IDs
head(keys(hgu133plus2.db, keytype = "PROBEID"))

## Core Workflows

### Mapping Identifiers with select()
The select() function is the standard way to retrieve data. It returns a data frame.

# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("200000_s_at", "200001_at", "200002_at")
res <- select(hgu133plus2.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")

### Simple 1-to-1 Mapping with mapIds()
If you need a named vector instead of a data frame, use mapIds().

# Get a named vector of Gene Symbols
symbols <- mapIds(hgu133plus2.db, 
                  keys = probes, 
                  column = "SYMBOL", 
                  keytype = "PROBEID", 
                  multiVals = "first")

### Reverse Mapping
You can map from other identifiers back to probe IDs by changing the keytype.

# Find probes associated with a specific Gene Symbol
select(hgu133plus2.db, 
       keys = "TP53", 
       columns = "PROBEID", 
       keytype = "SYMBOL")

## Specialized Annotations

### Gene Ontology (GO)
The GO mapping provides the GO ID, Evidence code, and Ontology category (BP, CC, MF).
# Get GO terms for probes
go_data <- select(hgu133plus2.db, keys = probes, columns = "GO", keytype = "PROBEID")

### KEGG Pathways
Map probes to KEGG pathway identifiers:
path_data <- select(hgu133plus2.db, keys = probes, columns = "PATH", keytype = "PROBEID")

### Chromosomal Location
Retrieve chromosome names and base pair locations:
loc_data <- select(hgu133plus2.db, 
                   keys = probes, 
                   columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                   keytype = "PROBEID")

## Tips and Best Practices

- **Handling Multi-mappings**: One probe may map to multiple Entrez IDs or GO terms. In select(), this results in multiple rows. In mapIds(), use the multiVals argument (e.g., "first", "list", "CharacterList") to control behavior.
- **Bimap Interface**: While the "old style" Bimap objects (e.g., hgu133plus2SYMBOL) still exist, using the select() interface is recommended for consistency and modern Bioconductor standards.
- **Database Connection**: For advanced users, hgu133plus2_dbconn() provides a direct DBI connection to the underlying SQLite database for custom SQL queries.
- **Organism Info**: Use hgu133plus2ORGANISM to programmatically confirm the species (Homo sapiens).

## Reference documentation

- [hgu133plus2.db Reference Manual](./references/reference_manual.md)
---
name: bioconductor-clariomshumantranscriptcluster.db
description: This package provides SQLite-based annotation data for mapping Clariom S Human transcript cluster identifiers to genomic, functional, and bibliographic information. Use when user asks to map transcript cluster IDs to gene symbols, retrieve Gene Ontology terms, find KEGG pathways, or identify chromosomal locations for Clariom S Human data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/clariomshumantranscriptcluster.db.html
---

# bioconductor-clariomshumantranscriptcluster.db

## Overview

The `clariomshumantranscriptcluster.db` package is a Bioconductor annotation data package for the Clariom S Human platform. It provides a SQLite-based interface to map manufacturer-specific transcript cluster identifiers to genomic, functional, and bibliographic data. The primary method for interaction is the `select()` interface from the `AnnotationDbi` package, though legacy "Bimap" objects are also available.

## Core Workflows

### Initialization and Discovery

To use the package, load it into your R session and explore available keys and columns.

```R
library(clariomshumantranscriptcluster.db)

# Check available columns (types of data you can retrieve)
columns(clariomshumantranscriptcluster.db)

# Check available keytypes (types of identifiers you can use as input)
keytypes(clariomshumantranscriptcluster.db)

# Get a sample of transcript cluster IDs
head(keys(clariomshumantranscriptcluster.db))
```

### Using the select() Interface

The `select()` function is the recommended way to retrieve data. It requires the database object, the input keys, the columns to retrieve, and the keytype of the input.

```R
# Map transcript cluster IDs to Gene Symbols and Entrez IDs
probes <- c("16650001", "16650003", "16650005")
results <- select(clariomshumantranscriptcluster.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Ontology (GO):** Retrieve GO IDs, evidence codes, and ontologies (BP, CC, MF).
- **Pathways:** Map to KEGG pathway identifiers using the `PATH` column.
- **Chromosomal Location:** Use `CHR`, `CHRLOC`, and `CHRLENGTHS` to find physical positions.
- **External IDs:** Map to `ENSEMBL`, `UNIPROT`, `REFSEQ`, or `ACCNUM` (GenBank accession).

### Legacy Bimap Interface

While `select()` is preferred, specific Bimap objects can be used for quick lookups or reverse mappings.

```R
# Get a list of symbols for transcript cluster IDs
symbol_map <- as.list(clariomshumantranscriptclusterSYMBOL)
# Access specific ID
symbol_map[["16650001"]]

# Reverse mapping: Find probes for a specific Gene Symbol
alias_map <- as.list(clariomshumantranscriptclusterALIAS2PROBE)
alias_map[["TP53"]]
```

## Database Connection and Metadata

You can access database metadata or the underlying SQLite connection directly if needed for complex SQL queries.

```R
# Get database schema
clariomshumantranscriptcluster_dbschema()

# Get organism information
clariomshumantranscriptclusterORGANISM
```

## Tips and Best Practices

- **One-to-Many Mappings:** Be aware that `select()` may return more rows than input keys if a single probe maps to multiple GO terms or pathways.
- **Filtering GO Evidence:** When retrieving GO terms, you may want to filter the results based on the `EVIDENCE` column (e.g., excluding 'IEA' - Inferred from Electronic Annotation).
- **Package Dependencies:** Ensure `AnnotationDbi` is installed, as it provides the generic methods used to interact with this database.

## Reference documentation

- [clariomshumantranscriptcluster.db](./references/reference_manual.md)
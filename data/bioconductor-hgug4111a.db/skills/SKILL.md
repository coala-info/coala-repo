---
name: bioconductor-hgug4111a.db
description: This package provides Bioconductor annotation data for mapping Agilent Human Genome G4111A platform probe identifiers to various biological metadata. Use when user asks to map manufacturer probe IDs to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgug4111a.db.html
---

# bioconductor-hgug4111a.db

name: bioconductor-hgug4111a.db
description: Annotation data for the Agilent Human Genome G4111A platform. Use this skill when you need to map manufacturer probe identifiers to biological identifiers like Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, or chromosomal locations in R.

# bioconductor-hgug4111a.db

## Overview

The `hgug4111a.db` package is a Bioconductor annotation data package for the Agilent Human Genome G4111A platform. It provides a comprehensive set of SQLite-based mappings between manufacturer probe IDs and various public identifiers. While it supports legacy "Bimap" objects, the modern and preferred way to interact with the data is through the `select()` interface provided by the `AnnotationDbi` package.

## Core Workflows

### Loading the Package

```r
library(hgug4111a.db)
```

### Using the select() Interface

The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype.

```r
# List available columns
columns(hgug4111a.db)

# List available keytypes
keytypes(hgug4111a.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1", "10", "100") # Replace with actual probe IDs
select(hgug4111a.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Mapping to Gene Ontology (GO)

To get functional annotations, map probes to GO identifiers. Note that this returns multiple rows per probe due to the one-to-many relationship.

```r
select(hgug4111a.db, 
       keys = probes, 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")
```

### Mapping to KEGG Pathways

```r
select(hgug4111a.db, 
       keys = probes, 
       columns = "PATH", 
       keytype = "PROBEID")
```

### Legacy Bimap Interface

If you encounter older scripts, they may use the Bimap interface. These objects can be converted to lists or accessed using `mappedkeys()`.

```r
# Get probe to Symbol mapping as a list
symbol_map <- as.list(hgug4111aSYMBOL)

# Get probes that have a mapped symbol
mapped_probes <- mappedkeys(hgug4111aSYMBOL)

# Access specific probe
symbol_map[["1"]]
```

## Database Utilities

You can access the underlying SQLite connection for custom SQL queries if needed.

```r
# Get the DB connection
conn <- hgug4111a_dbconn()

# Show database schema
hgug4111a_dbschema()

# Count total probes in the database
DBI::dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips

- **One-to-Many Mappings**: Many identifiers (like GO, PATH, or PMID) have a one-to-many relationship with probes. The `select()` function will return a "long" data frame with multiple rows for a single probe in these cases.
- **Official Symbols**: Use the `SYMBOL` map for official gene symbols. Use `ALIAS2PROBE` if you are starting with common gene aliases and need to find the corresponding manufacturer probes.
- **Chromosomal Locations**: `CHRLOC` provides the starting position, while `CHRLOCEND` provides the ending position. Negative values indicate the antisense strand.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
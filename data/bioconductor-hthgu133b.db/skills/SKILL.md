---
name: bioconductor-hthgu133b.db
description: This package provides annotation data for the Affymetrix Human Genome HG-U133B platform. Use when user asks to map manufacturer probe identifiers to biological annotations like Gene Symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133b.db.html
---


# bioconductor-hthgu133b.db

name: bioconductor-hthgu133b.db
description: Annotation data for the Affymetrix Human Genome HG-U133B platform. Use this skill to map manufacturer probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

# bioconductor-hthgu133b.db

## Overview

The `hthgu133b.db` package is a Bioconductor annotation data package for the Affymetrix Human Genome HG-U133B array. It provides a comprehensive set of mappings between manufacturer probe IDs and standard biological identifiers. While it supports the older "Bimap" interface, the modern `select()` interface from the `AnnotationDbi` package is the preferred method for querying this data.

## Core Workflows

### Loading the Package
```r
library(hthgu133b.db)
```

### Using the select() Interface
The `select()` function is the primary way to retrieve data. You need to specify the keys (probe IDs), the columns (data types you want), and the keytype (usually "PROBEID").

```r
# List available columns
columns(hthgu133b.db)

# List available keytypes
keytypes(hthgu133b.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("200000_s_at", "200001_at")
select(hthgu133b.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Symbols**: Use `SYMBOL` to get official gene abbreviations.
- **Entrez Gene IDs**: Use `ENTREZID` for NCBI Entrez Gene identifiers.
- **Gene Ontology (GO)**: Use `GO` to get GO IDs, Evidence codes, and Ontologies (BP, CC, MF).
- **KEGG Pathways**: Use `PATH` to map probes to KEGG pathway identifiers.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` for genomic positioning.
- **External IDs**: Use `ENSEMBL`, `UNIPROT`, or `REFSEQ` for cross-referencing other databases.

### Using the Bimap Interface (Legacy)
For specific tasks, you might use the older Bimap objects directly.

```r
# Get all mapped probe IDs for a specific map
x <- hthgu133bSYMBOL
mapped_probes <- mappedkeys(x)

# Convert a map to a list
symbol_list <- as.list(x[mapped_probes[1:5]])
```

### Database Connection Information
To inspect the underlying SQLite database:
```r
# Get database metadata
hthgu133b_dbInfo()

# Get the database schema
hthgu133b_dbschema()

# Get a direct connection object (DBI)
conn <- hthgu133b_dbconn()
```

## Tips and Best Practices
- **Vectorized Queries**: Always pass a vector of keys to `select()` rather than calling it in a loop for better performance.
- **Handling 1-to-Many**: Note that one probe ID may map to multiple GO terms or pathways; `select()` will return a long-format data frame.
- **Alias Mapping**: If you have common gene names that aren't official symbols, use the `ALIAS2PROBE` map to find the corresponding manufacturer IDs.
- **Check Versions**: Use `hthgu133b()` to see package metadata and data source timestamps.

## Reference documentation
- [hthgu133b.db Reference Manual](./references/reference_manual.md)
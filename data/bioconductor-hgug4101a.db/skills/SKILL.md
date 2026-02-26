---
name: bioconductor-hgug4101a.db
description: This package provides annotation data for mapping Agilent Human Genome G4101A chip probe identifiers to biological metadata and genomic locations. Use when user asks to map hgug4101a probe IDs to gene symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgug4101a.db.html
---


# bioconductor-hgug4101a.db

name: bioconductor-hgug4101a.db
description: Annotation data for the Agilent Human Genome G4101A chip. Use this skill when you need to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) or genomic locations for data generated on the hgug4101a platform.

## Overview

The `hgug4101a.db` package is a Bioconductor annotation hub for the Agilent Human Genome G4101A microarray. It provides a SQLite-based interface to map probe IDs to genomic, functional, and publication-related metadata. While it supports an older "Bimap" interface, the modern `select()` interface from the `AnnotationDbi` package is the recommended way to interact with this data.

## Core Workflows

### Loading the Package
```R
library(hgug4101a.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype (usually "PROBEID").

```R
# List available columns
columns(hgug4101a.db)

# List available keytypes
keytypes(hgug4101a.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("10001_at", "10002_at") # Replace with actual hgug4101a probe IDs
select(hgug4101a.db, keys = probes, columns = c("SYMBOL", "ENTREZID"), keytype = "PROBEID")
```

### Common Annotation Mappings

*   **Gene Symbols & Names**: Use `SYMBOL` for abbreviations and `GENENAME` for full descriptions.
*   **External IDs**: Map to `ENTREZID`, `ENSEMBL`, `UNIPROT`, or `REFSEQ`.
*   **Functional Annotation**: Use `GO` (Gene Ontology) or `PATH` (KEGG Pathways).
*   **Genomic Location**: Use `CHR` (Chromosome), `CHRLOC` (Start position), and `MAP` (Cytoband).

### Working with Gene Ontology (GO)
The GO mapping returns a data frame with Evidence codes and Ontologies (BP, CC, MF).

```R
# Get GO terms for specific probes
select(hgug4101a.db, keys = probes, columns = "GO", keytype = "PROBEID")
```

### Reverse Mappings
To find which probes correspond to a specific gene or pathway, change the `keytype`.

```R
# Find probes for a specific Gene Symbol
select(hgug4101a.db, keys = "TP53", columns = "PROBEID", keytype = "SYMBOL")

# Find probes associated with a KEGG pathway
select(hgug4101a.db, keys = "04110", columns = "PROBEID", keytype = "PATH")
```

## Database Metadata
You can inspect the database schema and source information using convenience functions:
*   `hgug4101a_dbInfo()`: Displays data sources and timestamps.
*   `hgug4101a_dbschema()`: Shows the underlying SQLite table structure.
*   `hgug4101a_dbconn()`: Returns the DBI connection object.

## Tips
*   **Bimap Interface**: Older code may use `as.list(hgug4101aSYMBOL)`. While functional, `select()` is more efficient for complex queries.
*   **NA Values**: If a probe cannot be mapped to a specific identifier (e.g., no Entrez ID), `NA` is returned.
*   **Multiple Matches**: Some probes may map to multiple GO terms or Entrez IDs; `select()` will return one row per association, potentially increasing the row count of your output.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
---
name: bioconductor-htmg430b.db
description: This tool provides annotation data for the Affymetrix HT Mouse Genome 430B array to map probe identifiers to biological metadata. Use when user asks to map probe IDs to gene symbols, retrieve Entrez Gene IDs, access GO terms, or find KEGG pathways for this specific mouse array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htmg430b.db.html
---


# bioconductor-htmg430b.db

name: bioconductor-htmg430b.db
description: Use this skill to access and query the Bioconductor annotation package for the Affymetrix HT Mouse Genome 430B array (htmg430b.db). This skill is essential for mapping manufacturer probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, and KEGG pathways.

# bioconductor-htmg430b.db

## Overview

The `htmg430b.db` package is a Bioconductor annotation data package for the Affymetrix HT Mouse Genome 430B platform. It provides a comprehensive set of mappings between manufacturer probe identifiers and various genomic databases. While it supports older "Bimap" interfaces, the modern and preferred method for interaction is the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(htmg430b.db)
```

### Using the select() Interface
The `select()` function is the primary way to query the database. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype.

```r
# List available columns
columns(htmg430b.db)

# List available keytypes
keytypes(htmg430b.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1415670_at", "1415671_at")
select(htmg430b.db, 
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
- **External Accessions**: Use `ENSEMBL`, `REFSEQ`, `UNIPROT`, or `ACCNUM` (GenBank).

### Reverse Mappings
To find probes associated with a specific gene or term, change the `keytype`:

```r
# Find probes for a specific Gene Symbol
select(htmg430b.db, 
       keys = "Tp53", 
       columns = "PROBEID", 
       keytype = "SYMBOL")
```

### Database Metadata
To inspect the underlying database schema or connection information:
```r
htmg430b_dbschema()
htmg430b_dbInfo()
```

## Tips and Best Practices
- **Bimap vs. select**: Avoid using the older Bimap objects (e.g., `htmg430bSYMBOL`) directly as lists unless specifically required for legacy code. `select()` is more robust and handles one-to-many mappings more cleanly.
- **Alias Mapping**: If a gene symbol search fails, try using `ALIAS` as the keytype, as it includes unofficial or older symbols.
- **GO Evidence**: When querying GO terms, pay attention to the `EVIDENCE` column to understand the quality of the annotation (e.g., IDA = Inferred from Direct Assay, IEA = Inferred from Electronic Annotation).
- **Package Dependencies**: This package depends on `AnnotationDbi`. Ensure it is installed to use the `select()`, `keys()`, and `columns()` functions.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)
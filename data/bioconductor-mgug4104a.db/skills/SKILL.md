---
name: bioconductor-mgug4104a.db
description: This package provides annotation data for the Agilent Mouse Genome UG 4104A platform. Use when user asks to map Agilent mouse probe identifiers to gene symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgug4104a.db.html
---

# bioconductor-mgug4104a.db

name: bioconductor-mgug4104a.db
description: Provides annotation data for the Agilent Mouse Genome UG 4104A (mgug4104a) platform. Use this skill when you need to map manufacturer probe identifiers to biological identifiers like Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, or chromosomal locations for mouse genomic data.

# bioconductor-mgug4104a.db

## Overview

The `mgug4104a.db` package is a Bioconductor annotation data package for the Agilent Mouse Genome UG 4104A platform. It provides a comprehensive set of mappings between manufacturer probe IDs and various genomic identifiers. While it supports the legacy "Bimap" interface, the modern `select()` interface from the `AnnotationDbi` package is the recommended way to query this data.

## Core Workflows

### Loading the Package
```r
library(mgug4104a.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns (data types you want), and the keytype (usually "PROBEID").

```r
# List available columns
columns(mgug4104a.db)

# List available keytypes
keytypes(mgug4104a.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("10001_at", "10002_at") # Replace with actual probe IDs
select(mgug4104a.db, keys = probes, columns = c("SYMBOL", "ENTREZID"), keytype = "PROBEID")
```

### Common Mappings
- **Gene Symbols**: Use `SYMBOL` to get official gene abbreviations.
- **Entrez Gene IDs**: Use `ENTREZID` for NCBI identifiers.
- **Gene Ontology (GO)**: Use `GO` for functional annotations (includes Evidence and Ontology category).
- **KEGG Pathways**: Use `PATH` to find associated metabolic or signaling pathways.
- **Ensembl IDs**: Use `ENSEMBL` for Ensembl gene accession numbers.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND`.

### Reverse Mappings
To find probes associated with a specific gene symbol or GO term, change the `keytype`:

```r
# Find probes for a specific Gene Symbol
select(mgug4104a.db, keys = "Tp53", columns = "PROBEID", keytype = "SYMBOL")
```

### Legacy Bimap Interface
If working with older scripts, you may encounter the Bimap interface. These objects behave like lists or environments.

```r
# Get all mapped probe IDs for Gene Symbols
x <- mgug4104aSYMBOL
mapped_probes <- mappedkeys(x)
# Convert to list
symbol_list <- as.list(x[mapped_probes])
```

## Package Specific Utilities
- `mgug4104aORGANISM`: Returns the organism name ("Mus musculus").
- `mgug4104a_dbconn()`: Returns the underlying SQLite connection.
- `mgug4104a_dbfile()`: Returns the path to the SQLite database file.

## Tips
- **Multiple Mappings**: Some probes may map to multiple genes or GO terms. `select()` will return a data.frame with one row per mapping, which may result in more rows than input keys.
- **Alias Mapping**: If a gene symbol search fails, try using `ALIAS2PROBE` to check for common synonyms.
- **Evidence Codes**: When querying GO terms, pay attention to the `EVIDENCE` column to understand the quality of the annotation (e.g., IDA = Inferred from Direct Assay, IEA = Inferred from Electronic Annotation).

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
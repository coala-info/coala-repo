---
name: bioconductor-ecoli2.db
description: This package provides comprehensive annotation data and identifier mappings for the E. coli genome. Use when user asks to map between probe IDs, gene symbols, Entrez IDs, GO terms, or KEGG pathways for E. coli data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ecoli2.db.html
---

# bioconductor-ecoli2.db

name: bioconductor-ecoli2.db
description: Provides annotation data for the E. coli genome (ecoli2 platform). Use this skill when you need to map between different gene identifiers (Entrez, Symbol, RefSeq, Accession), Gene Ontology (GO) terms, KEGG pathways, or PubMed IDs for E. coli data in R.

## Overview

The `ecoli2.db` package is a Bioconductor annotation data package for the E. coli platform. It provides a comprehensive set of mappings between manufacturer probe identifiers and various biological databases. While it supports the older "Bimap" interface, the recommended way to interact with the data is through the modern `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package

```r
library(ecoli2.db)
```

### Using the select() Interface

The `select()` function is the primary method for retrieving data. You need to specify the keys (input IDs), the columns (data you want to retrieve), and the keytype (the type of input IDs).

```r
# List available columns
columns(ecoli2.db)

# List available keytypes
keytypes(ecoli2.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at")
select(ecoli2.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Symbols**: Use `SYMBOL` to get official abbreviations.
- **Entrez IDs**: Use `ENTREZID` to map to NCBI Entrez Gene identifiers.
- **GO Terms**: Use `GO` or `GOALL` (includes child terms) for Gene Ontology annotations.
- **Pathways**: Use `PATH` to find KEGG pathway identifiers.
- **RefSeq**: Use `REFSEQ` for mapping to NCBI reference sequences.
- **Accession Numbers**: Use `ACCNUM` for GenBank accession numbers.

### Using the Bimap Interface (Legacy)

For specific tasks, you might use the Bimap objects directly. These are named following the pattern `ecoli2[MAPPING]`.

```r
# Get a list of probe to Symbol mappings
x <- ecoli2SYMBOL
mapped_probes <- mappedkeys(x)
as.list(x[mapped_probes][1:5])

# Reverse mapping: Find probes for a specific GO term
rev_map <- ecoli2GO2PROBE
as.list(rev_map["GO:0006091"])
```

### Database Connection and Metadata

To inspect the underlying SQLite database or get organism information:

```r
# Get organism name
ecoli2ORGANISM

# Get the underlying DB connection
conn <- ecoli2_dbconn()
dbGetQuery(conn, "SELECT * FROM probes LIMIT 5")

# Show database schema
ecoli2_dbschema()
```

## Tips

- **Multiple Matches**: Note that one probe ID can sometimes map to multiple GO terms or PubMed IDs. The `select()` function will return a data frame with one row per match.
- **Evidence Codes**: When retrieving GO data, pay attention to the `EVIDENCE` column to understand the source of the annotation (e.g., IDA: Inferred from Direct Assay).
- **Alias Mapping**: If you have common gene names that aren't official symbols, try the `ecoli2ALIAS2PROBE` map.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
---
name: bioconductor-ag.db
description: This tool provides annotation data for the Arabidopsis thaliana platform to map manufacturer probe identifiers to biological metadata. Use when user asks to map probe IDs to AGI locus IDs, gene symbols, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ag.db.html
---

# bioconductor-ag.db

name: bioconductor-ag.db
description: Provides annotation data for the Arabidopsis thaliana (ag) platform. Use this skill when you need to map between manufacturer probe identifiers and various biological annotations such as AGI locus IDs, Gene Symbols, GO terms, KEGG pathways, AraCyc pathways, and chromosomal locations.

## Overview

The `ag.db` package is a Bioconductor annotation data package specifically for the Arabidopsis (ag) platform. It provides a comprehensive set of mappings between manufacturer probe IDs and functional genomic data. While it supports the older "Bimap" interface, the recommended way to interact with the data is through the `AnnotationDbi` `select()` interface.

## Core Workflows

### Loading the Package
```r
library(ag.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You can discover available keys and columns using:
```r
# List available columns (e.g., SYMBOL, GO, PATH, ACCNUM)
columns(ag.db)

# List available key types
keytypes(ag.db)

# Retrieve specific mappings
results <- select(ag.db, 
                  keys = c("247000_at", "247001_at"), 
                  columns = c("SYMBOL", "GENENAME", "ACCNUM"), 
                  keytype = "PROBEID")
```

### Common Annotation Mappings
- **AGI Locus IDs**: Use `ACCNUM` to map probe IDs to Arabidopsis Genome Initiative locus identifiers.
- **Gene Symbols**: Use `SYMBOL` for gene abbreviations.
- **Pathways**: 
    - `PATH`: KEGG pathway identifiers.
    - `ARACYC`: AraCyc pathway names.
    - `ARACYCENZYME`: Enzyme names from AraCyc.
- **Gene Ontology (GO)**: Use `GO` to get GO IDs, Evidence codes, and Ontologies (BP, CC, MF).
- **Chromosomal Info**: 
    - `CHR`: Chromosome assignment.
    - `CHRLOC` / `CHRLOCEND`: Start and end positions (negative values indicate the antisense strand).
    - `CHRLENGTHS`: Vector of chromosome lengths.

### Working with Bimaps (Legacy Interface)
If you need to work with the older Bimap objects directly:
```r
# Get all mapped probe IDs for Gene Symbols
x <- agSYMBOL
mapped_probes <- mappedkeys(x)
# Convert to a list
symbol_list <- as.list(x[mapped_probes])
```

### Database Connection and Metadata
To inspect the underlying SQLite database:
```r
ag_dbconn()    # Get the DB connection object
ag_dbschema()  # View the database schema
ag_dbInfo()    # View package metadata and data sources
```

## Tips and Best Practices
- **Multiple Mappings**: Be aware that one probe ID may map to multiple AGI locus IDs or GO terms. The `select()` function will return a data frame with one row per mapping.
- **Filtering GO Terms**: When querying GO terms, you can filter by evidence code (e.g., IDA, IMP) or ontology (BP, CC, MF) after retrieval.
- **AraCyc vs KEGG**: For Arabidopsis-specific pathway analysis, `ARACYC` often provides more specialized plant metabolism data compared to the general `PATH` (KEGG) mappings.

## Reference documentation
- [ag.db Reference Manual](./references/reference_manual.md)
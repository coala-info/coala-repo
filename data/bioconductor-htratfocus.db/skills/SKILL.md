---
name: bioconductor-htratfocus.db
description: This package provides annotation data for the Affymetrix Rat Focus genome array. Use when user asks to map manufacturer probe identifiers to biological identifiers like Gene Symbols or Entrez IDs, retrieve functional annotations, or access genomic metadata for the htratfocus platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htratfocus.db.html
---


# bioconductor-htratfocus.db

name: bioconductor-htratfocus.db
description: Provides annotation data for the Rat Focus genome array (htratfocus). Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbols, GO terms, KEGG pathways, etc.) and to retrieve genomic metadata for this specific Bioconductor platform.

## Overview

The `htratfocus.db` package is a Bioconductor annotation data package for the Rat Focus array. It provides a set of R objects (Bimaps) and a modern `select()` interface to map manufacturer-specific probe IDs to various biological annotations. This is essential for downstream analysis of microarray data, such as gene set enrichment analysis or functional annotation of differentially expressed genes.

## Core Workflows

### Loading the Package
```R
library(htratfocus.db)
```

### Using the select() Interface
The preferred method for interacting with the database is the `select()` interface from the `AnnotationDbi` package.

```R
# View available columns
columns(htratfocus.db)

# View available key types
keytypes(htratfocus.db)

# Retrieve specific annotations for a set of probe IDs
probes <- c("1367452_at", "1367453_at") # Example probe IDs
select(htratfocus.db, 
       keys = probes, 
       columns = c("SYMBOL", "GENENAME", "ENTREZID"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Symbols and Names**: Map probes to official gene symbols (`SYMBOL`) or full names (`GENENAME`).
- **External IDs**: Map to Entrez Gene IDs (`ENTREZID`), Ensembl IDs (`ENSEMBL`), or RefSeq accessions (`REFSEQ`).
- **Functional Annotation**: Map to Gene Ontology (`GO`) or KEGG pathways (`PATH`).
- **Chromosomal Location**: Retrieve chromosome numbers (`CHR`) and base pair positions (`CHRLOC`, `CHRLOCEND`).

### Using the Bimap Interface (Legacy)
While `select()` is preferred, the package supports older Bimap objects for specific tasks.

```R
# Map probes to Gene Symbols
x <- htratfocusSYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Map Gene Aliases back to Probes
alias_map <- as.list(htratfocusALIAS2PROBE)
```

### Database Metadata
To get information about the underlying SQLite database:
```R
htratfocus_dbconn()   # Get connection object
htratfocus_dbschema() # View table schemas
htratfocus_dbInfo()   # View package metadata
```

## Tips and Best Practices
- **Handling Multiple Matches**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **GO Evidence Codes**: When mapping to `GO`, the output includes evidence codes (e.g., IDA, IEA, TAS). Filter these if you only want high-confidence experimental annotations.
- **Organism Info**: Use `htratfocusORGANISM` to programmatically confirm the species (Rattus norvegicus).

## Reference documentation
- [htratfocus.db Reference Manual](./references/reference_manual.md)
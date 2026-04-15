---
name: bioconductor-hgug4100a.db
description: This package provides annotation data for the Agilent Human Genome G4100A microarray platform. Use when user asks to map manufacturer probe identifiers to biological identifiers, retrieve gene symbols, or access functional annotations like GO and KEGG for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgug4100a.db.html
---

# bioconductor-hgug4100a.db

name: bioconductor-hgug4100a.db
description: Provides annotation data for the Agilent Human Genome G4100A (hgug4100a) platform. Use this skill when you need to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) or retrieve genomic metadata for this specific microarray.

# bioconductor-hgug4100a.db

## Overview

The `hgug4100a.db` package is a Bioconductor annotation data package for the Agilent Human Genome G4100A platform. It provides SQLite-based mappings between manufacturer probe IDs and standard biological identifiers. While it supports older "Bimap" interfaces, the modern `select()` interface from the `AnnotationDbi` package is the preferred method for querying this data.

## Core Workflows

### Loading the Package

```r
library(hgug4100a.db)
```

### Using the select() Interface

The `select()` function is the primary way to retrieve data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype (usually "PROBEID").

```r
# View available columns and keytypes
columns(hgug4100a.db)
keytypes(hgug4100a.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at") # Replace with actual hgug4100a probe IDs
select(hgug4100a.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Symbols**: Use the `SYMBOL` column.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND`.
- **Functional Annotation**: Use `GO` (Gene Ontology) or `PATH` (KEGG Pathways).
- **External IDs**: Use `ENSEMBL`, `UNIPROT`, or `REFSEQ`.

### Using the Bimap Interface (Legacy)

For quick lookups or list-based processing, you can use the Bimap objects directly.

```r
# Convert a mapping to a list
sym_list <- as.list(hgug4100aSYMBOL)

# Get symbols for specific probes
probes <- names(sym_list)[1:5]
sym_list[probes]

# Reverse mapping (e.g., Symbols to Probes)
alias_to_probe <- as.list(hgug4100aALIAS2PROBE)
```

### Database Metadata

To inspect the underlying database connection and schema:

```r
hgug4100a_dbconn()    # Get the SQLite connection
hgug4100a_dbschema()  # View table structures
hgug4100a_dbInfo()    # View data source and date stamps
```

## Tips and Best Practices

- **Vectorized Queries**: Always pass a vector of keys to `select()` rather than calling it in a loop for better performance.
- **Handling NAs**: Microarray probes may not always map to a known gene; `select()` will return `NA` for these entries.
- **GO Evidence Codes**: When querying `GO`, the results include evidence codes (e.g., IDA, TAS, IEA). Filter these if you only want high-confidence experimental annotations.
- **Package Dependencies**: This package depends on `AnnotationDbi`. Ensure it is loaded if `select()` is not found.

## Reference documentation

- [hgug4100a.db Reference Manual](./references/reference_manual.md)
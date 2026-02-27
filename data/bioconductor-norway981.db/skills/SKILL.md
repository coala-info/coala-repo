---
name: bioconductor-norway981.db
description: This tool provides comprehensive annotation data for the Norway981 platform to map manufacturer probe identifiers to various biological identifiers and chromosomal locations. Use when user asks to map Norway981 probe IDs to gene symbols, Entrez IDs, GO terms, KEGG pathways, or genomic coordinates.
homepage: https://bioconductor.org/packages/release/data/annotation/html/Norway981.db.html
---


# bioconductor-norway981.db

name: bioconductor-norway981.db
description: Provides annotation data for the Norway981 platform. Use this skill when you need to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, RefSeq, Ensembl, GO, KEGG, etc.) or chromosomal locations for data generated on the Norway981 chip.

## Overview

The `Norway981.db` package is a Bioconductor annotation hub for the Norway981 platform. It allows researchers to translate manufacturer-specific probe IDs into standardized genomic information. The package primarily uses the `AnnotationDbi` interface, specifically the `select()` function, though it maintains legacy "Bimap" objects for backward compatibility.

## Core Workflows

### Loading the Package
```r
library(Norway981.db)
```

### Using the select() Interface
The recommended way to interact with the database is using `keys`, `columns`, and `select`.

```r
# List available columns (types of data you can retrieve)
columns(Norway981.db)

# List available keytypes (types of IDs you can use as input)
keytypes(Norway981.db)

# Retrieve mappings for specific probe IDs
probes <- c("123_at", "456_at") # Replace with actual Norway981 probe IDs
select(Norway981.db, keys = probes, columns = c("SYMBOL", "ENTREZID", "GENENAME"), keytype = "PROBEID")
```

### Common Mappings

- **Gene Symbols**: Map probes to official gene abbreviations using `SYMBOL`.
- **Entrez IDs**: Map probes to NCBI Entrez Gene identifiers using `ENTREZID`.
- **Chromosomal Location**: Use `CHR` for the chromosome, `CHRLOC` for the start position, and `CHRLOCEND` for the end position.
- **Gene Ontology (GO)**: Use `GO` to get GO IDs, Evidence codes, and Ontologies (BP, CC, MF).
- **Pathways**: Use `PATH` to get KEGG pathway identifiers.

### Legacy Bimap Interface
While `select()` is preferred, you can access specific maps directly as Bimap objects:

```r
# Example: Mapping probes to Gene Symbols
x <- Norway981SYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Get symbol for the first probe
xx[[1]]
```

### Database Metadata
To get information about the underlying database and data sources:
```r
Norway981_dbInfo()
Norway981_dbschema()
```

## Tips and Best Practices

- **Handling Multiple Mappings**: Some probes may map to multiple Entrez IDs or Gene Symbols. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Filtering GO Terms**: When retrieving GO terms, remember that `Norway981GO` provides direct associations, while `Norway981GO2ALLPROBES` includes child terms in the hierarchy.
- **Platform Specifics**: This package is specifically for the Norway981 chip. Ensure your input identifiers match the manufacturer's probe naming convention for this specific platform.

## Reference documentation
- [Norway981.db Reference Manual](./references/reference_manual.md)
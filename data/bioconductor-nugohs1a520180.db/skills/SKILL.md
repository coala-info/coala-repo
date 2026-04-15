---
name: bioconductor-nugohs1a520180.db
description: This tool provides comprehensive annotation data for the nugohs1a520180 platform by mapping manufacturer probe identifiers to biological metadata. Use when user asks to map nugohs1a520180 probe identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/nugohs1a520180.db.html
---

# bioconductor-nugohs1a520180.db

name: bioconductor-nugohs1a520180.db
description: Comprehensive annotation data for the nugohs1a520180 platform. Use this skill when you need to map manufacturer probe identifiers to biological metadata such as Gene Symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations in R.

# bioconductor-nugohs1a520180.db

## Overview

The `nugohs1a520180.db` package is a Bioconductor annotation data package that provides mappings between manufacturer-specific identifiers for the nugohs1a520180 platform and various gene-centric identifiers. It is built using SQLite and is updated biannually to maintain accuracy with primary data sources like Entrez Gene, Ensembl, and Gene Ontology.

## Core Usage

### Loading the Package

```r
library(nugohs1a520180.db)
```

### Discovering Available Maps

To see all available mapping objects provided by the package:

```r
ls("package:nugohs1a520180.db")
```

### Standard AnnotationDbi Interface

The preferred way to interact with this package is through the standard `AnnotationDbi` methods:

- `columns(nugohs1a520180.db)`: List available types of data.
- `keys(nugohs1a520180.db)`: List the manufacturer probe identifiers.
- `select(...)`: Retrieve specific data for a set of keys.
- `mapIds(...)`: A simplified version of `select` for returning a 1:1 mapping.

### Common Mapping Examples

#### Mapping Probes to Gene Symbols and Entrez IDs

```r
probes <- c("10001_at", "10002_at") # Example probe IDs

# Using select
results <- select(nugohs1a520180.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")

# Using mapIds for a simple vector
symbols <- mapIds(nugohs1a520180.db, 
                  keys = probes, 
                  column = "SYMBOL", 
                  keytype = "PROBEID", 
                  multiVals = "first")
```

#### Accessing Specific Map Objects

You can also access maps directly as R objects. These are often converted to lists for easier manipulation:

```r
# Map probes to Gene Symbols
x <- nugohs1a520180SYMBOL
mapped_probes <- mappedkeys(x)
symbol_list <- as.list(x[mapped_probes])

# Map probes to KEGG Pathways
path_map <- as.list(nugohs1a520180PATH)
```

## Specialized Mappings

- **Gene Ontology (GO)**: `nugohs1a520180GO` provides mappings to GO IDs, including Evidence codes and Ontologies (BP, CC, MF). Use `nugohs1a520180GO2ALLPROBES` to include child terms.
- **Chromosomal Location**: `nugohs1a520180CHRLOC` and `nugohs1a520180CHRLOCEND` provide start and end base pair positions.
- **PubMed**: `nugohs1a520180PMID` maps probes to PubMed identifiers for literature references.
- **External IDs**: Mappings are available for `ENSEMBL`, `UNIPROT`, `REFSEQ`, and `ACCNUM` (GenBank accessions).

## Database Information

To get metadata about the database or the underlying connection:

```r
nugohs1a520180_dbconn()   # Returns the DBIConnection object
nugohs1a520180_dbInfo()   # Prints database metadata
nugohs1a520180_dbschema() # Prints the SQL schema
```

## Reference documentation

- [nugohs1a520180.db Reference Manual](./references/reference_manual.md)
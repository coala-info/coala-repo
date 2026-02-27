---
name: bioconductor-org.gg.eg.db
description: This package provides genome-wide annotations for chicken based on Entrez Gene identifiers. Use when user asks to map between gene identifiers, retrieve Gene Ontology terms, access KEGG pathways, or find chromosomal locations for Gallus gallus genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Gg.eg.db.html
---


# bioconductor-org.gg.eg.db

name: bioconductor-org.gg.eg.db
description: Genome-wide annotation for Chicken (Gallus gallus) based on Entrez Gene identifiers. Use this skill when you need to map between different gene identifiers (Entrez, Ensembl, Symbol, RefSeq), retrieve Gene Ontology (GO) terms, KEGG pathways, or chromosomal locations for chicken genes in R.

## Overview

The `org.Gg.eg.db` package is a Bioconductor annotation data package for *Gallus gallus* (chicken). It provides a stable, SQLite-based environment for mapping Entrez Gene identifiers to various other biological annotations. While it supports an older "Bimap" interface, the primary and recommended method for interaction is the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(org.Gg.eg.db)
```

### Exploring Available Data
To see which types of identifiers and data are available for mapping:
```r
# List available columns (data types)
columns(org.Gg.eg.db)

# List available key types (identifiers you can use as input)
keytypes(org.Gg.eg.db)

# Preview the first few keys of a specific type
head(keys(org.Gg.eg.db, keytype = "ENTREZID"))
```

### Mapping Identifiers (The select Interface)
The `select()` function is the standard way to retrieve data. It requires the database object, the input keys, the columns you want to retrieve, and the keytype of your input.

```r
# Map Entrez IDs to Gene Symbols and Ensembl IDs
genes <- c("396084", "396085", "396086")
select(org.Gg.eg.db, 
       keys = genes, 
       columns = c("SYMBOL", "ENSEMBL", "GENENAME"), 
       keytype = "ENTREZID")
```

### Common Annotation Mappings
- **Gene Symbols to Entrez IDs**: Use `keytype = "SYMBOL"` and `columns = "ENTREZID"`. Note that `ALIAS` includes unofficial symbols.
- **GO Terms**: Retrieve Gene Ontology terms using `columns = "GO"`. This returns GO IDs, Evidence codes, and Ontologies (BP, CC, MF).
- **KEGG Pathways**: Map genes to pathways using `columns = "PATH"`.
- **Chromosomal Location**: Use `CHR`, `CHRLOC` (start), and `CHRLOCEND` (end).

### Using the Bimap Interface (Legacy)
For specific tasks like getting all mapped keys or converting the entire map to a list:
```r
# Convert Symbol to Entrez ID map to a list
sym_map <- as.list(org.Gg.egSYMBOL2EG)
# Access a specific symbol
sym_map[["ALB"]]
```

## Tips and Best Practices
- **One-to-Many Mappings**: Functions like `select()` may return more rows than input keys if a single key maps to multiple annotations (e.g., multiple GO terms).
- **Official vs. Alias**: Use `SYMBOL` for official nomenclature and `ALIAS` for common names found in literature that might be redundant.
- **Database Metadata**: Use `org.Gg.eg_dbInfo()` to check data source versions and date stamps.
- **Chromosome Lengths**: Use `org.Gg.egCHRLENGTHS` to get a named vector of chromosome sizes in base pairs.

## Reference documentation
- [org.Gg.eg.db Reference Manual](./references/reference_manual.md)
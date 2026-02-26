---
name: bioconductor-canine.db
description: This tool provides comprehensive annotation data for mapping between various biological identifiers for the canine genome. Use when user asks to map canine-specific probe IDs to gene symbols, retrieve Entrez or Ensembl IDs, find chromosomal locations, or perform functional annotation using Gene Ontology terms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/canine.db.html
---


# bioconductor-canine.db

name: bioconductor-canine.db
description: Comprehensive annotation data for the canine (dog) genome. Use this skill when you need to map between different canine-specific biological identifiers such as manufacturer probe IDs, Entrez Gene IDs, Ensembl IDs, Gene Symbols, RefSeq accessions, and Gene Ontology (GO) terms.

# bioconductor-canine.db

## Overview

The `canine.db` package is a Bioconductor annotation hub for the dog (*Canis familiaris*) genome. It provides a SQLite-based infrastructure to map manufacturer-specific identifiers (probes) to various biological databases. While it supports older "Bimap" interfaces, the primary and recommended way to interact with the data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(canine.db)
```

### Exploring Available Data
To see what types of data (columns) can be retrieved and what types of keys can be used as input:
```r
# List available columns
columns(canine.db)

# List available key types (usually similar to columns)
keytypes(canine.db)

# See a sample of keys for a specific type
head(keys(canine.db, keytype="PROBEID"))
```

### Using the select() Interface
The `select()` function is the standard method for retrieving data. It requires the database object, the keys you are looking up, the columns you want to return, and the keytype of your input.

```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("canine:1001_at", "canine:1002_at")
select(canine.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols to Probes:** Use `ALIAS2PROBE` or `SYMBOL` to find manufacturer IDs associated with a gene name.
*   **Chromosomal Location:** Use `CHR`, `CHRLOC`, and `CHRLOCEND` to find the physical position of a gene.
*   **Functional Annotation:** Use `GO` (Gene Ontology), `PATH` (KEGG pathways), or `ENZYME` (EC numbers) for functional analysis.
*   **Cross-Species/External IDs:** Map to `ENSEMBL`, `UNIPROT`, or `REFSEQ` for integration with other bioinformatics pipelines.

### Working with Gene Ontology (GO)
The package provides three specific GO mappings:
1.  `GO`: Direct associations between genes and GO terms.
2.  `GO2PROBE`: Reverse mapping of GO terms to probes.
3.  `GO2ALLPROBES`: Mapping of GO terms to probes, including associations inherited from child nodes in the GO hierarchy (more inclusive).

```r
# Get all probes associated with a specific GO term (including children)
select(canine.db, keys="GO:0008150", columns="PROBEID", keytype="GOALL")
```

## Tips and Best Practices

*   **Prefer select():** While objects like `canineSYMBOL` can be accessed directly using `as.list()`, the `select()` interface is more robust and consistent with other Bioconductor annotation packages.
*   **Handle 1:Many Mappings:** Be aware that one probe might map to multiple Entrez IDs or GO terms. The `select()` function will return a data.frame with one row per mapping, which may result in more rows than your input key vector.
*   **Check Versioning:** Use `canine_dbInfo()` to check the data source dates and versions to ensure your annotations are current.
*   **Database Connection:** If you need to perform raw SQL queries, use `canine_dbconn()` to get the underlying DBI connection.

## Reference documentation
- [canine.db Reference Manual](./references/reference_manual.md)
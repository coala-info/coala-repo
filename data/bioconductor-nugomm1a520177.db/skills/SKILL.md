---
name: bioconductor-nugomm1a520177.db
description: "This package provides functional annotation data for the nugomm1a520177 mouse microarray platform. Use when user asks to map manufacturer probe identifiers to gene symbols, Entrez Gene IDs, MGI identifiers, GO terms, or KEGG pathways for Mus musculus data."
homepage: https://bioconductor.org/packages/release/data/annotation/html/nugomm1a520177.db.html
---


# bioconductor-nugomm1a520177.db

name: bioconductor-nugomm1a520177.db
description: Annotation package for the nugomm1a520177 platform. Use when mapping manufacturer probe identifiers to genomic identifiers (Entrez Gene, Ensembl, RefSeq, MGI), biological categories (GO, KEGG pathways), or gene symbols for Mus musculus (mouse) data.

# bioconductor-nugomm1a520177.db

## Overview

The `nugomm1a520177.db` package is a Bioconductor annotation data package for the nugomm1a520177 platform (typically associated with NuGO mouse arrays). It provides comprehensive mappings between manufacturer probe identifiers and various biological databases, allowing for the functional annotation of microarray results.

## Installation and Loading

Install the package using BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("nugomm1a520177.db")
```

Load the package into the R environment:

```r
library(nugomm1a520177.db)
```

## Core Workflows

### Exploring Available Maps

To list all available annotation objects provided by the package:

```r
ls("package:nugomm1a520177.db")
```

### Basic Identifier Mapping

To map manufacturer probe IDs to common identifiers like Gene Symbols or Entrez Gene IDs:

```r
# Map to Gene Symbols
probes <- c("10001_at", "10002_at") # Example probe IDs
symbols <- as.list(nugomm1a520177SYMBOL[probes])

# Map to Entrez Gene IDs
entrez_ids <- as.list(nugomm1a520177ENTREZID[probes])
```

### Using AnnotationDbi Interface

For more complex queries, use the standard `select` interface:

```r
# View available columns
columns(nugomm1a520177.db)

# Retrieve multiple attributes for specific probes
keys <- head(keys(nugomm1a520177.db))
select(nugomm1a520177.db, keys = keys, columns = c("SYMBOL", "GENENAME", "MGI"), keytype = "PROBEID")
```

### Reverse Mappings

Many objects have reverse maps (e.g., finding probes associated with a specific Gene Symbol):

```r
# Map Symbols back to Probe IDs
symbol_to_probe <- as.list(nugomm1a520177ALIAS2PROBE)
my_probes <- symbol_to_probe[["Akt1"]]
```

### Biological Context Mapping

Retrieve Gene Ontology (GO) or KEGG Pathway information:

```r
# Get GO terms for probes
go_terms <- as.list(nugomm1a520177GO[probes])

# Get KEGG pathway IDs
pathways <- as.list(nugomm1a520177PATH[probes])
```

### Database Metadata

To check the source data versions and organism information:

```r
nugomm1a520177_dbInfo()
nugomm1a520177ORGANISM
```

## Tips

- Use `mappedkeys(x)` to identify which keys in a map actually have an associated value.
- When using `as.list()`, be prepared for one-to-many mappings (e.g., one probe mapping to multiple GO terms).
- For high-performance queries, use `nugomm1a520177_dbconn()` to access the underlying SQLite database directly via `DBI` and `RSQLite` functions.

## Reference documentation

- [nugomm1a520177.db](./references/reference_manual.md)
---
name: bioconductor-u133x3p.db
description: This package provides annotation data for the Affymetrix Human Genome U133 Plus 2.0 Array. Use when user asks to map probe identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/u133x3p.db.html
---

# bioconductor-u133x3p.db

name: bioconductor-u133x3p.db
description: Provides annotation data for the Affymetrix Human Genome U133 Plus 2.0 Array (u133x3p). Use this skill to map manufacturer probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

## Overview

The `u133x3p.db` package is a Bioconductor annotation data package for the Affymetrix u133x3p platform. It provides an SQLite-based interface to map probe set IDs to genomic metadata. While it supports older "Bimap" style interfaces, the modern `select()` interface from the `AnnotationDbi` package is the preferred method for querying this data.

## Core Workflows

### Loading the Package
```R
library(u133x3p.db)
```

### Using the select() Interface
The `select()` function is the primary way to retrieve data. You need to specify the keys (probe IDs), the columns (desired information), and the keytype.

```R
# List available columns
columns(u133x3p.db)

# List available keytypes
keytypes(u133x3p.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1007_s_at", "1053_at", "117_at")
select(u133x3p.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

**1. Map Probes to Gene Ontology (GO)**
```R
select(u133x3p.db, keys = "1007_s_at", columns = "GO", keytype = "PROBEID")
```

**2. Map Probes to KEGG Pathways**
```R
select(u133x3p.db, keys = "1007_s_at", columns = "PATH", keytype = "PROBEID")
```

**3. Map Probes to Chromosomal Location**
```R
select(u133x3p.db, keys = "1007_s_at", columns = c("CHR", "CHRLOC"), keytype = "PROBEID")
```

### Using the Bimap Interface (Legacy)
For specific tasks, you may use the older Bimap objects (e.g., `u133x3pSYMBOL`).

```R
# Convert a mapping to a list
sym_list <- as.list(u133x3pSYMBOL)
# Get symbols for specific probes
sym_list[c("1007_s_at", "1053_at")]

# Get all mapped probe IDs
mapped_probes <- mappedkeys(u133x3pSYMBOL)
```

### Database Information
To inspect the underlying database metadata or connection:
```R
u133x3p_dbconn()    # Get the DB connection object
u133x3p_dbschema()  # View the database schema
u133x3p_dbInfo()    # View package metadata
```

## Tips
- **Multiple Mappings**: Some probes map to multiple genes or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Reverse Mappings**: To map from a Gene Symbol back to Probes using `select()`, simply change the `keytype` to `"SYMBOL"` and include `"PROBEID"` in the `columns`.
- **Package Dependencies**: Ensure `AnnotationDbi` is loaded to use the `select()`, `keys()`, and `columns()` functions.

## Reference documentation
- [u133x3p.db Reference Manual](./references/reference_manual.md)
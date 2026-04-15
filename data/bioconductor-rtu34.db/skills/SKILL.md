---
name: bioconductor-rtu34.db
description: This package provides annotation data for the rtu34 platform to map manufacturer probe identifiers to biological metadata for Rattus norvegicus. Use when user asks to map probe IDs to gene symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rtu34.db.html
---

# bioconductor-rtu34.db

name: bioconductor-rtu34.db
description: Annotation data package for the rtu34 platform. Use when mapping manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, GO terms, and KEGG pathways for Rattus norvegicus.

# bioconductor-rtu34.db

## Overview

rtu34.db is a Bioconductor annotation data package for the rtu34 platform (typically associated with Rat/Rattus norvegicus studies). It provides a comprehensive set of mappings between manufacturer-specific probe identifiers and various gene-centric identifiers. While it supports the older Bimap interface, the modern `select()` interface from the AnnotationDbi package is the recommended way to query this data.

## Core Workflows

### Using the select() Interface

The `select()` interface is the most flexible way to retrieve data. You can discover available keys and columns before querying.

```r
library(rtu34.db)

# List available columns (e.g., SYMBOL, ENTREZID, GO, PATH)
columns(rtu34.db)

# List available keytypes (usually PROBEID)
keytypes(rtu34.db)

# Retrieve mappings for specific probes
probes <- c("1367452_at", "1367453_at") # Example probe IDs
select(rtu34.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Mapping Probes to Biological Ontologies

You can map probes to Gene Ontology (GO) terms or KEGG pathways for functional analysis.

```r
# Map probes to GO terms with evidence codes
select(rtu34.db, keys = probes, columns = "GO", keytype = "PROBEID")

# Map probes to KEGG pathways
select(rtu34.db, keys = probes, columns = "PATH", keytype = "PROBEID")
```

### Using the Bimap Interface

For legacy code or specific list-based operations, you can use the Bimap objects directly.

```r
# Convert a mapping to a list
sym_list <- as.list(rtu34SYMBOL)

# Get symbols for the first 5 probes
sym_list[1:5]

# Find probes mapped to a specific chromosome
chr_map <- as.list(rtu34CHR)
probes_on_chr1 <- names(chr_map[chr_map == "1"])
```

### Accessing Metadata and Schema

To programmatically check the organism or database structure:

```r
# Get the organism name
rtu34ORGANISM

# Get the underlying SQLite database connection
conn <- rtu34_dbconn()
rtu34_dbschema()
```

## Tips

- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data.frame with one row per mapping.
- **Alias Mapping**: Use `rtu34ALIAS2PROBE` to find manufacturer identifiers associated with common gene symbols that might not be the "official" symbol.
- **Version Consistency**: This package is updated biannually; ensure your package version matches the data release used in your primary analysis.

## Reference documentation

- [rtu34.db Reference Manual](./references/reference_manual.md)
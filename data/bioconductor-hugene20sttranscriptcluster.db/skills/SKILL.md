---
name: bioconductor-hugene20sttranscriptcluster.db
description: This package provides SQLite-based annotation maps for the Affymetrix Human Gene 2.0 ST array to link transcript cluster identifiers with standard biological identifiers. Use when user asks to map probe IDs to gene symbols, retrieve Entrez IDs or GO terms for transcript clusters, and perform functional annotation for Human Gene 2.0 ST array data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene20sttranscriptcluster.db.html
---

# bioconductor-hugene20sttranscriptcluster.db

## Overview

The `hugene20sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Human Gene 2.0 ST array. It provides a SQLite-based interface to map manufacturer-specific transcript cluster identifiers to standard biological identifiers. The primary way to interact with this package is through the `AnnotationDbi` interface (specifically the `select()` function), though it also supports the legacy "Bimap" interface.

## Core Workflows

### Loading the Package
```r
library(hugene20sttranscriptcluster.db)
```

### Exploring Available Data
To see what types of data (columns) can be retrieved and what keys can be used:
```r
# List available columns (e.g., SYMBOL, ENTREZID, GO, PATH)
columns(hugene20sttranscriptcluster.db)

# List available key types (usually the same as columns)
keytypes(hugene20sttranscriptcluster.db)

# Get a sample of manufacturer IDs (keys)
head(keys(hugene20sttranscriptcluster.db))
```

### Mapping Identifiers using select()
The `select()` function is the recommended method for retrieving annotations.
```r
# Map a vector of probe IDs to Gene Symbols and Entrez IDs
probe_ids <- c("16737477", "16906321", "17020212")
annotations <- select(hugene20sttranscriptcluster.db, 
                      keys = probe_ids, 
                      columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                      keytype = "PROBEID")
```

### Functional Annotation (GO and KEGG)
You can map probe IDs to Gene Ontology (GO) terms or KEGG pathways for enrichment analysis.
```r
# Get GO terms for specific probes
go_mappings <- select(hugene20sttranscriptcluster.db, 
                      keys = probe_ids, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")

# Get KEGG pathway IDs
path_mappings <- select(hugene20sttranscriptcluster.db, 
                        keys = probe_ids, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### Reverse Mappings
To find which probes correspond to a specific gene symbol or Entrez ID:
```r
# Find probes for a specific Gene Symbol
select(hugene20sttranscriptcluster.db, 
       keys = "TP53", 
       columns = "PROBEID", 
       keytype = "SYMBOL")
```

## Legacy Bimap Interface
While `select()` is preferred, you may encounter the Bimap interface in older scripts.
```r
# Convert a map to a list
symbol_map <- as.list(hugene20sttranscriptclusterSYMBOL)
# Access specific probe
symbol_map[["16737477"]]
```

## Database Connection Information
To access the underlying SQLite database directly:
```r
# Get database connection
conn <- hugene20sttranscriptcluster_dbconn()
# Show database schema
hugene20sttranscriptcluster_dbschema()
```

## Tips
- **One-to-Many Mappings**: Note that some probes may map to multiple Entrez IDs or GO terms. The `select()` function returns a data frame that will expand to accommodate these multiple matches.
- **NA Values**: If a manufacturer ID cannot be mapped to a specific identifier (e.g., a SYMBOL), it will return `NA`.
- **Package Updates**: This package is updated biannually by Bioconductor to reflect changes in source databases like Entrez Gene and Ensembl.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
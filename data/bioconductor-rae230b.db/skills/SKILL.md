---
name: bioconductor-rae230b.db
description: This package provides comprehensive annotation data for mapping Affymetrix Rat Expression 230B probe identifiers to biological metadata. Use when user asks to map rae230b probe IDs to Entrez Gene IDs, Gene Symbols, Ensembl IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rae230b.db.html
---

# bioconductor-rae230b.db

name: bioconductor-rae230b.db
description: Comprehensive annotation data for the Rat Expression 230B (rae230b) platform. Use this skill when you need to map Affymetrix rae230b probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Ensembl IDs, GO terms, or KEGG pathways in R.

## Overview

The `rae230b.db` package is a Bioconductor annotation data package for the Rat Expression 230B platform. It provides a stable, SQLite-based interface to map manufacturer probe identifiers to various genomic and functional annotations. While it supports an older "Bimap" interface, the modern `AnnotationDbi` `select()` interface is the preferred method for querying this data.

## Core Workflows

### Loading the Package

```r
library(rae230b.db)
```

### Using the select() Interface

The `select()` function is the primary way to retrieve data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype (usually "PROBEID").

```r
# View available columns
columns(rae230b.db)

# View available keytypes
keytypes(rae230b.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1367452_at", "1367453_at")
select(rae230b.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Mapping to Functional Annotations

You can retrieve Gene Ontology (GO) terms or KEGG pathways for specific probes.

```r
# Map probes to GO terms (includes Evidence and Ontology category)
select(rae230b.db, 
       keys = probes, 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")

# Map probes to KEGG Pathways
select(rae230b.db, 
       keys = probes, 
       columns = "PATH", 
       keytype = "PROBEID")
```

### Using the Bimap Interface (Legacy)

For specific tasks, you might use the older Bimap objects. These are named after the package and the target attribute (e.g., `rae230bSYMBOL`).

```r
# Convert a mapping to a list
sym_list <- as.list(rae230bSYMBOL)

# Get probes that have a mapped symbol
mapped_probes <- mappedkeys(rae230bSYMBOL)

# Get symbols for the first 5 mapped probes
sym_list[mapped_probes[1:5]]
```

### Accessing Chromosomal Information

The package provides chromosome locations and lengths.

```r
# Get chromosome for probes
select(rae230b.db, keys = probes, columns = "CHR", keytype = "PROBEID")

# Get chromosome lengths
rae230bCHRLENGTHS
```

## Tips and Best Practices

- **Consensus Mapping**: For `ENTREZID`, if a probe maps to multiple identifiers, the package attempts to select a consensus or the smallest identifier.
- **Alias Mapping**: Use `rae230bALIAS2PROBE` to find probes associated with common gene aliases that might not be the official symbol.
- **Database Connection**: Use `rae230b_dbconn()` to get the underlying DBI connection if you need to run custom SQL queries against the SQLite database. Do not call `dbDisconnect()` on this object.
- **Version Check**: Use `rae230b_dbInfo()` to see metadata about the data sources and build dates (e.g., Entrez Gene, UCSC, KEGG).

## Reference documentation

- [rae230b.db Reference Manual](./references/reference_manual.md)
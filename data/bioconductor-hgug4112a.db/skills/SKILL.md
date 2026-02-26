---
name: bioconductor-hgug4112a.db
description: This package provides SQLite-based annotation data for mapping Agilent Human Genome G4112A microarray probe identifiers to various biological annotations and genomic locations. Use when user asks to map Agilent G4112A probe IDs to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosome positions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgug4112a.db.html
---


# bioconductor-hgug4112a.db

name: bioconductor-hgug4112a.db
description: Annotation data for the Agilent Human Genome G4112A platform. Use when mapping manufacturer probe identifiers to biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) or genomic locations for this specific microarray.

## Overview

The `hgug4112a.db` package is a Bioconductor annotation data package for the Agilent Human Genome G4112A platform. It provides a SQLite-based interface to map manufacturer probe IDs to various biological annotations. While it supports legacy Bimap objects, the recommended way to interact with the data is through the `AnnotationDbi` interface using `select()`.

## Installation and Loading

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgug4112a.db")
library(hgug4112a.db)
```

## Core Workflows

### Using the select() Interface

The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype of your input.

```R
# View available columns
columns(hgug4112a.db)

# View available keytypes (usually PROBEID)
keytypes(hgug4112a.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1", "10", "100") # Replace with actual Agilent probe IDs
select(hgug4112a.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Mapping to Gene Ontology (GO)

To get functional annotations, use the GO column. This returns GO IDs, Evidence codes, and Ontologies (BP, CC, MF).

```R
select(hgug4112a.db, 
       keys = probes, 
       columns = "GO", 
       keytype = "PROBEID")
```

### Mapping to KEGG Pathways

To identify biological pathways associated with probes:

```R
select(hgug4112a.db, 
       keys = probes, 
       columns = "PATH", 
       keytype = "PROBEID")
```

### Genomic Locations

You can retrieve chromosome information and base pair locations:

```R
# Get chromosome and start position
select(hgug4112a.db, 
       keys = probes, 
       columns = c("CHR", "CHRLOC"), 
       keytype = "PROBEID")
```

## Legacy Bimap Interface

While `select()` is preferred, you can still use the older Bimap interface for specific tasks like getting all mapped keys.

```R
# Get all probe IDs that have an Entrez ID mapping
x <- hgug4112aENTREZID
mapped_probes <- mappedkeys(x)

# Convert to a list for inspection
as.list(x[mapped_probes[1:5]])
```

## Database Information

To inspect the underlying database metadata or schema:

```R
# Get database connection info
hgug4112a_dbInfo()

# View the SQL schema
hgug4112a_dbschema()

# Get the number of rows in the probes table
library(DBI)
dbGetQuery(hgug4112a_dbconn(), "SELECT COUNT(*) FROM probes")
```

## Tips

- **NAs:** If a probe cannot be mapped to a specific identifier, `NA` is returned.
- **One-to-Many:** Some probes may map to multiple Entrez IDs or GO terms. `select()` will return a data frame with one row per mapping (long format).
- **Official Symbols:** Use the `SYMBOL` column for official gene symbols and `ALIAS` for common aliases.

## Reference documentation

- [hgug4112a.db Reference Manual](./references/reference_manual.md)
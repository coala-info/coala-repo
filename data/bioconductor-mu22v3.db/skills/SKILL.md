---
name: bioconductor-mu22v3.db
description: This package provides comprehensive annotation data for the Mu22v3 mouse microarray platform. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve Entrez Gene IDs or symbols, or find GO terms and KEGG pathways for Mus musculus probes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/Mu22v3.db.html
---

# bioconductor-mu22v3.db

name: bioconductor-mu22v3.db
description: Comprehensive annotation data for the Mu22v3 platform (Mus musculus). Use when Claude needs to map manufacturer probe identifiers to various biological metadata including Entrez Gene IDs, Symbols, GO terms, KEGG pathways, Ensembl IDs, and chromosomal locations.

## Overview

The `Mu22v3.db` package is a Bioconductor annotation hub for the Mu22v3 mouse microarray platform. It provides a SQLite-based interface to map manufacturer-specific probe IDs to standard biological identifiers. While it supports older "Bimap" interfaces, the modern recommended approach is using the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```R
library(Mu22v3.db)
```

### Exploring Available Data
To see which types of data (columns) can be retrieved and what keys are available:
```R
# List available columns (e.g., SYMBOL, ENTREZID, GO, PATH)
columns(Mu22v3.db)

# List available key types (usually PROBEID)
keytypes(Mu22v3.db)

# Get a sample of keys
head(keys(Mu22v3.db, keytype="PROBEID"))
```

### Using the select() Interface
The `select()` function is the primary way to extract data. It requires the database object, the keys you are looking up, the columns you want to retrieve, and the keytype of your input.

```R
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("130001", "130002") # Example probe IDs
results <- select(Mu22v3.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Mapping to Functional Annotations
You can map probes to Gene Ontology (GO) terms or KEGG pathways for functional analysis.

```R
# Map probes to GO terms with evidence codes
go_mappings <- select(Mu22v3.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY"), 
                      keytype = "PROBEID")

# Map probes to KEGG pathways
path_mappings <- select(Mu22v3.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### Chromosomal Locations
To find where a probe's target gene is located:
```R
# Get chromosome and start position
locs <- select(Mu22v3.db, 
               keys = probes, 
               columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
               keytype = "PROBEID")
```

## Legacy Bimap Interface
If working with older scripts, you may encounter Bimap objects. These are accessed using `as.list()` or `mappedkeys()`.

```R
# Get all probe to symbol mappings as a list
symbol_list <- as.list(Mu22v3SYMBOL)

# Get probes that have an associated Entrez ID
mapped_probes <- mappedkeys(Mu22v3ENTREZID)
```

## Database Metadata
To get information about the underlying database and data sources:
```R
Mu22v3_dbconn()   # Get the SQLite connection
Mu22v3_dbInfo()   # Print database metadata
Mu22v3ORGANISM    # Check the organism (Mus musculus)
```

## Reference documentation
- [Mu22v3.db Reference Manual](./references/reference_manual.md)
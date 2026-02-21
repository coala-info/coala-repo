---
name: bioconductor-clariomdhumanprobeset.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/clariomdhumanprobeset.db.html
---

# bioconductor-clariomdhumanprobeset.db

## Overview

The `clariomdhumanprobeset.db` package is a Bioconductor annotation data package for the Clariom D Human Probeset array. It provides a SQLite-based interface to map manufacturer-specific probe identifiers to various biological database identifiers. While it supports older "Bimap" interfaces, the primary and recommended method for interaction is the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(clariomdhumanprobeset.db)
```

### Exploring Available Data
To see what types of data (columns) can be retrieved and what keys can be used:
```r
# List available columns (e.g., SYMBOL, ENTREZID, GO, PATH)
columns(clariomdhumanprobeset.db)

# List available key types
keytypes(clariomdhumanprobeset.db)

# Get a sample of probe identifiers (keys)
head(keys(clariomdhumanprobeset.db))
```

### Using the select() Interface
The `select()` function is the standard way to extract data. It requires the database object, the keys you are interested in, the columns you want to retrieve, and the keytype of your input.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("16650001", "16650005", "16650009")
results <- select(clariomdhumanprobeset.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

#### Mapping to Gene Ontology (GO)
Retrieves GO identifiers, evidence codes, and ontologies (BP, CC, MF).
```r
go_mappings <- select(clariomdhumanprobeset.db, 
                      keys = probes, 
                      columns = "GO", 
                      keytype = "PROBEID")
```

#### Mapping to KEGG Pathways
```r
path_mappings <- select(clariomdhumanprobeset.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

#### Chromosomal Locations
```r
loc_mappings <- select(clariomdhumanprobeset.db, 
                        keys = probes, 
                        columns = c("CHR", "CHRLOC", "MAP"), 
                        keytype = "PROBEID")
```

### Reverse Mappings
You can map from biological identifiers back to probe IDs by changing the `keytype`.

```r
# Find probes associated with a specific Gene Symbol
symbol_to_probe <- select(clariomdhumanprobeset.db, 
                          keys = "TP53", 
                          columns = "PROBEID", 
                          keytype = "SYMBOL")
```

## Database Connection Utilities
For advanced users needing direct SQL access:
- `clariomdhumanprobeset_dbconn()`: Returns the DBI connection object.
- `clariomdhumanprobeset_dbfile()`: Returns the path to the SQLite file.
- `clariomdhumanprobeset_dbschema()`: Prints the database schema.

## Tips
- **One-to-Many Mappings**: Note that `select()` may return more rows than input keys if a probe maps to multiple genes or GO terms.
- **Deprecated Functions**: Avoid using `clariomdhumanprobesetMAPCOUNTS` as it is out of sync; use `length(keys(x))` or `count.mappedkeys(x)` instead.
- **Alias Mapping**: Use the `ALIAS` column to find probes using common gene names that might not be the official symbol.

## Reference documentation
- [clariomdhumanprobeset.db](./references/reference_manual.md)
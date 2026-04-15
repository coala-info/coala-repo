---
name: bioconductor-canine2.db
description: This package provides annotation data for the Affymetrix Canine Genome 2.0 Array to map probe identifiers to biological metadata. Use when user asks to map canine probe IDs to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/canine2.db.html
---

# bioconductor-canine2.db

name: bioconductor-canine2.db
description: An annotation data package for the Affymetrix Canine Genome 2.0 Array. Use this skill when you need to map canine-specific manufacturer identifiers (probes) to various biological metadata such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, KEGG pathways, and Ensembl IDs.

## Overview

The `canine2.db` package is a Bioconductor annotation hub for the Canine Genome 2.0 platform. It provides a SQLite-based interface to map probe set IDs to genomic, functional, and publication data. The primary way to interact with this package is through the `AnnotationDbi` interface (`select()`, `keys()`, `columns()`, and `keytypes()`) or via the legacy Bimap interface.

## Core Workflows

### 1. Loading the Package
```r
library(canine2.db)
```

### 2. Exploring Available Data
Use these functions to understand what data can be retrieved:
```r
# View all available mapping categories (columns)
columns(canine2.db)

# View available key types (usually PROBEID)
keytypes(canine2.db)

# Get a sample of probe identifiers
head(keys(canine2.db, keytype="PROBEID"))
```

### 3. Retrieving Annotations using select()
The `select()` function is the recommended method for mapping identifiers.
```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("121_at", "122_at", "123_at")
res <- select(canine2.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

### 4. Functional Annotation (GO and KEGG)
```r
# Map probes to Gene Ontology (GO) terms
go_mapping <- select(canine2.db, 
                     keys = probes, 
                     columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                     keytype = "PROBEID")

# Map probes to KEGG Pathways
path_mapping <- select(canine2.db, 
                       keys = probes, 
                       columns = "PATH", 
                       keytype = "PROBEID")
```

### 5. Chromosomal Locations
```r
# Get chromosome and start position
loc_mapping <- select(canine2.db, 
                      keys = probes, 
                      columns = c("CHR", "CHRLOC"), 
                      keytype = "PROBEID")
```

## Legacy Bimap Interface
While `select()` is preferred, you can use the older Bimap objects for specific list-based operations:
- `canine2ACCNUM`: Manufacturer ID to GenBank Accession.
- `canine2ALIAS2PROBE`: Gene Symbols/Aliases to Manufacturer ID.
- `canine2ENSEMBL`: Manufacturer ID to Ensembl Gene ID.
- `canine2SYMBOL`: Manufacturer ID to Official Gene Symbol.
- `canine2UNIPROT`: Manufacturer ID to Uniprot ID.

Example of Bimap usage:
```r
# Convert a map to a list
sym_list <- as.list(canine2SYMBOL)
# Access specific probe
sym_list[["121_at"]]
```

## Database Connection Information
To query the underlying SQLite database directly:
```r
# Get database connection
conn <- canine2_dbconn()
# Show database schema
canine2_dbschema()
# Get path to SQLite file
canine2_dbfile()
```

## Tips
- **Multiple Mappings**: Some probes map to multiple Entrez IDs or GO terms. `select()` will return a data.frame with one row per mapping, which may result in more rows than input keys.
- **NA Values**: If a probe cannot be mapped to a specific column, `NA` is returned for that field.
- **Organism Info**: Use `canine2ORGANISM` to confirm the species (Canis familiaris).

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
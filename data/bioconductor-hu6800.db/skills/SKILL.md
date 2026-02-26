---
name: bioconductor-hu6800.db
description: This package provides SQLite-based annotation data for mapping Affymetrix Hu6800 chip probe identifiers to various biological and functional annotations. Use when user asks to map Hu6800 probe IDs to gene symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu6800.db.html
---


# bioconductor-hu6800.db

name: bioconductor-hu6800.db
description: Annotation data for the Affymetrix Hu6800 human oligonucleotide array. Use when mapping manufacturer probe identifiers to biological identifiers (Entrez Gene IDs, Gene Symbols, GO terms, etc.) or performing functional annotation for the hu6800 platform.

## Overview

The `hu6800.db` package is a Bioconductor annotation data package for the Affymetrix Hu6800 chip. It provides a SQLite-based interface to map manufacturer probe IDs to various genomic and functional annotations. While it supports a legacy "Bimap" interface, the modern `AnnotationDbi` `select()` interface is the preferred method for querying.

## Core Workflows

### Loading the Package
```r
library(hu6800.db)
```

### Exploring Available Data
To see which types of data can be retrieved:
```r
columns(hu6800.db)
# Common columns: SYMBOL, ENTREZID, GENENAME, GO, PATH, ENSEMBL
```

To see the available probe identifiers:
```r
probes <- keys(hu6800.db, keytype = "PROBEID")
head(probes)
```

### Using the select() Interface
The `select()` function is the primary way to retrieve data. It requires the database object, the keys to look up, the columns to return, and the keytype of the input.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
res <- select(hu6800.db, 
              keys = c("A10", "A11"), 
              columns = c("SYMBOL", "ENTREZID"), 
              keytype = "PROBEID")
```

### Mapping Gene Symbols back to Probes
To find which probes correspond to a specific gene symbol, use the `ALIAS` or `SYMBOL` keytypes.

```r
# Find probes for a specific gene alias
select(hu6800.db, 
       keys = "GAPDH", 
       columns = "PROBEID", 
       keytype = "ALIAS")
```

### Functional Annotation (GO and KEGG)
Retrieve Gene Ontology (GO) terms or KEGG pathway IDs associated with probes.

```r
# Get GO terms for specific probes
go_ann <- select(hu6800.db, 
                 keys = probes[1:5], 
                 columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                 keytype = "PROBEID")

# Get KEGG pathways
kegg_ann <- select(hu6800.db, 
                   keys = probes[1:5], 
                   columns = "PATH", 
                   keytype = "PROBEID")
```

### Accessing Metadata and Database Info
```r
# Get organism information
hu6800ORGANISM
hu6800ORGPKG

# Get database connection details
hu6800_dbconn()
hu6800_dbschema()
```

## Tips and Best Practices
- **Prefer select()**: Use the `select()` interface over the older Bimap objects (e.g., `hu6800SYMBOL`) for better consistency and multi-column retrieval.
- **Handle 1-to-Many Mappings**: Be aware that one probe might map to multiple GO terms or pathways; `select()` will return a data frame with multiple rows for these cases.
- **Keytypes**: Always verify your `keytype` argument. If you are using manufacturer IDs, the keytype is usually "PROBEID".
- **MapIds for Vectors**: If you need a simple named vector instead of a data frame, use `mapIds()`:
  ```r
  syms <- mapIds(hu6800.db, keys = probes[1:10], column = "SYMBOL", keytype = "PROBEID")
  ```

## Reference documentation
- [hu6800.db Reference Manual](./references/reference_manual.md)
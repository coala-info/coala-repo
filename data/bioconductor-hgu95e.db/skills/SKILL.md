---
name: bioconductor-hgu95e.db
description: This package provides comprehensive annotation data for the Affymetrix Human Genome U95 Set (hgu95e) platform. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve Gene Symbols or Entrez IDs for hgu95e probes, or find GO terms and KEGG pathways associated with these identifiers.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95e.db.html
---

# bioconductor-hgu95e.db

name: bioconductor-hgu95e.db
description: Comprehensive annotation data for the Affymetrix Human Genome U95 Set (hgu95e) platform. Use this skill when you need to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, KEGG pathways, and Ensembl identifiers.

# bioconductor-hgu95e.db

## Overview
The `hgu95e.db` package is a Bioconductor annotation data package for the Affymetrix Human Genome U95 Set. It provides a SQLite-based interface to map manufacturer probe identifiers to various biological identifiers and annotations. The primary way to interact with this data is through the `select()` interface from the `AnnotationDbi` package, though legacy Bimap objects are also available.

## Core Workflows

### Loading the Package
```r
library(hgu95e.db)
```

### Using the select() Interface
The `select()` function is the recommended method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired data), and the keytype (type of input IDs).

```r
# List available columns
columns(hgu95e.db)

# List available keytypes
keytypes(hgu95e.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
select(hgu95e.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

#### Mapping to Gene Ontology (GO)
To get GO terms including evidence codes and ontologies (BP, CC, MF):
```r
select(hgu95e.db, keys = "1000_at", columns = "GO", keytype = "PROBEID")
```

#### Mapping to KEGG Pathways
```r
select(hgu95e.db, keys = "1000_at", columns = "PATH", keytype = "PROBEID")
```

#### Finding Probes for a Specific Gene Symbol
```r
select(hgu95e.db, keys = "TP53", columns = "PROBEID", keytype = "SYMBOL")
```

### Using Legacy Bimap Objects
While `select()` is preferred, individual mapping objects (Bimaps) can be used for quick lookups or list conversions.

```r
# Convert a mapping to a list
sym_list <- as.list(hgu95eSYMBOL)
# Get symbols for specific probes
sym_list[c("1000_at", "1001_at")]

# Reverse mapping (e.g., Symbol to Probe)
rev_map <- revmap(hgu95eSYMBOL)
as.list(rev_map)["TP53"]
```

### Database Metadata and Connection
You can inspect the underlying database schema and metadata using utility functions.

```r
# Get database connection info
hgu95e_dbInfo()

# View the SQL schema
hgu95e_dbschema()

# Get the path to the SQLite file
hgu95e_dbfile()
```

## Tips and Best Practices
- **Key Selection**: Always ensure your `keytype` matches the format of your `keys`. For this package, the default `keytype` is usually `PROBEID`.
- **One-to-Many Mappings**: Be aware that one probe ID may map to multiple GO terms or pathways. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Package Dependencies**: This package requires `AnnotationDbi`. Ensure it is loaded if you are using `select()`, `keys()`, or `columns()`.
- **Data Updates**: Bioconductor annotation packages are updated biannually. Always check the version if consistency across long-term projects is required.

## Reference documentation
- [hgu95e.db Reference Manual](./references/reference_manual.md)
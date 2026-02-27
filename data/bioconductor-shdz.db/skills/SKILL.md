---
name: bioconductor-shdz.db
description: This package provides Bioconductor annotation data for mapping SHDZ platform manufacturer identifiers to various biological metadata. Use when user asks to map probe IDs to Entrez Gene IDs, gene symbols, chromosomal locations, GO terms, KEGG pathways, or PubMed identifiers.
homepage: https://bioconductor.org/packages/release/data/annotation/html/SHDZ.db.html
---


# bioconductor-shdz.db

name: bioconductor-shdz.db
description: Annotation data package for the SHDZ platform. Use when mapping manufacturer identifiers to biological metadata including Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, KEGG pathways, and PubMed identifiers.

## Overview

The `SHDZ.db` package is a Bioconductor annotation data package that provides detailed information about the SHDZ platform. It serves as an SQLite-based mapping between manufacturer-specific identifiers (probes) and various public identifiers. While it supports legacy Bimap interfaces, the recommended way to interact with the data is through the `AnnotationDbi` standard interface (`select`, `columns`, `keys`, and `mapIds`).

## Basic Usage

### Loading the Package

```r
library(SHDZ.db)
```

### Exploring the Database

To see what types of data can be retrieved:

```r
# List available columns (data types)
columns(SHDZ.db)

# List available keytypes (what you can search by)
keytypes(SHDZ.db)

# Get a sample of keys (manufacturer IDs)
head(keys(SHDZ.db, keytype="PROBEID"))
```

### Querying with select()

The `select()` function is the primary method for retrieving data. It returns a data frame.

```r
# Map probe IDs to Symbols and Entrez IDs
probes <- c("12345_at", "67890_at") # Replace with actual SHDZ probe IDs
results <- select(SHDZ.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Simple Mappings with mapIds()

Use `mapIds()` when you need a named vector or a specific multi-mapping resolution (like returning only the first match).

```r
# Get 1:1 mapping of probes to Symbols
symbols <- mapIds(SHDZ.db, 
                  keys = probes, 
                  column = "SYMBOL", 
                  keytype = "PROBEID", 
                  multiVals = "first")
```

## Common Annotation Tasks

### Chromosomal Locations

Retrieve the chromosome and start position for specific probes:

```r
select(SHDZ.db, keys = probes, columns = c("CHR", "CHRLOC"), keytype = "PROBEID")
```

### Functional Annotation (GO and KEGG)

Map probes to Gene Ontology (GO) terms or KEGG pathways:

```r
# Get GO terms and evidence codes
go_data <- select(SHDZ.db, keys = probes, columns = "GO", keytype = "PROBEID")

# Get KEGG pathway IDs
kegg_data <- select(SHDZ.db, keys = probes, columns = "PATH", keytype = "PROBEID")
```

### External Database Cross-References

Map manufacturer IDs to Ensembl, RefSeq, or UniProt:

```r
select(SHDZ.db, 
       keys = probes, 
       columns = c("ENSEMBL", "REFSEQ", "UNIPROT"), 
       keytype = "PROBEID")
```

## Legacy Bimap Interface

While `select()` is preferred, you can still use the "old style" Bimap objects for specific tasks:

```r
# Get all mapped probe IDs for Accession Numbers
x <- SHDZACCNUM
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Get chromosome lengths
SHDZCHRLENGTHS["1"]
```

## Database Metadata

To inspect the underlying database schema or connection:

```r
SHDZ_dbconn()    # Returns the DBI connection object
SHDZ_dbfile()    # Returns the path to the SQLite file
SHDZ_dbschema()  # Prints the database schema
SHDZ_dbInfo()    # Prints package metadata
```

## Reference documentation

- [SHDZ.db Reference Manual](./references/reference_manual.md)
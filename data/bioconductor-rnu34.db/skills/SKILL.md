---
name: bioconductor-rnu34.db
description: "This package provides Bioconductor annotation data for the Rattus norvegicus rnu34 platform. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve gene symbols, or access functional annotations like GO terms and KEGG pathways for rat data."
homepage: https://bioconductor.org/packages/release/data/annotation/html/rnu34.db.html
---


# bioconductor-rnu34.db

name: bioconductor-rnu34.db
description: Bioconductor annotation data package for the rnu34 platform. Use when mapping manufacturer probe identifiers to biological metadata such as Gene Symbols, Entrez IDs, GO terms, and KEGG pathways for Rattus norvegicus (Rat) data.

## Overview

The `rnu34.db` package is a comprehensive annotation database for the rnu34 platform. It allows researchers to translate manufacturer-specific probe identifiers into standard biological nomenclature and functional annotations. While it supports older "Bimap" objects, the recommended way to interact with the data is through the `AnnotationDbi` interface (`select`, `columns`, `keys`, and `mapIds`).

## Core Workflow

### Loading the Package
```r
library(rnu34.db)
```

### Exploring Available Data
To see which types of annotations (columns) and identifiers (keys) are available:
```r
# List all available annotation types
columns(rnu34.db)

# List the primary keys (usually manufacturer probe IDs)
keytypes(rnu34.db)
head(keys(rnu34.db))
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. It requires the database object, the keys you are interested in, the columns you want to retrieve, and the keytype of your input.

```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1367452_at", "1367453_at") # Example probe IDs
select(rnu34.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Using mapIds() for Simple Mappings
If you only need a 1-to-1 mapping (e.g., Probe ID to Symbol), `mapIds` is more convenient:
```r
symbols <- mapIds(rnu34.db, 
                  keys = probes, 
                  column = "SYMBOL", 
                  keytype = "PROBEID", 
                  multiVals = "first")
```

## Available Annotation Mappings

- **Gene Identifiers**: `ENTREZID`, `SYMBOL`, `GENENAME`, `ENSEMBL`, `REFSEQ`, `UNIPROT`.
- **Functional Annotation**: `GO` (Gene Ontology), `PATH` (KEGG Pathways), `ENZYME`.
- **Genomic Location**: `CHR` (Chromosome), `CHRLOC` (Start position), `CHRLOCEND` (End position).
- **Literature**: `PMID` (PubMed identifiers).

## Legacy Bimap Interface
While `select()` is preferred, you can still access specific mappings using the older Bimap objects:

```r
# Get the Gene Symbols for a set of probes
x <- rnu34SYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes][1:5])

# Reverse mapping (e.g., Symbols to Probes)
rev_x <- revmap(rnu34SYMBOL)
```

## Database Utilities
To get metadata about the database or the underlying SQLite connection:
```r
rnu34_dbconn()   # Returns the DB connection object
rnu34_dbschema() # Prints the database schema
rnu34_dbInfo()   # Displays package metadata
```

## Reference documentation
- [rnu34.db Reference Manual](./references/reference_manual.md)
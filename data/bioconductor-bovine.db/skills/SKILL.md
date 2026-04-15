---
name: bioconductor-bovine.db
description: This package provides comprehensive annotation data for mapping between various bovine-specific gene identifiers, functional annotations, and chromosomal locations. Use when user asks to map bovine probe IDs to gene symbols, retrieve Gene Ontology terms for Bos taurus genes, or find KEGG pathways and genomic coordinates for bovine sequences.
homepage: https://bioconductor.org/packages/release/data/annotation/html/bovine.db.html
---

# bioconductor-bovine.db

name: bioconductor-bovine.db
description: Comprehensive annotation data for the bovine (Bos taurus) platform. Use when you need to map between various bovine-specific gene identifiers (Entrez, Ensembl, RefSeq, UniProt), Gene Ontology (GO) terms, KEGG pathways, and chromosomal locations.

# bioconductor-bovine.db

## Overview

The `bovine.db` package is a Bioconductor annotation data package for Bos taurus. It provides a SQLite-based interface to map manufacturer identifiers (probes) to various biological identifiers and metadata. While it supports older "Bimap" interfaces, the primary and recommended way to interact with the data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(bovine.db)
```

### Exploring Available Data
To see which types of identifiers and data columns are available for querying:
```r
columns(bovine.db)
# Common columns: ENTREZID, SYMBOL, GENENAME, ENSEMBL, GO, PATH, CHR
```

To see the types of input keys you can use:
```r
keytypes(bovine.db)
```

### Using the select() Interface
The `select()` function is the standard way to retrieve data. It requires the database object, the input keys, the columns you want to retrieve, and the keytype of your input.

```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("121_at", "122_at") # Replace with actual bovine probe IDs
results <- select(bovine.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Mapping to Functional Annotations
You can map probes to Gene Ontology (GO) terms or KEGG pathways:

```r
# Map probes to GO terms
go_mappings <- select(bovine.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")

# Map probes to KEGG Pathways
path_mappings <- select(bovine.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### Chromosomal Locations
To find where genes are located on the bovine genome:
```r
# Get chromosome and start position
loc_data <- select(bovine.db, 
                   keys = probes, 
                   columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                   keytype = "PROBEID")
```

## Legacy Bimap Interface
While `select()` is preferred, you can still use the Bimap interface for quick lookups or list conversions:

```r
# Convert a specific map to a list
sym_list <- as.list(bovineSYMBOL)
# Access a specific probe
sym_list[["121_at"]]

# Get all mapped keys
mapped_probes <- mappedkeys(bovineACCNUM)
```

## Database Connection and Metadata
To inspect the underlying database schema or connection:
```r
# Get database metadata
bovine_dbInfo()

# Get the database schema
bovine_dbschema()

# Get the organism name
bovineORGANISM
```

## Tips
- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function returns a data frame that will contain one row for each possible mapping (resulting in a "long" format).
- **Key Selection**: Ensure your `keytype` matches the format of your input `keys`. If using manufacturer-specific probe IDs, use `keytype = "PROBEID"`.
- **Version Consistency**: This package is updated biannually. Always check `bovine_dbInfo()` to verify the data source dates (e.g., Entrez Gene or Ensembl release versions).

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)
---
name: bioconductor-mu19ksubc.db
description: This package provides comprehensive annotation data for the mu19ksubc microarray platform for Mus musculus. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve Gene Ontology terms, identify KEGG pathways, or find chromosomal locations for mouse genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu19ksubc.db.html
---

# bioconductor-mu19ksubc.db

name: bioconductor-mu19ksubc.db
description: Comprehensive annotation data for the mu19ksubc platform. Use when mapping manufacturer probe identifiers to biological metadata like Entrez IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations for Mus musculus.

# bioconductor-mu19ksubc.db

## Overview

The `mu19ksubc.db` package is a Bioconductor annotation data package that provides detailed mappings for the mu19ksubc microarray platform (Mus musculus). It functions as an SQLite-based interface to associate manufacturer-specific probe identifiers with various biological database identifiers and genomic metadata.

## Getting Started

Load the package and explore available columns:

```r
library(mu19ksubc.db)

# List all available annotation types
columns(mu19ksubc.db)

# List the first few probe keys
head(keys(mu19ksubc.db))
```

## Using the Select Interface

The `select()` function from the `AnnotationDbi` package is the recommended method for retrieving data. It allows for mapping between different identifier types in a single call.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at")
select(mu19ksubc.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

## Common Annotation Workflows

### Mapping to Gene Ontology (GO)
Retrieve GO terms associated with specific probes, including the ontology category (BP, CC, MF) and evidence codes.

```r
select(mu19ksubc.db, 
       keys = "1000_at", 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")
```

### Mapping to Pathways
Identify KEGG pathway identifiers for specific probes.

```r
select(mu19ksubc.db, 
       keys = "1000_at", 
       columns = "PATH", 
       keytype = "PROBEID")
```

### Chromosomal Locations
Find the chromosome and starting/ending base pair positions.

```r
select(mu19ksubc.db, 
       keys = "1000_at", 
       columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
       keytype = "PROBEID")
```

### External Database Cross-References
Map manufacturer IDs to Ensembl, MGI, RefSeq, or UniProt identifiers.

```r
select(mu19ksubc.db, 
       keys = "1000_at", 
       columns = c("ENSEMBL", "MGI", "REFSEQ", "UNIPROT"), 
       keytype = "PROBEID")
```

## Legacy Bimap Interface

While `select()` is preferred, you can still access individual mapping objects directly using the Bimap interface.

```r
# Convert a mapping to a list
alias_map <- as.list(mu19ksubcALIAS2PROBE)
# Get probes for a specific gene symbol alias
alias_map[["Akt1"]]

# Get chromosome lengths
mu19ksubcCHRLENGTHS["1"]
```

## Database Information

To inspect the underlying SQLite database or schema:

```r
# Get the database connection
conn <- mu19ksubc_dbconn()

# Show the database schema
mu19ksubc_dbschema()

# Get general database info
mu19ksubc_dbInfo()
```

## Reference documentation

- [mu19ksubc.db Reference Manual](./references/reference_manual.md)
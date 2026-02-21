---
name: bioconductor-hguqiagenv3.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hguqiagenv3.db.html
---

# bioconductor-hguqiagenv3.db

## Overview

The `hguqiagenv3.db` package is a Bioconductor annotation data package for the Qiagen Human Genome U133 Plus 2.0 platform. It provides a comprehensive set of SQLite-based mappings between manufacturer probe identifiers and various biological databases. While it supports older "Bimap" interfaces, the modern and preferred method for interaction is the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(hguqiagenv3.db)
```

### Exploring Available Annotations
To see which types of data (columns) can be retrieved:
```r
columns(hguqiagenv3.db)
```

To see the types of identifiers you can use as input (keys):
```r
keytypes(hguqiagenv3.db)
```

### Mapping Identifiers using select()
The `select()` function is the primary tool for mapping. It requires the database object, the input keys, the columns to retrieve, and the keytype of the input.

```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
results <- select(hguqiagenv3.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Targets
- **SYMBOL**: Official Gene Symbol
- **ENTREZID**: Entrez Gene Identifier
- **ENSEMBL**: Ensembl Gene Accession
- **GO**: Gene Ontology identifiers (includes Evidence and Ontology category)
- **PATH**: KEGG Pathway identifiers
- **UNIPROT**: UniProt accession numbers
- **ACCNUM**: GenBank Accession numbers

### Reverse Mappings
You can map from other identifiers back to probes by changing the `keytype`:
```r
# Map Gene Symbols back to Probe IDs
symbols <- c("TP53", "BRCA1")
select(hguqiagenv3.db, 
       keys = symbols, 
       columns = "PROBEID", 
       keytype = "SYMBOL")
```

## Specialized Mappings

### Gene Ontology (GO)
The package provides three ways to access GO data:
1. `GO`: Direct associations only.
2. `GO2PROBE`: Reverse map of direct associations.
3. `GO2ALLPROBES`: More inclusive; maps a GO term to all probes associated with that term or any of its child nodes in the GO hierarchy.

### Chromosomal Information
- `CHR`: Chromosome assignment.
- `CHRLOC`: Chromosomal start location (negative values indicate the antisense strand).
- `CHRLOCEND`: Chromosomal end location.
- `MAP`: Cytogenetic band locations.

## Database Connection and Metadata
To inspect the underlying database schema or connection:
```r
hguqiagenv3_dbconn()    # Returns the DBI connection object
hguqiagenv3_dbfile()    # Returns the path to the SQLite file
hguqiagenv3_dbschema()  # Prints the database schema
```

## Tips
- **Handling Multi-mappings**: Some probes may map to multiple genes or GO terms. The `select()` function returns a data.frame that will contain one row for each possible mapping, potentially increasing the row count relative to your input.
- **Bimap Interface**: While `as.list(hguqiagenv3SYMBOL)` still works, it is considered legacy. Stick to `select()` for better integration with modern Bioconductor workflows.
- **Organism Info**: Use `hguqiagenv3ORGANISM` to programmatically confirm the species (Homo sapiens).

## Reference documentation
- [hguqiagenv3.db Reference Manual](./references/reference_manual.md)
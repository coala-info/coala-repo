---
name: bioconductor-mgug4120a.db
description: This package provides annotation data for the Agilent Mouse Genome UG 4120a Array to map probe identifiers to biological metadata. Use when user asks to map Agilent mouse probe IDs to gene symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgug4120a.db.html
---


# bioconductor-mgug4120a.db

name: bioconductor-mgug4120a.db
description: Annotation data for the Agilent Mouse Genome UG 4120a Array. Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) and genomic locations for Mus musculus.

## Overview

The `mgug4120a.db` package is a Bioconductor annotation data package for the Agilent Mouse Genome UG 4120a platform. It provides a SQLite-based interface to map probe IDs to genomic metadata. The primary method for interaction is the `select()` interface from the `AnnotationDbi` package, though legacy "Bimap" objects are also available.

## Core Workflows

### Loading the Package
```r
library(mgug4120a.db)
```

### Using the select() Interface
The `select()` function is the recommended way to query the database. It requires four arguments: the database object, the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

```r
# List available columns
columns(mgug4120a.db)

# List available keytypes
keytypes(mgug4120a.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("10001_at", "10002_at") # Replace with actual mgug4120a probe IDs
select(mgug4120a.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Annotation Mappings
- **Gene Symbols**: Map probes to official gene abbreviations using `SYMBOL`.
- **Entrez Gene IDs**: Map probes to NCBI Entrez Gene identifiers using `ENTREZID`.
- **Gene Ontology (GO)**: Map probes to GO terms for functional analysis using `GO`.
- **KEGG Pathways**: Map probes to metabolic and signaling pathways using `PATH`.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` to find the physical position of genes.

### Reverse Mappings (Alias to Probe)
To find which probes correspond to a specific gene symbol or alias:
```r
select(mgug4120a.db, 
       keys = "Tp53", 
       columns = "PROBEID", 
       keytype = "SYMBOL")
```

### Database Metadata and Connection
You can inspect the database schema or connection directly if needed for complex SQL queries:
```r
# Get database connection
conn <- mgug4120a_dbconn()

# Show database schema
mgug4120a_dbschema()

# Get number of mapped keys
mgug4120a_dbInfo()
```

## Tips and Best Practices
- **Vectorized Queries**: Always pass a vector of keys to `select()` rather than calling it in a loop for better performance.
- **Handling 1-to-Many**: Note that some probes may map to multiple Entrez IDs or GO terms. `select()` will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Organism Check**: This package is specific to *Mus musculus*. Use `mgug4120aORGANISM` to programmatically verify the species.
- **Legacy Bimaps**: While `as.list(mgug4120aSYMBOL)` still works, the `select()` interface is more robust and consistent with modern Bioconductor workflows.

## Reference documentation
- [mgug4120a.db Reference Manual](./references/reference_manual.md)
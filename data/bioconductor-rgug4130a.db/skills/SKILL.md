---
name: bioconductor-rgug4130a.db
description: This package provides annotation data for the Agilent Rat Genome (rgug4130a) platform. Use when user asks to map Agilent rat probe identifiers to biological metadata, retrieve gene symbols, or find GO terms and KEGG pathways for Rattus norvegicus.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgug4130a.db.html
---


# bioconductor-rgug4130a.db

name: bioconductor-rgug4130a.db
description: Provides annotation data for the Agilent Rat Genome (rgug4130a) platform. Use this skill to map manufacturer probe identifiers to biological identifiers (Entrez Gene, Gene Symbol, GO terms, KEGG pathways, etc.) and genomic locations for Rattus norvegicus.

# bioconductor-rgug4130a.db

## Overview

The `rgug4130a.db` package is a Bioconductor annotation data package for the Agilent Rat Genome array. It provides a SQLite-based interface to map manufacturer-specific probe identifiers to various biological metadata. The primary organism is *Rattus norvegicus*.

## Installation

To install the package, use the BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rgug4130a.db")
```

## Core Workflows

### Using the select() Interface

The preferred method for interacting with the database is through the `AnnotationDbi` functions: `columns()`, `keytypes()`, `keys()`, and `select()`.

```r
library(rgug4130a.db)

# List available annotation types
columns(rgug4130a.db)

# List available key types (usually includes PROBEID)
keytypes(rgug4130a.db)

# Retrieve specific keys
probes <- head(keys(rgug4130a.db, keytype = "PROBEID"))

# Map probes to Gene Symbols and Entrez IDs
res <- select(rgug4130a.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

### Mapping to Gene Ontology (GO)

To retrieve GO terms associated with specific probes:

```r
go_mappings <- select(rgug4130a.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")
```

### Mapping to KEGG Pathways

To find biological pathways associated with probes:

```r
path_mappings <- select(rgug4130a.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

## Legacy Bimap Interface

While `select()` is preferred, the "Bimap" interface is still available for specific mapping objects.

```r
# Get the mapping object for Symbols
x <- rgug4130aSYMBOL

# Get probes that have a mapped symbol
mapped_probes <- mappedkeys(x)

# Convert to a list for inspection
symbol_list <- as.list(x[mapped_probes[1:5]])
```

### Common Bimap Objects
- `rgug4130aACCNUM`: Manufacturer ID to GenBank Accession.
- `rgug4130aALIAS2PROBE`: Gene Symbols/Aliases to Manufacturer ID.
- `rgug4130aCHR`: Manufacturer ID to Chromosome.
- `rgug4130aCHRLOC`: Manufacturer ID to Chromosomal Starting Location.
- `rgug4130aENSEMBL`: Manufacturer ID to Ensembl Gene ID.
- `rgug4130aUNIPROT`: Manufacturer ID to Uniprot Accession.

## Database Information

To inspect the underlying database schema and metadata:

```r
# Get database connection
conn <- rgug4130a_dbconn()

# Show database schema
rgug4130a_dbschema()

# Show package metadata
rgug4130a_dbInfo()
```

## Reference documentation

- [rgug4130a.db Reference Manual](./references/reference_manual.md)
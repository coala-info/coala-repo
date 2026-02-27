---
name: bioconductor-ragene11sttranscriptcluster.db
description: This package provides SQLite-based annotation data for mapping Affymetrix Rat Gene 1.1 ST Array transcript cluster identifiers to biological metadata. Use when user asks to map probe identifiers to gene symbols, retrieve Entrez or Ensembl IDs, or access Gene Ontology and KEGG pathway information for rat genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ragene11sttranscriptcluster.db.html
---


# bioconductor-ragene11sttranscriptcluster.db

## Overview

The `ragene11sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Rat Gene 1.1 ST Array. It provides a SQLite-based interface to map manufacturer-specific transcript cluster identifiers to various biological annotations. The primary method for interaction is the `select()` interface from the `AnnotationDbi` package, though legacy "Bimap" objects are also available.

## Core Workflows

### Loading the Package
```R
library(ragene11sttranscriptcluster.db)
```

### Inspecting Available Data
To see which types of data (columns) can be retrieved and which keys (probes) are available:
```R
# List available annotation types
columns(ragene11sttranscriptcluster.db)

# List available key types (usually PROBEID)
keytypes(ragene11sttranscriptcluster.db)

# Get a sample of probe identifiers
head(keys(ragene11sttranscriptcluster.db))
```

### Using the select() Interface
The `select()` function is the recommended way to extract data. It requires the database object, the keys to look up, the columns to return, and the keytype of the input.

```R
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("10700001", "10700003", "10700004")
results <- select(ragene11sttranscriptcluster.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Targets
- **SYMBOL**: Official Gene Symbol.
- **ENTREZID**: Entrez Gene Identifier.
- **ENSEMBL**: Ensembl Gene Accession.
- **GENENAME**: Full Gene Name.
- **GO**: Gene Ontology identifiers, evidence codes, and ontologies (BP, CC, MF).
- **PATH**: KEGG Pathway identifiers.
- **CHR/CHRLOC**: Chromosome and start/end positions.

### Reverse Mappings (Alias to Probe)
To find which probes correspond to a specific gene symbol:
```R
select(ragene11sttranscriptcluster.db, 
       keys = "Tp53", 
       columns = "PROBEID", 
       keytype = "SYMBOL")
```

## Legacy Bimap Interface
While `select()` is preferred, you can access specific maps directly as Bimap objects:
```R
# Get a list of probe-to-symbol mappings
x <- ragene11sttranscriptclusterSYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes][1:5])
```

## Database Connection Information
To access the underlying SQLite connection or metadata:
```R
# Get database schema
ragene11sttranscriptcluster_dbschema()

# Get metadata about the data sources
ragene11sttranscriptcluster_dbInfo()
```

## Tips
- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data.frame with one row per mapping, which may result in more rows than input keys.
- **NA Values**: If a probe cannot be mapped to a specific annotation, `NA` is returned for that field.
- **Organism**: This package is specifically for *Rattus norvegicus*.

## Reference documentation
- [ragene11sttranscriptcluster.db Reference Manual](./references/reference_manual.md)
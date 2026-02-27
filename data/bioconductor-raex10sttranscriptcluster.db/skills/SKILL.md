---
name: bioconductor-raex10sttranscriptcluster.db
description: This package maps Affymetrix Rat Exon 1.0 ST Array probe identifiers to biological annotations like Gene Symbols, Entrez IDs, and GO terms. Use when user asks to map rat exon array probe sets to gene identifiers, retrieve biological metadata for Affymetrix rat transcriptomic data, or convert manufacturer IDs to Ensembl and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/raex10sttranscriptcluster.db.html
---


# bioconductor-raex10sttranscriptcluster.db

name: bioconductor-raex10sttranscriptcluster.db
description: Use this skill to map manufacturer identifiers (probe sets) from the Affymetrix Rat Exon 1.0 ST Array to biological annotations. This is essential for bioinformatics workflows involving rat transcriptomic data where probe IDs need to be converted to Gene Symbols, Entrez IDs, Ensembl IDs, GO terms, or KEGG pathways.

## Overview

The `raex10sttranscriptcluster.db` package is a Bioconductor annotation data package for the Rat Exon 1.0 ST Array (transcript cluster level). It provides a stable SQLite-based environment to map manufacturer-specific identifiers to various biological databases. The primary interface for data retrieval is the `select()` function from the `AnnotationDbi` framework.

## Core Workflows

### Loading the Package
```r
library(raex10sttranscriptcluster.db)
```

### Discovering Available Data
Use these functions to explore the types of data available within the package:
- `columns(raex10sttranscriptcluster.db)`: List all types of data that can be retrieved (e.g., SYMBOL, ENTREZID, GO).
- `keytypes(raex10sttranscriptcluster.db)`: List the types of identifiers that can be used as input keys.
- `keys(raex10sttranscriptcluster.db, keytype="PROBEID")`: List all manufacturer probe identifiers.

### Retrieving Annotations using select()
The `select()` function is the recommended method for mapping identifiers.
```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("10700001", "10700003", "10700004")
annotations <- select(raex10sttranscriptcluster.db, 
                      keys = probes, 
                      columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                      keytype = "PROBEID")
```

### Using Legacy Bimap Interfaces
While `select()` is preferred, specific maps can be accessed directly for quick lookups:
- `raex10sttranscriptclusterSYMBOL`: Maps probe IDs to Gene Symbols.
- `raex10sttranscriptclusterENTREZID`: Maps probe IDs to Entrez Gene identifiers.
- `raex10sttranscriptclusterGO`: Maps probe IDs to Gene Ontology terms.
- `raex10sttranscriptclusterPATH`: Maps probe IDs to KEGG pathway identifiers.

```r
# Example: Convert a Bimap to a list
symbol_map <- as.list(raex10sttranscriptclusterSYMBOL)
# Access a specific probe
symbol_map[["10700001"]]
```

## Key Annotation Types

- **SYMBOL**: Official Gene Symbol.
- **ENTREZID**: Entrez Gene Identifier.
- **ENSEMBL**: Ensembl Gene Accession.
- **GENENAME**: Full Gene Name.
- **GO**: Gene Ontology (includes ID, Ontology category, and Evidence code).
- **PATH**: KEGG Pathway ID.
- **REFSEQ**: RefSeq Accession Number.
- **ACCNUM**: GenBank Accession Number.

## Tips for Effective Usage

- **One-to-Many Mappings**: Be aware that some probe IDs may map to multiple Gene Symbols or GO terms. The `select()` function returns a data.frame that will expand to accommodate these relationships.
- **Organism Verification**: This package is specific to *Rattus norvegicus*. Use `raex10sttranscriptclusterORGANISM` to programmatically check the species.
- **Database Connection**: If direct SQL queries are required, use `raex10sttranscriptcluster_dbconn()` to get the connection object, but never call `dbDisconnect()` on it.

## Reference documentation

- [raex10sttranscriptcluster.db Reference Manual](./references/reference_manual.md)
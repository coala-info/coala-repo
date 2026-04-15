---
name: bioconductor-ragene21sttranscriptcluster.db
description: This package provides annotation data for mapping Affymetrix Rat Gene 2.1 ST Transcript Cluster identifiers to various biological metadata. Use when user asks to map probe IDs to gene symbols, retrieve GO terms for rat transcript clusters, find KEGG pathways, or identify genomic locations for the Rat Gene 2.1 ST array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ragene21sttranscriptcluster.db.html
---

# bioconductor-ragene21sttranscriptcluster.db

name: bioconductor-ragene21sttranscriptcluster.db
description: Comprehensive annotation data for the Affymetrix Rat Gene 2.1 ST Transcript Cluster array. Use this skill when you need to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Symbol, GO, KEGG, etc.) or genomic locations for Rattus norvegicus.

# bioconductor-ragene21sttranscriptcluster.db

## Overview

The `ragene21sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Rat Gene 2.1 ST array. It provides a SQLite-based interface to map manufacturer-specific transcript cluster identifiers to standard biological annotations. This package is essential for downstream analysis of microarray data, such as gene set enrichment analysis (GSEA) or functional annotation of differentially expressed genes.

## Core Workflows

### Loading the Package and Exploring Columns

To begin, load the library and inspect the available annotation types (columns).

```R
library(ragene21sttranscriptcluster.db)

# List all available annotation types
columns(ragene21sttranscriptcluster.db)

# List available key types (usually PROBEID)
keytypes(ragene21sttranscriptcluster.db)
```

### Using the select() Interface

The `select()` function is the recommended method for retrieving data. It allows you to map a vector of probe IDs to multiple annotation types simultaneously.

```R
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("17000001", "17000002", "17000003") # Example IDs
annotations <- select(ragene21sttranscriptcluster.db, 
                      keys = probes, 
                      columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                      keytype = "PROBEID")
head(annotations)
```

### Mapping to Gene Ontology (GO)

Retrieving GO terms provides functional context, including the ontology category (BP, CC, MF) and evidence codes.

```R
go_mappings <- select(ragene21sttranscriptcluster.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")
```

### Mapping to Pathways (KEGG)

To identify biological pathways associated with specific probes:

```R
pathway_mappings <- select(ragene21sttranscriptcluster.db, 
                           keys = probes, 
                           columns = "PATH", 
                           keytype = "PROBEID")
```

### Genomic Locations

You can retrieve chromosomal coordinates and start/end positions for the genes represented by the transcript clusters.

```R
loc_data <- select(ragene21sttranscriptcluster.db, 
                   keys = probes, 
                   columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                   keytype = "PROBEID")
```

## Legacy Bimap Interface

While `select()` is preferred, you can still use the older Bimap interface for specific tasks like extracting all mapped keys.

```R
# Get all probe IDs that have an associated Gene Symbol
x <- ragene21sttranscriptclusterSYMBOL
mapped_probes <- mappedkeys(x)

# Convert to a list for inspection
symbol_list <- as.list(x[mapped_probes][1:5])
```

## Database Connection Information

To access the underlying SQLite database directly or check metadata:

```R
# Get database connection
conn <- ragene21sttranscriptcluster_dbconn()

# Get database schema
ragene21sttranscriptcluster_dbschema()

# Get metadata about the data sources
ragene21sttranscriptcluster_dbInfo()
```

## Tips for Success

- **Transcript Clusters vs. Probes**: This package is designed for "transcript cluster" level identifiers, which are the standard output for ST (Sense Target) arrays.
- **One-to-Many Mappings**: Be aware that one probe ID may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with multiple rows for such cases.
- **Organism**: This package is specific to *Rattus norvegicus*. Ensure your data matches this species.

## Reference documentation

- [ragene21sttranscriptcluster.db Reference Manual](./references/reference_manual.md)
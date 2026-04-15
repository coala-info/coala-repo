---
name: bioconductor-rae230a.db
description: This package provides comprehensive annotation data for the Affymetrix Rat Expression 230A chip. Use when user asks to map manufacturer probe identifiers to genomic features like Entrez IDs, Gene Symbols, or GO terms for rat transcriptomic data analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rae230a.db.html
---

# bioconductor-rae230a.db

name: bioconductor-rae230a.db
description: Comprehensive annotation data for the Affymetrix Rat Expression 230A chip. Use when mapping manufacturer probe identifiers to genomic features (Entrez IDs, Symbols, GO terms, KEGG pathways, etc.) or vice versa for rat transcriptomic data analysis.

## Overview

The `rae230a.db` package is a Bioconductor annotation data package for the Affymetrix Rat Expression 230A platform. It provides an SQLite-based interface to map manufacturer probe identifiers to various biological metadata. The package is primarily used in bioinformatics workflows to annotate microarray results, perform gene set enrichment analysis, or link experimental data to public databases like Entrez Gene, Ensembl, and Gene Ontology.

## Core Workflows

### Loading the Package and Exploring Columns

To begin, load the package and inspect the types of data available for mapping.

```r
library(rae230a.db)

# List all available annotation types (columns)
columns(rae230a.db)

# List the types of keys that can be used as input
keytypes(rae230a.db)
```

### Using the select() Interface

The `select()` function is the recommended modern interface for retrieving data. It allows you to map a vector of keys to one or more columns.

```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1367452_at", "1367453_at", "1367454_at")
annotations <- select(rae230a.db, 
                      keys = probes, 
                      columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                      keytype = "PROBEID")
head(annotations)
```

### Using mapIds() for 1-to-1 Mapping

If you need a simple vector mapping (e.g., for adding a column to a data frame), use `mapIds()`.

```r
# Get a named vector of Symbols indexed by Probe ID
# multiVals = "first" ensures a 1:1 mapping by taking the first match
symbol_map <- mapIds(rae230a.db, 
                     keys = probes, 
                     column = "SYMBOL", 
                     keytype = "PROBEID", 
                     multiVals = "first")
```

### Accessing Specific Mappings (Bimaps)

While `select()` is preferred, you can still access specific mapping objects (Bimaps) directly.

*   **rae230aSYMBOL**: Manufacturer ID to Gene Symbol.
*   **rae230aENTREZID**: Manufacturer ID to Entrez Gene ID.
*   **rae230aGO**: Manufacturer ID to Gene Ontology (GO) terms.
*   **rae230aPATH**: Manufacturer ID to KEGG Pathway identifiers.
*   **rae230aENSEMBL**: Manufacturer ID to Ensembl Gene Accession.

```r
# Example: Convert a Bimap to a list
symbol_list <- as.list(rae230aSYMBOL[1:10])
```

## Common Tasks

### Gene Ontology (GO) Annotation

Mapping probes to GO terms provides the GO ID, Evidence code, and Ontology category (BP, CC, or MF).

```r
go_annos <- select(rae230a.db, 
                   keys = probes, 
                   columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                   keytype = "PROBEID")
```

### Chromosomal Location

Retrieve the chromosome and starting position for specific probes.

```r
loc_data <- select(rae230a.db, 
                   keys = probes, 
                   columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                   keytype = "PROBEID")
```

### Reverse Mapping

To find which probes correspond to a specific Gene Symbol:

```r
probes_for_gene <- select(rae230a.db, 
                          keys = "Tp53", 
                          columns = "PROBEID", 
                          keytype = "SYMBOL")
```

## Tips and Best Practices

1.  **Check Organism**: Use `rae230aORGANISM` to programmatically confirm the species (Rattus norvegicus).
2.  **Handle Multi-mappings**: Some probes map to multiple Entrez IDs or GO terms. When using `select()`, this results in multiple rows per input key. Use `mapIds()` with appropriate `multiVals` arguments (first, list, CharacterList) to control this behavior.
3.  **Database Connection**: For advanced SQL queries, use `rae230a_dbconn()` to get the underlying DBI connection, but never call `dbDisconnect()` on it.
4.  **Version Consistency**: Ensure your version of `rae230a.db` matches the Bioconductor release used for your analysis to maintain annotation consistency.

## Reference documentation

- [rae230a.db Reference Manual](./references/reference_manual.md)
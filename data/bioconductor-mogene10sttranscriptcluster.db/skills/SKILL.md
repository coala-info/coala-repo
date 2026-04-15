---
name: bioconductor-mogene10sttranscriptcluster.db
description: This package provides annotation data for the Affymetrix Mouse Gene 1.0 ST array. Use when user asks to map mouse transcript cluster IDs to gene symbols, Entrez IDs, Ensembl IDs, or GO terms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene10sttranscriptcluster.db.html
---

# bioconductor-mogene10sttranscriptcluster.db

name: bioconductor-mogene10sttranscriptcluster.db
description: Annotation data for the Affymetrix Mouse Gene 1.0 ST array. Use when mapping manufacturer probe identifiers (transcript clusters) to biological identifiers like Entrez Gene IDs, Symbols, Ensembl IDs, or GO terms for mouse genomic data.

## Overview

The `mogene10sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Gene 1.0 ST array. It provides a comprehensive set of mappings between manufacturer-specific probe identifiers (transcript cluster IDs) and various gene-centric identifiers. The package uses an SQLite database backend and is primarily accessed via the `AnnotationDbi` interface.

## Installation

To install the package, use `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mogene10sttranscriptcluster.db")
```

## Core Workflows

### Using the select() Interface

The recommended way to interact with this package is through the `select`, `keys`, `columns`, and `keytypes` functions from the `AnnotationDbi` package.

```r
library(mogene10sttranscriptcluster.db)

# 1. List available columns (data types)
columns(mogene10sttranscriptcluster.db)

# 2. List available keytypes (usually PROBEID)
keytypes(mogene10sttranscriptcluster.db)

# 3. Retrieve specific mappings
probes <- c("10345241", "10345248", "10345257")
mappings <- select(mogene10sttranscriptcluster.db, 
                   keys = probes, 
                   columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                   keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols**: Map probes to official gene symbols using `SYMBOL`.
*   **Entrez IDs**: Map probes to NCBI Entrez Gene identifiers using `ENTREZID`.
*   **Ensembl IDs**: Map probes to Ensembl gene accessions using `ENSEMBL`.
*   **GO Terms**: Map probes to Gene Ontology terms using `GO` (returns GO ID, Evidence, and Ontology category).
*   **MGI IDs**: Map probes to Mouse Genome Informatics identifiers using `MGI`.

### Legacy Bimap Interface

While `select()` is preferred, the "old style" Bimap interface is still available for quick list conversions:

```r
# Convert a specific map to a list
symbol_map <- as.list(mogene10sttranscriptclusterSYMBOL)

# Get symbols for the first few probes
symbol_map[1:5]
```

## Database Information

You can inspect the underlying database connection and schema:

```r
# Get database connection
conn <- mogene10sttranscriptcluster_dbconn()

# Show database schema
mogene10sttranscriptcluster_dbschema()

# Get number of rows in the probes table
library(DBI)
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips for AI Agents

*   **Organism**: This package is specifically for *Mus musculus* (mouse).
*   **Key Type**: The default `keytype` is `PROBEID`, which corresponds to the Affymetrix transcript cluster identifiers.
*   **One-to-Many**: Be aware that some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with multiple rows for these cases.
*   **Alias Mapping**: If you have gene symbols and want to find the corresponding probes, use the `mogene10sttranscriptclusterALIAS2PROBE` map.

## Reference documentation

- [mogene10sttranscriptcluster.db Reference Manual](./references/reference_manual.md)
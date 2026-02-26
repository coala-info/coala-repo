---
name: bioconductor-lapointe.db
description: This package provides annotation data for mapping LAPOINTE platform probe identifiers to biological metadata in R. Use when user asks to map probe IDs to gene symbols, retrieve Entrez Gene IDs, find chromosomal locations, or associate probes with GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/LAPOINTE.db.html
---


# bioconductor-lapointe.db

name: bioconductor-lapointe.db
description: Annotation data for the LAPOINTE platform. Use when mapping manufacturer identifiers (probes) to biological metadata including Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, and KEGG pathways in R.

# bioconductor-lapointe.db

## Overview

LAPOINTE.db is a Bioconductor annotation functional package providing detailed mapping between manufacturer identifiers (probes) for the LAPOINTE platform and various biological databases. It is primarily used in bioinformatics workflows to annotate microarray results with gene-centric information.

The package supports two primary interfaces:
1. **Modern select() interface**: The recommended approach using `AnnotationDbi` methods.
2. **Legacy Bimap interface**: Direct access to mapping objects (e.g., `LAPOINTESYMBOL`).

## Installation

To use this package, it must be installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("LAPOINTE.db")
library(LAPOINTE.db)
```

## Core Workflows

### Using the select() Interface

The `select()` function is the standard way to retrieve data. You need to specify the keys (input IDs), the columns (data to retrieve), and the keytype (the type of input IDs).

```r
# View available columns and keytypes
columns(LAPOINTE.db)
keytypes(LAPOINTE.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- head(keys(LAPOINTE.db, keytype="PROBEID"))
res <- select(LAPOINTE.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
print(res)
```

### Using the Bimap Interface

While `select()` is preferred, the Bimap interface allows for quick list-based access to specific mappings.

```r
# Map probes to Entrez IDs
x <- LAPOINTEENTREZID
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Access the first few mappings
xx[1:5]
```

### Common Annotation Tasks

*   **Chromosomal Location**: Use `LAPOINTECHRLOC` (start position) and `LAPOINTECHRLOCEND` (end position). Positions on the antisense strand are indicated by a leading "-" sign.
*   **Gene Ontology (GO)**: Use `LAPOINTEGO` for direct associations or `LAPOINTEGO2ALLPROBES` to include child terms in the GO hierarchy.
*   **Pathway Analysis**: Use `LAPOINTEPATH` to map probes to KEGG pathway identifiers.
*   **External IDs**: Map to `ENSEMBL`, `UNIPROT`, `REFSEQ`, or `ACCNUM` (GenBank accession).

### Database Information

To inspect the underlying SQLite database metadata:

```r
# Get database connection and schema
LAPOINTE_dbconn()
LAPOINTE_dbschema()
# Get organism information
LAPOINTEORGANISM
```

## Tips and Best Practices

*   **Defunct Mappings**: The Bimap interface for `PFAM` and `PROSITE` is defunct. Always use the `select()` interface to retrieve these identifiers.
*   **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` interface will return a data.frame with one row per mapping, which may result in more rows than input keys.
*   **Alias Mapping**: Use `LAPOINTEALIAS2PROBE` to map common gene symbols/aliases back to manufacturer identifiers.

## Reference documentation

- [LAPOINTE.db Reference Manual](./references/reference_manual.md)
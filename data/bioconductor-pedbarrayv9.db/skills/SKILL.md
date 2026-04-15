---
name: bioconductor-pedbarrayv9.db
description: This package provides functional and genomic annotation data for the pedbarrayv9 platform. Use when user asks to map manufacturer probe identifiers to gene symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pedbarrayv9.db.html
---

# bioconductor-pedbarrayv9.db

name: bioconductor-pedbarrayv9.db
description: Use this skill when working with the Bioconductor annotation package pedbarrayv9.db. This is essential for mapping manufacturer-specific probe identifiers from the pedbarrayv9 platform to various biological identifiers (Entrez Gene, Gene Symbols, GO terms, KEGG pathways, etc.) and genomic locations.

# bioconductor-pedbarrayv9.db

## Overview

The `pedbarrayv9.db` package is a Bioconductor annotation data package for the pedbarrayv9 platform. It provides a SQLite-based interface to map manufacturer probe IDs to biological metadata. While it supports the older "Bimap" interface, the recommended way to interact with this data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(pedbarrayv9.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype.

```r
# Check available columns
columns(pedbarrayv9.db)

# Check available keytypes
keytypes(pedbarrayv9.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1001_at", "1002_f_at") # Replace with actual probe IDs
select(pedbarrayv9.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols**: Map probes to official gene symbols using the `SYMBOL` column.
*   **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` to find the physical location of the gene associated with a probe.
*   **Functional Annotation**: Map to Gene Ontology (`GO`) or KEGG pathways (`PATH`).
*   **External IDs**: Map to `ENSEMBL`, `REFSEQ`, `UNIPROT`, or `ACCNUM` (GenBank accession).

### Using the Bimap Interface (Legacy)
If you encounter older scripts, they may use the Bimap interface. These objects behave like lists or environments.

```r
# Convert a map to a list
sym_list <- as.list(pedbarrayv9SYMBOL)
# Get symbols for specific probes
probes <- mappedkeys(pedbarrayv9SYMBOL)[1:5]
sym_list[probes]
```

### Database Connection and Metadata
To inspect the underlying SQLite database or check version information:
```r
# Get database metadata
pedbarrayv9_dbInfo()

# Get the database schema
pedbarrayv9_dbschema()

# Get the number of rows in the probes table via direct SQL
library(DBI)
dbGetQuery(pedbarrayv9_dbconn(), "SELECT COUNT(*) FROM probes")
```

## Tips and Best Practices
*   **One-to-Many Mappings**: Be aware that some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data.frame with multiple rows for these cases.
*   **Alias Mapping**: If you have common gene names that aren't official symbols, use the `ALIAS2PROBE` map to find corresponding manufacturer IDs.
*   **Organism Info**: Use `pedbarrayv9ORGANISM` to programmatically confirm the species this package targets.

## Reference documentation
- [pedbarrayv9.db Reference Manual](./references/reference_manual.md)
---
name: bioconductor-hugene11stprobeset.db
description: This Bioconductor package provides functional and genomic annotations for the Affymetrix Human Gene 1.1 ST array at the probeset level. Use when user asks to map probe identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene11stprobeset.db.html
---

# bioconductor-hugene11stprobeset.db

name: bioconductor-hugene11stprobeset.db
description: Expert guidance for using the Bioconductor annotation package hugene11stprobeset.db. Use this skill when you need to map Affymetrix Human Gene 1.1 ST probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

## Overview

The `hugene11stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Human Gene 1.1 ST array (probeset level). It provides a comprehensive set of mappings between manufacturer probe identifiers and various genomic databases. This skill helps you navigate the `AnnotationDbi` interface to retrieve these mappings efficiently.

## Core Workflows

### Loading the Package

```R
library(hugene11stprobeset.db)
```

### Using the select() Interface

The preferred method for interacting with this package is the `select()` interface from `AnnotationDbi`.

```R
# 1. List available columns (types of data you can retrieve)
columns(hugene11stprobeset.db)

# 2. List available keytypes (types of input identifiers you have)
keytypes(hugene11stprobeset.db)

# 3. Perform a lookup
probes <- c("10344620", "10344687", "10344737")
results <- select(hugene11stprobeset.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Symbols and Names**: Map probe IDs to official gene symbols and descriptive names.
  - Columns: `SYMBOL`, `GENENAME`
- **External Database IDs**: Map to Entrez, Ensembl, RefSeq, or Uniprot.
  - Columns: `ENTREZID`, `ENSEMBL`, `REFSEQ`, `UNIPROT`
- **Functional Annotation**: Retrieve Gene Ontology (GO) terms or KEGG pathways.
  - Columns: `GO`, `PATH`
- **Chromosomal Location**: Find the cytogenetic band or specific genomic coordinates.
  - Columns: `MAP`, `CHR`, `CHRLOC`, `CHRLOCEND`

### Using the Bimap Interface (Legacy)

While `select()` is recommended, you can still use the older Bimap interface for specific list-based operations.

```R
# Convert a specific map to a list
symbol_map <- as.list(hugene11stprobesetSYMBOL)
# Access a specific probe
symbol_map[["10344620"]]

# Get all mapped keys
mapped_probes <- mappedkeys(hugene11stprobesetACCNUM)
```

## Tips and Best Practices

- **Handling Multiple Matches**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function returns a data.frame that will contain one row for each match, potentially increasing the row count relative to your input keys.
- **GO Evidence Codes**: When retrieving GO terms, the `EVIDENCE` column indicates the type of evidence (e.g., IDA: Inferred from Direct Assay).
- **Package Metadata**: Use `hugene11stprobeset_dbInfo()` to check the data source versions and date stamps.
- **Database Connection**: If you need to perform raw SQL queries, use `hugene11stprobeset_dbconn()` to get the underlying SQLite connection.

## Reference documentation

- [hugene11stprobeset.db Reference Manual](./references/reference_manual.md)
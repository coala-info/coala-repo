---
name: bioconductor-hthgu133plusa.db
description: This package provides annotation data for the Affymetrix Human Genome U133 Plus 2.0 HT platform. Use when user asks to map probe identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133plusa.db.html
---


# bioconductor-hthgu133plusa.db

name: bioconductor-hthgu133plusa.db
description: Annotation data for the Affymetrix hthgu133plusa (Human Genome U133 Plus 2.0 HT) platform. Use this skill to map manufacturer probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

# bioconductor-hthgu133plusa.db

## Overview

The `hthgu133plusa.db` package is a Bioconductor annotation hub for the Affymetrix Human Genome U133 Plus 2.0 High-Throughput (HT) array. It provides a SQLite-based interface to map probe set IDs to genomic, functional, and bibliographic data.

## Core Workflows

### Loading the Package
```R
library(hthgu133plusa.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `select()` function from `AnnotationDbi`.

```R
# View available columns
columns(hthgu133plusa.db)

# View available key types (usually PROBEID)
keytypes(hthgu133plusa.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1007_s_at", "1053_at", "117_at")
select(hthgu133plusa.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Annotation Mappings

- **Gene Symbols**: Map probes to official gene abbreviations using `SYMBOL`.
- **Entrez IDs**: Map probes to NCBI Entrez Gene identifiers using `ENTREZID`.
- **GO Terms**: Map probes to Gene Ontology terms using `GO` (includes Evidence codes and Ontology categories: BP, CC, MF).
- **KEGG Pathways**: Map probes to pathway identifiers using `PATH`.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` for physical mapping.
- **RefSeq/Ensembl**: Map to transcript and protein accessions using `REFSEQ` or `ENSEMBL`.

### Legacy Bimap Interface
While `select()` is preferred, you can use the older Bimap objects for specific list-based operations.

```R
# Convert a mapping to a list
sym_list <- as.list(hthgu133plusaSYMBOL)
# Access specific probe
sym_list[["1007_s_at"]]

# Get all mapped keys
mapped_probes <- mappedkeys(hthgu133plusaSYMBOL)
```

### Database Connection Info
To inspect the underlying database metadata or schema:
```R
hthgu133plusa_dbconn()   # Get DB connection object
hthgu133plusa_dbschema() # View table structures
hthgu133plusa_dbInfo()   # View data source and date stamps
```

## Tips
- **Multiple Mappings**: Some probes map to multiple genes or GO terms. `select()` will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Reverse Mapping**: To find probes associated with a specific gene symbol, use the `hthgu133plusaALIAS2PROBE` object or use `select()` with `keytype = "SYMBOL"`.
- **Evidence Codes**: When working with GO annotations, pay attention to evidence codes (e.g., IDA, IEA, TAS) to assess the reliability of the functional assignment.

## Reference documentation
- [hthgu133plusa.db Reference Manual](./references/reference_manual.md)
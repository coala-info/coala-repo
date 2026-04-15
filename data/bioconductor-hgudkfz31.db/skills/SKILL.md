---
name: bioconductor-hgudkfz31.db
description: This package provides annotation data for the hguDKFZ31 platform to map manufacturer probe identifiers to biological annotations in R. Use when user asks to map probe IDs to gene symbols, retrieve Entrez Gene IDs, find GO terms, or access KEGG pathway information for the hguDKFZ31 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hguDKFZ31.db.html
---

# bioconductor-hgudkfz31.db

name: bioconductor-hgudkfz31.db
description: Provides annotation data for the hguDKFZ31 platform. Use this skill when you need to map manufacturer identifiers (probes) to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations in R.

## Overview

The `hguDKFZ31.db` package is a Bioconductor annotation data package for the hguDKFZ31 platform. It provides a set of SQLite-based maps to translate manufacturer-specific probe identifiers into standard biological nomenclature. While it supports the older "Bimap" interface, the modern and recommended way to interact with this data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```R
library(hguDKFZ31.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype.

```R
# List available columns
columns(hguDKFZ31.db)

# List available keytypes
keytypes(hguDKFZ31.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at") # Replace with actual probe IDs
select(hguDKFZ31.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Annotation Mappings
- **Gene Symbols**: Use `SYMBOL` to get official gene abbreviations.
- **Entrez Gene IDs**: Use `ENTREZID` for NCBI gene identifiers.
- **Gene Ontology (GO)**: Use `GO` for functional annotations (includes Evidence and Ontology codes).
- **KEGG Pathways**: Use `PATH` to find associated pathway identifiers.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` for genomic positioning.
- **RefSeq/Ensembl**: Use `REFSEQ` or `ENSEMBL` for transcript and protein accessions.

### Using the Bimap Interface (Legacy)
For specific tasks, you might use the older Bimap objects. These are accessed as list-like objects.

```R
# Map Probes to Symbols
x <- hguDKFZ31SYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Get symbols for the first 5 probes
xx[1:5]
```

### Reverse Mappings
Many maps have reverse counterparts (e.g., mapping Symbols back to Probes).
- `hguDKFZ31ALIAS2PROBE`: Maps gene aliases to manufacturer IDs.
- `hguDKFZ31GO2ALLPROBES`: Maps GO IDs to all associated probes (including child terms).
- `hguDKFZ31PATH2PROBE`: Maps KEGG pathway IDs to probes.

## Database Information
To inspect the underlying database connection and schema:
```R
hguDKFZ31_dbconn()   # Get the DBI connection object
hguDKFZ31_dbschema() # Print the database schema
hguDKFZ31_dbInfo()   # Print package metadata
```

## Tips
- **NA Values**: If a probe cannot be mapped to a specific annotation, `NA` is returned.
- **One-to-Many**: Some probes may map to multiple Entrez IDs or GO terms. `select()` will return a data frame with multiple rows for these cases.
- **Organism**: This package is built for *Homo sapiens*. You can verify this with `hguDKFZ31ORGANISM`.

## Reference documentation
- [hguDKFZ31.db Reference Manual](./references/reference_manual.md)
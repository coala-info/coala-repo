---
name: bioconductor-hu35ksubb.db
description: This package provides comprehensive SQLite-based annotation data for the Affymetrix hu35ksubb platform. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubb.db.html
---


# bioconductor-hu35ksubb.db

name: bioconductor-hu35ksubb.db
description: Comprehensive annotation data for the Affymetrix hu35ksubb platform. Use when needing to map manufacturer probe identifiers to biological metadata including Entrez IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

# bioconductor-hu35ksubb.db

## Overview

The `hu35ksubb.db` package is a Bioconductor annotation hub for the Affymetrix hu35ksubb chip. It provides a SQLite-based interface to map manufacturer-specific probe identifiers to various genomic and functional annotations.

## Core Workflows

### Loading the Package
```r
library(hu35ksubb.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `AnnotationDbi` interface.

```r
# View available columns
columns(hu35ksubb.db)

# View available key types (usually PROBEID)
keytypes(hu35ksubb.db)

# Retrieve specific annotations for a set of probes
probes <- c("1000_at", "1001_at")
select(hu35ksubb.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Annotation Mappings

- **Gene Symbols and Names**: Map probes to official gene symbols (`SYMBOL`) or descriptive names (`GENENAME`).
- **External IDs**: Map to `ENTREZID`, `ENSEMBL`, `UNIPROT`, or `REFSEQ`.
- **Functional Annotation**: Map to Gene Ontology (`GO`) or KEGG pathways (`PATH`).
- **Genomic Location**: Map to chromosomes (`CHR`), cytobands (`MAP`), or specific base pair locations (`CHRLOC`, `CHRLOCEND`).

### Using the Bimap Interface (Legacy)
While `select()` is preferred, the package provides Bimap objects for specific lookups.

```r
# Map probes to Accession Numbers
x <- hu35ksubbACCNUM
mapped_probes <- mappedkeys(x)
as.list(x[mapped_probes][1:5])

# Map Gene Aliases back to Probes
alias_map <- as.list(hu35ksubbALIAS2PROBE)
```

### Database Connection Information
To query the underlying SQLite database directly:
```r
# Get database connection
conn <- hu35ksubb_dbconn()
# List tables
dbListTables(conn)
# Get schema
hu35ksubb_dbschema()
```

## Tips and Best Practices
- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. `select()` will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Evidence Codes**: When querying `GO`, use the `EVIDENCE` column to filter by the type of supporting data (e.g., IDA for direct assay).
- **Reverse Maps**: Many objects have reverse mappings (e.g., `hu35ksubbGO2PROBE`) to find all probes associated with a specific biological term.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)
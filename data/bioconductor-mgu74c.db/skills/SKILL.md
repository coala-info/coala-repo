---
name: bioconductor-mgu74c.db
description: This package provides annotation data for the Affymetrix Murine Genome U74v2 chip (version C) by mapping probe IDs to various biological identifiers. Use when user asks to map Affymetrix mgu74c probe IDs to gene symbols, Entrez IDs, Ensembl accessions, or Gene Ontology terms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74c.db.html
---

# bioconductor-mgu74c.db

## Overview

The `mgu74c.db` package is a Bioconductor annotation data package for the Affymetrix Murine Genome U74v2 chip (version C). It is built upon the `AnnotationDbi` framework, allowing for efficient querying of genomic metadata. The package maps manufacturer-specific probe IDs to standard biological identifiers based on Entrez Gene, Ensembl, RefSeq, and other databases.

## Core Workflows

### Loading the Package
```r
library(mgu74c.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `select`, `keys`, `columns`, and `keytypes` functions from `AnnotationDbi`.

```r
# List available columns (data types)
columns(mgu74c.db)

# List available keytypes (usually PROBEID)
keytypes(mgu74c.db)

# Retrieve specific annotations for a set of probes
probes <- c("100001_at", "100002_at")
select(mgu74c.db, keys = probes, columns = c("SYMBOL", "ENTREZID", "GENENAME"), keytype = "PROBEID")
```

### Common Mappings
The package contains several specific objects (Bimaps) for common lookups:
- `mgu74cSYMBOL`: Probe ID to Gene Symbol.
- `mgu74cENTREZID`: Probe ID to Entrez Gene ID.
- `mgu74cGENENAME`: Probe ID to full Gene Name.
- `mgu74cGO`: Probe ID to Gene Ontology (GO) terms.
- `mgu74cPATH`: Probe ID to KEGG Pathway identifiers.
- `mgu74cCHR`: Probe ID to Chromosome.
- `mgu74cENSEMBL`: Probe ID to Ensembl Gene Accession.

### Reverse Mappings
To map from a biological identifier back to probe IDs, use the `2PROBE` suffix or the `select` interface with the appropriate `keytype`.

```r
# Map Gene Symbols to Probe IDs
select(mgu74c.db, keys = c("Gnat1", "Pdc"), columns = "PROBEID", keytype = "SYMBOL")

# Using the Bimap interface for reverse mapping
as.list(mgu74cALIAS2PROBE["Gnat1"])
```

### Chromosomal Information
You can retrieve starting and ending positions of genes, as well as chromosome lengths.
- `mgu74cCHRLOC`: Start position.
- `mgu74cCHRLOCEND`: End position.
- `mgu74cCHRLENGTHS`: Length of each chromosome.

## Tips and Best Practices
- **Bimap vs. select**: While the "old style" Bimap interface (e.g., `as.list(mgu74cSYMBOL)`) still works, the `select()` interface is more robust and consistent across Bioconductor.
- **Handling NAs**: Not every probe ID maps to every biological identifier. Always check for `NA` values in your results.
- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Database Connection**: Use `mgu74c_dbconn()` to get a direct connection to the underlying SQLite database if you need to perform custom SQL queries.

## Reference documentation
- [mgu74c.db Reference Manual](./references/reference_manual.md)
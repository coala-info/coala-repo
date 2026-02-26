---
name: bioconductor-htmg430pm.db
description: This package provides annotation data for the Affymetrix htmg430pm platform to map manufacturer probe identifiers to biological metadata for Mus musculus. Use when user asks to map probe IDs to gene symbols, Entrez Gene IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htmg430pm.db.html
---


# bioconductor-htmg430pm.db

name: bioconductor-htmg430pm.db
description: Access and query annotation data for the Affymetrix htmg430pm platform. Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) and genomic locations for Mus musculus.

# bioconductor-htmg430pm.db

## Overview

The `htmg430pm.db` package is a Bioconductor annotation data package for the Affymetrix htmg430pm platform. It provides a comprehensive set of SQLite-based mappings between manufacturer probe identifiers and various biological metadata. This skill guides the use of both the modern `select()` interface and the legacy `Bimap` interface for data retrieval.

## Core Workflows

### Loading the Package

```r
library(htmg430pm.db)
```

### Using the select() Interface

The recommended way to interact with this package is via the `AnnotationDbi` interface.

```r
# View available columns
columns(htmg430pm.db)

# View available key types
keytypes(htmg430pm.db)

# Retrieve specific mappings
probes <- head(keys(htmg430pm.db))
res <- select(htmg430pm.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

### Common Mappings (Bimap Interface)

While `select()` is preferred, specific objects (Bimaps) are available for direct access:

*   **Gene Symbols**: `htmg430pmSYMBOL`
*   **Entrez Gene IDs**: `htmg430pmENTREZID`
*   **Gene Ontology (GO)**: `htmg430pmGO`
*   **KEGG Pathways**: `htmg430pmPATH`
*   **Accession Numbers**: `htmg430pmACCNUM`
*   **Chromosomal Location**: `htmg430pmCHRLOC` (start) and `htmg430pmCHRLOCEND` (end)

Example of Bimap usage:
```r
# Convert a mapping to a list
mapped_list <- as.list(htmg430pmSYMBOL[1:5])

# Get probes mapped to a specific chromosome
chr_map <- as.list(htmg430pmCHR)
probes_on_chr1 <- names(chr_map[chr_map == "1"])
```

### Reverse Mappings

Many mappings have reverse counterparts to find probes associated with biological IDs:

*   `htmg430pmALIAS2PROBE`: Map gene aliases to probe IDs.
*   `htmg430pmGO2ALLPROBES`: Map GO IDs to all associated probes (including child terms).
*   `htmg430pmENSEMBL2PROBE`: Map Ensembl IDs to probe IDs.

### Database Metadata

To inspect the underlying database connection and schema:

```r
# Get database connection
conn <- htmg430pm_dbconn()

# View database schema
htmg430pm_dbschema()

# Get organism information
htmg430pmORGANISM
```

## Tips and Best Practices

*   **Filtering**: Use `mappedkeys(x)` to get only the identifiers that have a valid mapping in the database.
*   **GO Evidence**: When querying GO terms, the results include evidence codes (e.g., IDA, IEA, TAS). Filter these if you require specific levels of experimental validation.
*   **Memory Efficiency**: For large-scale lookups, `select()` is generally more efficient than converting entire Bimaps to lists using `as.list()`.
*   **Version Consistency**: This package is updated biannually; ensure your package version matches the data release used in your analysis.

## Reference documentation

- [htmg430pm.db Reference Manual](./references/reference_manual.md)
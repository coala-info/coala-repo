---
name: bioconductor-hthgu133pluspm.db
description: This package provides annotation data for the Affymetrix Human Genome U133 Plus 2.0 PM Array. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve gene symbols, or find genomic locations for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133pluspm.db.html
---


# bioconductor-hthgu133pluspm.db

name: bioconductor-hthgu133pluspm.db
description: Annotation data for the Affymetrix Human Genome U133 Plus 2.0 PM Array. Use this skill to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

# bioconductor-hthgu133pluspm.db

## Overview

The `hthgu133pluspm.db` package is a Bioconductor annotation data package for the Affymetrix Human Genome U133 Plus 2.0 PM Array. It provides a comprehensive set of mappings between manufacturer probe identifiers and various genomic, functional, and bibliographic identifiers.

The package uses an SQLite database backend. While it supports legacy "Bimap" objects, the recommended way to interact with the data is through the `select()` interface provided by the `AnnotationDbi` package.

## Core Workflows

### Loading the Package

```r
library(hthgu133pluspm.db)
```

### Using the select() Interface

The `select()` function is the primary method for retrieving data. You need to specify the keys (input IDs), the columns (desired data), and the keytype (the type of input IDs).

```r
# View available columns
columns(hthgu133pluspm.db)

# View available keytypes
keytypes(hthgu133pluspm.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1007_s_at", "1053_at", "117_at")
select(hthgu133pluspm.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mappings

*   **Gene Symbols:** `SYMBOL`
*   **Entrez Gene IDs:** `ENTREZID`
*   **Ensembl IDs:** `ENSEMBL`
*   **Gene Ontology:** `GO` (returns GO ID, Evidence code, and Ontology category)
*   **KEGG Pathways:** `PATH`
*   **Chromosomal Location:** `CHR`, `CHRLOC`, `CHRLOCEND`
*   **RefSeq Accessions:** `REFSEQ`
*   **Uniprot Accessions:** `UNIPROT`

### Using Legacy Bimap Objects

For quick lookups or specific list-based operations, you can use the Bimap interface.

```r
# Convert a map to a list
sym_list <- as.list(hthgu133pluspmSYMBOL)

# Get symbols for specific probes
sym_list[c("1007_s_at", "1053_at")]

# Get all mapped probe IDs
mapped_probes <- mappedkeys(hthgu133pluspmSYMBOL)
```

### Reverse Mappings

Many maps have reverse counterparts (e.g., mapping Symbols back to Probes).

```r
# Map Gene Symbols to Probes
alias_to_probe <- as.list(hthgu133pluspmALIAS2PROBE)
alias_to_probe["TP53"]
```

## Database Information

To inspect the underlying SQLite database:

```r
# Get database connection
conn <- hthgu133pluspm_dbconn()

# Show database schema
hthgu133pluspm_dbschema()

# Get summary information
hthgu133pluspm_dbInfo()
```

## Tips

*   **NAs:** If a probe cannot be mapped to a specific identifier, `NA` is returned.
*   **One-to-Many:** Some probes map to multiple identifiers (e.g., multiple GO terms). The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
*   **Evidence Codes:** When mapping to GO terms, pay attention to the `EVIDENCE` column to understand the quality of the annotation (e.g., TAS: Traceable Author Statement, IEA: Inferred from Electronic Annotation).

## Reference documentation

- [reference_manual.md](./references/reference_manual.md)
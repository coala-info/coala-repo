---
name: bioconductor-drosophila2.db
description: This tool provides comprehensive biological identifier mappings and functional annotations for the Affymetrix Drosophila Genome 2.0 Array. Use when user asks to map probe identifiers to gene symbols, retrieve Entrez or Ensembl IDs, or access Gene Ontology and KEGG pathway information for fruit fly research.
homepage: https://bioconductor.org/packages/release/data/annotation/html/drosophila2.db.html
---


# bioconductor-drosophila2.db

name: bioconductor-drosophila2.db
description: Use this skill to perform gene annotation and identifier mapping for the Drosophila melanogaster 2 (Affymetrix) platform. This includes mapping manufacturer probe IDs to Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, Ensembl accessions, and chromosomal locations. Use this when working with Drosophila microarray data or needing to translate between various biological database identifiers for fruit fly research.

# bioconductor-drosophila2.db

## Overview

The `drosophila2.db` package is a Bioconductor annotation data package for the Affymetrix Drosophila Genome 2.0 Array. It provides a comprehensive set of SQLite-based mappings between manufacturer probe identifiers and various biological identifiers. While it supports an older "Bimap" interface, the modern and preferred way to interact with this data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(drosophila2.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired information), and the keytype (the type of input IDs).

```r
# 1. List available columns
columns(drosophila2.db)

# 2. List available keytypes
keytypes(drosophila2.db)

# 3. Perform a mapping (e.g., Probe IDs to Gene Symbols and Entrez IDs)
probes <- c("161660_at", "161661_at")
select(drosophila2.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names:** Map probe IDs to official gene symbols (`SYMBOL`) or full names (`GENENAME`).
*   **External Database IDs:** Map to `ENTREZID`, `ENSEMBL`, `FLYBASE`, `REFSEQ`, or `UNIPROT`.
*   **Functional Annotation:** Retrieve Gene Ontology (`GO`) terms or KEGG pathway identifiers (`PATH`).
*   **Genomic Location:** Find chromosome information (`CHR`), chromosomal start/end positions (`CHRLOC`, `CHRLOCEND`), or cytogenetic bands (`MAP`).

### Reverse Mappings
You can map from other identifiers back to probe IDs by changing the `keytype`.

```r
# Map Gene Symbols back to Probe IDs
symbols <- c("zen", "bcd")
select(drosophila2.db, 
       keys = symbols, 
       columns = "PROBEID", 
       keytype = "SYMBOL")
```

### Accessing Metadata
To get information about the database version and source data:
```r
drosophila2_dbInfo()
drosophila2_dbschema()
drosophila2ORGANISM # Returns "Drosophila melanogaster"
```

## Tips and Best Practices
*   **One-to-Many Mappings:** Be aware that some mappings (like GO terms or Pathways) will return multiple rows for a single input key.
*   **Bimap Interface:** If you encounter older code using `as.list(drosophila2SYMBOL)`, it is recommended to convert it to the `select()` workflow for better performance and consistency.
*   **Filtering GO Terms:** When retrieving GO information, the output includes `EVIDENCE` and `ONTOLOGY` (BP, CC, MF) columns, allowing you to filter results based on the type of experimental evidence or functional category.

## Reference documentation
- [drosophila2.db Reference Manual](./references/reference_manual.md)
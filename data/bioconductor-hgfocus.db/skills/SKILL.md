---
name: bioconductor-hgfocus.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgfocus.db.html
---

# bioconductor-hgfocus.db

name: bioconductor-hgfocus.db
description: Provides annotation data for the Affymetrix Human Genome Focus Array (hgfocus). Use this skill to map manufacturer probe identifiers to various biological annotations including Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

## Overview

The `hgfocus.db` package is a Bioconductor annotation data package for the hgfocus platform. It provides a comprehensive set of mappings between manufacturer probe identifiers and various genomic, functional, and bibliographic data. While it supports the older "Bimap" interface, the modern `select()` interface from the `AnnotationDbi` package is the recommended way to interact with this data.

## Core Workflows

### Loading the Package

```R
library(hgfocus.db)
```

### Using the select() Interface

The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype.

```R
# List available columns
columns(hgfocus.db)

# List available keytypes
keytypes(hgfocus.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("200000_s_at", "200001_at", "200002_at")
select(hgfocus.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Use `SYMBOL` and `GENENAME`.
*   **Functional Annotation**: Use `GO` (Gene Ontology) or `PATH` (KEGG Pathways).
*   **External IDs**: Use `ENSEMBL`, `UNIPROT`, `REFSEQ`, or `ACCNUM` (GenBank Accession).
*   **Chromosomal Location**: Use `CHR` (Chromosome), `MAP` (Cytoband), or `CHRLOC` (Base pair start).

### Working with Gene Ontology (GO)

When selecting GO terms, the result includes the GO ID, the Evidence code (e.g., IDA, IEA, TAS), and the Ontology category (BP, CC, or MF).

```R
select(hgfocus.db, 
       keys = "200000_s_at", 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")
```

### Database Connection Information

To inspect the underlying SQLite database or schema:

```R
# Get database connection
conn <- hgfocus_dbconn()

# Show database schema
hgfocus_dbschema()

# Get path to the SQLite file
hgfocus_dbfile()
```

## Tips and Best Practices

*   **Bimap Interface**: If using the older Bimap interface (e.g., `as.list(hgfocusSYMBOL)`), remember that `mappedkeys()` can be used to filter for probes that actually have an annotation.
*   **One-to-Many Mappings**: Be aware that a single probe ID may map to multiple GO terms or pathways. The `select()` function will return a data.frame with multiple rows for such cases.
*   **Alias Mapping**: Use `hgfocusALIAS2PROBE` if you need to map common gene symbols (including non-official ones) back to manufacturer probe identifiers.
*   **Package Updates**: This package is updated biannually; ensure you are using the version corresponding to your Bioconductor release for the most current mappings.

## Reference documentation

- [hgfocus.db Reference Manual](./references/reference_manual.md)
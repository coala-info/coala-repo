---
name: bioconductor-hgu219.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu219.db.html
---

# bioconductor-hgu219.db

name: bioconductor-hgu219.db
description: Provides annotation data for the Affymetrix Human Genome U219 (hgu219) platform. Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) and to retrieve genomic metadata for human microarray data analysis.

## Overview

The `hgu219.db` package is a Bioconductor annotation data package for the Affymetrix Human Genome U219 array. It provides a SQLite-based interface to map probe IDs to gene-centric information. While it supports older "Bimap" interfaces, the modern and preferred method for interaction is the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(hgu219.db)
```

### Exploring Available Data
To see what types of data (columns) can be retrieved:
```r
columns(hgu219.db)
```
Common columns include: `PROBEID`, `SYMBOL`, `ENTREZID`, `GENENAME`, `ENSEMBL`, `GO`, and `PATH`.

To see available key types (usually `PROBEID` for this chip):
```r
keytypes(hgu219.db)
```

### Using the select() Interface
The `select()` function is the primary way to retrieve data. It requires the database object, the keys (probe IDs), the columns to return, and the keytype of the input keys.

```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("11715100_at", "11715101_s_at", "11715102_x_at")
results <- select(hgu219.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Mapping to Biological Pathways and Ontologies
- **Gene Ontology (GO):** Maps probes to GO terms, including evidence codes and ontologies (BP, CC, MF).
- **KEGG Pathways (PATH):** Maps probes to KEGG pathway identifiers.

```r
# Get GO terms for specific probes
go_mappings <- select(hgu219.db, keys = probes, columns = "GO", keytype = "PROBEID")

# Get KEGG pathways
kegg_mappings <- select(hgu219.db, keys = probes, columns = "PATH", keytype = "PROBEID")
```

### Reverse Mappings
To find which probes correspond to a specific Gene Symbol or Entrez ID, change the `keytype`:

```r
# Find probes for a specific gene symbol
select(hgu219.db, keys = "TP53", columns = "PROBEID", keytype = "SYMBOL")
```

### Accessing Metadata
- **Organism Information:** `hgu219ORGANISM` returns "Homo sapiens".
- **Chromosome Lengths:** `hgu219CHRLENGTHS` provides a named vector of chromosome sizes.
- **Database Connection:** `hgu219_dbconn()` returns the underlying connection to the SQLite database for SQL queries.

## Tips and Best Practices
- **One-to-Many Mappings:** Be aware that one probe ID can map to multiple GO terms or pathways. The `select()` function will return a data frame with multiple rows for a single input key in these cases.
- **Alias Mapping:** If a gene symbol is not found in the `SYMBOL` map, try using `ALIAS2PROBE` to check for common synonyms.
- **Package Updates:** This package is updated biannually by Bioconductor; ensure you are using the version corresponding to your Bioconductor release for the most accurate mappings.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)
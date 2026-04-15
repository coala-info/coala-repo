---
name: bioconductor-rgug4131a.db
description: This package provides annotation data for the Agilent Rat Genome 4x44K Microarray. Use when user asks to map manufacturer probe IDs to biological identifiers like Entrez Gene IDs, Symbols, GO terms, or KEGG pathways for rat genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgug4131a.db.html
---

# bioconductor-rgug4131a.db

name: bioconductor-rgug4131a.db
description: Annotation data for the Agilent Rat Genome 4x44K Microarray (rgug4131a). Use when mapping manufacturer probe IDs to biological identifiers like Entrez Gene IDs, Symbols, GO terms, or KEGG pathways for rat genomic data.

# bioconductor-rgug4131a.db

## Overview

The `rgug4131a.db` package is a Bioconductor annotation data package for the Agilent Rat Genome 4x44K Microarray. It provides a stable SQLite-based interface to map manufacturer probe identifiers to various biological metadata for *Rattus norvegicus*.

## R Usage

### Loading the Package

```r
library(rgug4131a.db)
```

### Exploring Available Data

Use the `AnnotationDbi` interface to see what identifiers and categories are available:

```r
# List available mapping categories (columns)
columns(rgug4131a.db)

# List available key types (usually includes PROBEID)
keytypes(rgug4131a.db)

# Get a sample of probe IDs
head(keys(rgug4131a.db, keytype="PROBEID"))
```

### Using the select() Interface

The `select()` function is the recommended method for retrieving data.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("A_44_P10001", "A_44_P10005")
select(rgug4131a.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Using Legacy Bimap Objects

While `select()` is preferred, you can still use the "Bimap" interface for quick list conversions:

```r
# Convert Symbol mappings to a list
symbol_map <- as.list(rgug4131aSYMBOL)
# Access a specific probe
symbol_map[["A_44_P10001"]]

# Get probes mapped to a specific chromosome
chr_map <- as.list(rgug4131aCHR)
```

### Common Mapping Tasks

- **Gene Ontology (GO):** Retrieve GO IDs, Evidence codes, and Ontologies (BP, CC, MF).
- **Pathways:** Map probes to KEGG pathway identifiers using `rgug4131aPATH`.
- **Chromosomal Location:** Use `rgug4131aCHRLOC` and `rgug4131aCHRLOCEND` to find start and end coordinates.
- **External IDs:** Map to ENSEMBL, REFSEQ, UNIPROT, or UNIGENE.

### Database Connection Info

To inspect the underlying SQLite database:

```r
# Get database metadata
rgug4131a_dbInfo()

# Get the raw DBI connection
conn <- rgug4131a_dbconn()
```

## Reference documentation

- [Reference Manual](./references/reference_manual.md)
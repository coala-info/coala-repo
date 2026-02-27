---
name: bioconductor-mu11ksuba.db
description: This package provides annotation mappings for the Affymetrix Murine 11K Subarray A to translate probe IDs into biological identifiers. Use when user asks to map Affymetrix Murine 11K Subarray A probe IDs to gene symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu11ksuba.db.html
---


# bioconductor-mu11ksuba.db

## Overview

The `mu11ksuba.db` package is a standard Bioconductor annotation data package for the Affymetrix Murine 11K Subarray A. It provides a comprehensive set of mappings between manufacturer probe IDs and various biological databases. While it supports the older "Bimap" interface, the modern and preferred method for interacting with this data is through the `select()` interface provided by the `AnnotationDbi` package.

## Core Workflows

### Loading the Package and Exploring Columns

To begin, load the package and check the available annotation types (columns) and keys.

```r
library(mu11ksuba.db)

# List available columns (e.g., SYMBOL, ENTREZID, GO, PATH)
columns(mu11ksuba.db)

# List available key types (usually PROBEID)
keytypes(mu11ksuba.db)

# Get a sample of probe IDs
head(keys(mu11ksuba.db, keytype="PROBEID"))
```

### Using the select() Interface

The `select()` function is the primary way to retrieve data. It requires the database object, the keys you are interested in, the columns you want to retrieve, and the keytype of your input.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
results <- select(mu11ksuba.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Mapping to Functional Annotations

You can map probes to Gene Ontology (GO) terms or KEGG pathways for functional analysis.

```r
# Map probes to KEGG Pathways
path_map <- select(mu11ksuba.db, 
                   keys = probes, 
                   columns = "PATH", 
                   keytype = "PROBEID")

# Map probes to GO terms (includes Evidence and Ontology)
go_map <- select(mu11ksuba.db, 
                 keys = probes, 
                 columns = "GO", 
                 keytype = "PROBEID")
```

### Genomic Locations and Chromosomes

Retrieve information about where the genes targeted by the probes are located on the mouse genome.

```r
# Get chromosome and start position
loc_data <- select(mu11ksuba.db, 
                   keys = probes, 
                   columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                   keytype = "PROBEID")
```

## Tips and Best Practices

- **One-to-Many Mappings**: Be aware that `select()` may return more rows than input keys if a probe maps to multiple identifiers (e.g., multiple GO terms).
- **Bimap Interface**: If you encounter older code using `as.list(mu11ksubaSYMBOL)`, this is the Bimap interface. While still functional, it is less flexible than `select()`.
- **Organism Information**: Use `mu11ksubaORGANISM` or `mu11ksubaORGPKG` to programmatically confirm the target species (Mus musculus) and the underlying organism-level annotation package (org.Mm.eg.db).
- **Database Connection**: For advanced SQL queries, you can access the underlying SQLite connection using `mu11ksuba_dbconn()`.

## Reference documentation

- [mu11ksuba.db Reference Manual](./references/reference_manual.md)
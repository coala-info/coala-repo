---
name: bioconductor-mouse430a2.db
description: This package provides annotation data for the Affymetrix Mouse Genome 430A 2.0 Array. Use when user asks to map mouse probe identifiers to biological metadata, retrieve Gene Symbols or Entrez IDs, and perform GO or KEGG pathway mapping for mouse genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mouse430a2.db.html
---

# bioconductor-mouse430a2.db

name: bioconductor-mouse430a2.db
description: Provides annotation data for the Affymetrix Mouse Genome 430A 2.0 Array. Use this skill when mapping manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, and KEGG pathways for mouse genomic studies.

## Overview

The `mouse430a2.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Genome 430A 2.0 platform. It provides a comprehensive set of mappings between manufacturer probe identifiers and various gene-centric identifiers. While it supports legacy Bimap interfaces, the preferred method for interaction is the `select()` interface from the `AnnotationDbi` package.

## Basic Usage

### Loading the Package

To begin using the annotation data, load the library:

```r
library(mouse430a2.db)
```

### Exploring Available Data

Use the standard `AnnotationDbi` methods to see what data is available within the package:

```r
# List available columns (types of data)
columns(mouse430a2.db)

# List available keytypes (usually PROBEID)
keytypes(mouse430a2.db)

# Get a sample of keys (probe identifiers)
head(keys(mouse430a2.db))
```

### Mapping Identifiers with select()

The `select()` function is the primary way to retrieve data. It requires the database object, the keys you are interested in, the columns you want to retrieve, and the keytype of your input.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1415670_at", "1415671_at", "1415672_at")
results <- select(mouse430a2.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
print(results)
```

## Common Workflows

### Gene Ontology (GO) Annotation

To retrieve GO terms associated with specific probes, including the evidence codes and ontologies (BP, CC, MF):

```r
go_data <- select(mouse430a2.db, 
                  keys = probes, 
                  columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                  keytype = "PROBEID")
```

### Pathway Mapping (KEGG)

Map probes to KEGG pathway identifiers:

```r
pathways <- select(mouse430a2.db, 
                   keys = probes, 
                   columns = "PATH", 
                   keytype = "PROBEID")
```

### Chromosomal Locations

Retrieve the starting position and chromosome for specific probes:

```r
locations <- select(mouse430a2.db, 
                    keys = probes, 
                    columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                    keytype = "PROBEID")
```

## Legacy Bimap Interface

While `select()` is preferred, you can still use the older Bimap interface for quick lookups or list conversions.

```r
# Convert Symbol map to a list
symbol_list <- as.list(mouse430a2SYMBOL)

# Get symbols for specific probes
symbols <- symbol_list[probes]

# Reverse mapping: Find probes for a specific symbol
alias_map <- as.list(mouse430a2ALIAS2PROBE)
probes_for_gene <- alias_map[["Gpx1"]]
```

## Database Metadata

To inspect the underlying SQLite database version and source information:

```r
# Get database connection info
mouse430a2_dbInfo()

# Get the organism name
mouse430a2ORGANISM
```

## Tips for Efficient Use

- **Vectorization**: Always pass a vector of keys to `select()` rather than calling it in a loop for better performance.
- **Handling NAs**: Not every probe maps to every type of identifier. Be prepared to handle `NA` values in the returned data frames.
- **Duplicate Keys**: Note that one probe ID might map to multiple GO terms or pathways, resulting in a data frame with more rows than the input key vector.

## Reference documentation

- [mouse430a2.db Reference Manual](./references/reference_manual.md)
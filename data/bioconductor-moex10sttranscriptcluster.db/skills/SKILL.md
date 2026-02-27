---
name: bioconductor-moex10sttranscriptcluster.db
description: This package provides Bioconductor annotation data for mapping Affymetrix Mouse Exon 1.0 ST Transcript Cluster identifiers to biological metadata. Use when user asks to map probe IDs to gene symbols, Entrez IDs, GO terms, or KEGG pathways for mouse transcriptomic analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/moex10sttranscriptcluster.db.html
---


# bioconductor-moex10sttranscriptcluster.db

name: bioconductor-moex10sttranscriptcluster.db
description: Annotation data for the Affymetrix Mouse Exon 1.0 ST Transcript Cluster platform. Use when mapping manufacturer probe identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or other biological metadata for mouse transcriptomic data.

## Overview

The `moex10sttranscriptcluster.db` package is a Bioconductor annotation data package for the Mouse Exon 1.0 ST array. It provides a SQLite-based infrastructure to map manufacturer identifiers (probeset IDs) to various biological identifiers. The primary interface for this package is the `select()` function from the `AnnotationDbi` framework, though it also supports legacy "Bimap" objects.

## Core Workflows

### Loading the Package

```r
library(moex10sttranscriptcluster.db)
```

### Using the select() Interface

The `select()` interface is the recommended way to query annotations. You can discover available columns and keys before performing the lookup.

```r
# List available annotation types (columns)
columns(moex10sttranscriptcluster.db)

# List the types of keys that can be used for querying
keytypes(moex10sttranscriptcluster.db)

# Retrieve specific annotations for a set of probe IDs
probe_ids <- c("4050001", "4050005", "4050009")
results <- select(moex10sttranscriptcluster.db, 
                  keys = probe_ids, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

#### Mapping Probes to Gene Symbols and Entrez IDs
```r
select(moex10sttranscriptcluster.db, 
       keys = probe_ids, 
       columns = c("SYMBOL", "ENTREZID"), 
       keytype = "PROBEID")
```

#### Retrieving Gene Ontology (GO) Terms
Note that GO mappings include evidence codes and ontology categories (BP, CC, MF).
```r
select(moex10sttranscriptcluster.db, 
       keys = probe_ids, 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")
```

#### Mapping to KEGG Pathways
```r
select(moex10sttranscriptcluster.db, 
       keys = probe_ids, 
       columns = "PATH", 
       keytype = "PROBEID")
```

### Using Legacy Bimap Objects

While `select()` is preferred, you can use the older Bimap interface for specific list-based operations.

```r
# Convert a mapping to a list
sym_list <- as.list(moex10sttranscriptclusterSYMBOL)

# Get mapped keys only
mapped_probes <- mappedkeys(moex10sttranscriptclusterSYMBOL)

# Reverse mapping (e.g., Symbol to Probe ID)
rev_map <- as.list(moex10sttranscriptclusterALIAS2PROBE)
```

### Database Information

To get metadata about the database version and source data:
```r
moex10sttranscriptcluster_dbInfo()
```

## Tips and Best Practices

- **Key Selection**: Ensure your input keys match the `keytype` (usually "PROBEID" for this package).
- **One-to-Many Mappings**: Be aware that one probe ID may map to multiple GO terms or pathways. The `select()` function will return a data frame with multiple rows for such cases.
- **MGI Identifiers**: Since this is a mouse-specific package, use the `MGI` column to retrieve Jackson Laboratory MGI gene accession numbers.
- **Chromosomal Locations**: Use `CHRLOC` and `CHRLOCEND` to find the start and end positions of genes on the sense strand. Negative values indicate the antisense strand.

## Reference documentation

- [moex10sttranscriptcluster.db](./references/reference_manual.md)
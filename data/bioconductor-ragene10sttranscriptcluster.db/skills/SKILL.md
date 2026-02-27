---
name: bioconductor-ragene10sttranscriptcluster.db
description: This package provides biological annotations for the Affymetrix Rat Gene 1.0 ST Array by mapping transcript cluster identifiers to various gene-centric data. Use when user asks to map rat probe IDs to gene symbols, retrieve functional annotations like GO terms or KEGG pathways, or convert manufacturer identifiers to external database IDs such as Entrez or Ensembl.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ragene10sttranscriptcluster.db.html
---


# bioconductor-ragene10sttranscriptcluster.db

## Overview

The `ragene10sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Rat Gene 1.0 ST Array. It provides a SQLite-based interface to map manufacturer transcript cluster identifiers to various biological annotations. This package is essential for downstream analysis of rat microarray data, enabling the translation of probe-level results into gene-centric biological insights.

## Core Workflows

### Loading the Package
```r
library(ragene10sttranscriptcluster.db)
```

### Using the `select()` Interface
The recommended way to interact with this package is via the `AnnotationDbi` interface.

```r
# View available columns
columns(ragene10sttranscriptcluster.db)

# View available key types
keytypes(ragene10sttranscriptcluster.db)

# Retrieve specific annotations for a set of probe IDs
probe_ids <- c("10700001", "10700003", "10700005")
results <- select(ragene10sttranscriptcluster.db, 
                  keys = probe_ids, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Map probe IDs to official gene symbols (`SYMBOL`) or full names (`GENENAME`).
*   **External Database IDs**: Map to `ENTREZID`, `ENSEMBL`, `UNIPROT`, or `REFSEQ`.
*   **Functional Annotation**: Retrieve Gene Ontology (`GO`) terms or KEGG pathway IDs (`PATH`).
*   **Chromosomal Location**: Find the chromosome (`CHR`) and specific base pair start/end positions (`CHRLOC`, `CHRLOCEND`).

### Using the Bimap Interface (Legacy)
While `select()` is preferred, the package supports older Bimap objects for specific lookups.

```r
# Map probe IDs to Gene Symbols
x <- ragene10sttranscriptclusterSYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Access the first few mappings
xx[1:5]
```

### Reverse Mappings
To map from a gene-centric ID back to probe IDs, use the `select()` interface by changing the `keytype` or use the specific reverse Bimap objects.

```r
# Map Gene Symbols to Probe IDs
alias_map <- as.list(ragene10sttranscriptclusterALIAS2PROBE)
probes_for_gene <- alias_map[["Tp53"]]
```

## Tips and Best Practices
*   **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
*   **Organism Info**: Use `ragene10sttranscriptclusterORGANISM` to programmatically confirm the species (Rattus norvegicus).
*   **Package Dependencies**: This package depends on `AnnotationDbi` and the organism-level package `org.Rn.eg.db`.
*   **Database Connection**: If you need direct SQL access, use `ragene10sttranscriptcluster_dbconn()`, but do not close the connection manually.

## Reference documentation

- [ragene10sttranscriptcluster.db Reference Manual](./references/reference_manual.md)
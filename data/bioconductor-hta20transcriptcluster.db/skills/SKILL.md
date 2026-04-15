---
name: bioconductor-hta20transcriptcluster.db
description: This package provides Bioconductor annotation data for mapping Affymetrix Human Transcriptome Array 2.0 transcript cluster identifiers to biological metadata. Use when user asks to map HTA 2.0 probe IDs to gene symbols, retrieve Entrez or Ensembl identifiers, or annotate transcript clusters with GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hta20transcriptcluster.db.html
---

# bioconductor-hta20transcriptcluster.db

name: bioconductor-hta20transcriptcluster.db
description: Annotation data for the Affymetrix HTA 2.0 (Human Transcriptome Array) platform. Use this skill when you need to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Ensembl IDs, GO terms, and KEGG pathways for HTA 2.0 transcript cluster data.

## Overview

The `hta20transcriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Human Transcriptome Array 2.0. It provides a set of SQLite-based mappings between manufacturer-specific transcript cluster identifiers and various public identifiers. While it supports the older "Bimap" interface, the modern and preferred way to interact with this data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package

```r
library(hta20transcriptcluster.db)
```

### Exploring Available Data

To see which types of information (columns) can be retrieved:

```r
columns(hta20transcriptcluster.db)
```

To see the types of identifiers you can use as input (keys):

```r
keytypes(hta20transcriptcluster.db)
```

### Using the select() Interface

The `select()` function is the primary method for retrieving data. It requires the database object, the input keys, the columns you want to retrieve, and the keytype of your input.

```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("16650001", "16650003", "16650005")
results <- select(hta20transcriptcluster.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mappings

- **Gene Symbols**: Use `columns = "SYMBOL"` to get official gene abbreviations.
- **Entrez IDs**: Use `columns = "ENTREZID"` for NCBI Gene identifiers.
- **Ensembl**: Use `columns = "ENSEMBL"` for Ensembl gene accession numbers.
- **Gene Ontology**: Use `columns = "GO"` for GO identifiers, evidence codes, and ontologies (BP, CC, MF).
- **KEGG Pathways**: Use `columns = "PATH"` for KEGG pathway identifiers.
- **Chromosomal Location**: Use `columns = c("CHR", "CHRLOC")` for chromosome and start positions.

### Reverse Mappings

If you have Gene Symbols and want to find the corresponding HTA 2.0 probes:

```r
symbols <- c("TP53", "BRCA1")
select(hta20transcriptcluster.db, 
       keys = symbols, 
       columns = "PROBEID", 
       keytype = "SYMBOL")
```

### Database Connection Information

To inspect the underlying SQLite database schema or connection:

```r
hta20transcriptcluster_dbschema()
hta20transcriptcluster_dbInfo()
```

## Tips and Best Practices

- **One-to-Many Mappings**: Be aware that some probes may map to multiple genes or GO terms. The `select()` function will return a data frame with one row for each possible mapping, which may result in more rows than your input vector.
- **Bimap Interface**: While you may see older code using `as.list(hta20transcriptclusterSYMBOL)`, the `select()` interface is more robust and consistent across Bioconductor.
- **Filtering**: Use standard R data frame operations to filter results where mappings are `NA`.

## Reference documentation

- [hta20transcriptcluster.db Reference Manual](./references/reference_manual.md)
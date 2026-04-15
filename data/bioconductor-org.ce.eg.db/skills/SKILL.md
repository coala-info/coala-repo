---
name: bioconductor-org.ce.eg.db
description: This package provides genome-wide annotations and identifier mapping for Caenorhabditis elegans. Use when user asks to map between gene identifiers, find chromosomal locations, retrieve GO terms, or access KEGG pathways for C. elegans genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Ce.eg.db.html
---

# bioconductor-org.ce.eg.db

name: bioconductor-org.ce.eg.db
description: Genome-wide annotation for Caenorhabditis elegans (worm), primarily based on mapping Entrez Gene identifiers. Use this skill when you need to map between different gene identifiers (Entrez, Ensembl, WormBase, Symbols), find chromosomal locations, GO terms, KEGG pathways, or PubMed IDs for C. elegans genes.

## Overview

The `org.Ce.eg.db` package is an organism-specific annotation package for *Caenorhabditis elegans*. It provides a central hub for mapping Entrez Gene identifiers to various other biological annotations. While it supports older "Bimap" interfaces, the modern and preferred way to interact with the data is through the `select()` interface provided by the `AnnotationDbi` package.

## Core Workflows

### 1. Discovery and Exploration
Before querying, identify what types of data (columns) and identifiers (keys) are available.

```r
library(org.Ce.eg.db)

# List available annotation types
columns(org.Ce.eg.db)

# List available key types (usually same as columns)
keytypes(org.Ce.eg.db)

# See the first few Entrez Gene IDs
head(keys(org.Ce.eg.db, keytype="ENTREZID"))
```

### 2. Mapping Identifiers with select()
The `select()` function is the primary tool for retrieving data. It requires the database object, the input keys, the columns you want to retrieve, and the keytype of your input.

```r
# Map Gene Symbols to Ensembl IDs and Chromosomal locations
genes <- c("daf-16", "zip-2", "skn-1")
select(org.Ce.eg.db, 
       keys = genes, 
       columns = c("ENSEMBL", "CHR", "GENENAME"), 
       keytype = "SYMBOL")
```

### 3. Common Annotation Mappings
- **Gene Symbols/Aliases**: Use `SYMBOL` for official symbols and `ALIAS` for common/historical names.
- **External IDs**: Map to `ENSEMBL`, `WORMBASE`, `UNIPROT`, or `REFSEQ`.
- **Functional Annotation**: Map to `GO` (Gene Ontology) or `PATH` (KEGG Pathways).
- **Literature**: Map to `PMID` (PubMed identifiers).

### 4. Working with Gene Ontology (GO)
When querying GO terms, the output includes the GO ID, the Evidence code (e.g., IDA, IEA), and the Ontology (BP, CC, or MF).

```r
# Get GO terms for specific Entrez IDs
select(org.Ce.eg.db, 
       keys = c("172469", "172470"), 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "ENTREZID")
```

### 5. Chromosomal Information
You can retrieve start positions (`CHRLOC`), end positions (`CHRLOCEND`), and chromosome names (`CHR`). Note that antisense strand locations are represented as negative values.

```r
# Get chromosomal locations
select(org.Ce.eg.db, 
       keys = "daf-16", 
       columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
       keytype = "SYMBOL")
```

## Tips and Best Practices
- **Avoid Symbols as Primary Keys**: Gene symbols can be redundant or change over time. Use Entrez IDs (`ENTREZID`), Ensembl IDs (`ENSEMBL`), or WormBase IDs (`WORMBASE`) for more stable analysis.
- **One-to-Many Mappings**: Be aware that `select()` may return more rows than input keys if a gene maps to multiple GO terms, PubMed IDs, or transcripts.
- **Database Metadata**: Use `org.Ce.eg_dbconn()` to get a connection to the underlying SQLite database or `org.Ce.eg_dbInfo()` to see data source versions and timestamps.
- **Species Confirmation**: Use `org.Ce.egORGANISM` to programmatically verify the species is *Caenorhabditis elegans*.

## Reference documentation
- [org.Ce.eg.db Reference Manual](./references/reference_manual.md)
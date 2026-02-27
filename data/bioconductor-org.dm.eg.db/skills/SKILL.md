---
name: bioconductor-org.dm.eg.db
description: This package provides genome-wide annotations and identifier mappings for Drosophila melanogaster. Use when user asks to map between FlyBase IDs, Entrez IDs, and gene symbols, retrieve Gene Ontology terms, or find genomic locations for fruit fly genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Dm.eg.db.html
---


# bioconductor-org.dm.eg.db

## Overview
The `org.Dm.eg.db` package is a Bioconductor "org" (organism-level) annotation package for *Drosophila melanogaster*. It provides a central map between Entrez Gene identifiers and various biological annotations. While it supports an older "Bimap" interface, the primary and recommended way to interact with the data is through the `select()` interface provided by the `AnnotationDbi` package.

## Core Workflows

### 1. Initialization and Discovery
To use the package, load it into your R session and explore the available keys and columns.

```r
library(org.Dm.eg.db)

# View available annotation types (columns)
columns(org.Dm.eg.db)

# View available key types (identifier types you can use as input)
keytypes(org.Dm.eg.db)

# Get a sample of Entrez IDs (the default keys)
head(keys(org.Dm.eg.db, keytype="ENTREZID"))
```

### 2. Mapping Identifiers (The select Interface)
Use `select()` to translate between different identifier systems.

```r
# Map FlyBase IDs to Gene Symbols and Entrez IDs
genes <- c("FBgn0000008", "FBgn0000024")
select(org.Dm.eg.db, 
       keys = genes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "FLYBASE")
```

### 3. Functional Annotation
Retrieve Gene Ontology (GO) terms or KEGG pathways for specific genes.

```r
# Get GO terms for a list of symbols
select(org.Dm.eg.db, 
       keys = c("dpp", "act5C"), 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "SYMBOL")

# Get KEGG pathway IDs
select(org.Dm.eg.db, 
       keys = "30664", 
       columns = "PATH", 
       keytype = "ENTREZID")
```

### 4. Genomic Location and Physical Mapping
Find where genes are located on the Drosophila genome.

```r
# Get chromosome and start/end locations
select(org.Dm.eg.db, 
       keys = "act5C", 
       columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
       keytype = "SYMBOL")

# Get cytogenetic map bands
select(org.Dm.eg.db, 
       keys = "FBgn0000008", 
       columns = "MAP", 
       keytype = "FLYBASE")
```

## Key Annotation Columns
*   **SYMBOL**: Common gene symbol (e.g., "dpp").
*   **GENENAME**: Full descriptive name of the gene.
*   **FLYBASE**: FlyBase accession number (primary ID for Drosophila research).
*   **ENSEMBL**: Ensembl gene identifiers.
*   **GO**: Gene Ontology identifiers.
*   **PATH**: KEGG pathway identifiers.
*   **REFSEQ**: NCBI Reference Sequence identifiers.
*   **UNIPROT**: UniProt protein accessions.

## Tips and Best Practices
*   **Redundancy**: Gene symbols (ALIAS) can sometimes be redundant. It is safer to use Entrez IDs or FlyBase IDs as primary keys.
*   **Bimap Interface**: You may see older code using `as.list(org.Dm.egSYMBOL)`. While this still works, the `select()` method is more robust and handles multiple return values more consistently.
*   **Database Connection**: You can inspect the underlying SQLite metadata using `org.Dm.eg_dbInfo()` or `org.Dm.eg_dbschema()`.
*   **Reverse Mappings**: If using the Bimap interface, reverse maps are often named with a "2" (e.g., `org.Dm.egSYMBOL2EG` to map symbols back to Entrez IDs).

## Reference documentation
- [org.Dm.eg.db Reference Manual](./references/reference_manual.md)
---
name: bioconductor-org.sc.sgd.db
description: This package provides comprehensive genome-wide annotations and identifier mappings for the yeast Saccharomyces cerevisiae. Use when user asks to map yeast ORF identifiers to gene names, retrieve Gene Ontology terms, or access functional annotations from the Saccharomyces Genome Database.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Sc.sgd.db.html
---

# bioconductor-org.sc.sgd.db

## Overview

The `org.Sc.sgd.db` package is an organism-specific annotation package for *Saccharomyces cerevisiae* (Yeast). It provides a comprehensive mapping between various gene identifiers and functional annotations based on data from the Saccharomyces Genome Database (SGD). The primary identifier used in this package is the Systematic Open Reading Frame (ORF) identifier.

## Core Workflows

### 1. Using the select() Interface
The modern and preferred way to interact with this package is through the `select()` interface from the `AnnotationDbi` package.

```R
library(org.Sc.sgd.db)

# 1. List available columns (data types)
columns(org.Sc.sgd.db)

# 2. List available key types (input types)
keytypes(org.Sc.sgd.db)

# 3. Retrieve data
# Example: Map ORF IDs to Gene Names and Entrez IDs
genes <- c("YAL001C", "YAL002W")
select(org.Sc.sgd.db, 
       keys = genes, 
       columns = c("GENENAME", "ENTREZID", "DESCRIPTION"), 
       keytype = "ORF")
```

### 2. Common Identifier Mappings
The package supports various mappings essential for yeast bioinformatics:
- **ORF to Common Name**: Use `GENENAME` or `ALIAS`.
- **ORF to External IDs**: Use `ENTREZID`, `ENSEMBL`, `UNIPROT`, or `REFSEQ`.
- **Common Name to ORF**: Use `COMMON2ORF` to map aliases or gene names back to systematic IDs.

### 3. Functional and Pathway Annotation
- **Gene Ontology (GO)**: Retrieve GO IDs, Evidence codes, and Ontologies (BP, CC, MF).
- **KEGG Pathways**: Map ORF IDs to KEGG pathway identifiers using the `PATH` column.
- **Enzyme Commission (EC)**: Map genes to enzyme classifications using `ENZYME`.

### 4. Genomic Location and Structure
- **Chromosomes**: Use `CHR` to find which chromosome a gene resides on.
- **Chromosomal Location**: Use `CHRLOC` (start) and `CHRLOCEND` (end). Negative values indicate the antisense strand.
- **Chromosome Lengths**: Access the `org.Sc.sgdCHRLENGTHS` object for base pair counts per chromosome.

### 5. Yeast-Specific Data
- **Rejected ORFs**: `org.Sc.sgdREJECTORF` contains a list of ORFs rejected by the Reading Frame Conservation (RFC) test.
- **Descriptions**: `org.Sc.sgdDESCRIPTION` provides textual descriptions of gene functions.

## Tips and Best Practices
- **ORF IDs**: Always ensure your input keys match the expected format (e.g., "YAL001C").
- **Bimap Interface**: While "old style" Bimaps (e.g., `org.Sc.sgdENTREZID`) still work, `select()` is more flexible for joining multiple data types in one call.
- **Evidence Codes**: When working with GO terms, pay attention to the `EVIDENCE` column to understand the experimental or computational basis of the annotation.
- **Database Connection**: Use `org.Sc.sgd_dbconn()` to access the underlying SQLite connection if complex SQL queries are required, but do not call `dbDisconnect()` on it.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)
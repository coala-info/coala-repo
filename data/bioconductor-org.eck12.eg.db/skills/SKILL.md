---
name: bioconductor-org.eck12.eg.db
description: This package provides genome-wide annotations and identifier mappings for Escherichia coli K12. Use when user asks to map between Entrez Gene identifiers and other biological identifiers like gene symbols, GO terms, KEGG pathways, or RefSeq accessions for E. coli K12.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.EcK12.eg.db.html
---


# bioconductor-org.eck12.eg.db

name: bioconductor-org.eck12.eg.db
description: Genome-wide annotation for Escherichia coli K12. Use when mapping between Entrez Gene identifiers and other biological identifiers (Symbols, GO terms, KEGG pathways, RefSeq, etc.) for E. coli K12.

# bioconductor-org.eck12.eg.db

## Overview

The `org.EcK12.eg.db` package is a Bioconductor annotation hub for *Escherichia coli* K12. It provides comprehensive mappings between Entrez Gene identifiers (the primary key) and various other database identifiers. This package is essential for bioinformatics workflows involving E. coli K12, such as RNA-seq analysis, functional enrichment, and cross-database ID conversion.

## Core Workflows

### 1. Exploring Available Data
Before querying, identify what information is available and what keys you can use as input.

library(org.EcK12.eg.db)

# List all available annotation types (columns)
columns(org.EcK12.eg.db)

# List all valid input identifier types (keytypes)
keytypes(org.EcK12.eg.db)

### 2. Using the select() Interface
The `select()` function is the recommended method for retrieving data. It requires the database object, the input keys, the columns you want to retrieve, and the keytype of your input.

# Example: Map Gene Symbols to Entrez IDs and GO Terms
genes <- c("thrA", "thrB", "thrC")
select(org.EcK12.eg.db, 
       keys = genes, 
       columns = c("ENTREZID", "GO", "EVIDENCE"), 
       keytype = "SYMBOL")

### 3. Mapping to Functional Annotations
The package provides specific mappings for biological pathways and functions.

# Map Entrez IDs to KEGG Pathways
select(org.EcK12.eg.db, 
       keys = c("944742", "944747"), 
       columns = "PATH", 
       keytype = "ENTREZID")

# Map Entrez IDs to Enzyme Commission (EC) numbers
select(org.EcK12.eg.db, 
       keys = "944742", 
       columns = "ENZYME", 
       keytype = "ENTREZID")

### 4. Legacy Bimap Interface
While `select()` is preferred, "Bimaps" are useful for quick list conversions or reverse mappings.

# Convert Symbol to Entrez ID list
symbol_map <- as.list(org.EcK12.egSYMBOL2EG)
symbol_map["thrA"]

# Get all mapped Entrez IDs
mapped_genes <- mappedkeys(org.EcK12.egSYMBOL)

## Key Identifier Types
- **ENTREZID**: NCBI Entrez Gene identifiers (Primary Key).
- **SYMBOL**: Official gene symbols.
- **ALIAS**: Common aliases or literature symbols.
- **GENENAME**: Full descriptive gene names.
- **GO**: Gene Ontology identifiers (includes Evidence and Ontology category).
- **PATH**: KEGG pathway identifiers.
- **ACCNUM**: GenBank Accession numbers.
- **REFSEQ**: RefSeq identifiers.
- **PMID**: PubMed identifiers associated with the gene.

## Tips and Best Practices
- **Redundancy**: Gene symbols can sometimes be redundant. When using `ALIAS`, verify the resulting Entrez IDs to ensure they match your expected biological context.
- **GO Evidence Codes**: When retrieving GO terms, use the `EVIDENCE` column to filter by quality (e.g., "TAS" for Traceable Author Statement vs "IEA" for Inferred from Electronic Annotation).
- **Database Connection**: Use `org.EcK12.eg_dbconn()` to get a DBI connection to the underlying SQLite database if you need to perform complex SQL queries directly. Do not call `dbDisconnect()` on this object.
- **Organism Verification**: Use `org.EcK12.egORGANISM` to programmatically confirm the species is "Escherichia coli".

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
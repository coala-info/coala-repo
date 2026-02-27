---
name: bioconductor-org.bt.eg.db
description: This package provides genome-wide annotations and identifier mappings for Bos taurus (Cow) based on Entrez Gene identifiers. Use when user asks to map between cow gene identifiers, retrieve functional annotations like GO terms and KEGG pathways, or find chromosomal locations for cow genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Bt.eg.db.html
---


# bioconductor-org.bt.eg.db

name: bioconductor-org.bt.eg.db
description: Genome-wide annotation for Cow (Bos taurus), primarily based on Entrez Gene identifiers. Use this skill when you need to map between different cow gene identifiers (Entrez, Symbol, Ensembl, RefSeq, Uniprot), find chromosomal locations, or retrieve functional annotations like GO terms and KEGG pathways for Bos taurus.

# bioconductor-org.bt.eg.db

## Overview

The org.Bt.eg.db package is a genome-wide annotation database for Bos taurus (Cow). It uses Entrez Gene identifiers as the primary key to map to various other identifiers and biological metadata. This package is essential for bioinformatics workflows involving cow genomic data, such as RNA-seq analysis, gene set enrichment, and functional annotation.

## Core Workflows

### 1. Exploration
Before mapping, check what data types (columns) and keys are available in the database.

library(org.Bt.eg.db)

# List available annotation types
columns(org.Bt.eg.db)

# List available key types (usually same as columns)
keytypes(org.Bt.eg.db)

# See a sample of Entrez Gene IDs
head(keys(org.Bt.eg.db, keytype="ENTREZID"))

### 2. Mapping Identifiers (select)
Use the select() function for general purpose mapping. It can return multiple columns for a set of input keys.

# Map Gene Symbols to Entrez IDs and Chromosomes
genes <- c("GHR", "IGF1", "SCD")
select(org.Bt.eg.db, 
       keys = genes, 
       columns = c("ENTREZID", "CHR", "GENENAME"), 
       keytype = "SYMBOL")

### 3. Simple 1-to-1 Mapping (mapIds)
Use mapIds() when you need a simple vector or list returned, which is often easier for adding a new column to an existing dataframe.

# Add Ensembl IDs to a vector of Entrez IDs
entrez_ids <- c("280805", "280822")
ensembl_ids <- mapIds(org.Bt.eg.db, 
                      keys = entrez_ids, 
                      column = "ENSEMBL", 
                      keytype = "ENTREZID", 
                      multiVals = "first")

### 4. Functional Annotation
Retrieve Gene Ontology (GO) or KEGG Pathway information.

# Get GO terms for specific genes
go_annots <- select(org.Bt.eg.db, 
                    keys = "280805", 
                    columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                    keytype = "ENTREZID")

# Get KEGG Pathway IDs
pathways <- select(org.Bt.eg.db, 
                   keys = "280805", 
                   columns = "PATH", 
                   keytype = "ENTREZID")

## Key Mapping Tables

- SYMBOL: Official gene symbols.
- ALIAS: Common aliases or old symbols.
- ENSEMBL: Ensembl gene identifiers.
- UNIPROT: UniProt protein accessions.
- REFSEQ: RefSeq identifiers.
- GENENAME: The full descriptive name of the gene.
- CHRLOC: Chromosomal start location (negative values indicate antisense strand).

## Tips and Best Practices

- Entrez vs Symbol: Always prefer Entrez IDs (ENTREZID) or Ensembl IDs for programmatic work, as Symbols can be ambiguous or change over time.
- Handling Multi-mappings: Some keys map to multiple values (e.g., one gene to many GO terms). In select(), this results in multiple rows. In mapIds(), use the multiVals argument ("first", "list", "CharacterList") to control behavior.
- Species Confirmation: Use org.Bt.egORGANISM to programmatically confirm the species is Bos taurus.
- Database Connection: If you need to perform raw SQL queries, use org.Bt.eg_dbconn() to get the DBI connection object.

## Reference documentation
- [org.Bt.eg.db Reference Manual](./references/reference_manual.md)
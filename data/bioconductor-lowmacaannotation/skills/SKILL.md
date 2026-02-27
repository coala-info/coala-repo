---
name: bioconductor-lowmacaannotation
description: This package provides curated annotation datasets for mapping genes to UniProt protein sequences and Pfam domain coordinates. Use when user asks to retrieve protein sequences, identify Pfam domain boundaries, or validate gene aliases for mutational analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/LowMACAAnnotation.html
---


# bioconductor-lowmacaannotation

name: bioconductor-lowmacaannotation
description: Access and retrieve curated annotation datasets for the LowMACA R package, including UniProt protein sequences, Pfam domain boundaries, and gene aliases. Use this skill when you need to map gene symbols to protein sequences or identify Pfam domain coordinates for mutational analysis.

# bioconductor-lowmacaannotation

## Overview

The `LowMACAAnnotation` package provides the underlying data infrastructure for the `LowMACA` (Low Frequency Mutation Analysis via Consensus Alignment) framework. It contains three primary curated datasets that facilitate the 1-to-1 mapping between genes, UniProt protein sequences, and Pfam domains. This is essential for analyzing mutations at the protein residue level rather than genomic coordinates.

## Core Functions

The package uses three simple getter functions to retrieve its internal data frames.

### 1. Retrieve Protein Sequences (myUni)
Use `getMyUni()` to get a data frame of proteins with their relative gene names and UniProt amino acid sequences.

```r
library(LowMACAAnnotation)
myUni <- getMyUni()

# Key columns:
# Gene_Symbol, Entrez, UNIPROT (name_HUMAN), Entry (Uniprot ID), 
# HGNC, Approved_Name, Protein.name, Chromosome, AMINO_SEQ
```

### 2. Retrieve Pfam Domains (myPfam)
Use `getMyPfam()` to get Pfam domain boundaries relative to the protein sequences in the `myUni` dataset.

```r
myPfam <- getMyPfam()

# Key columns:
# Entry (Uniprot ID), Envelope_Start, Envelope_End, 
# Pfam_ID (PF######), Pfam_Name, Type (Domain/Family/Repeat/Motif),
# Clan_ID, Entrez, UNIPROT, Gene_Symbol, Pfam_Fasta
```

### 3. Retrieve Gene Aliases (myAlias)
Use `getMyAlias()` to check for official gene symbols and their known aliases. This is used for validating user input and ensuring consistency with the HGNC database.

```r
myAlias <- getMyAlias()

# Key columns:
# Alias, Official_Gene_Symbol, Locus_Group, Locus_Type, 
# MappedByLowMACA (Yes/No indicator if gene is in myUni)
```

## Typical Workflows

### Mapping a Gene to its Protein Sequence
If you have a gene symbol and need the canonical protein sequence used by LowMACA:

```r
myUni <- getMyUni()
target_gene <- "TP53"
protein_info <- myUni[myUni$Gene_Symbol == target_gene, ]
sequence <- protein_info$AMINO_SEQ
```

### Finding Pfam Domains for a Specific Protein
To identify which Pfam domains are present on a specific UniProt entry:

```r
myPfam <- getMyPfam()
uniprot_id <- "P04637" # TP53
domains <- myPfam[myPfam$Entry == uniprot_id, ]
```

## Data Curation Logic
LowMACAAnnotation enforces a "1 gene, 1 protein" rule to resolve the ambiguity of multiple transcripts. The selection of the "canonical" protein follows a specific hierarchy:
1. Canonical protein defined by UniProt.
2. Match with cBioPortal annotation.
3. Longest protein sequence among transcripts.
4. Reviewed status in UniProt.

## Reference documentation

- [LowMACAAnnotation](./references/LowMACAAnnotation.md)
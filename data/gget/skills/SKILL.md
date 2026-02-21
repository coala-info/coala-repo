---
name: gget
description: gget is a modular command-line tool and Python package designed to streamline genomic data retrieval.
homepage: https://github.com/pachterlab/gget
---

# gget

## Overview
gget is a modular command-line tool and Python package designed to streamline genomic data retrieval. It replaces complex manual database navigation with simple, single-line commands to fetch reference annotations, search for genes by description, perform sequence alignments, and predict protein structures. It is particularly useful for researchers who need to programmatically access data from Ensembl, UniProt, and NCBI without writing custom API wrappers.

## Installation
Install gget via pip or conda:
- `pip install gget`
- `conda install bioconda::gget`

## Core CLI Patterns

### 1. Reference and Search
- **Fetch reference FTPs**: Get the latest Ensembl reference and annotation links for a species.
  `gget ref homo_sapiens`
- **Search for genes**: Find Ensembl IDs using keywords or descriptions.
  `gget search -s homo_sapiens 'ace2' 'angiotensin converting enzyme 2'`
- **Lookup metadata**: Get detailed information for specific gene or transcript IDs.
  `gget info ENSG00000130234 ENST00000252519`

### 2. Sequence Retrieval and Alignment
- **Fetch sequences**: Get the amino acid sequence of a gene (use `--translate` for protein).
  `gget seq --translate ENSG00000130234`
- **BLAST/BLAT**: Align a sequence against NCBI (blast) or find genomic locations (blat).
  `gget blast <sequence>`
  `gget blat <sequence>`
- **Multiple Alignment**: Align multiple sequences using MUSCLE.
  `gget muscle <seq1> <seq2> -o output.afa`

### 3. Functional and Structural Analysis
- **Enrichment analysis**: Perform ontology analysis on a gene list using Enrichr.
  `gget enrichr -db ontology ACE2 AGT AGTR1`
- **Tissue expression**: Query ARCHS4 for human tissue expression data.
  `gget archs4 -w tissue ACE2`
- **Protein structures**: Download PDB files or predict structures using AlphaFold.
  `gget pdb 1R42 -o 1R42.pdb`
  `gget setup alphafold` (Required once)
  `gget alphafold <sequence>`

### 4. Specialized Modules
- **Virus data**: Download virus genome datasets from NCBI Virus.
  `gget virus "Zika virus" --host "Homo sapiens" --nuc_completeness complete`
- **Single-cell RNAseq**: Fetch count matrices from CellxGene.
  `gget setup cellxgene` (Required once)
  `gget cellxgene --gene ACE2 --tissue lung -o data.h5ad`

## Expert Tips
- **Setup Modules**: Modules like `alphafold`, `cellxgene`, and `elm` require a one-time setup using `gget setup <module>` to install heavy dependencies or databases.
- **Output Management**: Most commands support the `-o` or `--out` flag to save results directly to a file, which is preferred for large datasets like sequences or PDB files.
- **Batch Processing**: `gget info` and `gget search` accept multiple arguments, allowing for efficient batch querying in a single command.

## Reference documentation
- [gget GitHub Repository](./references/github_com_pachterlab_gget.md)
- [gget Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gget_overview.md)
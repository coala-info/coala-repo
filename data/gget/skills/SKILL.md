---
name: gget
description: gget is a modular bioinformatics toolkit that provides programmatic access to genomic databases for metadata lookups, sequence retrieval, and structural analysis. Use when user asks to search for gene IDs, fetch reference sequences, perform sequence alignments, query tissue expression, or retrieve protein structures.
homepage: https://github.com/pachterlab/gget
metadata:
  docker_image: "quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0"
---

# gget

## Overview
`gget` is a modular toolkit designed to simplify bioinformatics workflows by providing single-line access to major genomic databases. It eliminates the need to manually navigate web portals or write complex API scrapers. Use this skill to perform rapid lookups of gene metadata, retrieve biological sequences, align sequences, and fetch protein structural data directly from the command line or within Python environments.

## Core CLI Patterns

### Database Lookups and Search
*   **Find Ensembl IDs**: Search for genes using common names or descriptions.
    ```bash
    gget search -s homo_sapiens 'ace2'
    ```
*   **Retrieve Metadata**: Get detailed information about specific Ensembl IDs.
    ```bash
    gget info ENSG00000130234 ENST00000252519
    ```
*   **Fetch Reference FTPs**: Get the latest Ensembl release FTP links for a species.
    ```bash
    gget ref homo_sapiens
    ```

### Sequence Retrieval and Alignment
*   **Get Sequences**: Fetch the amino acid sequence of a canonical transcript.
    ```bash
    gget seq --translate ENSG00000130234
    ```
*   **BLAST/BLAT Search**: Quickly find genomic locations or homologs for a sequence.
    ```bash
    gget blat MSSSSWLLLSLVAVTAAQSTIEEQAKTFLDKFNHEAEDLFYQSSLAS
    gget blast MSSSSWLLLSLVAVTAAQSTIEEQAKTFLDKFNHEAEDLFYQSSLAS
    ```
*   **Multiple Sequence Alignment**: Align sequences using MUSCLE.
    ```bash
    gget muscle seq1.fa seq2.fa
    ```

### Specialized Analysis
*   **Ontology Analysis**: Run Enrichr on a list of gene symbols.
    ```bash
    gget enrichr -db ontology ACE2 AGT AGTR1 ACE
    ```
*   **Tissue Expression**: Query ARCHS4 for human tissue expression levels.
    ```bash
    gget archs4 -w tissue ACE2
    ```
*   **Protein Structures**: Download PDB files or predict structures using AlphaFold.
    ```bash
    gget pdb 1R42 -o 1R42.pdb
    gget alphafold MSSSSWLLLSLVAVTAAQSTIEEQAKTFLDKFNHEAEDLFYQSSLAS
    ```
*   **Single-cell Data**: Fetch scRNA-seq count matrices from CellxGene.
    ```bash
    gget setup cellxgene
    gget cellxgene --gene ACE2 SLC5A1 --tissue lung -o data.h5ad
    ```

## Expert Tips
*   **Setup Requirements**: Modules like `elm`, `cellxgene`, and `alphafold` require a one-time setup using `gget setup <module>`.
*   **Species Naming**: When using `-s` or species arguments, use the scientific name format (e.g., `homo_sapiens`, `mus_musculus`).
*   **Output Redirection**: Most commands support the `-o` flag to save results directly to a file instead of printing to STDOUT.
*   **Batch Processing**: `gget info` and `gget search` can accept multiple IDs or search terms in a single command.



## Subcommands

| Command | Description |
|---------|-------------|
| gget_ref | Fetch FTPs for reference genomes and annotations by species. |
| gget_search | Fetch gene and transcript IDs from Ensembl using free-form search terms. |

## Reference documentation
- [gget GitHub Repository](./references/github_com_pachterlab_gget_blob_main_README.md)
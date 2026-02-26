---
name: bio
description: The bio utility provides streamlined command-line tools for common bioinformatics workflows including data retrieval, sequence manipulation, and taxonomic queries. Use when user asks to fetch GenBank records, convert sequences to FASTA, extract genes or proteins, align sequences, look up ontology terms, or query taxonomic lineages.
homepage: https://github.com/ialbert/bio
---


# bio

## Overview
The `bio` utility is a collection of streamlined command-line tools designed to simplify common bioinformatics workflows. It treats biological data as modular components that can be easily piped together. Use this skill to automate the retrieval of GenBank records, slice sequences, extract coding sequences by gene name, and query taxonomic lineages or sequence ontologies without writing complex scripts.

## Core CLI Patterns

### Data Retrieval and Conversion
*   **Fetch GenBank records**: Use `bio fetch` with accession numbers.
    ```bash
    bio fetch NC_045512 MN996532 > genomes.gb
    ```
*   **Convert to FASTA**: Convert GenBank or other formats to FASTA. Use `--end` or `--start` to slice the sequence.
    ```bash
    bio fasta genomes.gb --end 100
    ```
*   **Extract Genes/Proteins**: Target specific features by gene name.
    ```bash
    # Get the protein sequence for gene S
    bio fasta genomes.gb --gene S --protein
    ```

### Analysis and Exploration
*   **Sequence Alignment**: Pipe FASTA sequences directly into the aligner.
    ```bash
    bio fasta genomes.gb --gene S --protein | bio align
    ```
*   **GFF Extraction**: View specific genomic features in GFF format.
    ```bash
    bio gff genomes.gb --gene S
    ```
*   **Ontology Definitions**: Quickly look up Sequence Ontology (SO) or Gene Ontology (GO) terms.
    ```bash
    bio explain exon
    bio explain "food vacuole"
    ```

### Taxonomy and Metadata
*   **Taxonomic Queries**: Explore the tree of life using TaxIDs.
    ```bash
    # Show descendants
    bio taxon 117565
    # Show full lineage
    bio taxon 117565 --lineage
    ```
*   **Sample Metadata**: Retrieve metadata for viral or sequencing samples.
    ```bash
    bio meta 11138 -H
    ```

## Expert Tips
*   **Stream Orientation**: `bio` is designed for piping. You can pass a list of accessions from a file into a full pipeline:
    ```bash
    cat accessions.txt | bio fetch | bio fasta --gene S | bio align --vcf
    ```
*   **VCF Generation**: When aligning, use the `--vcf` flag to output variants directly if the tool version supports it.
*   **Search Functionality**: Use `bio search` to find SRR numbers or accessions when exploring public repositories.

## Reference documentation
- [bio: making bioinformatics fun again](./references/github_com_ialbert_bio.md)
- [bioconda bio overview](./references/anaconda_org_channels_bioconda_packages_bio_overview.md)
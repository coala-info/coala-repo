---
name: metasbt
description: MetaSBT is a scalable bioinformatics framework for indexing microbial genomes and characterizing metagenome-assembled genomes using Sequence Bloom Trees. Use when user asks to manage genomic databases, sketch and index sequences, profile query genomes for taxonomic identity, or retrieve reference data from NCBI.
homepage: https://github.com/cumbof/MetaSBT
---


# metasbt

## Overview

MetaSBT is a scalable bioinformatics framework designed to index microbial genomes and characterize metagenome-assembled genomes (MAGs) using Sequence Bloom Trees (SBTs). It allows researchers to handle massive genomic datasets efficiently by representing sequences as Bloom filters organized in a tree structure. This skill assists in navigating the MetaSBT command-line interface for database management, indexing, and taxonomic profiling.

## Installation and Setup

Install MetaSBT via Conda from the bioconda channel:

```bash
conda install -c bioconda metasbt
```

## Core CLI Commands

MetaSBT uses a sub-command structure. The primary entry point is `metasbt`.

### Database Management
*   **List available databases**: Use `db` to see public databases hosted by the MetaSBT team.
    ```bash
    metasbt db --list
    ```
*   **Install a database**: Use `unpack` to download and set up a specific database.
    ```bash
    metasbt unpack --db <database_name> --out <destination_folder>
    ```
*   **Summarize content**: Check the taxonomic composition of a database.
    ```bash
    metasbt summarize --db <database_path>
    ```

### Indexing and Sketching
*   **Sketching**: Convert raw genomes into Bloom filters. This is a prerequisite for indexing.
    ```bash
    metasbt sketch --input <genomes_dir> --extension .fna --output <sketches_dir>
    ```
*   **Indexing**: Build the Sequence Bloom Tree from sketches.
    ```bash
    metasbt index --input <sketches_dir> --output <index_dir> --taxonomy <taxonomy_file>
    ```

### Profiling and Characterization
*   **Profile genomes**: Compare a query genome or MAG against an indexed database to determine its taxonomic identity.
    ```bash
    metasbt profile --input <query.fna> --db <index_dir> --output <results_dir>
    ```

### Data Retrieval
*   **NCBI Genomes**: MetaSBT includes a specialized script for fetching reference data.
    ```bash
    python scripts/get_ncbi_genomes.py --domain Bacteria --group "Proteobacteria" --out <download_dir>
    ```

## Expert Tips and Best Practices

*   **Incremental Updates**: Instead of rebuilding an index from scratch, use the `update` command to add new genomes to an existing SBT. This saves significant computational time.
*   **Memory Management**: When sketching, pay attention to the Bloom filter size (`-f` or `--filter-size`). Larger filters reduce false positives but increase memory usage and disk space.
*   **Taxonomy Awareness**: Ensure your taxonomy file follows the expected MetaSBT format (typically a tab-separated file mapping genome IDs to full taxonomic paths) to enable accurate "taxonomy-aware" searches.
*   **Kraken Integration**: If you prefer k-mer based classification, use `metasbt kraken` to build a custom Kraken2-compatible database directly from your MetaSBT index.
*   **Compression**: Use `metasbt pack` to create portable, compressed versions of your custom databases for sharing or archiving.

## Reference documentation
- [MetaSBT GitHub README](./references/github_com_cumbof_MetaSBT.md)
- [MetaSBT Wiki Home](./references/github_com_cumbof_MetaSBT_wiki.md)
- [Bioconda MetaSBT Overview](./references/anaconda_org_channels_bioconda_packages_metasbt_overview.md)
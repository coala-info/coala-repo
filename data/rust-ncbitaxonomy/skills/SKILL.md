---
name: rust-ncbitaxonomy
description: The rust-ncbitaxonomy suite provides high-performance tools for managing NCBI Taxonomy data and filtering genomic files based on taxonomic lineages. Use when user asks to initialize a local taxonomy database, perform taxonomic lookups, calculate distances between taxa, or filter RefSeq and FASTQ files to retain specific taxonomic branches.
homepage: https://github.com/pvanheus/ncbitaxonomy
---

# rust-ncbitaxonomy

## Overview

The `rust-ncbitaxonomy` suite provides a high-performance Rust-based toolkit for managing and querying NCBI Taxonomy data locally. By converting the standard NCBI `taxdump` files into a structured SQLite database, it enables fast, offline access to taxonomic relationships. This skill is particularly valuable for bioinformatics pipelines that require filtering genomic data (like RefSeq or classified FASTQ reads) to retain only specific taxonomic branches, or for calculating distances between taxa without relying on external API calls.

## Core Utilities and Usage

### 1. Database Management (`taxonomy_util`)
Before using the filtering tools, you must initialize a local SQLite database from the NCBI FTP taxdump files (`taxdump.zip` or `taxdump.tar.gz`).

*   **Create SQLite DB**: 
    `taxonomy_util to_sqlite --db <output_db_url>`
*   **Taxonomic Lookups**:
    *   Find ID by name: `taxonomy_util get_id <name>`
    *   Find name by ID: `taxonomy_util get_name <taxid>`
    *   Get full lineage: `taxonomy_util get_lineage <name>`
*   **Tree Analysis**:
    *   Calculate distance to common ancestor: `taxonomy_util common_ancestor_distance <taxid1> <taxid2>`

### 2. Filtering RefSeq FASTA Files (`taxonomy_filter_refseq`)
Use this tool to subset a RefSeq FASTA file so it only contains sequences belonging to a specific ancestor's lineage.

*   **Basic Filter**:
    `taxonomy_filter_refseq -d <db_url> <input_fasta> <ancestor_name> <output_fasta>`
*   **Refining Selection**:
    *   Exclude curated accessions (NM_, NR_, NP_): `--no_curated`
    *   Exclude predicted accessions (XM_, XR_, XP_): `--no_predicted`

### 3. Filtering FASTQ Files (`taxonomy_filter_fastq`)
This tool filters FASTQ files based on classification reports from Kraken2 or Centrifuge, retaining only reads that descend from a specified ancestor.

*   **Kraken2 Filtering**:
    `taxonomy_filter_fastq --kraken2 -A <ancestor_id> -F <kraken_report> <input_fastq>`
*   **Centrifuge Filtering**:
    `taxonomy_filter_fastq --centrifuge -A <ancestor_id> -F <centrifuge_report> <input_fastq>`
*   **Output Management**:
    Use `-d` or `--output_dir` to specify where the filtered FASTQ files should be saved.

## Best Practices
*   **Database URL**: The tools typically expect a URL format for the SQLite database. If using a local file, ensure the path is correctly formatted (e.g., `sqlite:///path/to/taxonomy.sqlite`).
*   **Environment Variables**: You can define `DATABASE_URL` in a `.env` file to avoid passing the `--db` flag repeatedly.
*   **Performance**: For large-scale filtering, ensure the SQLite database is stored on a fast disk (SSD) to minimize I/O bottlenecks during lineage lookups.



## Subcommands

| Command | Description |
|---------|-------------|
| taxonomy_filter_fastq | Filter FASTQ files whose reads have been classified by Centrifuge or Kraken2, only retaining reads in taxa descending from given ancestor |
| taxonomy_filter_refseq | Filter NCBI RefSeq FASTA files by taxonomic lineage |
| taxonomy_util | Utilities for working with the NCBI taxonomy database |

## Reference documentation
- [NCBI Taxonomy Rust Crate README](./references/github_com_pvanheus_ncbitaxonomy_blob_master_README.md)
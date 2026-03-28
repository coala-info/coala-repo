---
name: locidex
description: Locidex is a search engine and allele-calling tool designed for bacterial genomics and public health surveillance. Use when user asks to build genomic databases, search for loci within assemblies, extract sequence regions, or generate merged allele profiles for phylogenetic analysis.
homepage: https://pypi.org/project/locidex/
---

# locidex

## Overview

Locidex is a specialized search engine and allele-calling tool designed for bacterial genomics and public health surveillance. It provides a robust framework for identifying target sequences within genomic assemblies to facilitate phylogenetic analysis and phenotype prediction (such as serotyping or AMR detection). 

A key innovation of Locidex is its use of MD5 cryptographic hashes to generate decentralized allele identifiers. This allows different laboratories to compare genetic similarity without a centralized authority issuing allele numbers, ensuring interoperability while maintaining data privacy. The tool is built to be HPC-compatible, avoiding file-locking issues during parallel processing.

## Core Workflows and CLI Usage

Locidex operates through several functional modules. The typical workflow involves building a database, searching query sequences, and generating reports or merged profiles.

### 1. Database Management
Before searching, you must have a Locidex database.
- **build**: Used to construct a new database from reference sequences.
- **manifest**: Use this module to manage and track multiple databases across different species or typing schemes.
- **format**: Standardizes input data for database construction.

### 2. Search and Extraction
- **search**: Performs similarity searching using the BLAST interface. It identifies loci within your assembly or contig input.
- **extract**: Pulls specific sequence regions of interest from the input data based on search hits. This is useful for de novo annotations or when working with unannotated contigs.

### 3. Reporting and Analysis
- **report**: Generates a structured analysis of the search results. 
    - **Expert Tip**: Always check the quality metrics included in the report (v0.4.0+) to validate the confidence of allele calls.
- **merge**: Aggregates results from multiple samples into a single profile (e.g., `profile.tsv`).
    - **Profile Referencing**: Use `--profile_ref` or `-p` to correct or change the profile used in the output based on an MLST profile key.
    - **Loci Selection**: You can select specific loci to include in the final `profile.tsv` output to reduce noise or focus on specific markers.

## Best Practices

- **Decentralized Identification**: Favor the MD5 hashing approach when collaborating across jurisdictions. This allows for the comparison of "hamming distances" based on hashes rather than sharing raw sequence data.
- **Input Flexibility**: Locidex supports existing sequence annotations, de novo annotations from contigs, and raw sequence extraction. Choose the input method that matches your assembly quality.
- **Database Integrity**: Ensure your database directory contains the required `config.json`, `meta.json`, and the associated BLAST database files. Locidex relies on these for metadata and search logic.
- **HPC Environments**: Locidex is designed for high-throughput environments. You can trigger multiple search processes simultaneously without encountering the database locking issues common in other typing tools.



## Subcommands

| Command | Description |
|---------|-------------|
| locidex build | Build a locidex database |
| locidex manifest | Create a multi-database folder manifest |
| locidex_extract | Extract loci from a genome based on a locidex database |
| locidex_format | Format fasta files from other MLST databases for use with locidex build |
| locidex_merge | Merge a set of gene profiles into a standard profile format |
| locidex_report | Filter a sequence store and produce and extract of blast results and gene profile |
| locidex_search | Query set of Loci/Genes against a database to produce a sequence store for downstream processing |

## Reference documentation
- [Locidex Main Documentation](./references/github_com_phac-nml_locidex_blob_main_README.md)
- [Locidex Changelog and Version Features](./references/github_com_phac-nml_locidex_blob_main_CHANGELOG.md)
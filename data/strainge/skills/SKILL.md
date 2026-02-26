---
name: strainge
description: Strainge performs high-resolution identification and genomic variation analysis of microbial strains within metagenomic samples. Use when user asks to identify reference strains, profile genomic variation, call SNPs, or create k-mer databases for strain analysis.
homepage: The package home page
---


# strainge

## Overview
The `strainge` tool suite is designed for high-resolution analysis of microbial strains within complex metagenomic samples. It excels at identifying which specific strains are present in a sample and characterizing their genomic variation relative to reference genomes. It is particularly effective for detecting low-abundance strains that might be missed by broader taxonomic profilers.

## Core Workflows

### 1. Strain Identification (straingst)
Use `straingst` to identify the closest reference strains in a metagenomic sample using a k-mer based approach.

*   **Database Construction**: Before running identification, a k-mer database must be created from reference genomes.
    ```bash
    straingst make -o genome_db.hdf5 reference_genomes/*.fasta
    ```
*   **Running Identification**:
    ```bash
    straingst run -d genome_db.hdf5 sample_reads.fastq.gz > identification_results.tsv
    ```

### 2. Strain Profiling and SNP Calling (straingr)
Once a reference strain is identified, use `straingr` to perform detailed alignment-based profiling.

*   **Indexing**: Index the reference genome.
    ```bash
    straingr index reference.fasta
    ```
*   **Alignment and Analysis**: Map reads to the reference and calculate statistics.
    ```bash
    straingr align reference.fasta sample_1.fastq.gz sample_2.fastq.gz | straingr call reference.fasta -o sample_profile.hdf5
    ```
*   **Summary Statistics**: Extract human-readable metrics (coverage, identity, etc.) from the HDF5 output.
    ```bash
    straingr stats sample_profile.hdf5 > stats.tsv
    ```

## Best Practices
*   **Input Quality**: Ensure adapters are trimmed and low-quality reads are filtered before running `straingst` to reduce k-mer noise.
*   **Resource Management**: `straingst` database files (HDF5) can be large; ensure sufficient RAM is available when loading comprehensive databases.
*   **Multi-sample Analysis**: When comparing strains across multiple samples, use the same reference database and version of `strainge` to ensure consistency in SNP calling and abundance estimates.

## Reference documentation
- [strainge Overview](./references/anaconda_org_channels_bioconda_packages_strainge_overview.md)
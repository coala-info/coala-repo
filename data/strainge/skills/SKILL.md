---
name: strainge
description: Strainge performs high-resolution identification and genomic variation analysis of microbial strains within metagenomic samples. Use when user asks to identify reference strains, profile genomic variation, call SNPs, or create k-mer databases for strain analysis.
homepage: The package home page
metadata:
  docker_image: "quay.io/biocontainers/strainge:1.3.9--py38h737be40_0"
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



## Subcommands

| Command | Description |
|---------|-------------|
| strainge | A command-line tool for analyzing and manipulating k-mer databases. |
| strainge | A command-line tool for analyzing genomic sequences. |
| strainge | A toolkit for analyzing k-mer profiles of sequencing data. |
| strainge | A toolkit for analyzing microbial genomes and metagenomes. |
| strainge | A toolkit for analyzing genomic sequences using k-mer based methods. |
| strainge | A tool for analyzing and comparing k-mer profiles of genomic sequences. |
| strainge | A toolkit for analyzing and comparing k-mer profiles of sequencing data. |
| strainge createdb | Create pan-genome database in HDF5 format from a list of k-merized strains. |
| strainge kmerize | K-merize a given reference sequence or a sample read dataset. |
| strainge kmersim | Compare k-mer sets with each other. Both all-vs-all and one-vs-all is supported. |
| strainge plot | Generate plots for a given k-mer set. |
| strainge tree | Build an approximate phylogenetic tree based on a given distance matrix, using neighbour joining. Because our pairwise distances are pretty rough (especially at lower coverages), the triangle inequality may not hold, and the resulting tree may not be accurate. |
| strainge_cluster | Group k-mer sets that are very similar to each other together. |
| strainge_compare | Compare strains and variant calls in two different samples. Reads of both samples must be aligned to the same reference. |
| strainge_stats | Obtain statistics about a given k-mer set. |
| strainge_view | View call statistics stored in a HDF5 file and output results to different file formats |

## Reference documentation
- [strainge Overview](./references/anaconda_org_channels_bioconda_packages_strainge_overview.md)
---
name: obitools
description: OBITools is a suite of command-line utilities designed for the management and analysis of large-scale DNA metabarcoding data. Use when user asks to align paired-end reads, demultiplex samples, dereplicate sequences, filter for quality, or perform taxonomic assignment.
homepage: http://metabarcoding.org/obitools
metadata:
  docker_image: "quay.io/biocontainers/obitools:1.2.13--py27h516909a_0"
---

# obitools

## Overview
The OBITools package provides a comprehensive Unix-style command-line interface for the management of sequence data from the initial cleaning of raw reads to the final taxonomic identification. It is particularly effective for handling large-scale metabarcoding datasets where sequences must be matched against reference databases while accounting for PCR errors and sequencing artifacts.

## Core Workflow Patterns

### 1. Data Preprocessing and Quality Control
*   **Paired-end Alignment**: Use `illuminapairedend` to align forward and reverse reads.
    ```bash
    illuminapairedend -r reverse_reads.fastq forward_reads.fastq > aligned.fastq
    ```
*   **Filtering by Quality**: Use `obigrep` to remove sequences with low alignment scores or ambiguous bases.
    ```bash
    obigrep -p 'mode!="joined"' -s '^[ACGT]+$' aligned.fastq > filtered.fastq
    ```

### 2. Sample Demultiplexing
*   **Barcode Identification**: Use `ngsfilter` to assign sequences to samples based on a configuration file (containing primers and tags).
    ```bash
    ngsfilter -t sample_config.txt -u unidentified.fastq filtered.fastq > demultiplexed.fastq
    ```

### 3. Sequence Dereplication and Cleaning
*   **Dereplication**: Use `obiuniq` to group identical sequences and keep track of their abundance.
    ```bash
    obiuniq -m sample demultiplexed.fastq > dereplicated.fasta
    ```
*   **Denoising**: Use `obiclean` to identify and remove PCR errors (variants) based on a head/internal/singleton classification.
    ```bash
    obiclean -s sample -r 0.05 -d 1 dereplicated.fasta > cleaned.fasta
    ```

### 4. Taxonomic Assignment
*   **Reference Matching**: Use `ecotag` to assign taxonomy by comparing sequences against a reference database (formatted for OBITools).
    ```bash
    ecotag -d reference_db -R reference.fasta cleaned.fasta > assigned.fasta
    ```

## Expert Tips
*   **Attribute Management**: OBITools stores metadata in the header line of FASTA/FASTQ files using a specific key=value format. Use `obiannotate` to add, delete, or modify these attributes without external scripts.
*   **Pipe Efficiency**: Since OBITools commands read from stdin and write to stdout, chain commands together to avoid creating massive intermediate files.
*   **Memory Handling**: For very large datasets, ensure the `obiuniq` step is performed early to reduce the number of unique sequences processed in downstream taxonomic assignments.

## Reference documentation
- [OBITools Overview](./references/anaconda_org_channels_bioconda_packages_obitools_overview.md)
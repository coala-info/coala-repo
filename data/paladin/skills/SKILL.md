---
name: paladin
description: PALADIN (Protein ALignment And Detection INterface) is a specialized alignment tool designed for metagenomic functional analysis.
homepage: https://github.com/ToniWestbrook/paladin
---

# paladin

## Overview

PALADIN (Protein ALignment And Detection INterface) is a specialized alignment tool designed for metagenomic functional analysis. Unlike standard nucleotide aligners, PALADIN performs alignments in protein space using the Burrows-Wheeler Transform (BWT). It streamlines the workflow by automatically detecting Open Reading Frames (ORFs) in nucleotide reads, translating them, and mapping them against protein references. This approach often provides higher sensitivity and accuracy for functional annotation compared to tools like BLASTX or DIAMOND.

## Core Workflows

### 1. Reference Preparation
Before alignment, you must index your reference database. PALADIN provides two distinct commands for this:

*   **`paladin prepare`**: Use this for UniProt-formatted references (Swiss-Prot or UniRef). This is required if you want PALADIN to generate a detailed functional TSV report.
    *   `paladin prepare -r1` (Downloads and indexes Swiss-Prot)
    *   `paladin prepare -r2` (Downloads and indexes UniRef90)
*   **`paladin index`**: Use this for custom protein FASTA files where a UniProt-style report is not needed, or for nucleotide references with GTF/GFF annotations.
    *   `paladin index -r3 reference.fasta`

### 2. Sequence Alignment
The `align` command is the primary tool for mapping reads. Note that PALADIN currently only supports single-end or merged reads.

*   **Basic Alignment**:
    `paladin align -t 8 -o output_prefix reference.fasta reads.fastq.gz`
*   **Generate BAM Output**:
    `paladin align -t 8 reference.fasta reads.fastq.gz | samtools view -Sb - > output.bam`
*   **High-Confidence Mapping**:
    Increase the minimum score threshold to prefer quality over quantity:
    `paladin align -T 20 -o output_prefix reference.fasta reads.fastq.gz`

## Expert Tips and Best Practices

*   **Filtering for Noise**: PALADIN reports many potential mappings. Always filter your results by **Maximum Mapping Quality**. A high maximum mapping quality in the TSV report indicates that at least one ORF mapped with high confidence, whereas low values often represent noise.
*   **UniProt Integration**: To get the most out of PALADIN, use the `prepare` command with UniProt databases. This enables the generation of a tabular report containing Organism, Gene Names, Pathways, and GO terms.
*   **Memory Management**: When running `paladin prepare -r2` (UniRef90), ensure the system has significant RAM (typically 32GB+), as indexing large protein databases is memory-intensive.
*   **BWA Compatibility**: Since PALADIN is based on BWA-MEM, it accepts many standard BWA command-line arguments for fine-tuning alignment parameters (e.g., gap penalties, clipping).
*   **Input Types**: While optimized for metagenomic DNA, PALADIN supports transcript (ribo-depleted) or direct protein inputs. Ensure you adjust your expectations for ORF detection when using non-genomic DNA inputs.

## Reference documentation
- [PALADIN GitHub README](./references/github_com_ToniWestbrook_paladin.md)
- [PALADIN Wiki](./references/github_com_ToniWestbrook_paladin_wiki.md)
- [Bioconda Paladin Package](./references/anaconda_org_channels_bioconda_packages_paladin_overview.md)
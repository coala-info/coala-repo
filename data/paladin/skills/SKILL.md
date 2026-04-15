---
name: paladin
description: PALADIN aligns metagenomic sequencing reads to protein reference databases by detecting and translating open reading frames. Use when user asks to index protein references, align reads to protein databases, or perform functional characterization of metagenomic samples.
homepage: https://github.com/ToniWestbrook/paladin
metadata:
  docker_image: "quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0"
---

# paladin

## Overview

PALADIN (Protein ALignment And Detection INterface) is a specialized alignment tool designed for the functional characterization of metagenomic samples. Unlike standard nucleotide aligners, PALADIN operates in protein space by detecting Open Reading Frames (ORFs) in sequencing reads, translating them, and aligning them against protein reference databases using the Burrows-Wheeler Transform (BWT). This approach is optimized for accuracy in functional profiling, often outperforming tools like BLASTX or DIAMOND in specific metagenomic contexts. It is particularly powerful when used with UniProt databases, as it can automatically download references and generate detailed characterization reports.

## Core Command Patterns

### 1. Reference Preparation
Before alignment, references must be indexed. PALADIN distinguishes between "preparing" (for UniProt-formatted data) and "indexing" (for general protein FASTA).

*   **Download and Index UniProt Swiss-Prot:**
    `paladin prepare -r1`
*   **Download and Index UniProt UniRef90:**
    `paladin prepare -r2`
*   **Index a Custom Protein FASTA:**
    `paladin index -r3 custom_proteins.fasta`
    *Note: Use `prepare` if you want the detailed UniProt TSV report; use `index` if you only need SAM output.*

### 2. Alignment Workflows
PALADIN currently supports single-end or merged reads.

*   **Standard Alignment with UniProt Report:**
    `paladin align -t 4 -o output_prefix reference_index input.fastq.gz`
    *This generates `output_prefix.sam` and `output_prefix.tsv`.*
*   **Direct to BAM Output:**
    `paladin align -t 4 reference_index input.fastq.gz | samtools view -Sb - > output.bam`
*   **Reporting Secondary Alignments:**
    `paladin align -a -o output_prefix reference_index input.fastq.gz`

## Expert Tips and Best Practices

*   **Quality Filtering:** PALADIN mappings can include noise. Always filter results by mapping quality. Use the `-T` flag to set a minimum score (e.g., `-T 20`) to prefer higher confidence mappings over raw quantity.
*   **UniProt Integration:** To get the most out of PALADIN, use the `prepare` command with UniProt references. This enables the generation of the tabular (.tsv) report containing UniProtKB IDs, Organism names, Gene Ontology (GO) terms, and KEGG pathways.
*   **Memory Management:** Indexing large databases like UniRef90 requires significant RAM. If the process fails, ensure the system has sufficient memory or use the smaller Swiss-Prot (`-r1`) database.
*   **ORF Detection:** PALADIN performs ORF detection automatically. If working with transcript data (ribo-depleted or poly-A selected) or direct protein inputs, be aware that ORF detection logic is modified or disabled accordingly.
*   **BWA Compatibility:** Since PALADIN is based on BWA-MEM, many standard BWA command-line arguments are supported and can be used to fine-tune the alignment process.

## Output Format (TSV Report)
The UniProt report includes high-utility columns for functional analysis:
1.  **Count/Abundance:** Quantitative mapping data.
2.  **Quality (Avg/Max):** Mapping confidence metrics.
3.  **Functional Metadata:** UniProtKB ID, Protein Names, Pathways, and Gene Ontology.



## Subcommands

| Command | Description |
|---------|-------------|
| bwa fa2pac | Convert FASTA to PAC format |
| bwa shm | Manage indices in shared memory |
| paladin align | Protein alignment tool for functional profiling of metagenomes |
| paladin bwt2sa | Generate a suffix array (.sa) from a BWT index (.bwt) using PALADIN |
| paladin bwtupdate | Update a BWT index for PALADIN |
| paladin index | Index a reference genome or transcriptome for PALADIN alignment |
| paladin pac2bwt | Generate a BWT from a PAC file using PALADIN |
| paladin prepare | Prepare a reference database for PALADIN by downloading or using a local copy. |

## Reference documentation
- [PALADIN Main Documentation](./references/github_com_ToniWestbrook_paladin.md)
- [PALADIN Wiki Home](./references/github_com_ToniWestbrook_paladin_wiki.md)
- [File and Test Organization](./references/github_com_ToniWestbrook_paladin_wiki_File-and-Test-Organization.md)
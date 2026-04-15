---
name: bismark
description: Bismark maps bisulfite-converted sequencing reads to a reference genome and determines the methylation state of cytosines. Use when user asks to prepare a bisulfite-converted reference genome, align bisulfite-treated reads, deduplicate alignment files, or extract methylation calls.
homepage: https://github.com/FelixKrueger/Bismark/
metadata:
  docker_image: "quay.io/biocontainers/bismark:0.25.1--hdfd78af_0"
---

# bismark

## Overview

Bismark is a specialized toolset designed to map bisulfite-converted sequencing reads to a reference genome and determine the methylation state of cytosines. Because bisulfite treatment converts unmethylated cytosines to uracil (read as thymine during sequencing), Bismark performs in silico conversions of both the reference genome and the sequencing reads to facilitate accurate alignment. It supports single-end and paired-end reads and integrates with aligners like Bowtie2, HISAT2, and minimap2.

## Core Workflow and CLI Patterns

### 1. Genome Preparation
Before alignment, the reference genome must be bisulfite-converted and indexed. This creates two folders within the genome directory: one for a C->T converted version and one for a G->A converted version.

```bash
bismark_genome_preparation --bowtie2 /path/to/genome/
```
*   **Tip**: Ensure the directory contains only the fasta files for the target genome.
*   **Note**: You must specify the aligner (e.g., `--bowtie2` or `--hisat2`).

### 2. Read Alignment
Align the bisulfite-treated reads to the prepared reference. Bismark automatically handles the multi-step alignment process.

**Single-end reads:**
```bash
bismark --bowtie2 /path/to/genome/ sample.fastq.gz
```

**Paired-end reads:**
```bash
bismark --bowtie2 -1 sample_R1.fastq.gz -2 sample_R2.fastq.gz /path/to/genome/
```

*   **Multicore usage**: Use `--multicore <int>` to increase speed. Note that Bismark is resource-intensive; each core typically uses multiple threads of the underlying aligner.
*   **Alignment modes**: Bismark supports gapped, ungapped, and spliced alignments depending on the chosen aligner.

### 3. Deduplication
For standard whole-genome bisulfite sequencing (WGBS), PCR duplicates should be removed to avoid biased methylation calls.

```bash
# For single-end
deduplicate_bismark -s sample_bismark_bt2.bam

# For paired-end
deduplicate_bismark -p sample_bismark_bt2.bam
```
*   **Exception**: Do NOT deduplicate for RRBS (Reduced Representation Bisulfite Sequencing) or libraries where reads are expected to have the same start/end coordinates.

### 4. Methylation Extraction
Extract the methylation call for every cytosine analyzed. This produces strand-specific output files and a comprehensive report.

```bash
bismark_methylation_extractor --gzip --bedGraph --counts --buffer_size 10G sample.deduplicated.bam
```
*   **--bedGraph**: Produces a file suitable for genome viewers (e.g., SeqMonk, IGV).
*   **--cytosine_report**: Generates a report for every single cytosine in the genome, even those not covered by reads (requires genome path).
*   **--comprehensive**: Merges results from different strands into a single file for each context (CpG, CHG, CHH).

### 5. Report Generation
Generate visual HTML reports to assess the quality of the alignment and methylation extraction.

```bash
# Create a report for a specific sample
bismark2report

# Create a summary report for multiple samples in a directory
bismark2summary
```

## Expert Tips and Best Practices

*   **Memory Management**: When using `--multicore`, ensure the system has enough RAM (approx. 4GB per core for Bowtie2 on a human genome).
*   **Non-CG Methylation**: Bismark is one of the few tools that explicitly discriminates between CpG, CHG, and CHH contexts. Use the `CHG` and `CHH` output files to study non-canonical methylation in plants or specific mammalian tissues (like brain or oocytes).
*   **Library Type**: If using a non-directional library (e.g., PBAT), you must specify `--non_directional` during the alignment step. The default is directional.
*   **Output Formats**: The primary output is a BAM file. Use `samtools` for further manipulation, but always use Bismark's native tools for the initial methylation calls to ensure the bisulfite logic is correctly applied.

## Reference documentation
- [Bismark GitHub Repository](./references/github_com_FelixKrueger_Bismark.md)
- [Bismark Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bismark_overview.md)
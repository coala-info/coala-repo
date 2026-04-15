---
name: zga
description: ZGA automates the entire process of bacterial and archaeal genome assembly and annotation from raw sequencing reads. Use when user asks to perform end-to-end genome assembly and annotation, perform hybrid or long-read only assembly, annotate an existing genome, preprocess sequencing reads, manage memory usage, merge paired-end reads, perform fast read correction, or specify the genomic domain.
homepage: https://github.com/laxeye/zga
metadata:
  docker_image: "quay.io/biocontainers/zga:0.1.1--pyhdfd78af_0"
---

# zga

## Overview
ZGA is a streamlined pipeline designed for bacterial and archaeal genomics. It automates the transition from raw reads to annotated genomes, integrating popular tools like fastp, SPAdes, and CheckM into a single workflow. It is particularly useful for researchers needing a "one-stop" command-line solution that runs on standard hardware without requiring high-performance computing clusters.

## Installation and Setup
ZGA is primarily distributed via Bioconda. Before running the pipeline for the first time, ensure the annotation database is initialized.

```bash
# Installation
conda install bioconda::zga

# Required: Download Bakta database (light or full)
bakta_db download --output <path> --type light
```

## Core CLI Patterns

### Standard End-to-End Assembly
To perform QC, trimming, assembly, quality assessment, and annotation in one command:
`zga -1 R1.fastq.gz -2 R2.fastq.gz --threads 8 -o output_dir`

### Hybrid Assembly
ZGA supports hybrid assembly by combining short and long reads. Use the `-a spades` (default) or `-a unicycler` for these workflows:
`zga -1 R1.fq.gz -2 R2.fq.gz --nanopore long_reads.fq.gz -a spades -o hybrid_output`

### Long-Read Only Assembly
For Oxford Nanopore or PacBio data, Flye is the recommended assembler:
`zga --nanopore reads.fq.gz -a flye -o long_read_output`

### Resuming or Running Specific Steps
Use `-s` (first step) and `-l` (last step) to control the pipeline flow. Available steps: `readqc`, `preprocessing`, `assembling`, `polishing`, `check_genome`, `annotation`.

*   **Annotation only** (starting from an existing assembly):
    `zga --first-step annotation --assembly existing_contigs.fasta -o annotation_results`
*   **Preprocessing only**:
    `zga -1 R1.fq.gz -2 R2.fq.gz --last-step preprocessing -o clean_reads`

## Expert Tips and Best Practices

*   **Memory Management**: On systems with limited RAM, use `--memory-limit <GB>` to prevent SPAdes or other assemblers from crashing the system.
*   **Read Merging**: For Illumina paired-end data with significant overlap, use the `--bbmerge` flag to improve assembly quality by merging pairs before assembly.
*   **Fast Correction**: If SPAdes read correction is too slow, use `--tadpole-correct`. It uses a k-mer based approach that is significantly faster and less memory-intensive.
*   **Domain Specificity**: Always specify `--domain archaea` if working with archaeal genomes to ensure CheckM uses the correct marker sets for quality assessment.
*   **Flye Polishing**: When using Flye for long reads, you can toggle polishing behavior with `--flye-short-polish` (requires short reads) or `--flye-skip-long-polish`.

## Reference documentation
- [ZGA GitHub Repository](./references/github_com_laxeye_zga.md)
- [ZGA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_zga_overview.md)
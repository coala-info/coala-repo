---
name: srnapipe
description: sRNAPipe is a pipeline for the bioinformatic exploration and profiling of small RNA-seq datasets. Use when user asks to align small RNA reads to a reference genome, categorize reads by size and genomic origin, or identify ping-pong signatures.
homepage: https://github.com/GReD-Clermont/sRNAPipe-cli
metadata:
  docker_image: "quay.io/biocontainers/srnapipe:1.2.1--pl5321r44hdfd78af_0"
---

# srnapipe

## Overview

sRNAPipe is a specialized pipeline for the bioinformatic exploration of small RNA-seq datasets. It automates the alignment of reads against a reference genome and various annotation sets (transposable elements, miRNAs, rRNAs, etc.) to provide a comprehensive profile of the small RNA landscape. It is particularly effective for researchers analyzing silencing pathways, as it includes specific logic for identifying ping-pong signatures and categorizing reads by size and genomic origin.

## Core Usage

The basic execution requires defining input FASTQ files, a reference genome, and various annotation files.

```bash
srnapipe \
  --fastq sample1.fastq --fastq_n Sample_A \
  --ref genome.fa --build_index \
  --TE te_sequences.fa --build_TE \
  --miRNAs mirna.fa --build_miRNAs \
  --dir ./results \
  --html report.html
```

### Handling Multiple Samples
You can process multiple libraries in a single run by repeating the `--fastq` and `--fastq_n` arguments.
- `--fastq <file>`: Path to the FASTQ file.
- `--fastq_n <name>`: A descriptive label for the sample used in reports.

### Reference Indexing
For every FASTA file provided (genome, TE, rRNAs, etc.), sRNAPipe requires a BWA index. 
- If indices do not exist, append the corresponding `--build_[element]` flag (e.g., `--build_index`, `--build_transcripts`, `--build_TE`).
- If indices are already present in the same directory as the FASTA files, these flags can be omitted to save time.

## Parameter Tuning

### Read Size Selection
Define the global bounds for the analysis. Reads outside this range are typically discarded.
- `--min <INT>`: Minimum read size (default: 18).
- `--max <INT>`: Maximum read size (default: 29).

### Small RNA Species Definition
Customize the size ranges for specific small RNA types to match your organism's biology:
- **siRNAs**: `--si_min` and `--si_max` (default: 21 for both).
- **piRNAs**: `--pi_min` and `--pi_max` (default: 23 to 29).

### Alignment Sensitivity
- `--mis <INT>`: Maximum mismatches allowed for genome alignment (default: 0).
- `--misTE <INT>`: Maximum mismatches allowed for Transposable Element alignment (default: 3).
- `--PPPon <true|false>`: Enable or disable Ping-Pong Partner analysis (default: true).

## Expert Tips and Best Practices

- **Use Absolute Paths**: A known limitation in the current version requires all FASTA file paths to be absolute. Relative paths may cause the pipeline to fail during the alignment phase.
- **Performance Optimization**: Use the `--threads <INT>` option to enable parallel processing, which significantly reduces the time required for BWA alignment and data parsing.
- **Memory Management**: When building indices for large genomes, ensure the environment has sufficient RAM for `bwa index`.
- **Output Organization**: The directory specified by `--dir` will contain numerous intermediate files and subdirectories. Always specify a clean or dedicated directory to avoid file collisions.
- **HTML Reports**: The `--html` argument defines the name of the master report. Ensure this file is kept in the same relative location as the `--dir` folder, as the HTML report relies on relative links to assets within the results directory.

## Reference documentation
- [sRNAPipe-cli README](./references/github_com_GReD-Clermont_sRNAPipe-cli.md)
- [Known Issues - Absolute Paths](./references/github_com_GReD-Clermont_sRNAPipe-cli_issues.md)
- [Version History and Threading](./references/github_com_GReD-Clermont_sRNAPipe-cli_commits_main.md)
---
name: karect
description: Karect is a bioinformatics tool designed to correct substitution, insertion, and deletion errors in Next-Generation Sequencing reads. Use when user asks to fix errors in raw sequencing data, align reads to a reference genome for evaluation, or calculate error correction accuracy statistics.
homepage: https://github.com/aminallam/karect
---


# karect

## Overview
Karect (KAUST Assembly Read Error Correction Tool) is a specialized bioinformatics utility designed to enhance the reliability of Next-Generation Sequencing (NGS) data. While many error correction tools focus primarily on substitution errors, Karect is engineered to handle insertions and deletions (indels) as well. It serves as a critical preprocessing step, reducing noise in raw reads to produce higher-quality genome assemblies.

## Installation and Setup
To build the tool from the source repository:
1. Extract the source archive: `tar -xzf karect.tar.gz`
2. Enter the directory: `cd karect`
3. Compile the executable: `make`

## Core Workflows

### Error Correction
Use the `-correct` mode to fix errors in raw sequencing files.
```bash
./karect -correct -threads=12 -matchtype=hamming -celltype=haploid -inputfile=reads_1.fastq -inputfile=reads_2.fastq
```
*   **Output**: By default, corrected files are generated in the same directory with a `karect_` prefix (e.g., `karect_reads_1.fastq`).
*   **Multi-file support**: You can specify multiple `-inputfile` flags for paired-end data or multiple libraries.

### Evaluation Workflow
If a reference genome is available, you can evaluate the tool's performance using a two-step process.

**1. Align original reads to the reference**
```bash
./karect -align -threads=12 -matchtype=hamming -inputfile=orig_1.fastq -refgenomefile=genome.fasta -alignfile=align.txt
```

**2. Run the evaluation**
```bash
./karect -eval -threads=12 -matchtype=hamming -inputfile=orig_1.fastq -resultfile=karect_orig_1.fastq -refgenomefile=genome.fasta -alignfile=align.txt -evalfile=eval.txt
```

## Command Line Reference
- `-correct`: Executes the error correction algorithm.
- `-align`: Aligns original reads to a reference genome to create an alignment map for evaluation.
- `-eval`: Compares corrected reads against the original alignment and reference genome to produce accuracy statistics.
- `-inputfile=[path]`: Specifies the input FASTA or FASTQ file.
- `-resultfile=[path]`: Specifies the corrected file to be evaluated (used in `-eval` mode).
- `-refgenomefile=[path]`: Specifies the reference genome file in FASTA format.
- `-threads=[int]`: Sets the number of CPU threads for parallel processing.
- `-matchtype=[type]`: Defines the matching algorithm (e.g., `hamming`).
- `-celltype=[type]`: Defines the organism's ploidy (e.g., `haploid`).

## Expert Tips
- **Memory Management**: For large datasets, ensure the system has sufficient RAM, as assembly read correction is computationally intensive.
- **Thread Optimization**: Always set `-threads` to match your hardware capabilities to significantly reduce processing time.
- **Input Formats**: Karect natively handles both FASTA and FASTQ formats. Ensure your input files are decompressed (using `gunzip`) before running the tool if they are in `.gz` format.



## Subcommands

| Command | Description |
|---------|-------------|
| karect | A suite of tools for assembly read correction, alignment, evaluation, and merging. |
| karect | A suite of tools for correcting assembly reads, aligning reads, evaluating corrections, and merging files. |
| karect | A suite of tools for assembly read correction, alignment, evaluation, and merging. |
| karect | A suite of tools for assembly evaluation and correction. |

## Reference documentation
- [Karect GitHub Repository](./references/github_com_aminallam_karect.md)
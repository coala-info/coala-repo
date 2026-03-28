---
name: snap-aligner
description: snap-aligner is a high-performance genomic aligner that maps nucleotide sequences to a reference genome using hash-based indexing. Use when user asks to index a reference genome, align single-end or paired-end reads, and perform post-alignment processing like sorting or marking duplicates.
homepage: http://snap.cs.berkeley.edu/
---

# snap-aligner

## Overview
SNAP (Scalable Nucleotide Alignment Program) is a high-performance genomic aligner optimized for modern sequencing read lengths. By leveraging hash-based indexing and large system memory, it achieves speeds significantly faster than traditional tools like BWA-mem2 or Bowtie2. Its primary advantage is the integration of post-alignment processing—such as sorting, indexing, and marking duplicates—directly into the alignment executable, which drastically reduces I/O overhead and total pipeline wall-clock time.

## Command Line Usage

### 1. Genome Indexing
Before alignment, create a hash table index from a FASTA reference.
```bash
snap-aligner index <reference.fa> <index_directory> [options]
```
- **Tip**: Indexing the human genome requires approximately 40-50 GB of RAM.
- **Options**: Use `-s` to specify seed size (default is 20; larger seeds increase speed but may reduce sensitivity).

### 2. Paired-End Alignment
Align paired FASTQ files and produce a sorted, duplicate-marked BAM file.
```bash
snap-aligner paired <index_directory> <read1.fastq> <read2.fastq> -o <output.bam> [options]
```
- **Essential Flags**:
  - `-t <threads>`: Specify CPU cores (SNAP auto-detects, but explicit setting is safer in HPC environments).
  - `-so`: Sort the output by alignment location.
  - `-d`: Mark duplicate reads during the alignment process.
  - `-X`: Indicate that the input is already filtered/compressed (e.g., .gz).

### 3. Single-End Alignment
```bash
snap-aligner single <index_directory> <reads.fastq> -o <output.bam> [options]
```

### 4. Working with SAM/BAM Inputs
SNAP can take existing SAM/BAM files as input to re-align or process them.
```bash
snap-aligner paired <index_directory> <input.bam> -o <output.bam>
```

## Expert Tips and Best Practices

- **Memory Management**: Ensure the host machine has at least 48GB of RAM for human genome projects. If memory is constrained, SNAP may fail to load the index.
- **Read Length**: SNAP is specifically optimized for reads of 100 bases or higher. For very short reads (e.g., <70bp), traditional aligners may provide better sensitivity.
- **Daemon Mode**: For high-volume environments, run SNAP in daemon mode to keep the index loaded in memory across multiple jobs.
  - Start daemon: `snap-aligner daemon`
  - Submit jobs: Use the `SNAPCommand` utility to send alignment requests to the running daemon.
- **I/O Optimization**: Since SNAP is extremely fast, the bottleneck is often disk I/O. Use SSDs for the index directory and output paths whenever possible.
- **Error Handling**: If you encounter "Bus error" or "unaligned access" on non-x86 architectures, ensure you are using the latest version or a build specifically patched for your CPU architecture.



## Subcommands

| Command | Description |
|---------|-------------|
| snap-aligner index | Build an index for the SNAP aligner. |
| snap-aligner paired | Align paired-end reads using SNAP. |
| snap-aligner single | Aligns reads to a SNAP index. |

## Reference documentation
- [SNAP GitHub Repository](./references/github_com_amplab_snap.md)
- [SNAP Project Overview - Microsoft Research](./references/www_microsoft_com_en-us_research_project_snap.md)
- [SNAP Wiki](./references/github_com_amplab_snap_wiki.md)
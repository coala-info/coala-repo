---
name: leviosam2
description: LevioSAM2 is a toolkit designed to migrate genomic alignment data and coordinates across different reference assemblies while updating full alignment records. Use when user asks to lift over SAM, BAM, or CRAM files, convert BED intervals between assemblies, or index UCSC chain files for genomic data migration.
homepage: https://github.com/milkschen/leviosam2
---

# leviosam2

## Overview
LevioSAM2 is a high-performance toolkit designed to migrate genomic data across different reference assemblies. Unlike traditional lift-over tools that only handle coordinates, LevioSAM2 updates the entire alignment record, including CIGAR strings, MD/NM tags, and mate-pair information. It utilizes a succinct index (ChainMap) built from standard UCSC chain files to enable rapid queries and multi-threaded processing.

## Core Workflow

### 1. Indexing the Chain File
Before lifting over alignments, you must generate a LevioSAM2 index (`.clft`) from a source-to-target chain file.

```bash
leviosam2 index -c source_to_target.chain -p source_to_target -F target.fai
```
- `-c`: Path to the input chain file.
- `-p`: Prefix for the output index (creates `source_to_target.clft`).
- `-F`: The `.fai` index of the target reference genome (required).

### 2. Lifting Over Alignments
The `lift` command is the primary kernel for converting SAM, BAM, or CRAM files.

```bash
leviosam2 lift -C source_to_target.clft -a aligned_to_source.bam -p lifted_from_source -O bam
```
- `-C`: Path to the `.clft` index generated in the previous step.
- `-a`: The input alignment file (SAM/BAM/CRAM).
- `-p`: Prefix for the output file.
- `-O`: Output format (sam, bam, or cram).

### 3. Lifting Over Intervals (BED)
LevioSAM2 also supports coordinate conversion for BED files (currently in beta).

```bash
leviosam2 lift -C source_to_target.clft -b input.bed -p lifted_output
```

## Expert Tips and Best Practices

- **Pre-sort Input**: Always sort your input BAM file by position (`samtools sort`) before running `leviosam2 lift`. This significantly improves performance and ensures consistency.
- **Alignment Tag Updates**: By default, LevioSAM2 updates core fields (RNAME, POS, FLAG, CIGAR). If you require updated `MD:Z` and `NM:i` tags, ensure you provide the target reference during the workflow.
- **Selective Re-mapping**: For regions with major structural differences between assemblies, use the `leviosam2.sh` workflow script. This identifies reads that cannot be lifted accurately and re-maps them to the target assembly using a standard aligner (like Bowtie2 or BWA-MEM).
- **Multithreading**: Use the `-t` flag to specify the number of threads for both indexing and lifting to reduce wall-clock time.
- **Memory Efficiency**: The `.clft` index is designed to be succinct; however, for very large genomes, ensure the system has sufficient RAM to load the index into memory.



## Subcommands

| Command | Description |
|---------|-------------|
| leviosam2 | lift over alignments using a chain file |
| leviosam2 bed | Lift over a BED file |
| leviosam2 collate | Collate alignments to make sure reads are paired |
| leviosam2 reconcile | Reconcile alignments to select the one with higher confidence |

## Reference documentation
- [LevioSAM2 README](./references/github_com_milkschen_leviosam2_blob_main_README.md)
- [Installation Guide](./references/github_com_milkschen_leviosam2_blob_main_INSTALL.md)
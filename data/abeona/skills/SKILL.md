---
name: abeona
description: Abeona is a transcriptome assembler that processes short-read RNA-seq data using a multi-stage graph traversal and quantification pipeline. Use when user asks to assemble transcripts from RNA-seq reads, construct De Bruijn graphs for transcriptomics, or generate abundance-filtered candidate transcripts.
homepage: https://github.com/winni2k/abeona
---


# abeona

## Overview

Abeona is a transcriptome assembler designed to process short-read RNA-seq data through a multi-stage graph traversal pipeline. It constructs a De Bruijn graph from input reads, prunes the graph to remove sequencing artifacts, partitions it into manageable subgraphs, and generates candidate transcripts through path traversal. Finally, it uses the kallisto pseudoaligner to filter these candidates based on abundance estimates. It is best suited for researchers looking for a lightweight assembly workflow that integrates graph theory with efficient transcript quantification.

## Installation and Setup

The recommended way to install abeona is via Conda:

```bash
conda install -c bioconda -c conda-forge abeona
```

## Command Line Usage

The primary entry point is the `abeona assemble` command.

### Basic Assembly (Single-end)
```bash
abeona assemble -k 31 -m 8 --fastx-single reads.fastq -o assembly_out
```

### Paired-end Assembly
```bash
abeona assemble -k 31 -m 16 --fastx-forward R1.fastq --fastx-reverse R2.fastq -o assembly_out
```

### Key Arguments
- `-k`, `--kmer-size`: The k-mer length for De Bruijn graph construction.
- `-m`, `--memory`: Memory limit in GB.
- `-o`, `--out-dir`: Directory for output files (default: `abeona_out`).
- `--fastx-single`: Path to single-end reads.
- `--fastx-forward` / `--fastx-reverse`: Paths to paired-end read files.
- `--kallisto-fragment-length`: Estimated average fragment length (required for single-end reads).
- `--kallisto-sd`: Standard deviation of fragment length (required for single-end reads).

## Expert Tips and Best Practices

### Graph Pruning
As of version 0.45.0, `mccortex` is used for pruning by default. 
- Use `--prune-tips-iteratively` to apply a more aggressive iterative pruning strategy, which can help resolve complex graph structures.
- If you need to disable mccortex pruning, use the `--no-prune-tips-with-mccortex` flag.

### Handling Complex Subgraphs
In datasets with high complexity or high coverage, some subgraphs may contain too many junctions, leading to long processing times.
- Use `--max-junctions <int>` to set a threshold for skipping subgraphs that exceed a specific junction count.
- Use `--no-links` to disable the use of read-links during candidate transcript creation, which can speed up the traversal process at the cost of some connectivity information.

### Output Management
By default, abeona cleans up intermediate files to save space, leaving only the final `transcripts.fa`.
- Use `--no-cleanup` if you need to inspect intermediate subgraphs, kallisto indices, or per-subgraph candidate files.
- The final output is always stored as `transcripts.fa` in the specified output directory to maintain compatibility with downstream tools like Trinity or Oases.

### Resource Allocation
Abeona uses Nextflow internally to manage the pipeline. You can control parallelism using the `--jobs` flag to specify the number of concurrent processes.

## Reference documentation
- [abeona GitHub Repository](./references/github_com_winni2k_abeona.md)
- [abeona Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_abeona_overview.md)
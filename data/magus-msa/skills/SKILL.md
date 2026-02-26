---
name: magus-msa
description: MAGUS is a piecewise alignment tool that scales high-accuracy methods to massive datasets by decomposing sequences into subsets and merging them via graph clustering. Use when user asks to align large sets of unaligned sequences, merge existing subalignments into a single multiple sequence alignment, or configure decomposition and graph clustering parameters for complex biological data.
homepage: https://github.com/vlasmirnov/MAGUS
---


# magus-msa

## Overview
MAGUS is a piecewise alignment strategy designed to scale high-accuracy base methods (like MAFFT -linsi) to massive datasets. It functions by decomposing a large sequence set into manageable subsets, aligning those subsets independently, and then merging them using a Graph Clustering Merger (GCM). This approach overcomes the computational bottlenecks of traditional MSA tools while maintaining high biological accuracy.

## Installation and Setup
The tool is available via PyPI and Bioconda.
- **Pip**: `pip install magus-msa`
- **Conda**: `conda install -c bioconda magus-msa`
- **Execution**: Once installed, the tool is typically invoked using the `magus` command.

## Core CLI Patterns

### 1. Aligning Unaligned Sequences
To perform a full alignment from scratch:
```bash
magus -i unaligned_sequences.fasta -o aligned_result.fasta -d work_dir
```
- `-i`: Path to the input FASTA file.
- `-o`: Path for the final output alignment.
- `-d`: (Recommended) Directory for intermediate files (graph, clusters, logs).

### 2. Merging Existing Subalignments
If you already have aligned subsets and wish to merge them:
```bash
magus -s path/to/subalignments/ -o merged_alignment.fasta
```
- `-s`: Directory containing subalignment files or a specific list of files.

### 3. Controlling Decomposition
For very large or specific datasets, adjust how the sequences are split:
```bash
magus -i input.fasta -t clustal --maxnumsubsets 100 --maxsubsetsize 50 -o output.fasta
```
- `-t`: Guide tree method. Use `fasttree` (default), `parttree`, `clustal` (recommended for ultra-large data), or `random`.
- `--maxnumsubsets`: Target number of subsets (default: 25).
- `--maxsubsetsize`: Stop decomposing when subsets fall below this size (default: 50).

### 4. Alignment Graph Configuration
Fine-tune the Graph Clustering Merger (GCM) phase:
```bash
magus -i input.fasta -r 10 -m 200 --graphtracemethod mwtgreedy -o output.fasta
```
- `-r`: Number of backbone alignments (default: 10).
- `-m`: Maximum size of backbones (default: 200).
- `--graphtracemethod`: Use `minclusters` (default/recommended) or `mwtgreedy` (recommended for extremely large graphs).

## Expert Tips and Best Practices
- **Avoid Over-decomposition**: Using more than 100 subalignments can significantly slow down the ordering phase, particularly with heterogeneous data.
- **Clean Starts**: MAGUS does **not** overwrite existing backbone, graph, or cluster files in the working directory. If a previous run failed or you are changing parameters, manually delete the working directory or specify a new one with `-d`.
- **Empty File Errors**: If the process is interrupted during the MAFFT phase, it may leave behind empty backbone files. These must be deleted before restarting, or the tool will error out.
- **Constraint Settings**: By default, MAGUS constrains the merge to induce the subalignments. While `-c false` allows unconstrained alignment, it is computationally expensive and strongly discouraged for datasets exceeding 200 sequences.
- **Memory Management**: For ultra-large datasets (1M+ sequences), prioritize the `clustal` guide tree and `mwtgreedy` trace method to manage memory and runtime efficiently.

## Reference documentation
- [MAGUS GitHub Repository](./references/github_com_vlasmirnov_MAGUS.md)
- [Bioconda magus-msa Overview](./references/anaconda_org_channels_bioconda_packages_magus-msa_overview.md)
---
name: pprodigal
description: pprodigal is a parallel wrapper for the Prodigal gene prediction tool that enables multi-threaded processing of FASTA files. Use when user asks to run gene prediction in parallel, speed up Prodigal execution, or predict genes across multiple CPU cores.
homepage: https://github.com/sjaenick/pprodigal
---


# pprodigal

## Overview

`pprodigal` is a Python-based wrapper designed to overcome the single-threaded limitations of the Prodigal gene prediction software. It functions by partitioning input FASTA files into smaller chunks, processing those chunks in parallel using multiple CPU cores, and then merging the results. It is fully compatible with all standard Prodigal command-line arguments, making it a drop-in performance upgrade for existing workflows.

## Installation

Install via Bioconda (recommended) or PyPI:

```bash
conda install -c bioconda pprodigal
# OR
pip install pprodigal
```

## Core Command Line Usage

The tool accepts all standard `prodigal` flags (like `-i`, `-o`, `-a`, `-d`, `-p`) plus two specific parallelization flags.

### Basic Parallel Execution
To run gene prediction using 8 parallel tasks:
```bash
pprodigal -i assembly.fasta -o output.gbk -a proteins.faa -T 8
```

### Parallelization Parameters
- `-T TASKS`, `--tasks TASKS`: Number of concurrent Prodigal processes to run. (Default: 20)
- `-C CHUNKSIZE`, `--chunksize CHUNKSIZE`: Number of sequences to include in each processing chunk. (Default: 2000)

## Expert Tips and Best Practices

### Maintaining Prediction Accuracy
Prodigal uses a self-training phase to build its gene model. If the `--chunksize` is set too low, individual chunks may not contain enough genetic material for Prodigal to train effectively, leading to suboptimal gene calls. 
- **Recommendation**: Stick to the default chunk size of 2000 or higher unless working with extremely large individual sequences.
- **Metagenomes**: When using `-p meta`, chunk size is less critical for training but still impacts the overhead of process management.

### Resource Management
Each task defined by `-T` spawns a full Prodigal process. 
- **Memory**: Ensure your system has sufficient RAM to support the number of tasks multiplied by the memory footprint of a single Prodigal instance (which varies based on sequence length).
- **I/O**: High task counts on slow storage systems can lead to I/O bottlenecks during the initial file splitting and final merging phases.

### Standard Prodigal Flags
Commonly used Prodigal flags that work within `pprodigal`:
- `-p [single|meta]`: Select procedure (single genome or metagenome).
- `-g [number]`: Specify the translation table (default 11).
- `-f [format]`: Select output format (gbk, gff, or sco).

## Reference documentation
- [PProdigal GitHub Repository](./references/github_com_sjaenick_pprodigal.md)
- [Bioconda pprodigal Package Overview](./references/anaconda_org_channels_bioconda_packages_pprodigal_overview.md)
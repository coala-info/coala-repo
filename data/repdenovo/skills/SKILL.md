---
name: repdenovo
description: REPdenovo is a specialized assembly pipeline that reconstructs repetitive elements from short-read sequencing data using a frequent k-mer approach.
homepage: https://github.com/Reedwarbler/REPdenovo
---

# repdenovo

## Overview
REPdenovo is a specialized assembly pipeline that reconstructs repetitive elements from short-read sequencing data using a frequent k-mer approach. Unlike traditional assemblers that focus on unique genomic regions, REPdenovo targets high-frequency sequences to build consensus repeat motifs. It is highly effective for characterizing the "repeatome" of an organism, providing both sequence contigs and coverage-based copy number estimates.

## Input Preparation

### 1. Raw Reads List File
You must create a tab-delimited text file (e.g., `reads.txt`) describing your input data.
- **Single-end**: `path/to/reads.fastq -1 -1 -1`
- **Paired-end**: Requires two lines with the same group ID.
  ```text
  /path/to/read_R1.fastq  1  300  50
  /path/to/read_R2.fastq  1  300  50
  ```
  *Format: [Path] [Group ID] [Mean Insert Size] [Insert Size SD]*

### 2. Configuration File
The configuration file defines the assembly parameters. Key variables include:
- `MIN_REPEAT_FREQ`: Cutoff for frequent k-mers (relative to average coverage).
- `K_MIN`, `K_MAX`, `K_INC`: Range and step for k-mer sizes (e.g., 30, 50, 10).
- `GENOME_LENGTH`: Approximate genome size for coverage calculations.
- `JELLYFISH_PATH`, `VELVET_PATH`, etc.: Set to `GLOBAL` if tools are in your PATH.

## Command Line Usage

The workflow is executed in two distinct stages.

### Stage 1: Assembly
Performs k-mer counting, frequent k-mer extraction, and initial contig assembly.
```bash
python main.py Assembly config.txt reads.txt
```

### Stage 2: Scaffolding
Uses paired-end information to connect contigs and calculate repeat coverage/copy number.
```bash
python main.py Scaffolding config.txt reads.txt
```

## Expert Tips and Best Practices

- **Velvet K-mer Limit**: By default, Velvet often supports k-mers only up to 31. If your `K_MAX` is higher, you must recompile Velvet: `make 'MAXKMERLENGTH=60'`.
- **Samtools Version**: Ensure you are using Samtools v1.3.1 or later. Older versions have incompatible parameter settings that will cause the pipeline to fail during the mapping phase.
- **Memory Management**: Jellyfish and Velvet are memory-intensive. Adjust the `THREADS` parameter in the config file to match your hardware, but monitor RAM usage closely when using large k-mer ranges.
- **Docker Execution**: For a consistent environment, use the official Docker image:
  ```bash
  docker run -v "${PWD}/data":"/input" -v "${PWD}/output":"/output" \
    warbler/repdenovo:0.1.0 python main.py -c Assembly \
    -g /input/config.txt -r /input/reads.txt
  ```
- **Output Files**:
  - `contigs.fa`: The primary output containing constructed repeat sequences.
  - `*_cov_info_with_cutoff.txt`: Contains the estimated coverage and copy number data for each repeat.

## Reference documentation
- [REPdenovo GitHub Repository](./references/github_com_simoncchu_REPdenovo.md)
- [REPdenovo Wiki](./references/github_com_simoncchu_REPdenovo_wiki.md)
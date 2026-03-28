---
name: parallel-fastq-dump
description: "parallel-fastq-dump is a parallelized wrapper for the NCBI fastq-dump utility that speeds up the extraction of FASTQ files from SRA data. Use when user asks to convert SRA accessions to FASTQ format, speed up data extraction using multiple CPU cores, or download and process sequencing data from the Sequence Read Archive."
homepage: https://github.com/rvalieris/parallel-fastq-dump
---


# parallel-fastq-dump

## Overview

`parallel-fastq-dump` is a Python-based wrapper designed to overcome the single-threaded limitations of the original NCBI `fastq-dump` utility. By leveraging the ability to query specific read ranges, it executes multiple instances of `fastq-dump` in parallel and merges the outputs, significantly reducing the time required for data extraction in bioinformatics pipelines. It is a drop-through wrapper, meaning it passes additional arguments directly to the underlying tool while managing the parallelization logic.

## Installation and Requirements

The tool requires `sra-tools` (specifically `fastq-dump` and `sra-stat`) to be available in your system PATH.

```bash
# Recommended installation via Bioconda
conda install parallel-fastq-dump 'sra-tools>=3.0.0'
```

## Common CLI Patterns

### Basic Parallel Extraction
To extract a specific SRA accession using multiple cores:
```bash
parallel-fastq-dump --sra-id SRR2244401 --threads 8 --outdir ./fastq_out --split-files --gzip
```

### Working with Local SRA Files
If you have already downloaded the `.sra` file, point the tool to the file or the directory containing it:
```bash
parallel-fastq-dump --sra-id /path/to/local/SRR2244401.sra --threads 4 --outdir .
```

## Expert Tips and Best Practices

### 1. Prefetch is Mandatory for Performance
Running `parallel-fastq-dump` directly on a remote SRA ID is often bottlenecked by network latency. For maximum speed, always use `prefetch` first to download the data locally:
```bash
prefetch SRR2244401
parallel-fastq-dump --sra-id SRR2244401 --threads 12 --split-3 --gzip
```

### 2. Optimize Thread Allocation
The tool is most effective on larger datasets. A good rule of thumb is to allocate threads only if the file contains at least 200,000 reads per requested thread. For very small files, the overhead of splitting and concatenating may exceed the benefits of parallelization.

### 3. Manage Temporary Space
The tool creates intermediate chunks in a temporary directory before merging them into the final output. If your system `/tmp` is small or slow, specify a high-performance temporary directory:
```bash
parallel-fastq-dump --sra-id SRR2244401 --threads 16 --tmpdir /path/to/fast/scratch/
```

### 4. Argument Pass-Through
Since `parallel-fastq-dump` is a wrapper, you can use any standard `fastq-dump` flags. Common useful flags include:
- `--split-3`: Handles paired-end data by putting left and right reads into separate files, and singletons into a third.
- `--clip`: Removes adapters/low-quality ends if specified in the SRA metadata.
- `--aligned`: Dump only aligned reads.

### 5. Troubleshooting sra-stat
The tool uses `sra-stat` to calculate the total number of spots to determine how to split the work. If you encounter errors related to "spot count," ensure your `sra-tools` version is 3.0.0 or higher to maintain compatibility with NCBI's latest metadata formats.



## Subcommands

| Command | Description |
|---------|-------------|
| fastq-dump | Dump SRA data into FASTQ format |
| prefetch | Download SRA accessions and their dependencies |
| sra-stat | Display table statistics |

## Reference documentation
- [README.rst](./references/github_com_rvalieris_parallel-fastq-dump_blob_master_README.rst.md)
- [parallel-fastq-dump source](./references/github_com_rvalieris_parallel-fastq-dump_blob_master_parallel-fastq-dump.md)
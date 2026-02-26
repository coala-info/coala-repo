---
name: parallel-fastq-dump
description: parallel-fastq-dump is a performance-oriented wrapper that speeds up the extraction of FASTQ files from SRA data by processing read ranges concurrently across multiple threads. Use when user asks to download SRA data, convert SRA files to FASTQ format, or parallelize the fastq-dump process for faster data extraction.
homepage: https://github.com/rvalieris/parallel-fastq-dump
---


# parallel-fastq-dump

## Overview

`parallel-fastq-dump` is a performance-oriented wrapper for the NCBI SRA Toolkit. It speeds up the "dumping" process by partitioning a single SRA file into multiple chunks based on read ranges (using the `-N` and `-X` flags) and processing those chunks concurrently across multiple threads. Once the parallel tasks are complete, the tool automatically concatenates the results into a single output, providing a significant speedup over the native single-threaded `fastq-dump` while maintaining identical output.

## Installation and Dependencies

This tool requires `fastq-dump` and `sra-stat` (from the SRA Toolkit) to be present in your PATH.

- **Preferred Install**: Use Bioconda to ensure all dependencies are met.
- **Version Requirement**: Ensure `sra-tools` is version 2.10.0 or higher (ideally >= 3.0.0) for compatibility with modern NCBI servers.

```bash
conda install -c bioconda parallel-fastq-dump 'sra-tools>=3.0.0'
```

## Core Usage Patterns

### Basic Parallel Extraction
To extract a specific SRA ID using multiple threads:
```bash
parallel-fastq-dump --sra-id SRR2244401 --threads 4 --outdir ./output
```

### Paired-End Data with Compression
For paired-end sequencing data, use `--split-files` to generate separate R1 and R2 files. Adding `--gzip` is recommended to save disk space.
```bash
parallel-fastq-dump --sra-id SRR2244401 --threads 8 --split-files --gzip
```

### Processing Local SRA Files
If you have already downloaded the `.sra` file, point the tool to the local file path:
```bash
parallel-fastq-dump --sra-id /path/to/local/data.sra --threads 4 --split-files
```

## Expert Tips and Best Practices

- **The Prefetch Protip**: `fastq-dump` is notoriously slow when downloading data over the network. For maximum efficiency, always use the `prefetch` tool from the SRA Toolkit to download the SRA file to your local storage before running `parallel-fastq-dump`.
- **Thread Scaling**: Speed improvements are most noticeable on larger datasets. A good rule of thumb is to ensure at least 200,000 reads/pairs per thread used. Using 16 threads on a very small file may result in overhead that negates the parallel benefits.
- **Argument Passing**: Any arguments not recognized by the wrapper are passed directly to the underlying `fastq-dump` call. This means you can still use standard filters like `--minReadLen` or `--clip`.
- **Memory and I/O**: While the tool parallelizes CPU usage, ensure your storage system can handle the concurrent I/O writes from multiple threads, especially when not using compression.

## Reference documentation
- [parallel-fastq-dump Overview](./references/anaconda_org_channels_bioconda_packages_parallel-fastq-dump_overview.md)
- [parallel-fastq-dump GitHub Repository](./references/github_com_rvalieris_parallel-fastq-dump.md)
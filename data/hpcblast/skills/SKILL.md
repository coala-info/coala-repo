---
name: hpcblast
description: hpcblast is a performance-oriented wrapper for the NCBI-BLAST+ suite that optimizes sequence alignment by partitioning input files and executing tasks in parallel. Use when user asks to run BLAST searches faster, parallelize sequence alignments on local machines or SGE clusters, or process compressed GZIP and FASTQ files directly.
homepage: https://github.com/yodeng/hpc-blast
---


# hpcblast

## Overview
hpcblast is a performance-oriented wrapper for the NCBI-BLAST+ suite. It optimizes sequence alignment tasks by automatically partitioning large input files into smaller chunks and executing them in parallel. This approach significantly reduces wall-clock time while maintaining compatibility with standard BLAST+ parameters. It is particularly useful because it handles compressed files (GZIP) and FASTQ formats directly, eliminating the need for manual preprocessing or conversion.

## Command Line Usage

The basic syntax for hpcblast is to prepend `hpc-blast` and its specific options before a standard BLAST+ command:

```bash
hpc-blast [hpc-options] <blast-command> [blast-options]
```

### Common hpcblast Options
- `--local`: Forces execution on the local machine instead of submitting to a cluster manager (SGE).
- `--split <int>`: Defines the number of chunks to divide the query into (default: 10).
- `--size <int>`: Defines the number of sequences per chunk (alternative to `--split`).
- `--num <int>`: Limits the maximum number of chunks running in parallel.
- `--tempdir <dir>`: Specifies the directory for temporary chunk files and partial results.
- `--cpu <int>`: Sets CPU cores for cluster jobs (SGE). Note: hpcblast uses `max(--cpu, -num_threads)`.
- `--memory <int>`: Sets memory (GB) for cluster jobs.

### Basic Examples

**Running locally on a workstation:**
To run a blastn search locally using 8 parallel chunks:
```bash
hpc-blast --local --split 8 blastn -query query.fa -db nt -outfmt 6 -out results.m6
```

**Running on an SGE Cluster:**
To submit a blastp job to a specific queue with resource limits:
```bash
hpc-blast --queue high_mem --cpu 4 --memory 16 blastp -query protein.fasta -db nr -out results.txt
```

## Best Practices and Expert Tips

### 1. Handling Compressed Data
hpcblast natively supports `.gz` files. You do not need to decompress your query files before running the search, which saves significant disk space and I/O time.
```bash
hpc-blast --local blastn -query sequences.fastq.gz -db ref_db -out results.m6
```

### 2. Optimizing Parallelism
- **Local Mode**: When using `--local`, ensure the `--num` or `--split` value does not exceed your available hardware threads to avoid context-switching overhead.
- **Chunking Strategy**: Use `--size` if you have a massive file and want to ensure each worker gets a specific workload (e.g., 1000 sequences per job), rather than just dividing the file into a fixed number of parts.

### 3. Resource Alignment
When running on a cluster, ensure the `-num_threads` passed to the underlying BLAST command matches the `--cpu` passed to hpcblast. If they differ, hpcblast will attempt to request the higher of the two values from the scheduler to prevent resource over-subscription.

### 4. Output Consistency
While hpcblast produces the same alignment data as standard BLAST+, the **order** of the sequences in the output file may differ because chunks finish at different times. If order is critical, sort the output file by query ID after the process completes.

### 5. Temporary File Management
By default, hpcblast creates temporary files for the split queries. If your query file is very large, ensure `--tempdir` points to a high-speed scratch disk or a location with sufficient quota to hold multiple copies of the split data.

## Reference documentation
- [github_com_yodeng_hpc-blast.md](./references/github_com_yodeng_hpc-blast.md)
- [anaconda_org_channels_bioconda_packages_hpcblast_overview.md](./references/anaconda_org_channels_bioconda_packages_hpcblast_overview.md)
---
name: metacache
description: MetaCache is a high-performance taxonomic classification system that maps metagenomic sequences to their most likely taxon of origin using locality-sensitive hashing. Use when user asks to classify metagenomic reads, build taxonomic reference databases, or generate taxonomic abundance summaries and visualizations.
homepage: https://github.com/muellan/metacache
---

# metacache

## Overview

MetaCache is a high-performance taxonomic classification system designed to map genomic sequences from metagenomic samples to their most likely taxon of origin. It utilizes locality-sensitive hashing to identify candidate regions within reference genomes, offering a balance between the speed of k-mer methods and significantly reduced memory footprints. It supports both CPU and GPU-accelerated workflows, making it suitable for analyzing massive datasets ranging from bacterial and viral genomes to complex eukaryotic assemblies.

## Installation and Setup

### Build the Tool
Compile the source code using the provided Makefile. Ensure `zlib` and `zlib1g-dev` are installed on the system.

- **CPU Version**: Run `make -j` to compile the standard version.
- **GPU Version**: Run `make gpu` (requires NVIDIA Pascal generation or newer and CUDA >= 11).

### Database Preparation
For a standard setup using NCBI RefSeq (Bacteria, Archaea, and Viruses):
1. Run `./metacache-build-refseq`. This script automates the download of genomes, taxonomy maps, and the construction of the classification database.
2. For custom databases, use the specific download scripts: `download-ncbi-genomes`, `download-ncbi-taxonomy`, and `download-ncbi-taxmaps`.

## Command Line Usage

### Basic Querying
Classify reads against a built database. MetaCache accepts FASTA or FASTQ files (including gzipped versions).

```bash
# Query a single file
./metacache query <database_name> <input_reads.fa> -out <results.txt>

# Query all files in a directory
./metacache query <database_name> <input_directory> -out <results.txt>
```

### Paired-End Reads
Handle paired-end data by specifying the input format:

```bash
# Separate files for R1 and R2
./metacache query <database_name> <reads_1.fa> <reads_2.fa> -pairfiles -out <results.txt>

# Interleaved paired-end file
./metacache query <database_name> <interleaved_reads.fa> -pairseq -out <results.txt>
```

### Database Management and Information
- **Check Database Info**: Use `./metacache-db-info <database_path>` to view metadata and parameters of an existing database.
- **Partitioning**: If system RAM is insufficient for a large database (e.g., full RefSeq), use `./metacache-partition-genomes` to split the database into manageable chunks.

## Post-Processing and Visualization

### Summarizing Results
Generate a taxonomic summary from the raw classification output:
```bash
./summarize-results <results.txt>
```

### Visualization with Krona
Convert MetaCache abundance results into a format compatible with Krona charts:
```bash
python3 krona-from-abundances.py <abundance_file> -o <output.html>
```

## Expert Tips and Best Practices

- **Memory Optimization**: Building a full RefSeq database typically requires at least 128GB of RAM. If working on a machine with less memory, always utilize the partitioning scripts.
- **GPU Acceleration**: Use the GPU version for significantly faster database build times (often 100x faster) and higher query throughput (up to 300 million reads per minute).
- **Input Formats**: MetaCache natively handles `.gz` files. Do not decompress files manually before querying to save disk space and I/O overhead.
- **Thread Allocation**: For the CPU version, MetaCache scales well with high thread counts. Use the `-t` flag (if available in your build) or rely on the default behavior which typically utilizes available cores.



## Subcommands

| Command | Description |
|---------|-------------|
| metacache | MetaCache  Copyright (C) 2016-2026  André Müller & Robin Kobus This program comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under certain conditions. See the file 'LICENSE' for details. |
| metacache build | Build a metacache database from sequence files or directories. |
| metacache build+query | Builds and queries a sequence cache. |
| metacache merge | Merge query files or directories with taxonomy information. |
| metacache modify | Modify a metacache database with new sequence files. |
| metacache query | Query a metacache database with sequence files or directories. |

## Reference documentation
- [MetaCache Main README](./references/github_com_muellan_metacache_blob_master_README.md)
- [Build Instructions (Makefile)](./references/github_com_muellan_metacache_blob_master_Makefile.md)
- [GPU Version Details](./references/github_com_muellan_metacache_blob_master_docs_gpu_version.md)
- [RefSeq Build Script](./references/github_com_muellan_metacache_blob_master_metacache-build-refseq.md)
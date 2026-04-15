---
name: kmc
description: KMC is a high-performance utility for counting and manipulating k-mers in large genomic datasets. Use when user asks to count k-mers, perform set operations on k-mer databases, filter reads based on k-mer abundance, or convert binary k-mer files to text.
homepage: https://github.com/refresh-bio/kmc
metadata:
  docker_image: "quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4"
---

# kmc

## Overview
KMC is a high-performance, disk-based utility designed for counting k-mers in large genomic datasets. It is particularly effective for handling gzipped input files and managing memory constraints by using temporary disk space. This skill assists in configuring k-mer length, setting abundance thresholds, and utilizing `kmc_tools` for downstream operations like database merging, filtering, and generating human-readable dumps.

## Core Workflows

### Counting K-mers
The primary command for counting k-mers requires a k-mer length, input files, an output prefix, and a temporary directory.

```bash
# Basic counting
kmc -k27 input.fastq output_prefix tmp_dir/

# Counting with specific thresholds
# -ci<value>: exclude k-mers occurring fewer than <value> times (default: 2)
# -cs<value>: maximum value of a counter (default: 255)
kmc -k31 -ci5 -cs10000 input.fastq.gz output_db tmp/
```

**Best Practices:**
- **Temporary Directory:** Always specify a dedicated `tmp/` directory. KMC creates many intermediate files; ensure the disk has sufficient space (often comparable to the input size).
- **Memory Management:** Use `-m<value>` to restrict RAM usage (e.g., `-m16` for 16GB).
- **Input Types:** KMC natively supports `.fasta`, `.fastq`, and their gzipped versions (`.gz`).

### Database Operations with kmc_tools
Once a database is created (consisting of `.kmc_pre` and `.kmc_suf` files), use `kmc_tools` for manipulation.

#### 1. Text Dump
Convert the binary database into a tab-separated text file (k-mer and count).
```bash
kmc_tools transform output_db dump output.txt
```

#### 2. Set Operations
Perform intersections, unions, or subtractions between multiple k-mer sets.
```bash
# Find k-mers present in both databases
kmc_tools simple db1 db2 intersect db_intersect
```

#### 3. Filtering Reads
Filter an input FASTQ file to keep only reads containing a specific number of k-mers from a KMC database.
```bash
kmc_tools filter db_prefix input.fastq -ci10 filtered_output.fastq
```

## Expert Tips
- **Thread Scaling:** Use `-t<number>` to specify threads. KMC is highly parallelized and scales well on multi-core systems.
- **Canonical K-mers:** By default, KMC counts canonical k-mers (the lexicographically smaller of a k-mer and its reverse complement). Use `-b` if you need to disable this and treat strands separately.
- **Large K values:** KMC supports k-mer lengths up to 256. Note that memory and disk requirements increase with larger `k`.
- **Ulimit on macOS:** If running on macOS, increase the open file limit before execution to avoid "too many open files" errors: `ulimit -n 2048`.

## Reference documentation
- [KMC GitHub Repository](./references/github_com_refresh-bio_kmc.md)
- [KMC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kmc_overview.md)
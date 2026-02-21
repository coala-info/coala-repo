---
name: mantis
description: Mantis is a specialized tool for indexing and searching massive collections of sequencing data.
homepage: https://github.com/splatlab/mantis
---

# mantis

## Overview
Mantis is a specialized tool for indexing and searching massive collections of sequencing data. It transforms raw reads into a searchable index that supports fast graph traversal and sequence-level queries without false positives or negatives. This skill provides the necessary procedures to build indices from Squeakr files, optimize them using Minimum Spanning Tree (MST) compression, and execute high-performance queries.

## Installation and Setup
Mantis is available via Bioconda or can be built from source.
- **Conda**: `conda install bioconda::mantis`
- **Source Requirements**: CMake 3.9+, C++17, zlib, and sdsl-lite.
- **Hardware Note**: For CPUs older than Intel Haswell, build with `-DNH=1` to bypass specific hardware instructions.

## Core Workflows

### 1. Building an Index
The `build` command creates the initial colored de Bruijn graph.
- **Input**: Requires a list of Squeakr CQF files.
- **Optimization**: Always run `squeakr` with the `--no-counts` flag to reduce intermediate disk usage by an order of magnitude.
- **System Prep**: Increase the open file handle limit (`ulimit -n`) to at least the number of input files.

**Command Pattern:**
```bash
mantis build -s <log-slots> -i <input_list.lst> -o <output_dir>
```
**Recommended `<log-slots>` values:**
- `28`: Small sets (e.g., bacterial genomes).
- `30`: Large sets of medium-sized read files.
- `33`: Large sets of big read files.

### 2. Compressing with MST
After building, use the `mst` command to compress color information. This significantly reduces the memory footprint for queries without impacting performance.

**Command Pattern:**
```bash
mantis mst -p <index_prefix> -t <threads> -d
```
- Use `-d` to delete the intermediate RRR-compressed representation and save space.
- Use `-k` if you need to keep the RRR representation for specific legacy analyses.

### 3. Querying the Index
Query the index using FASTA files or specific k-mers.

**Command Pattern:**
```bash
mantis query -p <index_prefix> -o <output_file> <query_sequences.fa>
```

## Expert Tips and Best Practices
- **Memory Management**: Mantis uses `mmap` and `madvise` to manage memory. While tools like `/usr/bin/time` might report high Resident Set Size (RSS), the kernel will reclaim pages under pressure.
- **Resize Overhead**: Choose a reasonable `log-slots` value initially. While Mantis auto-resizes, each resize operation halts the build and increases total runtime.
- **Input Consistency**: Ensure all input Squeakr files were generated with the same k-mer size.

## Reference documentation
- [Mantis GitHub Repository](./references/github_com_splatlab_mantis.md)
- [Bioconda Mantis Overview](./references/anaconda_org_channels_bioconda_packages_mantis_overview.md)
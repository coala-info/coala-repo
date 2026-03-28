---
name: gem3-mapper
description: gem3-mapper is a high-throughput tool designed to align single-end or paired-end sequenced reads against large reference genomes. Use when user asks to index a reference genome, map reads to a reference, or perform sensitive sequence alignment.
homepage: https://github.com/smarco/gem3-mapper
---

# gem3-mapper

## Overview

GEM3 is a high-throughput mapping tool designed for aligning sequenced reads against large reference genomes. It is particularly effective for reads up to 1000 bases long. Unlike many heuristic mappers, GEM3 can perform "complete" searches, ensuring no valid matches are missed based on user-defined criteria. It supports single-end and paired-end data, global and local alignment models, and various error models including Hamming, Edit, and Gap-affine.

## Core Workflows

### 1. Indexing a Reference Genome
Before mapping, you must create a custom FM-Index from a Multi-FASTA file.

```bash
# Basic indexing
gem-indexer -i reference.fa -o index_prefix

# Indexing for bisulfite sequencing (epigenetics)
gem-indexer -i reference.fa -o index_prefix -b
```

### 2. Mapping Single-End Reads
Align a single FASTQ file against the generated index.

```bash
# Standard mapping (outputting to SAM)
gem-mapper -I index_prefix.gem -i reads.fastq -o alignments.sam

# Using sensitive mode for higher accuracy
gem-mapper -I index_prefix.gem -i reads.fastq --mapping-mode sensitive -o alignments.sam
```

### 3. Mapping Paired-End Reads
GEM3 supports both interleaved and split file formats.

```bash
# Split files (Read 1 and Read 2)
gem-mapper -I index_prefix.gem -1 reads_1.fastq -2 reads_2.fastq -o alignments.sam

# Interleaved file (use -p flag)
gem-mapper -I index_prefix.gem -i interleaved.fastq -p -o alignments.sam
```

## Expert Tips and Best Practices

### Performance Optimization
*   **Multithreading**: Use `-t` to specify the number of cores. By default, GEM3 attempts to use all logical cores.
*   **Compressed I/O**: GEM3 can handle compressed files directly to save disk space and I/O time.
    *   Input: Use `-z` for gzip or `-j` for bzip2.
    *   Output: Use `--gzip-output` or `--bzip-output`.

### Alignment Tuning
*   **Error Rates**: The default maximum divergency is 12% (`-e 0.12`). Adjust this based on your expected sequencing error profile.
*   **Local Alignment**: By default, GEM3 attempts local alignment only if no global alignment is found (`--alignment-local if-unmapped`). Change to `never` to force global-only mapping.
*   **Template Length**: For paired-end data, use `-L` to set the maximum expected insert size (template length) to filter out discordant mappings.

### Search Strategies
*   **Mapping Modes**:
    *   `fast`: Optimized for speed (default).
    *   `sensitive`: Slower but explores more of the search space.
    *   `customed`: Allows manual override of internal heuristics.



## Subcommands

| Command | Description |
|---------|-------------|
| ./gem-indexer | Index a genome for GEM mapper |
| ./gem-mapper | GEM3 mapper |

## Reference documentation
- [GEM-Mapper (Version 3) README](./references/github_com_smarco_gem3-mapper_blob_master_README.md)
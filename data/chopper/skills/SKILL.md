---
name: chopper
description: Chopper is a high-performance Rust-based utility designed for the preprocessing of long-read sequencing data.
homepage: https://github.com/wdecoster/chopper
---

# chopper

## Overview
Chopper is a high-performance Rust-based utility designed for the preprocessing of long-read sequencing data. It serves as a significantly faster alternative to the Python-based NanoFilt and NanoLyse tools. Use this skill to filter FASTQ files based on Phred quality scores, read length, and GC content, or to apply sophisticated trimming strategies that isolate high-quality sub-reads and remove contaminants.

## Core CLI Usage

Chopper typically reads from standard input (stdin) and writes to standard output (stdout), though it supports explicit input flags.

### Basic Filtering
Filter reads by a minimum average quality (Q-score) and minimum length:
```bash
chopper -q 10 -l 500 -i reads.fastq > filtered_reads.fastq
```

### Handling Compressed Data
Since chopper works efficiently with pipes, use it directly with `gzip`:
```bash
gunzip -c reads.fastq.gz | chopper -q 12 -l 1000 | gzip > filtered.fastq.gz
```

## Trimming Strategies

Chopper provides four distinct approaches to trimming, selected via the `--trim-approach` flag.

### 1. Quality-based Trimming
Removes low-quality bases from the ends of the read until a base meeting the `--cutoff` threshold is reached.
```bash
chopper --trim-approach trim-by-quality --cutoff 15 -i input.fastq
```

### 2. Best Read Segment
Extracts the single highest-quality segment from a read based on the provided cutoff.
```bash
chopper --trim-approach best-read-segment --cutoff 15 -l 100 -i input.fastq
```

### 3. Split by Low Quality
Splits a single read into multiple high-quality parts whenever a low-quality segment (below cutoff) is encountered.
```bash
chopper --trim-approach split-by-low-quality --cutoff 15 -l 50 -i input.fastq
```

### 4. Fixed Cropping
Removes a specific number of bases from the start and/or end of every read.
```bash
chopper --trim-approach fixed-crop --headcrop 10 --tailcrop 10 -i input.fastq
```

## Advanced Options and Best Practices

### Contaminant Filtering
To remove reads matching a specific contaminant (e.g., Lambda phage), provide a FASTA file:
```bash
chopper -c lambda.fasta -i reads.fastq > clean_reads.fastq
```

### Performance Tuning
*   **Threads**: Chopper defaults to 4 threads. For high-throughput environments, adjust this with `-t` or `--threads`.
*   **Memory**: As a Rust tool, chopper is memory-efficient, but ensure your pipe buffer can handle the throughput when working with very large long-read files.

### Inverse Filtering
If you need to inspect the reads that *failed* your filters (e.g., to troubleshoot a library prep issue), use the `--inverse` flag:
```bash
chopper -q 15 --inverse -i reads.fastq > low_quality_reads.fastq
```

### GC Content Filtering
Filter for specific genomic regions or organisms by narrowing the GC percentage:
```bash
chopper --mingc 0.4 --maxgc 0.6 -i reads.fastq
```

## Reference documentation
- [Chopper GitHub Repository](./references/github_com_wdecoster_chopper.md)
- [Chopper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_chopper_overview.md)
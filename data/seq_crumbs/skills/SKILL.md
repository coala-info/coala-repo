---
name: seq_crumbs
description: seq_crumbs is a collection of lightweight bioinformatics utilities designed for processing and filtering sequence data within Unix pipelines. Use when user asks to filter reads by quality or length, trim adapter sequences, convert sequence formats, or synchronize paired-end data.
homepage: https://github.com/JoseBlanca/seq_crumbs
---


# seq_crumbs

## Overview
seq_crumbs is a collection of lightweight, specialized bioinformatics utilities designed to work within Unix pipelines. Each "crumb" performs a single discrete task—such as filtering reads by quality or trimming adapter sequences—and typically reads from standard input and writes to standard output. This modular design allows for the creation of complex sequence processing workflows by chaining simple commands together.

## Core Usage Patterns

### Unix Pipelines
The primary way to use seq_crumbs is by piping data between tools.
```bash
cat input.fastq | filter_by_quality -q 20 | trim_quality -w 20 -q 15 > filtered_trimmed.fastq
```

### Input and Output
- **Standard I/O**: Most tools default to stdin and stdout.
- **File Arguments**: You can provide one or more input files as arguments.
- **Explicit Output**: Use `-o` or `--outfile` to specify a destination file.
- **Compression**: The tools automatically detect and handle gzip, BGZF, and bzip2 compressed input files.

### Format Management
- **Guessing Format**: Use `guess_seq_format` to identify file types, including specific FASTQ variants (Sanger vs. Illumina).
- **Conversion**: Use `convert_format` to switch between supported types (FASTA, FASTQ, etc.).
- **Concatenation**: `cat_seqs` can merge multiple files of different formats into a single output format.

## High-Utility Commands

### Filtering Utilities
- `filter_by_quality`: Remove reads based on mean quality scores.
- `filter_by_length`: Keep sequences within a specific length range.
- `filter_duplicates`: Remove identical sequences to reduce redundancy.
- `filter_by_complexity`: Filter out low-complexity sequences (e.g., poly-A tails or simple repeats).
- `filter_by_name`: Extract or exclude sequences based on a list of IDs provided in a text file.

### Trimming Utilities
- `trim_quality`: Use a sliding window to remove low-quality regions from the ends of reads.
- `trim_edges`: Remove a fixed number of bases from the start or end of sequences.
- `trim_blast_short`: Remove specific oligonucleotides (like adapters or primers) using the blast-short algorithm.

### Paired-End Processing
- `pair_matcher`: Synchronize two files to ensure only reads with a valid mate are kept.
- `interleave_pairs` / `deinterleave_pairs`: Convert between interleaved and separate-file formats for paired-end data.

### Statistics and Exploration
- `count_seqs`: Quickly get the total number of sequences and total base count.
- `calculate_stats`: Generate detailed summary statistics for sequence files.
- `seq_head`: View the first few sequences in a file (similar to the Unix `head` command).
- `sample_seqs`: Extract a random subset of sequences for testing or downsampling.

## Expert Tips
- **Multiprocessing**: Many seq_crumbs tools can utilize multiple cores. Check the help menu for specific tools to see if they support parallel processing for large datasets.
- **Paired-End Awareness**: When filtering paired-end data, use the paired-end aware mode in filtering crumbs to ensure that if one read is filtered out, its mate is also handled correctly to maintain file synchronization.
- **Case Sensitivity**: Use `change_case` or `trim_by_case` when working with sequences where case (upper/lower) represents specific masking or quality information.

## Reference documentation
- [Main README and Tool List](./references/github_com_JoseBlanca_seq_crumbs.md)
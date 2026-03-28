---
name: fasten
description: Fasten is a high-performance bioinformatics toolkit designed for streaming and processing interleaved FASTQ files using Unix-style pipes. Use when user asks to interleave or deshuffle reads, filter and trim sequences, downsample datasets, or generate quality metrics.
homepage: https://github.com/lskatz/fasten
---

# fasten

## Overview

Fasten is a high-performance bioinformatics toolkit written in Rust, designed specifically for handling interleaved FASTQ files. Its primary strength lies in its "Unix philosophy" approach: each tool performs a specific task, reading from standard input and writing to standard output. This allows for complex sequence processing pipelines to be constructed using standard shell pipes, minimizing disk I/O and making it ideal for high-throughput streaming workflows.

## CLI Usage and Best Practices

### Core Workflow Patterns

The most common pattern for using fasten involves shuffling R1 and R2 files into an interleaved format, processing them, and then either analyzing the stream or deshuffling back to separate files.

**Interleaving and Metrics:**
```bash
cat R1.fastq R2.fastq | fasten_shuffle | fasten_metrics | column -t
```

**Cleaning and Compressing:**
```bash
cat R1.fastq R2.fastq | fasten_shuffle | fasten_clean --paired-end --min-length 50 | gzip -c > cleaned.fastq.gz
```

### High-Utility Commands

| Executable | Key Use Case |
| --- | --- |
| `fasten_clean` | Trims adapters and filters by length/quality. |
| `fasten_metrics` | Generates total length, read count, average length, and average quality. |
| `fasten_shuffle` | Interleaves R1/R2 or deshuffles an interleaved stream back to R1/R2. |
| `fasten_sample` | Downsamples a FASTQ file to a specific percentage or read count. |
| `fasten_kmer` | Performs k-mer counting on the fly. |
| `fasten_normalize` | Normalizes read depth based on k-mer coverage to reduce dataset size. |
| `fasten_straighten` | Standardizes FASTQ files to the 4-line-per-entry format. |

### Expert Tips

- **Paired-End Awareness**: When working with interleaved files, always include the `--paired-end` flag for tools like `fasten_clean` to ensure that if one mate is filtered out, its partner is also removed, maintaining the interleaved structure.
- **Streaming Efficiency**: Avoid writing intermediate FASTQ files to disk. Use pipes (`|`) to chain multiple fasten tools together.
- **Validation**: Use `fasten_inspect` to quickly add metadata like sequence length to read IDs, or `fasten_repair` to fix broken FASTQ formatting in a stream.
- **Randomization**: If your downstream analysis is sensitive to read order, use `fasten_randomize` to shuffle the order of entries in the FASTQ file.



## Subcommands

| Command | Description |
|---------|-------------|
| fasten_clean | Trims and filters reads |
| fasten_inspect | Marks up your reads with useful information like read length |
| fasten_kmer | Counts kmers. |
| fasten_metrics | Gives read metrics on a read set. |
| fasten_quality_filter | Transforms any low-quality base to 'N'. |
| fasten_randomize | Create random reads from stdin. |
| fasten_regex | Filter reads based on a regular expression. |
| fasten_repair | Repairs reads |
| fasten_sample | Downsample your reads |
| fasten_shuffle | Interleaves reads from either stdin or file parameters |
| fasten_straighten | Convert a fastq file to a standard 4-lines-per-entry format |
| fasten_trim | Blunt-end trims using 0-based coordinates |

## Reference documentation

- [Fasten GitHub Repository](./references/github_com_lskatz_fasten.md)
- [Fasten README](./references/github_com_lskatz_fasten_blob_master_README.md)
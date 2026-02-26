---
name: fasten
description: Fasten is a collection of modular executables designed to process and stream FASTQ files through efficient Unix pipelines. Use when user asks to generate read metrics, interleave paired-end reads, trim or clean sequences, downsample datasets, and filter reads by quality or regex motifs.
homepage: https://github.com/lskatz/fasten
---


# fasten

## Overview
Fasten is a collection of modular executables written in Rust, optimized for processing FASTQ files via standard input and output. By treating genomic data as a stream, it eliminates the need for temporary files and allows users to chain multiple operations—such as quality filtering, adapter trimming, and read sorting—into efficient Unix pipelines. It is particularly effective for bioinformatics workflows requiring speed and low memory overhead.

## Core CLI Patterns

### Generating Read Metrics
To quickly assess the quality and quantity of reads, pipe FASTQ data into `fasten_metrics`. Use `column -t` to format the tab-separated output for readability.
```bash
cat reads.fastq | fasten_metrics | column -t
```

### Handling Paired-End Reads
Fasten prefers interleaved FASTQ format for paired-end data. Use `fasten_shuffle` to interleave R1 and R2 files before processing.
```bash
cat R1.fastq R2.fastq | fasten_shuffle > interleaved.fastq
```
To process interleaved data, many commands require the `--paired-end` flag to ensure read pairs are treated as a single unit.

### Read Cleaning and Trimming
Chain `fasten_trim` and `fasten_clean` to prepare data for assembly or mapping.
```bash
cat interleaved.fastq | \
  fasten_trim --first-base 1 --last-base 100 | \
  fasten_clean --paired-end --min-length 50 --min-avg-qual 20 | \
  gzip -c > cleaned.fastq.gz
```

### Downsampling and Randomization
To reduce dataset size for testing or normalization:
```bash
# Sample 10% of the reads
cat reads.fastq | fasten_sample --proportion 0.1 > sampled.fastq

# Randomize read order
cat reads.fastq | fasten_randomize > randomized.fastq
```

### Filtering by Sequence or Quality
Use regex to isolate specific reads or filter out low-quality bases.
```bash
# Filter for reads containing a specific motif
cat reads.fastq | fasten_regex --regex "ATGCA" > filtered.fastq

# Convert low quality bases (below Phred 20) to 'N'
cat reads.fastq | fasten_quality_filter --min-score 20 > masked.fastq
```

## Expert Tips and Best Practices

- **Streaming Efficiency**: Fasten tools read from `stdin` and write to `stdout`. Always use Unix pipes (`|`) to avoid writing large intermediate FASTQ files to disk, which saves both time and I/O.
- **Interleaved Workflow**: Most Fasten tools are designed to work with interleaved paired-end files. If your pipeline involves paired-end data, interleave early with `fasten_shuffle` and deshuffle at the very end if necessary.
- **Validation and Repair**: If a pipeline fails due to malformed FASTQ files, use `fasten_repair` to fix common formatting issues or `fasten_inspect` to identify where the corruption occurs.
- **Parallelization**: While Fasten is fast, you can utilize `--numcpus` on supported modules to increase throughput for computationally intensive tasks like k-mer counting (`fasten_kmer`).
- **Standardization**: Use `fasten_straighten` to convert "wrapped" FASTQ files (where sequences span multiple lines) into the standard 4-line-per-entry format required by most modern bioinformatic tools.

## Reference documentation
- [Fasten GitHub Repository](./references/github_com_lskatz_fasten.md)
- [Bioconda Fasten Overview](./references/anaconda_org_channels_bioconda_packages_fasten_overview.md)
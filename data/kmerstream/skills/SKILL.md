---
name: kmerstream
description: KmerStream estimates k-mer frequency distributions and genomic parameters from raw sequencing data using a streaming algorithm. Use when user asks to estimate genome size, determine sequencing depth, calculate error rates, or perform multi-k analysis on large sequencing datasets.
homepage: https://github.com/pmelsted/KmerStream
metadata:
  docker_image: "quay.io/biocontainers/kmerstream:1.1--h077b44d_6"
---

# kmerstream

## Overview
KmerStream is a specialized tool designed for the rapid analysis of raw sequencing data. Unlike traditional k-mer counters that store every unique k-mer, KmerStream uses a streaming algorithm to provide statistical estimates of k-mer frequency distributions. This makes it ideal for initial data quality control, estimating the total size of a genome (G), determining sequencing depth (lambda), and calculating the underlying error rate (e) of a library. It is particularly effective for processing massive datasets where memory constraints prevent the use of exact counters.

## Core Workflows

### Basic K-mer Statistics
To estimate k-mer occurrences for a specific k-mer size:
```bash
KmerStream -k 31 -o output_prefix sample.fastq
```

### Multi-K Analysis
You can estimate statistics for multiple k-mer sizes in a single pass, which is useful for finding the optimal k-mer size for assembly:
```bash
KmerStream -k 31,47,63,79 -t 8 -o multi_k_results sample.fastq.gz
```

### Quality Filtering
To improve estimates by ignoring k-mers containing low-quality bases (PHRED score):
```bash
KmerStream -k 31 -q 20 -o filtered_results sample.fastq
```
*Note: Use `--q64` if your data uses older Illumina PHRED+64 encoding.*

### Genome Size and Coverage Estimation
After running KmerStream with the `--tsv` flag, use the companion Python script to derive biological estimates:
1. Generate the TSV:
   ```bash
   KmerStream -k 31 --tsv -o results.tsv sample.fastq
   ```
2. Run the estimator:
   ```bash
   python KmerStreamEstimate.py results.tsv
   ```

### Distributed Processing and Merging
For very large projects or distributed environments, process files individually and join the results:
1. Generate binary outputs for each sample:
   ```bash
   KmerStream -k 31 --binary -o sample1 sample1.fastq
   KmerStream -k 31 --binary -o sample2 sample2.fastq
   ```
2. Merge the estimates:
   ```bash
   KmerStreamJoin -o merged_output sample1_Q_0_k_31 sample2_Q_0_k_31
   ```
3. View the merged results:
   ```bash
   KmerStreamJoin merged_output
   ```

## Expert Tips
- **Memory vs. Accuracy**: The `-e` (error rate) parameter defaults to 0.01 (1%). If you have limited RAM and can tolerate less precision, increase this value. To get higher precision for small genomes, decrease it (e.g., `-e 0.001`), but be aware this increases memory usage.
- **Input Formats**: KmerStream natively supports BAM files using the `-b` flag. It also handles gzipped FASTQ/FASTA files if the system has `zlib` support.
- **K-mer Selection**: Prefer odd values for `-k` to avoid palindromic k-mer complications.
- **Online Mode**: Use `--online` to see estimates every 100,000 reads. This is extremely useful for "stopping" a download or a run once sufficient coverage for a specific genome size estimate has been reached.



## Subcommands

| Command | Description |
|---------|-------------|
| KmerStream | Estimates occurrences of k-mers in fastq or fasta files and saves results |
| KmerStreamJoin | Creates union of many stream estimates |

## Reference documentation
- [KmerStream GitHub Repository](./references/github_com_pmelsted_KmerStream.md)
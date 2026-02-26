---
name: kmerstream
description: "KmerStream estimates k-mer frequency distributions and genomic parameters using a memory-efficient streaming approach. Use when user asks to estimate genome size, determine sequencing depth, assess library error rates, or calculate k-mer statistics from FASTQ or BAM files."
homepage: https://github.com/pmelsted/KmerStream
---


# kmerstream

## Overview
KmerStream is a specialized tool for calculating k-mer frequency distributions without the massive memory requirements of traditional k-mer counters. It uses a streaming approach to provide rapid estimates of essential genomic parameters. It is ideal for pre-assembly QC, estimating genome size (G), determining sequencing depth (lambda), and assessing the error rate (e) of a library.

## Core CLI Usage

### Basic K-mer Statistics
To estimate k-mer occurrences for a specific k-mer size:
```bash
KmerStream -k 31 -o output_prefix sample.fastq
```

### Multi-K Analysis
KmerStream can process multiple k-mer sizes in a single pass, which is useful for determining the optimal k-mer for assembly:
```bash
KmerStream -k 31,47,63,79 -o multi_k_results sample.fastq
```

### Genome Size and Coverage Estimation
To get human-readable estimates for genome size and coverage, you must generate a TSV file and then process it with the included Python script:
```bash
# 1. Generate the TSV statistics
KmerStream -k 31 --tsv -o stats.tsv sample.fastq

# 2. Run the estimator script
python KmerStreamEstimate.py stats.tsv
```

### Processing BAM Files
If your data is already aligned or stored in BAM format:
```bash
KmerStream -b -k 31 -o bam_stats input.bam
```

## Distributed and Incremental Processing
For very large datasets or distributed environments, use the binary output and join functionality.

1. **Generate binary chunks:**
   ```bash
   KmerStream --binary -k 31 -o part1 sample_R1.fastq
   KmerStream --binary -k 31 -o part2 sample_R2.fastq
   ```
   *Note: This creates files with suffixes like `_Q_0_k_31`.*

2. **Merge results:**
   ```bash
   KmerStreamJoin -o merged_output part1_Q_0_k_31 part2_Q_0_k_31
   ```

3. **View merged results:**
   ```bash
   KmerStreamJoin merged_output
   ```

## Expert Tips and Best Practices

- **K-mer Selection:** Always prefer odd values for `-k` (e.g., 31, 55) to avoid palindromic k-mer complications.
- **Quality Filtering:** Use `-q` (e.g., `-q 20`) to ignore k-mers containing low-quality bases. This significantly improves the accuracy of genome size and error rate estimates by filtering out sequencing noise.
- **Memory vs. Accuracy:** The `-e` parameter (default 0.01) controls the error rate of the estimator. If you need higher precision, lower this value (e.g., `-e 0.001`), but be aware that memory usage will increase.
- **Real-time Monitoring:** Use the `--online` flag to see estimates every 100,000 reads. This is particularly useful when piping data directly from a download or a sequencer to decide if you have enough coverage.
- **PHRED Encoding:** If working with older Illumina data (Pipeline < 1.8), use the `--q64` flag for PHRED+64 quality scores. The default is PHRED+33.

## Reference documentation
- [KmerStream Overview](./references/anaconda_org_channels_bioconda_packages_kmerstream_overview.md)
- [KmerStream GitHub Documentation](./references/github_com_pmelsted_KmerStream.md)
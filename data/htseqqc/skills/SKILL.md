---
name: htseqqc
description: `htseqqc` (also known as HTSQualC) is an automated preprocessing tool designed to ensure the integrity of Illumina sequencing data.
homepage: https://reneshbedre.github.io/blog/htseqqc.html
---

# htseqqc

## Overview
`htseqqc` (also known as HTSQualC) is an automated preprocessing tool designed to ensure the integrity of Illumina sequencing data. It streamlines the transition from raw reads to high-quality data by providing simultaneous filtering and trimming capabilities. Beyond data cleaning, it generates comprehensive visual reports—including Phred quality distributions and GC content profiles—allowing for immediate comparative assessment of data quality before and after processing.

## Command Line Usage

The primary interface for the tool is the `filter.py` executable.

### Basic Quality Filtering
To run a standard quality filter (default Phred threshold of 20) on paired-end data:
```bash
filter.py --p1 sample_R1.fastq --p2 sample_R2.fastq --cpu 8
```

### Advanced Trimming and Adapter Removal
If you need to trim low-quality bases rather than discarding the entire read, and remove specific adapter sequences:
```bash
filter.py --p1 R1.fastq --p2 R2.fastq --qthr 25 --trim True --wsz 5 --adp AGATCGGAAGAGCACACGTCTGAACTCCAGTCA,AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
```

### Processing Multiple Samples
You can process multiple files in a single command by separating filenames with commas:
```bash
filter.py --p1 s1_R1.fq,s2_R1.fq --p2 s1_R2.fq,s2_R2.fq --cpu 12
```

## Parameter Reference

| Flag | Long Flag | Description |
|------|-----------|-------------|
| `-a` | `--p1` | Input FASTQ (Single-end or Left/R1 paired-end). |
| `-b` | `--p2` | Input FASTQ (Right/R2 paired-end). |
| `-i` | `--qthr` | Average quality threshold (1-40) [Default: 20]. |
| `-n` | `--trim` | Set to `True` to trim low-quality bases instead of discarding the read. |
| `-p` | `--wsz` | Window size for sliding window trimming (5' -> 3'). |
| `-f` | `--adp` | Adapter sequences to trim (comma-separated). |
| `-e` | `--nb` | Maximum percentage of uncalled bases (N) allowed. |
| `-r` | `--mlk` | Minimum read length to retain after trimming. |
| `-q` | `--cpu` | Number of CPUs for parallel computation. |
| `-v` | `--no-vis` | Set to `True` to suppress the generation of PNG plots. |

## Expert Tips and Best Practices

1.  **Quality Format Auto-detection**: The tool automatically detects Phred quality formats (Illumina 1.8+, Illumina 1.3+, or Sanger). You generally do not need to specify `-c` unless working with ambiguous legacy data.
2.  **Trimming vs. Filtering**: By default, `htseqqc` discards reads that fall below the quality threshold. Use `--trim True` in conjunction with `--wsz` (window size) to perform sliding-window trimming, which preserves the high-quality portions of reads.
3.  **Output Organization**: The tool creates a dedicated output directory named after the input file (e.g., `sample_filtering_out`). Inside, you will find:
    *   `Statistics.txt`: A summary of total reads, filtered reads, and discarded reads.
    *   `*.png`: Visualizations for Phred distribution, GC content, and base composition.
    *   `Command.log`: A record of the exact parameters used for reproducibility.
4.  **Resource Allocation**: For large datasets, always specify `--cpu` to leverage parallel processing, as the default is only 2.
5.  **Visualization**: If running in a headless environment or a high-throughput pipeline where plots aren't needed, use `--no-vis True` to save processing time and disk space.

## Reference documentation
- [HTSQualC: Quality control analysis for high-throughput sequencing data (HTS)](./references/reneshbedre_github_io_blog_htseqqc.html.md)
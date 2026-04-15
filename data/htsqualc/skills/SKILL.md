---
name: htsqualc
description: HTSQualC filters and trims raw sequencing data to remove adapters and low-quality segments while generating visual quality reports. Use when user asks to clean raw sequencing reads, perform quality filtering, remove adapter sequences, or generate PHRED distribution and GC content reports.
homepage: https://reneshbedre.github.io/blog/htseqqc.html
metadata:
  docker_image: "quay.io/biocontainers/htsqualc:1.1--pyhfa5458b_0"
---

# htsqualc

## Overview
HTSQualC is a specialized tool for cleaning raw sequencing data. It performs simultaneous filtering and trimming, allowing for the removal of technical artifacts like adapters and low-quality segments while preserving high-quality genomic information. It is particularly useful for processing multiple samples in parallel and generating visual quality reports (PHRED distribution, GC content, and base composition) to compare raw and cleaned datasets.

## Core Command Patterns

### Basic Quality Filtering
The primary command is `filter.py`. By default, it filters reads with an average quality score below 20.

**Single-end data:**
```bash
filter.py --p1 sample_R1.fastq --cpu 4
```

**Paired-end data:**
```bash
filter.py --p1 sample_R1.fastq --p2 sample_R2.fastq --cpu 8
```

### Advanced Trimming and Adapter Removal
To trim low-quality bases from the ends of reads instead of discarding the entire read, use the `--trim True` flag.

```bash
filter.py --p1 R1.fq --p2 R2.fq --adp AGATCGGAAGAGCACACGTCT,AGATCGGAAGAGCGTCGTGTA --trim True --qthr 25 --mlk 50
```
*   `--adp`: Comma-separated list of adapter sequences.
*   `--qthr`: Sets the PHRED quality threshold (e.g., 25).
*   `--mlk`: Minimum length to keep a read after trimming (e.g., 50bp).

### Handling Multiple Samples
HTSQualC accepts space or comma-separated lists for batch processing. Ensure the order of files in `--p1` matches the order in `--p2`.

```bash
filter.py --p1 s1_R1.fq,s2_R1.fq --p2 s1_R2.fq,s2_R2.fq --cpu 16
```

## Parameter Reference

| Flag | Long Form | Description | Default |
| :--- | :--- | :--- | :--- |
| `-c` | `--qfmt` | Quality format (1=Illumina 1.8, 2=Illumina 1.3, 3=Sanger) | Auto-detect |
| `-e` | `--nb` | Max % of uncalled bases (N) allowed | - |
| `-g` | `--per` | Adapter match threshold (0.0 - 1.0) | 0.9 |
| `-p` | `--wsz` | Sliding window size for trimming (5' -> 3') | 5 |
| `-m` | `--ofmt` | Output format (fastq or fasta) | fastq |
| `-v` | `--no-vis` | Set to `True` to disable image generation | False |

## Expert Tips
*   **Resource Allocation**: Use the `--cpu` flag to match your environment's available cores; HTSQualC scales well for parallel sample processing.
*   **Output Structure**: The tool creates a directory named after the input file (e.g., `sample_filtering_out`). Inside, `Statistics.txt` provides a summary of how many reads were filtered/trimmed.
*   **Visual Validation**: Always check the generated `.png` files (e.g., `*Qualdist.png`, `*GCdist.png`) to verify that the cleaning process successfully shifted the quality distribution and removed artifacts without introducing bias.
*   **N-Base Filtering**: For high-sensitivity downstream applications, use `--nb 0` to discard any reads containing uncalled bases.

## Reference documentation
- [HTSQualC: Quality control analysis for high-throughput sequencing data](./references/reneshbedre_github_io_blog_htseqqc.html.md)
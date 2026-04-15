---
name: filtlong
description: Filtlong filters and subsamples long-read sequencing data based on quality and length to create high-quality datasets. Use when user asks to filter Nanopore reads, subsample data to a target volume, or prioritize high-quality reads using external reference data.
homepage: http://http://canu.readthedocs.org/
metadata:
  docker_image: "quay.io/biocontainers/filtlong:0.3.1--h077b44d_0"
---

# filtlong

## Overview
Filtlong is a specialized tool for processing long-read sequencing data to create high-quality subsets for downstream applications like de novo assembly or variant calling. Unlike simple length filters, it uses a sophisticated scoring system that weighs both read length and estimated quality. It is particularly effective at "cleaning" raw Nanopore data by discarding the "worst" reads until a user-defined threshold or target data volume is met.

## Usage Patterns

### Basic Quality Filtering
To remove the lowest quality reads and very short fragments:
```bash
filtlong --min_length 1000 --keep_percent 90 input.fastq.gz > output.fastq
```

### Target-Based Subsampling
To reduce a large dataset to a specific volume (e.g., 500 MB) while keeping only the highest-scoring reads:
```bash
filtlong --target_bases 500000000 input.fastq.gz > output.fastq
```

### External Reference Weighting
If you have high-quality short reads (Illumina) from the same sample, use them to more accurately identify high-quality long reads:
```bash
filtlong -1 illumina_R1.fastq.gz -2 illumina_R2.fastq.gz input.fastq.gz > output.fastq
```

### Advanced Filtering Criteria
*   **--min_mean_q**: Discard reads below a specific mean Phred quality score.
*   **--min_window_q**: Discard reads if any sliding window within the read falls below a quality threshold (excellent for removing chimeric reads with low-quality junctions).
*   **--mean_q_weight**: Adjust the priority given to quality vs. length (default is 1.0). Increase this to prioritize quality over length.

## Expert Tips
*   **Assembly Optimization**: For de novo assembly, it is often better to have 50x of high-quality, long reads than 100x of mixed-quality data. Use `--target_bases` to aim for a specific coverage depth based on your estimated genome size.
*   **Chimeras**: Use `--min_window_q 7` (or similar) to aggressively target and remove chimeric reads that often plague Nanopore datasets.
*   **Piping**: Filtlong handles gzipped input and can pipe output directly to assemblers like Flye or Raven to save disk space.

## Reference documentation
- [Filtlong Overview](./references/anaconda_org_channels_bioconda_packages_filtlong_overview.md)
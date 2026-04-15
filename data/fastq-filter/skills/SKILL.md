---
name: fastq-filter
description: fastq-filter performs rapid quality control and filtering of sequencing data based on average error rates or Phred scores. Use when user asks to filter FASTQ files by quality, remove short reads, or process paired-end genomic data.
homepage: https://github.com/LUMC/fastq-filter
metadata:
  docker_image: "quay.io/biocontainers/fastq-filter:0.3.0--py312h0fa9677_4"
---

# fastq-filter

## Overview
`fastq-filter` is a specialized tool designed for rapid quality control of sequencing data. Unlike many tools that incorrectly average Phred scores linearly, `fastq-filter` converts scores to their underlying error rates before averaging, ensuring biological accuracy. It is optimized for speed using C-bindings and lookup tables, making it ideal for pre-processing large genomic datasets.

## Installation
Install via Conda or Pip:
```bash
conda install -c bioconda fastq-filter
# OR
pip install fastq-filter
```

## Common CLI Patterns

### Single-End Filtering
Filter a single file by average error rate (e.g., 0.001 for Q30 equivalent) and minimum length:
```bash
fastq-filter -e 0.001 -l 50 -o filtered.fastq input.fastq
```

### Paired-End Filtering
When filtering pairs, the tool keeps records in sync. If one read fails a length filter, the entire pair is discarded.
```bash
fastq-filter -e 0.001 -o r1_out.fq.gz -o r2_out.fq.gz r1.fq.gz r2.fq.gz
```

### Filtering by Phred Scores
If you prefer Phred notation over error rates, use `-q` (mean) or `-Q` (median):
```bash
# Filter for a minimum median quality of 25
fastq-filter -Q 25 -o output.fastq input.fastq

# Filter for a mean quality of 30 (equivalent to -e 0.001)
fastq-filter -q 30 -o output.fastq input.fastq
```

## Expert Tips & Best Practices

- **Error Rate vs. Phred**: Always prefer `-e` (average error rate) for the most mathematically sound quality filtering. Linear averaging of Phred scores (used by many other tools) significantly overestimates quality.
- **Compression**: The tool automatically detects compression based on file extensions. Use the `-c` flag to adjust the Gzip compression level (default is 2 for speed; higher values increase CPU load but reduce file size).
- **Piping**: Use `-` as the input argument to read from stdin, allowing `fastq-filter` to be integrated into larger bioinformatics pipelines without intermediate disk I/O.
- **Length Logic**: For paired-end data, the minimum length filter (`-l`) is satisfied if *at least one* read in the pair meets the requirement. The maximum length filter (`-L`) is satisfied only if *neither* read exceeds the limit.
- **Performance**: For large-scale processing, use the `--quiet` flag to reduce logging overhead, or `--verbose` during initial parameter tuning to see exactly how many reads are being dropped by each specific filter.

## Reference documentation
- [fastq-filter GitHub Repository](./references/github_com_LUMC_fastq-filter.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fastq-filter_overview.md)
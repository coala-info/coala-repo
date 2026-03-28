---
name: fastq-tools
description: fastq-tools is a collection of high-speed utilities for processing, filtering, and summarizing Next-Generation Sequencing data in FASTQ format. Use when user asks to generate read statistics, filter by quality, trim sequences, convert to FASTA, sample reads, or sort datasets.
homepage: http://homes.cs.washington.edu/~dcjones/fastq-tools/
---

# fastq-tools

## Overview

The `fastq-tools` suite provides a collection of C-based utilities designed for high-speed processing of Next-Generation Sequencing (NGS) data. It is particularly effective for pre-processing raw reads before alignment or assembly, offering a lightweight alternative to heavier toolsets. Use this skill to perform rapid quality filtering, sequence trimming, and data summarization on large FASTQ datasets.

## Common CLI Patterns

### Quality Control and Statistics
To generate a summary of read lengths and quality scores:
```bash
fastq-stats input.fastq
```

### Filtering and Trimming
Filter reads based on a minimum average quality score:
```bash
fastq-qual-filter -q 20 -p 80 input.fastq > filtered.fastq
```
*Note: `-q` sets the threshold, and `-p` sets the percentage of bases that must meet that threshold.*

Trim a specific number of bases from the start or end of reads:
```bash
fastq-trim -5 10 -3 5 input.fastq > trimmed.fastq
```

### Format Conversion and Manipulation
Convert FASTQ to FASTA format:
```bash
fastq-to-fasta input.fastq > output.fasta
```

Sample a specific number of reads from a large file (useful for testing):
```bash
fastq-sample -n 10000 input.fastq > subsample.fastq
```

Sort FASTQ files by sequence ID:
```bash
fastq-sort input.fastq > sorted.fastq
```

## Expert Tips

- **Piping for Efficiency**: Since these tools are written in C and output to stdout, chain them together to avoid creating massive intermediate files.
  - *Example*: `fastq-qual-filter -q 20 input.fastq | fastq-trim -3 10 > clean.fastq`
- **Compressed Data**: Most tools in this suite can handle gzipped input directly or via process substitution (e.g., `<(zcat file.fastq.gz)`).
- **Validation**: Always run `fastq-stats` before and after filtering to quantify how many reads were discarded and ensure the quality distribution has improved as expected.



## Subcommands

| Command | Description |
|---------|-------------|
| fastq-sample | Sample random reads from a FASTQ file. |
| fastq-sort | Concatenate and sort FASTQ files and write to standard output. |

## Reference documentation

- [fastq-tools Overview](./references/anaconda_org_channels_bioconda_packages_fastq-tools_overview.md)
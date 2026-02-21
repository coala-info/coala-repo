---
name: guide-counter
description: The `guide-counter` tool is a high-performance utility designed to quantify guide RNAs (sgRNAs) in CRISPR screen sequencing data.
homepage: https://github.com/fulcrumgenomics/guide-counter
---

# guide-counter

## Overview
The `guide-counter` tool is a high-performance utility designed to quantify guide RNAs (sgRNAs) in CRISPR screen sequencing data. It serves as a faster and more sensitive alternative to `mageck count`, capable of recovering more data by automatically detecting guide offsets within reads and allowing for mismatches. Use this skill to prepare raw sequencing data for downstream analysis (like `mageck test`) by generating raw count matrices and quality control statistics.

## Core Command: guide-counter count
The primary workflow involves the `count` command. It processes one or more FASTQ files against a library of expected guide sequences.

### Basic Usage
```bash
guide-counter count \
  --input sample1.fq.gz sample2.fq.gz \
  --library library.txt \
  --output experiment_results
```

### Key Arguments
- `--input`: One or more FASTQ files (can be gzipped).
- `--library`: A tab-delimited file containing guide information.
- `--samples`: (Optional) Custom names for samples, matched positionally to the input FASTQs.
- `--exact-match`: Disable the default 1-mismatch allowance to require perfect matches.

## Advanced Configuration
To improve the quality of the output and generate detailed statistics, provide gene sets and control patterns.

### Annotating Guide Types
You can categorize guides into Essential, Nonessential, or Control groups to generate an extended counts file:
- `--essential-genes`: File containing known essential gene names.
- `--nonessential-genes`: File containing known non-essential gene names.
- `--control-guides`: File containing specific guide IDs to be treated as controls.
- `--control-pattern`: A regex (e.g., `control`) applied to guide IDs and gene names to flag controls.

### Offset Detection
`guide-counter` automatically determines where the guide sequence starts in the read. You can tune this behavior:
- `--offset-sample-size`: Number of reads to check for offset detection (default is usually sufficient).
- `--offset-min-fraction`: The minimum frequency a specific offset must appear in the sample to be considered valid.

## Output Files
The tool produces three main files based on the `--output` prefix:
1. `{output}.counts.txt`: Standard matrix (Guide ID, Gene, and raw counts per sample). Compatible with `mageck`.
2. `{output}.extended-counts.txt`: Includes a `guide_type` column based on provided gene/control lists.
3. `{output}.stats.txt`: QC metrics including total reads, mapped reads, and mean reads per guide category.

## Best Practices
- **Performance**: `guide-counter` is optimized for speed. Use it over `mageck count` for large datasets or when processing time is a bottleneck.
- **Downstream Analysis**: The `{output}.counts.txt` file is designed as a drop-in replacement for `mageck`. You can immediately pipe the results into `mageck test`.
- **Quality Control**: Always check the `frac_mapped` column in the `.stats.txt` file. A low fraction (e.g., < 60%) may indicate issues with the library file, sequencing quality, or unexpected guide offsets.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_fulcrumgenomics_guide-counter.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_guide-counter_overview.md)
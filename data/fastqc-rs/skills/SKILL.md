---
name: fastqc-rs
description: fastqc-rs (invoked via the `fqc` command) is a high-performance quality control tool for FASTQ files, designed as a fast, Rust-based alternative to the original FastQC.
homepage: https://github.com/fxwiegand/fastqc-rs
---

# fastqc-rs

## Overview

fastqc-rs (invoked via the `fqc` command) is a high-performance quality control tool for FASTQ files, designed as a fast, Rust-based alternative to the original FastQC. It generates self-contained HTML reports featuring visualizations for read length, base quality, sequence content, GC content, and k-mer distribution. This tool is ideal for high-throughput sequencing pipelines where processing speed and resource efficiency are priorities.

## Usage Instructions

### Basic Quality Control
Generate a standard HTML report by providing the path to a FASTQ file and redirecting the standard output to a file:

```bash
fqc -q path/to/sequence.fastq > report.html
```

### MultiQC Integration
To generate a summary file compatible with MultiQC alongside the visual HTML report, use the `-s` or `--summary` flag:

```bash
fqc -q input.fastq -s multiqc_summary.txt > report.html
```

### Customizing K-mer Analysis
Adjust the k-mer length for the k-mer content statistics (default is 5) using the `-k` flag:

```bash
fqc -q input.fastq -k 7 > report.html
```

## Best Practices and Tips

- **Output Redirection**: Always remember to redirect stdout to an `.html` file, as `fqc` writes the report directly to the terminal by default.
- **Performance**: Use `fastqc-rs` when working with large datasets or in environments where Java (required by original FastQC) is unavailable or undesirable.
- **Statistics Covered**:
    - Read length distribution
    - Sequence quality scores
    - Per-base sequence quality
    - Per-base sequence content
    - GC content
    - K-mer content

## Reference documentation

- [fastqc-rs Overview](./references/anaconda_org_channels_bioconda_packages_fastqc-rs_overview.md)
- [fastqc-rs GitHub Repository](./references/github_com_fastqc-rs_fastqc-rs.md)
---
name: falco
description: Falco is a high-performance C++ implementation of the popular FastQC tool, designed to assess the quality of large sequencing datasets.
homepage: https://github.com/smithlabcode/falco
---

# falco

## Overview
Falco is a high-performance C++ implementation of the popular FastQC tool, designed to assess the quality of large sequencing datasets. It serves as a drop-in replacement, meaning it accepts similar inputs and produces compatible output files (HTML reports and text summaries) but with improved execution speed. Use this skill to identify common sequencing problems such as adapter contamination, base quality drops, or biased k-mer distributions.

## Installation and Setup
The most efficient way to install falco is via Bioconda:
```bash
conda install -c bioconda falco
```
For source builds requiring BAM support, ensure `htslib` is installed and use the `--enable-hts` flag during configuration.

## Common CLI Patterns

### Basic Quality Control
Run a standard analysis on a single FASTQ file. By default, this creates output files in the same directory as the input.
```bash
falco example.fq
```

### Specifying Output Directory
Direct all results to a specific folder. Falco will create the directory if it does not exist.
```bash
falco -o ./qc_reports/ sample_R1.fastq.gz
```

### Forcing Input Format
If the file extension is non-standard or detection fails, manually specify the format (valid: `bam`, `sam`, `fastq`, `fq`, `fastq.gz`, `fq.gz`).
```bash
falco -f fastq.gz sample_data.dat
```

### High-Resolution Analysis
For reads longer than 50bp, FastQC/Falco normally groups bases. Use `--nogroup` to see data for every single base position.
```bash
falco --nogroup long_reads.fq
```

## Output Files
Falco generates three primary files for every processed sequence file:
1. **fastqc_report.html**: A visual report containing plots for per-base quality, sequence content, and adapter levels.
2. **fastqc_data.txt**: The raw metrics used to generate the report, suitable for programmatic parsing.
3. **summary.txt**: A high-level tab-separated file indicating "PASS", "WARN", or "FAIL" for each QC module.

## Expert Tips and Limitations
- **Parallelization**: As of current versions, the `--threads` option is not yet implemented in falco. To process multiple files in parallel, use shell-level tools like `GNU Parallel` or `xargs -P`.
- **BAM Processing**: If falco was not compiled with `htslib`, BAM files may be treated as unrecognized formats. Always verify your build if working with alignment files.
- **Memory Efficiency**: Falco is generally more memory-efficient than the original Java-based FastQC, making it better suited for high-depth sequencing runs on resource-constrained systems.
- **FastQC Parity**: While falco emulates FastQC, some specific flags like `--casava` or `--nano` are currently ignored. It focuses on the core QC metrics.

## Reference documentation
- [Falco GitHub README](./references/github_com_smithlabcode_falco.md)
- [Bioconda Falco Overview](./references/anaconda_org_channels_bioconda_packages_falco_overview.md)
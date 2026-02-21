---
name: tb-profiler
description: tb-profiler is a command-line tool designed specifically for Mycobacterium tuberculosis genomics.
homepage: https://github.com/jodyphelan/TBProfiler
---

# tb-profiler

## Overview
tb-profiler is a command-line tool designed specifically for Mycobacterium tuberculosis genomics. It automates a complex bioinformatics workflow—including read alignment, variant calling, and database comparison—to provide rapid insights into a sample's strain type and its resistance to anti-tubercular drugs. It supports data from multiple platforms, including Illumina and Oxford Nanopore (minION), and allows for both targeted resistance gene analysis and whole-genome variant calling.

## Core Workflows

### Initial Setup
Before running analyses, ensure the drug resistance database is up to date. The tool and the database are developed independently.
```bash
tb-profiler update_tbdb
```

### Standard Profiling (Illumina)
To run the full pipeline on paired-end reads, use the `profile` command. This performs alignment, variant calling, and resistance profiling.
```bash
tb-profiler profile -1 reads_1.fastq.gz -2 reads_2.fastq.gz -p sample_prefix -t 4
```
- `-p`: Sets the prefix for all output files (BAM, VCF, and results).
- `-t`: Specifies the number of threads to use.

### Analyzing Nanopore (minION) Data
The pipeline automatically handles long-read data, typically using minimap2 for alignment. Note that hetero-resistance prediction is currently not applicable for minION data.
```bash
tb-profiler profile -1 nanopore_reads.fastq.gz -p sample_prefix
```

### Using Existing Alignments
If you already have a BAM file, you can skip the alignment step. 
**Warning:** The BAM must be aligned to the H37Rv reference genome (length 4,411,532 bp) used by the database.
```bash
tb-profiler profile -a sample.bam -p sample_prefix
```

## Advanced Options and Best Practices

### Output Formats
By default, results are saved in JSON format in the `results/` directory. Use flags to generate human-readable reports:
- `--txt`: Tab-separated summary.
- `--csv`: Comma-separated summary.
- `--docx`: Generates a Word document report (requires a template).

### Whole Genome Analysis
By default, the tool only looks at known drug-resistance candidate genes. To call variants across the entire genome:
```bash
tb-profiler profile -1 r1.fq.gz -2 r2.fq.gz -p sample --call_whole_genome
```

### Experimental Features
- **SNP Distance**: When `--call_whole_genome` is active, use `--snp_dist` to find samples in your local library that are closely related to the current sample.
- **Spoligotyping**: Add `--spoligotype` to the command to perform in silico spoligotyping.

### Expert Tips
- **Version Tracking**: Always report both the `tb-profiler` version and the database version in publications, as they are updated on different cycles.
- **Hetero-resistance**: The tool predicts the number of reads supporting a variant. This is crucial for identifying sub-populations of resistant bacteria within a single sample.
- **M1/M2 Macs**: If running on ARM-based macOS, ensure the terminal is running under Rosetta, as many underlying dependencies (like bowtie2 or BWA) are optimized for x86 architecture.

## Reference documentation
- [TB-Profiler GitHub Repository](./references/github_com_jodyphelan_TBProfiler.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tb-profiler_overview.md)
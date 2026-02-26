---
name: readfq
description: The readfq tool provides rapid summarization of sequencing data by calculating the total number of reads and bases in FASTQ files. Use when user asks to count sequences, calculate total nucleotides, or summarize genomic datasets.
homepage: https://github.com/billzt/readfq
---


# readfq

## Overview
The `readfq` tool is a specialized, high-performance utility designed for the rapid summarization of sequencing data. It is particularly effective for large-scale genomic datasets where standard parsing might be too slow. It provides two primary metrics: the total number of sequences (reads) and the cumulative number of nucleotides (bases) within a file.

## Usage Guidelines

### Basic Command
To process a FASTQ file and output statistics to STDOUT:
```bash
kseq_fastq_base [input.fq]
```

### Handling Compressed Files
The tool natively supports GZIP compression. You do not need to decompress files before running the tool:
```bash
kseq_fastq_base sample_data.fq.gz
```

### Performance Expectations
- **Small datasets (~4M reads / 1GB):** Typically processed in under 40 seconds.
- **Large datasets (~50M reads / 14GB):** Typically processed in under 5 minutes.

### Installation and Compilation
If the binary is not present in the environment, it can be installed via Bioconda or compiled from source:

**Conda Installation:**
```bash
conda install -c bioconda readfq
```

**Manual Compilation:**
Requires `zlib`.
```bash
gcc -o kseq_fastq_base kseq_fastq_base.c -lz
```

## Best Practices
- **Piping:** Since the tool outputs to STDOUT, use standard redirection to save results to a report file: `kseq_fastq_base input.fq > stats.txt`.
- **Validation:** Use `readfq` as a first-pass validation step after receiving sequencing data to ensure the read counts match the expected yield from the sequencing facility.
- **Integration:** Incorporate `readfq` into shell scripts for automated QC pipelines where speed is a priority over detailed per-base quality metrics.

## Reference documentation
- [readfq GitHub Repository](./references/github_com_tao-bioinfo_readfq.md)
- [Bioconda readfq Overview](./references/anaconda_org_channels_bioconda_packages_readfq_overview.md)
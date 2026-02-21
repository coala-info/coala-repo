---
name: atol-qc-raw-ont
description: The `atol-qc-raw-ont` tool is designed for the initial processing of raw Nanopore reads.
homepage: https://github.com/TomHarrop/atol-qc-raw-ont
---

# atol-qc-raw-ont

## Overview

The `atol-qc-raw-ont` tool is designed for the initial processing of raw Nanopore reads. It provides a unified interface to trim sequencing adapters and filter reads based on length, consolidating multiple input files into a single, high-quality output. Use this skill when you need to prepare ONT data for downstream applications like genome assembly or variant calling, ensuring that short fragments and technical sequences are removed.

## Command Line Usage

### Basic Processing from Multiple Files
To process a set of compressed FASTQ files directly, use the `--fastqfiles` flag followed by the list of inputs.

```bash
atol-qc-raw-ont \
  --fastqfiles data/*.fastq.gz \
  --out results/cleaned_reads.fastq.gz \
  --stats results/qc_stats.json \
  --threads 8
```

### Processing from a Tar Archive
If your raw data is stored in a tarball, the tool can search for and process all matching files within the archive.

```bash
atol-qc-raw-ont \
  --tarfile data/raw_reads.tar \
  --out results/cleaned_reads.fastq.gz \
  --stats results/qc_stats.json \
  --logs results/qc_logs/
```

### Filtering by Read Length
By default, the tool keeps all reads. Use `--min-length` to discard short reads that may negatively impact assembly quality.

```bash
atol-qc-raw-ont \
  --fastqfiles input.fastq.gz \
  --out output.fastq.gz \
  --stats stats.json \
  --min-length 1000
```

## Expert Tips and Best Practices

### Critical Locale Configuration
The underlying `filtlong` tool may crash if the system locale is not set correctly. Always ensure your environment is configured to use the C locale before execution:

```bash
export LC_ALL=C
# Or when using Apptainer/Singularity
apptainer exec --env LC_ALL=C docker://... atol-qc-raw-ont [args]
```

### File Naming Requirements
The tool uses a specific search pattern (`find -name "*.fastq.gz"`) when extracting files from a tar archive. Ensure your input files are named exactly with the `.fastq.gz` extension; files named `.fq.gz` or uncompressed `.fastq` files will be ignored.

### Resource Management
- **Threads**: Use the `-t` or `--threads` flag to speed up adapter trimming.
- **Dry Run**: Use the `-n` flag to validate your command and check file paths without executing the heavy processing steps.
- **Logs**: Always specify a `--logs` directory to capture the output from `porechop` and `filtlong` for troubleshooting and reproducibility.

## Reference documentation
- [Main Repository and Usage Guide](./references/github_com_TomHarrop_atol-qc-raw-ont.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_atol-qc-raw-ont_overview.md)
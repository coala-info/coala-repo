---
name: atol-qc-raw-shortread
description: This tool performs quality control, adapter trimming, and filtering for Illumina short-read sequencing data. Use when user asks to process raw FASTQ files, trim adapters from Hi-C libraries, perform quality-based filtering, or generate read processing statistics.
homepage: https://github.com/TomHarrop/atol-qc-raw-shortread
---


# atol-qc-raw-shortread

## Overview
The `atol-qc-raw-shortread` tool is a specialized utility designed for the initial processing of Illumina short-read data, with a particular focus on Hi-C libraries. It streamlines the workflow of validating read pairs, trimming adapters, and performing quality-based filtering. By leveraging `bbduk.sh` internally, it provides high-performance trimming that is optimized for multi-threaded environments. This skill provides the necessary command-line patterns and configuration logic to execute these QC steps efficiently.

## Command Line Usage

### Basic Execution
To process a pair of raw FASTQ files with adapter trimming:

```bash
atol-qc-raw-shortread \
  --in data/read_R1.fastq.gz \
  --in2 data/read_R2.fastq.gz \
  --adaptors resources/adapters.fasta \
  --out results/trimmed_R1.fastq.gz \
  --out2 results/trimmed_R2.fastq.gz \
  --stats results/qc_metrics.json
```

### Quality Trimming
Enable quality-based trimming at the right ends of reads by specifying the threshold:

```bash
atol-qc-raw-shortread \
  --in R1.fq.gz --in2 R2.fq.gz \
  --out R1_out.fq.gz --out2 R2_out.fq.gz \
  --stats stats.json \
  --qtrim \
  --trimq 10
```

## Expert Tips and Best Practices

### Threading and Performance
*   **IO Bottlenecks**: The underlying trimming process is often IO-bound because it writes compressed `fq.gz` files. 
*   **Optimal Thread Count**: Testing indicates that **14 threads** (`-t 14`) is generally the "sweet spot" for balancing processing speed with IO overhead.
*   **Dry Runs**: Use the `-n` flag to validate your command-line arguments and file paths without executing the actual processing.

### Adapter Handling
*   **Multiple Files**: You can pass multiple adapter files to the `--adaptors` argument if your library contains a mix of potential contaminants.
*   **Container Paths**: If running via the BioContainer (Apptainer/Singularity), the default BBMap adapter files are typically located at `/usr/local/opt/bbmap/resources/adapters.fa`.

### Logging and Debugging
*   **Log Retention**: By default, logs are discarded. For production pipelines or troubleshooting, always specify a log directory:
    ```bash
    --logs ./processing_logs/
    ```
*   **Stats Output**: The tool generates a JSON file containing read counts and processing metrics. This file is essential for downstream multi-QC reporting or pipeline validation.

## Reference documentation
- [atol-qc-raw-shortread Overview](./references/anaconda_org_channels_bioconda_packages_atol-qc-raw-shortread_overview.md)
- [GitHub Repository and Usage Guide](./references/github_com_TomHarrop_atol-qc-raw-shortread.md)
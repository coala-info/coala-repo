---
name: longqc
description: LongQC is a diagnostic tool specifically engineered for the unique error profiles and characteristics of third-generation sequencing (TGS).
homepage: https://github.com/yfukasawa/LongQC
---

# longqc

## Overview
LongQC is a diagnostic tool specifically engineered for the unique error profiles and characteristics of third-generation sequencing (TGS). It provides two primary workflows: **Sample QC**, which evaluates standard sequence files (FASTA, FASTQ, or PacBio BAM) to determine if data is ready for downstream analysis, and **Platform QC**, which provides fundamental run statistics and productivity plots. It is particularly useful when a reference genome is unavailable or when a quick, reference-independent assessment of sequencing performance is required.

## Common CLI Patterns

### Sample QC Workflows
The primary command structure is `python longQC.py sampleqc [options]`. You must specify a preset using `-x` to apply appropriate adapter and overlap parameters.

**PacBio Data:**
*   **RS-II:** `python longQC.py sampleqc -x pb-rs2 -o out_dir input_reads.fq`
*   **Sequel (BAM):** `python longQC.py sampleqc -x pb-sequel -o out_dir input_reads.bam`

**Oxford Nanopore (ONT) Data:**
*   **1D Ligation:** `python longQC.py sampleqc -x ont-ligation -o out_dir input_reads.fq`
*   **Rapid Kit:** `python longQC.py sampleqc -x ont-rapid -o out_dir input_reads.fq`

### Key Arguments
*   `-x, --preset`: Sets the platform/kit. Options: `pb-rs2`, `pb-sequel`, `ont-ligation`, `ont-rapid`, `ont-1dsq`.
*   `-o, --output`: Path to the output directory.
*   `-p, --ncpu`: Number of CPUs to use. Use `$(nproc)` on Linux or `$(sysctl -n hw.physicalcpu)` on Mac.
*   `-t, --transcript`: Apply this flag if the input data consists of transcripts (RNA-seq).
*   `-s, --sample_name`: Adds a specific suffix to output files for easier identification in multi-sample runs.

## Performance and Memory Optimization
*   **Fast Mode (`-f`)**: Disables sensitive settings to reduce memory usage and processing time. **Warning**: Do not use this for datasets with shallow coverage (less than 15x).
*   **Memory Limit (`-m`)**: Controls the memory limit for chunking in gigabytes. Default is 0.5 GB (range: >0 to <=2).
*   **Parallel Indexing (`-d`)**: Use this to build the minimap2 database in parallel with other tasks to save time.
*   **Index Size (`-i`)**: Adjust the minimap2 index size (default 4G). Reduce this if running on machines with limited RAM.

## Expert Tips
*   **Input Requirements**: LongQC expects at least 5x coverage for reliable statistics.
*   **Adapter Trimming**: Use `-c` followed by a path to save trimmed reads if you want LongQC to output the cleaned sequences.
*   **Docker Usage**: Because LongQC depends on a specific modified version of minimap2 (`minimap2-coverage`), using the official Docker image is the most reliable way to avoid compilation and dependency issues.
*   **Mac Silicon (M1/M2)**: If compiling manually on ARM architecture, ensure you use version 1.2.1 or newer and include `arm_neon=1 aarch64=1` flags during the `make` process for `minimap2-coverage`.

## Reference documentation
- [LongQC GitHub Repository](./references/github_com_yfukasawa_LongQC.md)
- [LongQC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_longqc_overview.md)
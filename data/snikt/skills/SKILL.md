---
name: snikt
description: snikt (Slice Nucleotides Into Klassifiable Tequences) is a specialized utility for detecting and removing systemic contamination in DNA/RNA sequencing reads.
homepage: https://github.com/piyuranjan/SNIKT
---

# snikt

## Overview

snikt (Slice Nucleotides Into Klassifiable Tequences) is a specialized utility for detecting and removing systemic contamination in DNA/RNA sequencing reads. Unlike traditional trimmers that require a database of known adapter sequences, snikt identifies contamination by detecting biases in nucleotide composition and Phred quality scores at the ends of reads. While it supports Illumina data for identification purposes, it is most effective for long-read data (e.g., Oxford Nanopore) where end-trimming has a minimal impact on overall throughput.

## Installation

The recommended installation method is via Bioconda:

```bash
conda install bioconda::snikt
```

## Common CLI Patterns

### Interactive Identification and Trimming
Use this mode for exploratory analysis on a local machine where you can view generated plots in real-time.

```bash
snikt.R reads.fastq.gz
```
*   **Workflow**: The tool processes the top 10,000 reads, displays a composition graph, and pauses to prompt the user for specific left/right trim lengths and a minimum read length filter.

### Batch Mode (Headless/HPC)
For remote servers or automated pipelines, use a two-phase approach.

**Phase 1: Identification (No Trimming)**
```bash
snikt.R --notrim reads.fastq.gz
```
*   Generates a 6-panel PDF report showing pre-QC metrics. Use this report to determine the optimal trim coordinates.

**Phase 2: Cleanup (Applying Trims)**
Once trim lengths are determined from the Phase 1 report, run the tool with explicit parameters:
```bash
snikt.R -l <left_trim> -r <right_trim> -f <min_length> reads.fastq.gz
```

### Processing Illumina Data
To identify contamination in short-read datasets, use the Illumina preset. Note that end-trimming is disabled by default for short reads to prevent excessive data loss.

```bash
snikt.R --illumina reads.fastq.gz
```

### Full Dataset Analysis
By default, snikt "skims" the first 10,000 reads to save time. For higher precision on heterogeneous samples, analyze the entire file:

```bash
snikt.R --skim=0 reads.fastq.gz
```

## Expert Tips

*   **Parallelization**: For large projects with multiple FASTQ files, use GNU Parallel to run the identification phase across multiple cores:
    ```bash
    parallel -j 4 snikt.R --notrim {} ::: *.fastq.gz
    ```
*   **Visual Cues**: When reviewing the generated reports, look for "spikes" or "plateaus" in specific nucleotide frequencies (A, T, C, or G) at the start or end of the x-axis. These typically indicate adapter sequences or barcodes.
*   **Backend**: snikt uses `seqtk` for high-performance FASTQ handling. Ensure `seqtk` is in your PATH if you are using a local R installation instead of the Conda package.
*   **Output**: Cleaned reads are exported to a new FASTQ file, and a final summary report is generated to show the "before and after" state of the library.

## Reference documentation

- [snikt - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_snikt_overview.md)
- [GitHub - piyuranjan/SNIKT](./references/github_com_piyuranjan_SNIKT.md)
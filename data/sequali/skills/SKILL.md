---
name: sequali
description: sequali is a high-performance sequencing quality control tool that provides rapid insights into genomic data with a minimal memory footprint. Use when user asks to perform quality control on FASTQ or BAM files, generate MultiQC-compatible reports, or analyze adapter contamination and insert size metrics.
homepage: https://github.com/rhpvorderman/sequali
---


# sequali

## Overview

`sequali` is a high-performance sequencing quality control tool designed to provide rapid insights into genomic data with a minimal memory footprint (typically under 2 GB). It serves as a modern, faster alternative to FastQC, offering specialized visualizations for base quality, adapter contamination, and overrepresented sequences. It is the preferred tool when processing large datasets on resource-constrained systems or when building efficient bioinformatics pipelines that require MultiQC-compatible outputs.

## Command Line Usage

### Basic Execution
Run `sequali` on a single compressed or uncompressed FASTQ file:
```bash
sequali sample.fastq.gz
```
This generates `sample.fastq.gz.html` (visual report) and `sample.fastq.gz.json` (raw metrics) in the current directory.

### Paired-End Data
Provide both files as positional arguments to enable insert size metrics and overlap-based adapter analysis:
```bash
sequali sample_R1.fastq.gz sample_R2.fastq.gz
```

### Working with BAM Files
`sequali` supports unaligned BAM (uBAM) files, which is common for Oxford Nanopore (ONT) data:
```bash
sequali sample.bam
```
*Note: For aligned BAM files, the tool automatically ignores secondary and supplementary alignments to ensure metrics reflect the primary library quality.*

### Output Management
Use the `--out-dir` flag to organize reports, especially when processing multiple samples for MultiQC:
```bash
sequali --out-dir ./qc_results/ sample.fastq.gz
```

To specify exact filenames for the outputs:
```bash
sequali --html report.html --json report.json sample.fastq.gz
```

## Expert Tips and Best Practices

### Resource Optimization
*   **Threading**: `sequali` uses one thread for decompression and one for processing. Setting `--threads` higher than 2 has no performance benefit due to decompression bottlenecks.
*   **HPC Environments**: In SLURM or similar schedulers, use `--threads 1` to maximize efficiency when running many files in parallel across different nodes.

### Platform-Specific Features
*   **Illumina**: Automatically generates per-tile quality plots if the FASTQ headers contain tile information.
*   **Nanopore**: Provides channel-specific plots and end-anchored quality plots. It also detects read-splitting performed by basecallers like Dorado.
*   **Adapter Detection**: The tool checks for 6 Illumina and 17 Nanopore adapter sequences by default.

### Advanced Reporting
*   **MultiQC**: `sequali` is natively supported by MultiQC (v1.22+). Always generate the `.json` output to allow MultiQC to aggregate results across a project.
*   **Image Extraction**: Use the `--images-zip` flag to export all report plots as a standalone zip file for use in presentations or publications.
*   **Reproducibility**: Reports are generated without timestamps by default, ensuring that identical input data produces identical report checksums.

### Data Compatibility
*   **Phred Scores**: Only Sanger/Phred+33 encoding is supported.
*   **Overrepresentation**: The tool uses 21 bp fragments for overrepresentation analysis. By default, it samples the first and last 100 bp of reads to reduce false positives from common genomic repeats.

## Reference documentation
- [sequali GitHub Repository](./references/github_com_rhpvorderman_sequali.md)
- [sequali Version Tags and Changelog](./references/github_com_rhpvorderman_sequali_tags.md)
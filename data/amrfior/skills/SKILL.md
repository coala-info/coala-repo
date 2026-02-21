---
name: amrfior
description: AMRfíor is a multi-tool orchestration framework for identifying antimicrobial resistance genes in genomic data.
homepage: https://github.com/NickJD/AMRfior
---

# amrfior

## Overview
AMRfíor is a multi-tool orchestration framework for identifying antimicrobial resistance genes in genomic data. It streamlines the process of running various alignment algorithms against curated AMR databases and applies transparent validation thresholds for coverage and identity. This skill allows you to configure complex search workflows, manage database selection, and recompute statistics from existing results without rerunning computationally expensive alignments.

## Installation and Setup
The tool is primarily distributed via Bioconda, which ensures all underlying dependencies (samtools, blast, diamond, etc.) are correctly configured.

```bash
# Recommended installation
conda install -c bioconda amrfior

# Alternative via pip (requires manual dependency management)
pip install amrfior
```

## Core Command Line Usage

### Basic Analysis
To run a standard analysis using default tools (all except slow BLASTn/x) and default databases (CARD and ResFinder):

```bash
# For Single-FASTA
AMRfior -i input.fasta -st Single-FASTA -o output_dir/

# For Paired-End FASTQ
AMRfior -i R1.fastq,R2.fastq -st Paired-FASTQ -o output_dir/
```

### Tool and Database Selection
Customize the pipeline by specifying tools and databases to balance speed and sensitivity.

```bash
# Run only protein-based tools (DIAMOND)
AMRfior -i input.fasta -st Single-FASTA -o output_dir/ --protein-only

# Use specific tools and include the NCBI database
AMRfior -i input.fasta -st Single-FASTA -o output_dir/ --tools diamond bowtie2 --databases card ncbi
```

### Sensitivity Presets
Use the `--sensitivity` flag to apply optimized tool-specific parameters:
- `default`: Standard tool settings.
- `conservative`: Higher stringency.
- `sensitive`: Increased search depth.
- `very-sensitive`: Applies DIAMOND `--ultra-sensitive` and Bowtie2 `--very-sensitive-local`.

## Expert Tips and Best Practices

### 1. Optimizing Performance
BLASTn and BLASTx are disabled by default because they are significantly slower than DIAMOND or mapping-based tools. Only enable them if you require the specific alignment characteristics of BLAST for a small number of sequences.

### 2. Handling Long Reads
When working with Oxford Nanopore or PacBio data, use the Minimap2 preset to ensure the alignment algorithm is tuned for long-read error profiles:
```bash
AMRfior -i long_reads.fastq -st Single-FASTA -o output_dir/ --minimap2-preset map-ont
```

### 3. Iterative Thresholding with Recompute
If you need to adjust detection thresholds (e.g., identity or coverage) after a run, do not rerun the entire pipeline. Use `AMRfior-Recompute` to process the existing `raw_outputs/` directory:
```bash
AMRfior-Recompute -i original_output_dir/ -o new_threshold_results/ --d-min-id 95 --d-min-cov 90
```

### 4. Sequence Extraction
To obtain the actual sequences that matched AMR genes for downstream analysis, use the `--report-fasta` flag:
- `detected`: Reports reads passing thresholds.
- `detected-all`: Reports all reads associated with a detected gene.

## Detection Parameters
Fine-tune these thresholds to reduce false positives in complex metagenomic samples:
- `--d-min-cov`: Minimum percentage of the reference gene length covered (Default: 80.0).
- `--d-min-id`: Minimum percentage identity (Default: 80.0).
- `--d-min-base-depth`: Minimum average depth across covered regions (Default: 1.0).

## Reference documentation
- [AMRfior Overview](./references/anaconda_org_channels_bioconda_packages_amrfior_overview.md)
- [AMRfior GitHub Repository](./references/github_com_NickJD_AMRfior.md)
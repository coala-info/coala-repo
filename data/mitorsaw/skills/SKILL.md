---
name: mitorsaw
description: Mitorsaw analyzes PacBio HiFi data to perform mitochondrial genome assembly, heteroplasmy detection, and NUMT filtering. Use when user asks to reconstruct mitochondrial haplotypes, call low-frequency variants, or filter nuclear mitochondrial segments from long-read sequencing data.
homepage: https://github.com/PacificBiosciences/mitorsaw
---

# mitorsaw

## Overview

Mitorsaw is a specialized bioinformatics tool designed to leverage the high accuracy and long-read nature of PacBio HiFi data for comprehensive mitochondrial genome analysis. Unlike standard variant callers, it specifically addresses the challenges of the circular mitochondrial genome, including the detection of low-frequency heteroplasmy and the filtering of nuclear mitochondrial segments (NUMTs) that often confound mitochondrial mapping. It produces phased VCFs and haplotype-specific consensus sequences, allowing for a detailed view of mitochondrial diversity within a single sample.

## Core Workflow: Haplotype Analysis

The primary command is `mitorsaw haplotype`. This command performs the full pipeline: read parsing, NUMT removal, variant calling, and haplotype reconstruction.

### Basic Command Pattern
```bash
mitorsaw haplotype \
    --reference path/to/GRCh38.fasta \
    --bam input_sample.bam \
    --output-vcf results.vcf.gz \
    --output-hap-stats stats.json
```

### Key Requirements
- **Reference**: Must be GRCh38 and must contain the `chrM` contig.
- **Input**: BAM files must be indexed (`.bai`). You can specify `--bam` multiple times to include multiple files for a single sample.
- **Resources**: The process is single-threaded. Ensure at least 20GB of RAM is available, primarily for the remapping step used to identify NUMTs.

## Heuristic Tuning and Optimization

Adjust these parameters to balance sensitivity against false discovery, depending on your research goals:

- **Sensitivity for Low-Frequency Variants**:
  Use `--minimum-maf` (default: 0.10) to control the Minimum Allele Frequency. Lowering this (e.g., to 0.01 or 0.05) increases the detection of rare heteroplasmic variants but may introduce noise from sequencing artifacts.
- **Filtering False Positives**:
  Use `--minimum-read-count` (default: 3) to set the minimum number of supporting reads required for a heteroplasmic variant. Increasing this value is recommended for datasets with lower coverage to ensure variant call robustness.
- **Sample Naming**:
  By default, the tool uses the SM tag from the BAM read group. Use `--sample-name {NAME}` to manually override the sample name in the output VCF.

## Interpreting Outputs

### Phased VCF
The VCF output uses the pipe (`|`) symbol to indicate phasing.
- **GT Field**: `0|1|0` indicates that the variant is absent in the primary consensus (`hap_0`), present in `hap_1`, and absent in `hap_2`.
- **AD/DP**: The Allele Depth (AD) sum may be less than the Total Depth (DP) if reads overlap a locus but cannot be confidently assigned (common in homopolymer regions).

### Debugging and Visualization
Use the `--output-debug {FOLDER}` flag to generate auxiliary files. This is highly recommended for:
- **IGV Review**: It generates customized BAMs and tracks optimized for viewing mitochondrial alignments.
- **Coverage Analysis**: Produces `coverage_stats.json` to verify sequencing depth across the 16.5kb genome.



## Subcommands

| Command | Description |
|---------|-------------|
| mitorsaw | a tool for haplotyping mitochondria from HiFi data. Select a subcommand to see more usage information: |
| mitorsaw_build | Download and build the mitochondria database |
| mitorsaw_haplotype | Run the haplotyper on a dataset |

## Reference documentation
- [Mitorsaw User Guide](./references/github_com_PacificBiosciences_mitorsaw_blob_main_docs_user_guide.md)
- [Installation and CLI Basics](./references/github_com_PacificBiosciences_mitorsaw_blob_main_docs_install.md)
- [Mitorsaw README](./references/github_com_PacificBiosciences_mitorsaw_blob_main_README.md)
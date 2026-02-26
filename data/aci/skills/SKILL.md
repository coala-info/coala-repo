---
name: aci
description: The Amplicon Coverage Inspector evaluates sequencing coverage at the amplicon level to distinguish between total and unique read depths. Use when user asks to perform quality control on amplicon-based sequencing, identify amplicon dropouts, or assess coverage uniformity across tiled schemes.
homepage: https://github.com/erinyoung/ACI
---


# aci

## Overview
The Amplicon Coverage Inspector (ACI) is a specialized bioinformatics tool for quality control of amplicon-based sequencing. While standard tools calculate per-base depth, ACI evaluates coverage at the amplicon level. It is particularly valuable for tiled schemes where amplicons overlap, as it distinguishes between "Max Depth" (total reads contained within an amplicon) and "Min Depth" (reads uniquely assigned to a single amplicon). This distinction helps researchers identify regions where variant allele frequency (VAF) calculations might be less reliable due to read ambiguity.

## Installation and Setup
ACI can be installed via Bioconda or PyPI:
- **Conda**: `conda install -c bioconda aci`
- **PyPI**: `pip install amplicon_coverage_inspector`

## Core CLI Usage
The basic syntax requires one or more BAM files and a specific BED file defining the amplicon coordinates.

### Common Command Patterns
- **Single Sample**:
  `aci --bam input.bam --bed amplicon.bed --out results_dir`
- **Batch Processing**:
  `aci --bam *.bam --bed amplicon.bed --out results_dir`
- **Performance Optimization**:
  `aci -b *.bam -d amplicon.bed -o results_dir -t 8` (Uses 8 threads for sorting and counting)

## Input Requirements and Best Practices
To ensure accurate results, follow these data preparation standards:

### 1. The BED File (Critical)
ACI does **not** use standard primer scheme BED files. It requires a 4-column, tab-delimited BED file defining the **insert (biological) coordinates**.
- **Format**: `Reference  Start  End  Name`
- **Coordinates**: 0-based, half-open.
- **Example**: If primers are at 30-54 and 385-410, the ACI BED entry should be `Reference 54 385 Amplicon_1`.

### 2. BAM Pre-processing
- **Primer Trimming**: Always trim primers from your BAM files before running ACI. ACI analyzes biological insert coverage; untrimmed primers will mask variants and artificially inflate coverage metrics.
- **Reference Names**: Ensure the reference sequence names in the BED file match the BAM header exactly (e.g., `MN908947.3`).

## Interpreting Results
ACI produces several key outputs in the results directory:

### Depth Metrics
- **Max Depth (`amplicon_max_depth.csv`)**: Lenient count. Includes any read pair strictly contained within the amplicon boundaries, even if it overlaps a neighbor.
- **Min Depth (`amplicon_min_depth.csv`)**: Strict count. Only includes read pairs uniquely contained in exactly one amplicon.
- **Expert Tip**: A large divergence between Max and Min depth indicates that most coverage comes from overlapping regions. This suggests fragment lengths exceed the non-overlapping window, which may reduce confidence in VAF for those specific amplicons.

### Quality Control Reports
- **`dropout_report.tsv`**: Lists amplicons failing the depth threshold (default <10x) in more than 50% of samples.
- **`sample_uniformity_report.tsv`**: Provides Gini coefficients. A higher score indicates poorer coverage evenness across the scheme.
- **`heatmap_min_depth.png`**: A log-scale visualization where dark spots immediately highlight dropouts across the cohort.

## Advanced Parameters
- `--fail-threshold`: Set the minimum depth required to "pass" an amplicon (default: 10).
- `--fail-percentage`: Set the percentage of samples that must fail for an amplicon to be flagged in the dropout report (default: 50).

## Reference documentation
- [Amplicon Coverage Inspector (ACI) Main Documentation](./references/github_com_erinyoung_ACI.md)
- [ACI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_aci_overview.md)
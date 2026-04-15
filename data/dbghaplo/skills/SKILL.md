---
name: dbghaplo
description: dbghaplo phases long-read sequencing data from heterogeneous samples using a SNP-encoded positional de Bruijn Graph approach. Use when user asks to phase long reads into distinct haplotypes, reconstruct viral quasispecies, or process high-depth amplicon sequencing data.
homepage: https://github.com/bluenote-1577/dbghaplo
metadata:
  docker_image: "quay.io/biocontainers/dbghaplo:0.0.2--ha6fb395_1"
---

# dbghaplo

## Overview

dbghaplo is a high-performance tool for phasing long-read sequencing data from heterogeneous samples. It uses a SNP-encoded positional de Bruijn Graph approach to group reads with similar alleles into distinct haplotypes. This tool is particularly effective for high-depth datasets (up to 30,000x coverage) and highly diverse samples containing more than 10 distinct haplotypes. Because it scales linearly with sequencing depth and the number of SNPs, it can process complex gene-sized regions in minutes.

## Installation

The tool is available via Bioconda. It is recommended to use `mamba` for faster dependency resolution:

```bash
mamba install -c bioconda dbghaplo
```

## Common CLI Patterns

### 1. Automated Pipeline (Recommended)
If starting from raw reads, use the wrapper script which handles alignment (minimap2) and variant calling (lofreq) before haplotyping.

```bash
run_dbghaplo_pipeline -i reads.fastq.gz -r reference.fasta -o output_directory --overwrite
```

### 2. Manual Execution
If you already have a BAM file and a VCF of called variants, run the core engine directly. Note that the VCF must be bgzipped and indexed.

```bash
dbghaplo -b input.bam -v variants.vcf.gz -r reference.fasta
```

### 3. Output Interpretation
The tool generates a results folder (default: `dbghaplo_output`). Key outputs include:
- **Haplotagged BAM**: A BAM file where reads are assigned to specific haplotype groups, suitable for visualization in IGV.
- **MSA**: Multiple Sequence Alignments of the reconstructed haplotypes.

## Expert Tips and Best Practices

- **Target Sequence Size**: dbghaplo is a "local" haplotyper. It works best when the target sequence (e.g., a specific gene or viral segment) fits within the length of the long reads. For whole-genome scale haplotyping of large organisms, consider tools like `floria` instead.
- **High Heterogeneity**: If you suspect a very high number of strains (e.g., a complex viral quasispecies), dbghaplo is preferred over traditional overlap-layout-consensus tools due to its de Bruijn Graph architecture.
- **Input Requirements**: When running the manual command, ensure your BAM file is sorted and indexed (`samtools index`). The VCF should contain high-quality SNPs to ensure accurate graph construction.
- **Resource Efficiency**: The tool is written in Rust and is highly memory-efficient. It is suitable for use on standard workstations even with extremely high-coverage amplicon data.

## Reference documentation
- [dbghaplo GitHub README](./references/github_com_bluenote-1577_dbghaplo.md)
- [dbghaplo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dbghaplo_overview.md)
- [dbghaplo Wiki Home](./references/github_com_bluenote-1577_dbghaplo_wiki.md)
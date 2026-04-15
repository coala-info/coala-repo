---
name: amplici
description: AmpliCI is a model-based clustering tool used to denoise Illumina amplicon sequences and distinguish true biological haplotypes from sequencing errors. Use when user asks to estimate sequencing error profiles, infer haplotypes and their abundances, or assign reads to a reference set of haplotypes.
homepage: https://github.com/DormanLab/AmpliCI
metadata:
  docker_image: "quay.io/biocontainers/amplici:2.2--h2555670_1"
---

# amplici

## Overview
AmpliCI (Amplicon Clustering Inference) is a specialized tool for denoising Illumina amplicon sequences. It employs an approximate model-based clustering approach to distinguish true biological sequences (haplotypes) from sequencing errors. The workflow typically involves a two-stage process: first, empirically estimating the error profile of the sequencing run, and second, using that profile to infer the underlying haplotypes and their relative abundances. It is particularly effective for high-throughput marker gene surveys (e.g., 16S rRNA) where accuracy in variant calling is critical.

## Preprocessing Requirements
AmpliCI is strict regarding input formatting. Before running the tool, ensure your FASTQ files meet these criteria:
- **Uniform Length**: All reads must be trimmed to the exact same length.
- **No Ambiguous Bases**: Reads containing 'N' must be removed.
- **Standard Format**: Each read must occupy exactly four lines.

**Recommended Preprocessing Commands:**
```bash
# Remove reads with 'N' bases
seqkit grep -srv -p 'N' input.fastq > clean.fastq

# Ensure 4-line format (no line wrapping in sequences)
seqkit seq clean.fastq -w 0 > final.fastq
```

## Core Workflows

### 1. Error Profile Estimation
Always estimate a data-specific error profile rather than relying on default Phred scores to avoid high false-positive rates and slow execution.
```bash
run_AmpliCI --fastq input.fastq --outfile error_profile.out --error
```

### 2. Haplotype and Abundance Inference
Once the error profile is generated, use it to infer haplotypes.
```bash
run_AmpliCI --fastq input.fastq --outfile output_prefix --abundance 2 --profile error_profile.out
```
*Note: The `--abundance` parameter sets the minimum abundance threshold for a cluster to be considered a true haplotype.*

### 3. Read Reassignment
To assign reads from a sample to a pre-defined set of haplotypes (e.g., from a previous run or database):
```bash
run_AmpliCI --fastq input.fastq --outfile assignment.id --profile error_profile.out --haplotypes reference_haplotypes.fa
```

## Expert Tips and Best Practices
- **Long Read Adjustment**: For reads longer than 300bp (such as merged paired-end reads), the default screening threshold may be too restrictive. Decrease the log-likelihood bound to improve sensitivity:
  `--log_likelihood -200` (Default is -100).
- **Paired-End Data**: AmpliCI does not process forward and reverse reads simultaneously. You must either analyze one direction only or merge the reads (e.g., using PEAR or FLASH) before inputting them into AmpliCI.
- **UMI Support**: For sequences with Unique Molecular Identifiers, refer to the DAUMI extension included in AmpliCI v2.0+.
- **Performance**: Using a specific `--profile` significantly increases the speed of the abundance estimation step compared to using raw Phred quality scores.

## Reference documentation
- [AmpliCI GitHub Repository](./references/github_com_DormanLab_AmpliCI.md)
- [AmpliCI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_amplici_overview.md)
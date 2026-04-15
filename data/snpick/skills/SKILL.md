---
name: snpick
description: snpick is a high-performance utility designed to identify and extract variable sites from genomic alignments. Use when user asks to extract SNPs from FASTA alignments, generate VCF files from sequence data, or prepare SNP-only datasets for phylogenetic analysis.
homepage: https://github.com/PathoGenOmics-Lab/snpick
metadata:
  docker_image: "quay.io/biocontainers/snpick:1.0.0--h3f2c17f_0"
---

# snpick

## Overview

snpick is a high-performance, Rust-based utility designed to identify and extract variable sites from genomic alignments. It serves as a scalable alternative to tools like `snp-sites`, specifically optimized to handle thousands of sequences or megabase-length alignments with minimal RAM overhead. The tool is particularly useful for researchers in epidemiology and population genomics who need to generate SNP datasets compatible with Ascertainment Bias Correction (ASC) in phylogenetic workflows.

## Installation

Install snpick via Bioconda for the most stable environment:

```bash
conda install -c bioconda snpick
# OR
mamba install -c bioconda snpick
```

## Common CLI Patterns

### Basic SNP Extraction
Extract all variable sites from a FASTA alignment into a new SNP-only FASTA file:

```bash
snpick --fasta input_alignment.fasta --output snp_sites.fasta
```

### Generating VCF Files
To produce a Variant Call Format (VCF) file alongside the SNP alignment for downstream genomic analysis:

```bash
snpick --fasta input_alignment.fasta --output snp_sites.fasta --vcf --vcf-output snp_calls.vcf
```

### Performance Optimization
By default, snpick uses 4 threads. For large datasets, scale this to match your available CPU cores:

```bash
snpick --fasta input_alignment.fasta --output snp_sites.fasta --threads 16
```

## Expert Tips and Best Practices

- **Phylogenetic Compatibility**: The SNP-only FASTA output is specifically designed for use with RAxML or IQ-TREE. When using these tools, ensure you apply Ascertainment Bias Correction (e.g., `+ASC` in IQ-TREE) to account for the absence of invariant sites in the filtered alignment.
- **Handling Ambiguity**: snpick natively handles IUPAC ambiguous nucleotides. It identifies a site as a SNP if there is variation among the sequences, even when ambiguous bases are present, ensuring higher sensitivity in low-coverage or complex datasets.
- **Memory Efficiency**: Unlike many Python or Perl-based scripts, snpick uses a streaming approach and parallel processing in Rust. It is safe to run on standard workstations even when the input alignment exceeds several gigabytes.
- **Progress Monitoring**: For very large runs, snpick provides a built-in progress bar and spinner. If running in a headless or CI/CD environment, ensure your terminal supports TTY to see these updates, or redirect stderr to a log file.

## Reference documentation
- [snpick GitHub Repository](./references/github_com_PathoGenOmics-Lab_snpick.md)
- [Bioconda snpick Overview](./references/anaconda_org_channels_bioconda_packages_snpick_overview.md)
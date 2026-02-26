---
name: quasitools
description: Quasitools is a bioinformatics suite designed for the analysis and characterization of viral quasispecies populations. Use when user asks to perform quality control on sequencing data, call nucleotide or amino acid variants, measure genetic diversity, identify drug resistance mutations, calculate evolutionary metrics like dN/dS ratios, or generate consensus sequences.
homepage: https://github.com/phac-nml/quasitools/
---


# quasitools

## Overview

Quasitools is a specialized suite of bioinformatics tools designed to handle the unique challenges of viral population analysis. Unlike standard genomic tools that often focus on a single consensus sequence, quasitools is built to characterize the "quasispecies"—the diverse cloud of related but non-identical viral variants within a single host. It provides a comprehensive workflow from raw FASTQ quality control to advanced evolutionary metrics like angular cosine distance and Shannon entropy.

## Core Workflows and CLI Patterns

The general syntax for the suite is: `quasitools <subcommand> [options] <arguments>`

### 1. Quality Control and Pre-processing
Before analysis, use the `quality` tool to filter and trim raw sequencing data.
- **Command**: `quasitools quality [options] <fastq_file>`
- **Tip**: Always perform QC to remove low-quality reads that could be mistaken for low-frequency variants in the quasispecies.

### 2. Variant Calling (Nucleotide, Amino Acid, and Codon)
Quasitools provides three distinct levels of variant calling from aligned BAM files:
- **Nucleotide**: `quasitools ntvar <bam_file> <reference_fasta>`
- **Amino Acid**: `quasitools aavar <bam_file> <reference_fasta> <genes_bed>`
- **Codon**: `quasitools codonvar <bam_file> <reference_fasta> <genes_bed>`
- **Best Practice**: Use the `genes_bed` file to define specific regions of interest (e.g., Pol or Gag genes) to ensure variants are mapped to the correct reading frames.

### 3. Population Complexity and Diversity
To measure the genetic diversity of the viral population:
- **Command**: `quasitools complexity [options] <bam_file>`
- **Expert Tip (v0.7.0+)**: Use the filtering options to exclude low-frequency haplotypes that may be the result of sequencing errors. This tool calculates measures such as Shannon entropy to quantify the "cloud" of variants.

### 4. Drug Resistance and Mutations
For clinical or research applications involving drug resistance:
- **Hydra (HIV Specific)**: `quasitools hydra <bam_file> <reference_fasta>`
  - This is a specialized tool for identifying HIV drug resistance mutations (DRMs) from NGS data.
- **General Mutations**: `quasitools drmutations <bam_file> <reference_fasta>`
  - Identifies amino acid mutations relative to the reference.

### 5. Evolutionary Analysis
- **dN/dS Ratios**: `quasitools dnds <bam_file> <reference_fasta> <genes_bed>`
  - Calculates the ratio of non-synonymous to synonymous substitutions to detect selective pressure.
- **Distance**: `quasitools distance <bam_file1> <bam_file2>`
  - Measures the angular cosine distance between two quasispecies populations to determine how much they have diverged.

### 6. Consensus Generation
- **Command**: `quasitools consensus <bam_file>`
- Generates a consensus sequence from the aligned reads. This is often a prerequisite for downstream comparative analysis.

## Best Practices
- **Reference Selection**: Ensure your reference FASTA is closely related to the expected viral strain to minimize alignment artifacts.
- **Coverage Analysis**: Use `quasitools aacoverage` to verify that your sequencing depth is sufficient across the entire gene of interest before trusting variant calls.
- **Bioconda Installation**: The most reliable way to manage dependencies (like samtools) is via Bioconda: `conda install -c bioconda quasitools`.

## Reference documentation
- [github_com_phac-nml_quasitools.md](./references/github_com_phac-nml_quasitools.md)
- [anaconda_org_channels_bioconda_packages_quasitools_overview.md](./references/anaconda_org_channels_bioconda_packages_quasitools_overview.md)
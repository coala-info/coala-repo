---
name: vsnp3
description: vSNP3 is a specialized tool for high-resolution pathogen surveillance, identifying strain differences down to the single nucleotide level and generating comparative analyses. Use when user asks to process individual pathogen samples, align reads, call SNPs, generate comparative SNP matrices, create phylogenetic trees, classify pathogen strains, or identify mixed pathogen infections.
homepage: https://github.com/USDA-VS/vsnp3
---


# vsnp3

## Overview

vSNP3 is a specialized tool for high-resolution pathogen surveillance that identifies strain differences down to the single nucleotide level. Unlike traditional SNP callers that require reprocessing all samples when new data is added, vSNP3 utilizes a decoupled two-step architecture. Step 1 performs alignment and SNP calling for individual samples, while Step 2 aggregates these results to generate comparative matrices and phylogenetic trees. A core strength of the tool is its "Defining SNP" system, which uses specific genomic markers to automatically classify samples into hierarchical groups and filter out lineage-specific problematic positions.

## Core Workflow

### 1. Environment Setup
Before running analysis, ensure the reference dependencies are correctly mapped.

```bash
# Add the path to your reference dependencies (defining SNPs, metadata, etc.)
vsnp3_path_adder.py -d /path/to/vsnp_dependencies

# Verify installed reference types and their paths
vsnp3_path_adder.py -s
```

### 2. Step 1: Individual Sample Processing
Run this once per sample. It aligns reads to a reference genome, calls SNPs, and tracks zero-coverage regions.

```bash
# Basic usage for paired-end reads
vsnp3_step1.py -r1 sample_R1.fastq.gz -r2 sample_R2.fastq.gz -t <reference_type>
```
*   **Note**: The `<reference_type>` (e.g., `Mycobacterium_AF2122`) determines which reference genome and defining SNP files are used.

### 3. Step 2: Comparative Analysis
Run this to combine VCF files from multiple samples into a final analysis.

```bash
# Generate SNP matrices and phylogenetic trees for all processed samples in the directory
vsnp3_step2.py -a -t <reference_type>
```

## Expert Tips and Best Practices

- **Incremental Database Building**: When receiving new samples for an ongoing investigation, only run Step 1 on the new FASTQ files. You can then run Step 2 on the entire collection of VCF files to see how new strains relate to the existing database without wasting time re-aligning old samples.
- **Defining SNPs for Classification**: Use the defining SNP Excel files to automatically group samples. vSNP3 checks specific positions to assign samples to subgroups (e.g., Group A vs. Group B). This allows for focused analysis on specific clusters within a larger dataset.
- **Handling Mixed Strains**: vSNP3 uses IUPAC ambiguity codes to represent positions with multiple alleles. This is critical for identifying mixed infections or intra-host variation.
- **Zero Coverage Tracking**: Pay attention to the zero-coverage output. vSNP3 distinguishes between a "Reference" call and "No Data," which prevents false-negative SNP calls in regions with poor sequencing depth.
- **Filtering**: The tool automatically filters problematic positions defined in the reference-specific Excel files. If you discover new problematic sites for a specific lineage, update the corresponding defining SNP file to improve future analysis quality.

## Reference documentation
- [vSNP3 GitHub Repository](./references/github_com_USDA-VS_vSNP3.md)
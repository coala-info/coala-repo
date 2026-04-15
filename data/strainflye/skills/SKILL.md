---
name: strainflye
description: strainFlye is a bioinformatics pipeline for identifying and analyzing low-frequency single-nucleotide mutations within metagenomic assemblies. Use when user asks to align reads to contigs, call p-mutations or r-mutations, estimate false discovery rates, identify genomic hotspots, or analyze allele co-occurrence through link graphs.
homepage: https://github.com/fedarko/strainFlye
metadata:
  docker_image: "quay.io/biocontainers/strainflye:0.2.0--pyhca03a8a_0"
---

# strainflye

## Overview

strainFlye is a specialized bioinformatics pipeline designed to identify and analyze low-frequency single-nucleotide mutations within metagenomic assemblies. Unlike standard variant callers optimized for diploid organisms, strainFlye focuses on the unique challenges of metagenomics, where rare mutations may represent strain-level variation. It provides a complete workflow from read alignment and mutation calling to the identification of genomic "hotspots" and the creation of link graphs for phasing alleles.

## Core Workflow and CLI Patterns

### 1. Alignment
The first step involves mapping your long reads back to your assembled contigs.
```bash
strainFlye align \
    --reads reads.fastq.gz \
    --contigs contigs.fasta \
    --output alignment.bam
```
*   **Tip**: Ensure your contigs are indexed. strainFlye produces an indexed BAM file required for all subsequent steps.

### 2. Mutation Calling
You can call mutations based on frequency (`p-mutation`) or raw read counts (`r-mutation`).
```bash
# Call mutations using frequency thresholds
strainFlye call p-mutation \
    --bam alignment.bam \
    --contigs contigs.fasta \
    --output-dir call_output/
```
*   **Output**: This generates an indexed BCF file of called mutations and a TSV of diversity indices (e.g., Shannon entropy).

### 3. FDR Estimation and Fixing (Recommended)
To distinguish true rare mutations from sequencing errors, use the FDR module.
```bash
# Estimate FDR
strainFlye fdr estimate \
    --bam alignment.bam \
    --bcf call_output/mutations.bcf \
    --contigs contigs.fasta \
    --output-dir fdr_output/

# Apply FDR fix to filter the BCF
strainFlye fdr fix \
    --bcf call_output/mutations.bcf \
    --fdr-stats fdr_output/fdr_info.tsv \
    --output filtered_mutations.bcf
```

### 4. Downstream Analysis
Once mutations are called and filtered, use specialized modules for biological insights:

*   **Spotting Features**: Identify "hotspots" (high mutation density, often genes) or "coldspots" (gaps in mutations).
    ```bash
    strainFlye spot hot-features --bcf filtered_mutations.bcf --gff genes.gff3 --output hotspots.tsv
    ```
*   **Link Graphs**: Analyze co-occurrence of alleles to understand strain structure.
    ```bash
    strainFlye link nt --bam alignment.bam --bcf filtered_mutations.bcf --output links.pickle
    ```
*   **Growth Dynamics**: Compute coverage and skew statistics to estimate replication rates.
    ```bash
    strainFlye dynam covskew --bam alignment.bam --output dynamics.tsv
    ```

## Expert Tips and Constraints

*   **Contig Naming**: Avoid special characters in contig names that might break `bcftools` or `samtools` downstream.
*   **Read Smoothing**: The `smooth assemble` command requires the LJA (Laplacian Junction Assembler) to be installed separately, as it is not included in the standard conda environment.
*   **Input Formats**: While FASTA/FASTQ are standard, providing an assembly graph (GFA 1) to the `align` command can improve results in complex regions.
*   **Memory Management**: For very large metagenomes, consider subsetting contigs using `strainFlye utils` if you encounter performance bottlenecks.

## Reference documentation
- [strainFlye GitHub Repository](./references/github_com_fedarko_strainFlye.md)
- [Bioconda strainflye Package Overview](./references/anaconda_org_channels_bioconda_packages_strainflye_overview.md)
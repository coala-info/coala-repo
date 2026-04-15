---
name: shapeit
description: SHAPEIT is a high-performance tool used for haplotype estimation and phasing of large-scale genomic data. Use when user asks to phase genotypes, estimate haplotypes, integrate read-based phase information, or configure population-based phasing runs.
homepage: https://github.com/odelaneau/shapeit4
metadata:
  docker_image: "quay.io/biocontainers/shapeit:2.r837--h09b0a5c_1"
---

# shapeit

## Overview
SHAPEIT4 (Segmented HAPlotype Estimation and Imputation Tool) is a high-performance method for haplotype estimation. It is designed to handle large-scale genomic data by utilizing the Positional Burrows-Wheeler Transform (PBWT) to quickly identify informative conditioning haplotypes. Use this skill to configure phasing runs, integrate read-based phase information, and troubleshoot common errors related to sample size and conditioning.

## Core Workflow & Best Practices

### 1. Version Selection
*   **Upgrade to Version 5**: The developers officially recommend using SHAPEIT5 over SHAPEIT4 for improved performance and features. Only use SHAPEIT4 if maintaining a legacy pipeline or if specific version 4 features are required.

### 2. Input Preparation
*   **File Formats**: Always prefer BCF over VCF for both input and output. SHAPEIT4 uses HTSlib, and BCF significantly improves I/O performance.
*   **Read-Based Phasing**: For sequencing data, do not rely on SHAPEIT4 to extract phase information directly from BAM files. Use **WhatsHap** as a pre-processing step to extract phase sets, then provide the resulting VCF/BCF to SHAPEIT4.
*   **Genetic Maps**: Ensure you use the appropriate genetic map for your reference assembly (e.g., hg19, GRCh38). The tool requires these to model recombination rates accurately.

### 3. Phasing Strategies
*   **Population-Based Phasing**: Requires a minimum of 20 individuals. Attempting to phase smaller cohorts will result in errors.
*   **Scaffolding**: If you have high-quality pre-phased data (from family studies or large reference panels), use the scaffold feature to improve the accuracy of the target sample phasing.
*   **Haploid Data**: Be aware of potential underflow errors when processing haploid regions or samples; ensure the input data is properly formatted for the expected ploidy.

### 4. Performance Optimization
*   **Multi-threading**: Use the `--thread` flag to parallelize the HMM routines and PBWT selections.
*   **PBWT Tuning**: 
    *   If the tool fails to find conditioning haplotypes, review the `--pbwt-*` and `--ibd2-*` parameters.
    *   Use `--pbwt-disable-init` if you need to bypass the initial PBWT selection phase for specific debugging or custom workflows.
*   **Memory/Hardware**: The tool is optimized for AVX2 instructions. Ensure your build is compiled for the target architecture to maximize throughput.

### 5. Auxiliary Tools
*   **bingraphsample**: Use this tool to sample likely haplotype pairs from the genotype graphs produced by SHAPEIT4. This is useful for downstream analyses that require accounting for phasing uncertainty.

## Troubleshooting Common Errors
*   **"Could not find conditioning haplotypes"**: Usually caused by overly restrictive PBWT or IBD2 settings. Relax these parameters or check if the region has extremely low polymorphism.
*   **"Problem opening index file"**: Ensure your VCF/BCF files are indexed (using `bcftools index`) and that reference FASTA indexes (.fai) are present if a reference genome is specified.
*   **"Underflow impossible to recover"**: Often occurs in regions with very high marker density or when using dense scaffolds. Consider thinning markers or checking for data quality issues in the specific region.

## Reference documentation
- [SHAPEIT4 Main Repository](./references/github_com_odelaneau_shapeit4.md)
- [SHAPEIT4 Issues and Troubleshooting](./references/github_com_odelaneau_shapeit4_issues.md)
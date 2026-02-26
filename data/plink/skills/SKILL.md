---
name: plink
description: PLINK is a high-performance command-line utility used for the rapid analysis and management of large-scale genetic datasets. Use when user asks to perform quality control filtering, convert genomic file formats, conduct linkage disequilibrium pruning, or run genetic association analyses.
homepage: https://www.cog-genomics.org/plink
---


# plink

## Overview
PLINK is a high-performance command-line utility designed for the rapid analysis of large-scale genetic datasets. It is the standard for processing genotype data, offering robust features for data management, summary statistics, and association modeling. This skill provides the procedural knowledge to execute complex genomic workflows, from initial raw data cleaning to final association reports, while optimizing for computational efficiency.

## Core Command Structure
PLINK commands follow a standard pattern: `plink <input-flag> <input-prefix> <operation-flags> --out <output-prefix>`.

### Input and Output
*   **Binary Fileset (Recommended):** Use `--bfile prefix` to load `.bed`, `.bim`, and `.fam` files.
*   **Text Fileset:** Use `--file prefix` to load `.ped` and `.map` files.
*   **VCF Files:** Use `--vcf file.vcf` or `--vcf file.vcf.gz`.
*   **Output Prefix:** Always specify `--out prefix` to prevent overwriting default `plink.*` files.

## Common Workflows

### 1. Quality Control (QC)
Standard filters to remove low-quality variants and samples:
*   **Minor Allele Frequency:** `--maf 0.05` (removes variants with MAF < 5%).
*   **Variant Missingness:** `--geno 0.1` (removes variants missing in > 10% of samples).
*   **Sample Missingness:** `--mind 0.1` (removes samples missing > 10% of genotypes).
*   **Hardy-Weinberg Equilibrium:** `--hwe 1e-6` (filters variants failing HWE test).

### 2. Data Management and Conversion
*   **Create Binary Fileset:** `plink --vcf data.vcf --make-bed --out binary_data`
*   **Convert to VCF:** `plink --bfile data --recode vcf --out new_vcf`
*   **Extract Specific Variants:** `plink --bfile data --extract snp_list.txt --make-bed --out subset`
*   **Filter by Chromosome:** `plink --bfile data --chr 1-22 --make-bed --out autosomes_only`

### 3. Linkage Disequilibrium (LD) Pruning
Essential for PCA and other analyses assuming independent markers:
*   **Pruning:** `plink --bfile data --indep-pairwise 50 5 0.2`
    *   `50`: Window size in variants.
    *   `5`: Step size (variants to shift window).
    *   `0.2`: r^2 threshold.
*   **Apply Pruning:** Use the resulting `plink.prune.in` file with `--extract`.

### 4. Association Analysis
*   **Basic Case/Control:** `plink --bfile data --assoc --out results`
*   **Quantitative Trait:** `plink --bfile data --assoc --out quant_results`
*   **Logistic Regression (with Covariates):** `plink --bfile data --logistic --covar covar.txt --out logistic_results`
*   **Linear Regression:** `plink --bfile data --linear --covar covar.txt --out linear_results`

## Expert Tips
*   **Order of Operations:** PLINK applies filters (MAF, geno, etc.) *before* performing calculations or creating new filesets in a single command.
*   **Non-Human Data:** If working with non-human species or extra contigs, use `--allow-extra-chr` to prevent errors regarding unrecognized chromosome codes.
*   **Sex Check:** Use `--check-sex` to identify sample swaps by comparing pedigree sex to X-chromosome heterozygosity.
*   **Memory Management:** For extremely large datasets, use `--memory <megabytes>` to limit RAM usage.
*   **Missing Phenotypes:** By default, PLINK uses `-9` or `0` as missing phenotype values. Ensure your `.fam` or phenotype file matches this or use `--missing-phenotype <value>`.

## Reference Documentation
- [General Usage](./references/www_cog-genomics_org_plink_1.9_general_usage.md)
- [Input Filtering](./references/www_cog-genomics_org_plink_1.9_filter.md)
- [Data Management](./references/www_cog-genomics_org_plink_1.9_data.md)
- [Association Analysis](./references/www_cog-genomics_org_plink_1.9_assoc.md)
- [File Formats](./references/www_cog-genomics_org_plink_1.9_formats.md)
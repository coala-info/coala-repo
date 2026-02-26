---
name: finemap
description: "Finemap identifies causal SNPs and estimates their effect sizes and heritability contributions. Use when user asks to fine-map genetic association results, identify causal variants, or estimate heritability."
homepage: http://www.christianbenner.com
---


# finemap

yaml
name: finemap
description: |
  Program for identifying causal SNPs and their effect sizes and heritability contributions.
  Use when you need to fine-map genetic association results to identify potential causal variants and estimate their contributions to heritability. This is particularly useful for post-GWAS analysis and understanding the genetic architecture of complex traits.
```
## Overview
Finemap is a powerful tool designed for fine-mapping genetic association studies. It helps researchers pinpoint potential causal single nucleotide polymorphisms (SNPs) within a genomic region and quantify their individual contributions to the heritability of a trait. This is a crucial step after genome-wide association studies (GWAS) to move from identifying associated regions to identifying specific causal variants.

## Usage

Finemap operates by taking summary statistics from genetic association studies and using them to calculate posterior probabilities for each SNP being causal. It can also estimate heritability contributions from these SNPs.

### Core Functionality and Input

Finemap primarily works with summary statistics from association studies. The most common input format is a tab-separated file containing:

*   **SNP**: rsID of the SNP
*   **A1**: Allele 1 (reference allele)
*   **A2**: Allele 2 (alternative allele)
*   **Z**: Z-score for the association test
*   **N**: Sample size for the SNP

You can also provide LD (Linkage Disequilibrium) information, which is crucial for accurate fine-mapping. Finemap can accept LD matrices directly or generate them from VCF files.

### Common CLI Patterns

Here are some common ways to use Finemap:

1.  **Basic Fine-mapping with Summary Statistics:**
    ```bash
    finemap --sumstats <summary_stats.txt> --output <output_prefix>
    ```
    This command performs fine-mapping using only the provided summary statistics.

2.  **Fine-mapping with Summary Statistics and LD Matrix:**
    ```bash
    finemap --sumstats <summary_stats.txt> --ld <ld_matrix.ld> --output <output_prefix>
    ```
    Providing an LD matrix (`.ld` file) significantly improves the accuracy of the fine-mapping results.

3.  **Estimating Heritability:**
    ```bash
    finemap --sumstats <summary_stats.txt> --heritability --output <output_prefix>
    ```
    This option focuses on estimating the heritability explained by the SNPs in the summary statistics.

4.  **Using a Region File:**
    You can specify a region file to analyze specific genomic intervals:
    ```bash
    finemap --sumstats <summary_stats.txt> --region <region_file.txt> --output <output_prefix>
    ```
    The region file typically contains columns like `CHR`, `BP`, and `SNP` to define the regions of interest.

### Expert Tips

*   **LD Matrix Generation:** If you don't have a pre-computed LD matrix, you can generate one from a VCF file using tools like `plink` or `ldak`. Ensure the LD matrix is in the correct format for Finemap.
*   **Allele Matching:** It is critical that the alleles in your summary statistics (`A1`, `A2`) are consistent with the alleles in your LD reference panel. Mismatched alleles can lead to incorrect results.
*   **Z-score Direction:** Ensure your Z-scores are consistently oriented with respect to one of the alleles (e.g., always for `A1`).
*   **Output Files:** Finemap generates several output files, including `_config.txt`, `_log.txt`, `_results.txt`, and `_ld.txt`. The `_results.txt` file typically contains the posterior probabilities of causality for each SNP.
*   **Parameter Tuning:** For complex datasets, consider exploring Finemap's advanced parameters for controlling the number of causal SNPs or the prior probabilities. Refer to the official Finemap documentation for a comprehensive list of options.

## Reference documentation
- [Finemap Overview](./references/anaconda_org_channels_bioconda_packages_finemap_overview.md)
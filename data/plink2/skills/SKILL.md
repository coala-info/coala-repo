---
name: plink2
description: plink2 is a comprehensive toolset for efficient analysis of large-scale genetic datasets.
homepage: https://www.cog-genomics.org/plink2
---

# plink2

## Overview
plink2 is a comprehensive toolset for efficient analysis of large-scale genetic datasets. It is the successor to PLINK 1.9, optimized for memory efficiency and speed when handling millions of variants and thousands of samples. Use this skill to perform data cleaning (filtering by MAF, HWE, or missingness), population structure analysis (PCA), and various association tests (linear/logistic regression) on genomic data.

## Core CLI Patterns

### Data Conversion and Management
plink2 uses a "double-dash" flag system. The most common entry point is converting VCF or BGEN files into the efficient PLINK 2 binary format (.pgen/.psam/.pvar) or PLINK 1 binary format (.bed/.bim/.fam).

*   **Convert VCF to PLINK 1 Binary:**
    `plink2 --vcf input.vcf.gz --make-bed --out output_prefix`
*   **Convert BGEN to PGEN:**
    `plink2 --bgen input.bgen 'ref-last' --make-pgen --out output_prefix`
*   **Update Variant IDs:**
    `plink2 --pfile data --set-all-var-ids '@:#:$r:$a' --make-pgen --out data_named`

### Quality Control (QC)
Standard GWAS QC involves filtering out low-quality variants and samples. These flags can be combined in a single command.

*   **Standard QC Filter:**
    `plink2 --pfile input --maf 0.01 --geno 0.05 --mind 0.05 --hwe 1e-6 --make-pgen --out qc_passed`
    *   `--maf`: Minor Allele Frequency threshold.
    *   `--geno`: Filter variants with missing call rates > 5%.
    *   `--mind`: Filter samples with missing call rates > 5%.
    *   `--hwe`: Hardy-Weinberg Equilibrium p-value threshold.

### Population Structure
Principal Component Analysis (PCA) is the standard method for identifying population stratification.

*   **Run PCA:**
    `plink2 --pfile input --pca 10 --out pca_results`
*   **LD Pruning (Pre-PCA):**
    PCA should be performed on independent variants.
    1. `plink2 --pfile input --indep-pairwise 50 5 0.2 --out pruned_list`
    2. `plink2 --pfile input --extract pruned_list.prune.in --pca 10 --out pca_results`

### Association Testing
plink2 supports complex models including covariates (like age, sex, and PCs).

*   **Linear Regression (Quantitative Traits):**
    `plink2 --pfile input --pheno pheno.txt --covar covar.txt --glm --out assoc_results`
*   **Logistic Regression (Case/Control):**
    `plink2 --pfile input --pheno cc_pheno.txt --covar covar.txt --glm --out logistic_results`
    *Note: Use `--1` if your phenotype file uses 1/2 coding for case/control.*

## Expert Tips
*   **Memory Management:** Use `--memory [val in MB]` to prevent plink2 from over-allocating on shared clusters.
*   **Thread Control:** Use `--threads [n]` to specify CPU usage; plink2 is highly multithreaded.
*   **Chromosome Sets:** If working with non-human data or extra contigs, use `--allow-extra-chr` or `--chr-set` to prevent errors regarding unrecognized chromosome names.
*   **Reference Allele:** Always be explicit about the reference allele when merging or performing association tests using `--ref-from-fa` or `--keep-allele-order`.

## Reference documentation
- [PLINK 2.0 Introduction and Downloads](./references/www_cog-genomics_org_plink2.md)
- [Bioconda plink2 Package Overview](./references/anaconda_org_channels_bioconda_packages_plink2_overview.md)
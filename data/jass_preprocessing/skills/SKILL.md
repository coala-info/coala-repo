---
name: jass_preprocessing
description: This tool transforms and harmonizes inconsistent GWAS summary statistics into a standardized format by aligning them against a reference panel. Use when user asks to format GWAS data, align alleles to a reference, calculate effective sample sizes, or prepare genetic datasets for multi-trait analysis.
homepage: http://statistical-genetics.pages.pasteur.fr/jass_preprocessing/
---


# jass_preprocessing

## Overview
The `jass_preprocessing` tool is a specialized command-line utility designed to transform inconsistent GWAS summary statistics into a uniform format. It automates the alignment of genetic data against a reference panel, ensuring that alleles are correctly oriented and that statistical metrics (like Z-scores and effective sample sizes) are calculated consistently across different studies. This preprocessing is a prerequisite for multi-trait analysis and imputation workflows.

## Core Workflow
To perform a complete harmonization, you must provide a descriptor file, a reference panel, and the raw data directory.

### 1. Prepare the Descriptor File (`--gwas-info`)
The descriptor file is a tab-separated (TSV) file that maps your raw file headers to the tool's internal requirements.
- **Mandatory Study Info**: `Consortium`, `Outcome`, `Nsample`.
- **Mandatory Column Mapping**: `snpid`, `a1` (effect allele), `a2` (other allele), `pval`, and `beta_or_Z`.
- **Note**: The combination of `Consortium` and `Outcome` must be unique for every row. Use `na` for missing optional fields like `ncas` or `ncont`.

### 2. Reference Panel Format (`--ref-path`)
The reference panel must be a headerless TSV file with columns in this exact order:
`Chromosome`, `rsID`, `Minor Allele Frequency`, `Position`, `Reference Allele`, `Alternative Allele`.

### 3. Execution Pattern
Run the full pipeline using the following structure:
```bash
jass_preprocessing \
    --gwas-info metadata_descriptor.tsv \
    --ref-path reference_panel.tsv \
    --input-folder ./raw_gwas_data/ \
    --diagnostic-folder ./qc_reports/ \
    --output-folder ./standardized_output/
```

## Expert Tips & Best Practices
- **Effective Sample Size**: For binary traits, the tool calculates effective sample size as $1 / (1/N_{cases} + 1/N_{controls})$. Ensure these columns are mapped in the descriptor if you want precise per-SNP filtering.
- **Filtering Outliers**: Use `--percent-sample-size` (default 0.7) to remove SNPs where the sample size is significantly lower than the 90th percentile of the study, which often indicates poor genotyping or imputation coverage.
- **MHC Handling**: For complex traits, consider using `--mask-MHC True` to exclude the Major Histocompatibility Complex region, which can bias joint analysis due to extreme linkage disequilibrium.
- **LDSC Compatibility**: If you plan to run LD-Score Regression later, use the `--output-folder-1-file` flag to generate a single concatenated file containing the `N_effective` and `P` columns required by LDSC.
- **Imputation Quality**: If your raw data includes INFO scores, map the column to `imputation_quality` in the descriptor and set a threshold (e.g., `--imputation-quality-treshold 0.6`) to filter low-confidence variants.

## Reference documentation
- [Jass Preprocessing Documentation](./references/statistical-genetics_pages_pasteur_fr_jass_preprocessing.md)
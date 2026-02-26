---
name: raiss
description: RAISS imputes missing Z-scores in GWAS summary statistics by leveraging linkage disequilibrium information from a reference panel. Use when user asks to impute missing variants, precompute LD matrices, optimize imputation parameters via grid search, or perform sanity checks on imputed summary statistics.
homepage: http://statistical-genetics.pages.pasteur.fr/raiss/
---


# raiss

## Overview
RAISS is a Python-based tool designed to fill in missing Z-scores in GWAS summary statistics by leveraging the correlation structure of neighboring SNPs. It uses a reference panel (like 1000 Genomes) to calculate Linkage Disequilibrium (LD) and provides statistical confidence for each imputed variant. This skill helps you navigate the multi-step process of preparing LD matrices, running the imputation engine, and validating results through grid searches and sanity checks.

## Core Workflow

### 1. Precomputing LD Matrices
Before imputation, you must generate LD correlation matrices. RAISS uses specific genomic regions (e.g., Berisa blocks) to limit computation.

```python
import raiss
# Example Python snippet for LD generation
raiss.LD.generate_genome_matrices(
    region_file="/path/to/Region_LD.csv",
    ref_folder="/path/to/plink_ref_panel",
    ld_folder_out="/path/to/output_ld_dir"
)
```
*   **Input**: Plink binary files (.bed, .fam, .bim) split by chromosome.
*   **Output**: Tabular or scipy sparse matrix (.npz) files.

### 2. Input Data Formatting
GWAS files must be tab-separated and named using the pattern: `z_{GWAS_TAG}_chr{1..22}.txt`.
Required columns: `rsID`, `pos`, `A0`, `A1`, `Z`.

### 3. Running Imputation
Execute imputation on a per-chromosome basis. This is the primary command for generating results.

```bash
raiss --chrom chr22 \
      --gwas MY_STUDY_TAG \
      --ld-folder /path/to/ld_matrices \
      --ref-folder /path/to/reference_panel \
      --zscore-folder /path/to/input_zscores \
      --output-folder /path/to/results \
      --eigen-threshold 0.000001
```

### 4. Parameter Optimization (Grid Search)
To find the best balance between imputation error and coverage, run a performance grid search on a small chromosome (e.g., chr22).

```bash
raiss --ld-folder ${LD_DIR} \
      --ref-folder ${REF_DIR} \
      --gwas MY_STUDY \
      --chrom chr22 \
      performance-grid-search \
      --harmonized-folder ${INPUT_DIR} \
      --masked-folder ${TEMP_MASKED_DIR} \
      --imputed-folder ${TEMP_IMPUTED_DIR} \
      --output-path ./perf_report.csv \
      --eigen-ratio-grid '[0.000001, 0.001, 0.1]' \
      --ld-threshold-grid '[0, 10, 20]'
```
*   **Key Metric**: Look for a high `cor` (correlation) and a high `fraction_imputed`.

### 5. Sanity Checks
After imputation, verify that the distribution of signal is coherent and that the tool hasn't introduced excessive false positives.

```bash
raiss sanity-check \
      --trait z_MY_STUDY \
      --harmonized-folder /path/to/input_data \
      --imputed-folder /path/to/imputed_results
```
*   **Check**: The `imputed_hit_OR` should be near 1.0, indicating the number of new hits is proportional to the increased coverage.

## Expert Tips
*   **Eigen Threshold**: This is the most critical parameter. If your reference panel is small or mismatched, increase the `--eigen-threshold` to be more conservative.
*   **Parallelization**: RAISS is optimized for cluster environments. Always process chromosomes in parallel across different nodes to save time.
*   **Variance Column**: In the output, a `Var` value of `-1` indicates the SNP was present in the original input (not imputed).
*   **LD Type**: If using modern sparse formats, specify `--ld-type scipy` in the command line.

## Reference documentation
- [RAISS Documentation and Usage Guide](./references/statistical-genetics_pages_pasteur_fr_raiss.md)
---
name: raiss
description: RAISS predicts missing SNP Z-scores in GWAS datasets by leveraging the linkage disequilibrium structure of neighboring variants. Use when user asks to impute missing summary statistics, precompute LD matrices, optimize imputation parameters via grid search, or perform sanity checks on imputed genetic data.
homepage: http://statistical-genetics.pages.pasteur.fr/raiss/
---


# raiss

## Overview

RAISS (Robust and Accurate Imputation from Summary Statistics) is a tool designed to predict missing SNP Z-scores by leveraging the correlation structure of neighboring SNPs. This is essential for harmonizing GWAS datasets with varying coverage or for increasing the resolution of association studies without requiring raw genotype data. The tool optimizes execution time by using precomputed LD matrices and provides robust statistical frameworks to ensure imputation accuracy.

## Input Requirements

Ensure GWAS input files are tab-separated and follow the naming convention `z_{GWAS_TAG}_chr{1..22}.txt`. Files must contain these specific headers:
- `rsID`: SNP identifier
- `pos`: Genomic position
- `A0`: Reference allele
- `A1`: Alternative allele
- `Z`: Z-score

## Core Workflows

### 1. Precomputing LD Matrices
Before imputation, compute LD correlation matrices from a reference panel (e.g., 1000 Genomes). This requires PLINK 1.9.

```python
import raiss
# Define paths to regions, reference panel (PLINK format), and output
raiss.LD.generate_genome_matrices(region_files, ref_folder, ld_folder_out)
```

### 2. Optimizing Parameters (Grid Search)
Imputation quality depends heavily on the `--eigen-threshold` and `--minimum-ld`. Use the `performance-grid-search` subcommand to find the best trade-off between the fraction of SNPs imputed and the mean absolute error.

```bash
raiss --ld-folder ${LD_PATH} \
      --ref-folder ${REF_PATH} \
      --gwas ${TAG} \
      --chrom chr22 \
      performance-grid-search \
      --harmonized-folder ${INPUT_PATH} \
      --masked-folder ${TEMP_MASK_PATH} \
      --output-path ${REPORT_FILE} \
      --eigen-ratio-grid '[0.000001, 0.001, 0.1]' \
      --ld-threshold-grid '[0, 10, 20]'
```

### 3. Executing Imputation
Run the main imputation command for a specific chromosome.

```bash
raiss --chrom chr22 \
      --gwas ${TAG} \
      --ld-folder ${LD_PATH} \
      --ref-folder ${REF_PATH} \
      --zscore-folder ${INPUT_PATH} \
      --output-folder ${OUTPUT_PATH} \
      --eigen-threshold 0.000001
```

### 4. Sanity Checks
After imputation, verify that the distribution of the imputed signal is coherent and that the number of new significant hits is reasonable.

```bash
raiss sanity-check \
      --trait z_{TAG} \
      --harmonized-folder ${INPUT_PATH} \
      --imputed-folder ${OUTPUT_PATH}
```

## Expert Tips and Best Practices

- **Parameter Tuning**: Always run the grid search on Chromosome 22 first. It is computationally efficient and parameters typically generalize well to other chromosomes.
- **Variance Interpretation**: In the output files, a `Var` value of `-1` indicates the variant was already present in the input dataset (not imputed).
- **Reference Panel Match**: Ensure the ancestry of your reference panel matches your GWAS population. Significant mismatches will lead to false positives and poor imputation R2.
- **LD Blocks**: Use approximately LD-independent regions (e.g., Berisa and Pickrell regions) to limit the number of SNP pairs and speed up matrix generation.
- **Parallelization**: For large-scale GWAS, launch imputation for each chromosome as a separate job on a cluster (e.g., using SLURM) to minimize wall-clock time.



## Subcommands

| Command | Description |
|---------|-------------|
| raiss performance-grid-search | Performs a grid search for RAISS performance tuning. |
| sanity-check | Sanity check for RAISS imputation. |

## Reference documentation
- [RAISS Main Documentation](./references/statistical-genetics_pages_pasteur_fr_raiss.md)
- [RAISS Index Source](./references/statistical-genetics_pages_pasteur_fr_raiss__sources_index.rst.txt.md)
- [Imputation R2 Evaluation](./references/statistical-genetics_pages_pasteur_fr_raiss__autosummary_raiss.imputation_R2.html.md)
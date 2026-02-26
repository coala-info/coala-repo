---
name: bioconductor-genphen
description: This tool quantifies genotype-phenotype associations using a combination of machine learning and Bayesian hierarchical modeling. Use when user asks to analyze associations between genetic markers and phenotypes, control for phylogenetic bias, or perform data reduction for large-scale GWAS.
homepage: https://bioconductor.org/packages/3.8/bioc/html/genphen.html
---


# bioconductor-genphen

name: bioconductor-genphen
description: Statistical tool for quantifying genotype-phenotype associations using a hybrid approach of machine learning (Random Forest, SVM) and Bayesian hierarchical modeling. Use this skill when analyzing associations between genetic markers (SNPs, SAAPs) and phenotypes (quantitative or dichotomous), controlling for phylogenetic bias, or performing data reduction for large-scale GWAS.

# bioconductor-genphen

## Overview
The `genphen` package provides a robust framework for Genome-Wide Association Studies (GWAS) that moves beyond frequentist P-values. It uses statistical learning to capture non-linear associations and Bayesian inference to provide accurate effect sizes (beta) and classification accuracy (CA). It is particularly effective for small to medium datasets where outliers and population structure (phylogenetic bias) might confound results.

## Core Workflow

### 1. Data Preparation
Genotype data can be a character vector, matrix (N individuals x S SNPs), or Biostrings alignment objects. Phenotypes should be numerical vectors or matrices.

```r
library(genphen)

# Example: Load provided sample data
data(genotype.saap)
data(phenotype.saap)

# Recommendation: Log-transform skewed quantitative phenotypes before analysis
phenotype.log <- log10(phenotype.saap)
```

### 2. Running the Association Analysis
The primary function is `runGenphen`. It calculates Classification Accuracy (CA), Cohen’s Kappa (κ), and Bayesian Effect Size (β).

```r
# Run association for a quantitative phenotype ('Q')
results <- runGenphen(
  genotype = genotype.saap[, 82:89],
  phenotype = phenotype.saap,
  phenotype.type = "Q",             # "Q" for quantitative, "D" for dichotomous
  model.type = "hierarchical",      # "hierarchical" (multi-test correction) or "univariate"
  mcmc.chains = 2,
  mcmc.steps = 1500,
  stat.learn.method = "rf",         # "rf" (Random Forest) or "svm" (Support Vector Machine)
  cv.steps = 200,                   # Cross-validation iterations
  cores = 2
)

# Access scores
scores <- results$scores
```

### 3. Controlling for Phylogenetic Bias
To detect if associations are driven by population structure rather than functional links, use `runPhyloBiasCheck`.

```r
bias_results <- runPhyloBiasCheck(
  genotype = genotype.saap,
  input.kinship.matrix = NULL # Computes kinship automatically if NULL
)

# Extract bias scores (B)
# B = 1 indicates complete phylogenetic bias; B = 0 indicates no bias.
mutation_bias <- bias_results$bias
```

### 4. Data Reduction for Large Datasets
For high-dimensional SNP data, use `runDiagnostics` to filter non-informative markers via Random Forest importance scores before running the full Bayesian model.

```r
diag <- runDiagnostics(
  genotype = large_genotype_matrix,
  phenotype = pheno_vector,
  phenotype.type = "Q",
  rf.trees = 50000
)

# Filter SNPs with high importance
important_snps <- diag[diag$importance > threshold, ]
```

## Interpreting Results
*   **Classification Accuracy (CA):** Values near 1.0 indicate the phenotype strongly predicts the genotype.
*   **Cohen’s Kappa (κ):** Adjusts CA for uneven allele representation. κ > 0.6 is considered "substantial agreement."
*   **Effect Size (β):** The slope from the Bayesian model. An association is typically considered significant if the **95% HDI** (Highest Density Interval) does not overlap with 0.
*   **Phylogenetic Bias (B):** If a SNP has high CA but also high B, the association may be a false positive due to lineage effects.

## Tips
*   **Phenotype Types:** If analyzing multiple phenotypes of different types, pass a vector to `phenotype.type`, e.g., `c("Q", "D")`.
*   **Convergence:** Always check MCMC diagnostics using `rstan::check_hmc_diagnostics(results$complete.posterior)` to ensure the Bayesian model converged.
*   **Multi-allelic sites:** `genphen` automatically expands multi-allelic genotypes into bi-allelic permutations for analysis.

## Reference documentation
- [genphen Manual](./references/genphenManual.md)
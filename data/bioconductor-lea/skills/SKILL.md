---
name: bioconductor-lea
description: The LEA package provides optimized algorithms for landscape genomics and ecological association studies to identify population structure and genetic markers associated with environmental gradients. Use when user asks to estimate ancestry coefficients, perform genotype-environment association testing, impute missing genomic data, or calculate genetic gaps for predictive ecological genomics.
homepage: https://bioconductor.org/packages/release/bioc/html/LEA.html
---

# bioconductor-lea

## Overview
The `LEA` package is designed for landscape genomics and ecological association studies. It provides optimized algorithms for large-scale genomic data to identify population structure and genetic markers associated with environmental gradients. Key methodologies include Sparse Non-negative Matrix Factorization (snmf) for ancestry and Latent Factor Mixed Models (LFMM) for association testing.

## Input Formats and Conversion
LEA primarily uses `.lfmm` or `.geno` formats for genotypes and `.env` for environmental variables.
- **Genotypes**: Use `write.lfmm(R_matrix, "file.lfmm")` or `write.geno(R_matrix, "file.geno")`.
- **Environment**: Use `write.env(env_matrix, "file.env")`.
- **Conversion**: Use `vcf2geno()`, `ped2lfmm()`, or `struct2geno()` to import external data formats.

## Population Structure Analysis (snmf)
Use `snmf()` to estimate individual admixture coefficients and evaluate the number of ancestral populations (K).

```r
# Run snmf for a range of K values
project = snmf("genotypes.geno", K = 1:10, entropy = TRUE, repetitions = 10, project = "new")

# Plot cross-entropy to find the "elbow" or minimum (optimal K)
plot(project)

# Extract ancestry matrix (Q-matrix) for the best run of a specific K
best_run = which.min(cross.entropy(project, K = 4))
q_matrix = Q(project, K = 4, run = best_run)

# Visualize with a barchart
barchart(project, K = 4, run = best_run, border = NA, space = 0)
```

## Missing Data Imputation
Imputation is performed using the results of an `snmf` project.

```r
# Impute missing values based on the best snmf run
impute(project, "genotypes.geno", method = 'mode', K = 4, run = best_run)
# Output: "genotypes.geno_imputed.lfmm"
```

## Genotype-Environment Association (GEA)
LEA provides two versions of LFMM. `lfmm2` is generally preferred for large datasets due to speed and exact least-squares solutions.

### Using lfmm2 (Frequentist/Fast)
```r
# 1. Fit the model
mod2 = lfmm2(input = genotype_matrix, env = env_matrix, K = 2)

# 2. Perform association tests (linear or full Fisher tests)
pv = lfmm2.test(object = mod2, input = genotype_matrix, env = env_matrix, full = TRUE)

# 3. Visualize results (Manhattan plot)
plot(-log10(pv$pvalues), pch = 19, col = "blue")
```

### Using lfmm (Bayesian/MCMC)
```r
# Run MCMC-based LFMM
project = lfmm("genotypes.lfmm", "gradients.env", K = 6, repetitions = 5, project = "new")

# Combine p-values from multiple repetitions
p_values = lfmm.pvalues(project, K = 6)$pvalues
```

## Predictive Ecological Genomics (Genetic Gap)
Calculate the "genetic gap" to predict maladaptation to environmental change.

```r
# Calculate genetic offset/gap
g_gap = genetic.gap(input = genotype_matrix, 
                    env = current_env, 
                    pred.env = future_env, 
                    K = 2, 
                    scale = TRUE)

# Access offset values
offsets = g_gap$offset
```

## Workflow Tips
- **Choosing K**: Use the elbow of a PCA screeplot (`pca()`) or the minimum cross-entropy from `snmf()` to determine the number of latent factors (K).
- **Multiple Testing**: Always adjust p-values using the Benjamini-Hochberg procedure: `p.adjust(pvalues, method = "BH")`.
- **Data Cleaning**: Filter for Minor Allele Frequency (MAF > 5%) and prune for Linkage Disequilibrium (LD) before running LEA for more robust results.

## Reference documentation
- [LEA: An R Package for Landscape and Ecological Association Studies](./references/LEA.md)
---
name: r-nam
description: This tool performs association mapping and genomic prediction in nested association mapping panels and multi-population structured datasets. Use when user asks to perform marker quality control, conduct multi-family genome-wide association studies, implement whole genome regression for genomic selection, or estimate variance components using REML or Bayesian methods.
homepage: https://cran.r-project.org/web/packages/nam/index.html
---


# r-nam

name: r-nam
description: Specialized for Nested Association Mapping (NAM) and multi-population genome-wide association studies (GWAS). Use this skill when performing marker quality control, association mapping in structured populations, genomic prediction (Whole Genome Regression), or estimating variance components using Bayesian or Likelihood methods in R.

## Overview
The `NAM` package provides tools for association studies in nested association mapping panels, experimental populations, and random panels. It is optimized for handling multiple populations simultaneously, allowing for the identification of quantitative trait loci (QTL) while accounting for population structure. Key capabilities include marker quality control, population genetics analysis, and solving mixed models via REML or Bayesian Gibbs sampling.

## Installation
To install the package from CRAN:
```R
install.packages("NAM")
library(NAM)
```

## Core Workflows

### 1. Marker Quality Control and Pre-processing
Before analysis, use `snpQC` to filter markers and `markov` to impute missing genotypes.
- **snpQC**: Filters by Minor Allele Frequency (MAF) and missing data.
- **markov**: Fast imputation for NAM populations.

```R
# Example QC
# gen: genotype matrix, fam: vector indicating family/population
clean_gen = snpQC(gen=my_genotypes, m_rate=0.1, maf=0.05)
# Imputation
imputed_gen = markov(clean_gen, res=2)
```

### 2. Genome-Wide Association Studies (GWAS)
The `gwas2` function is the primary tool for multi-family association mapping. It supports various models including the "random effect" model and "fixed effect" model for markers.

```R
# Multi-family GWAS
# y: phenotype, gen: genotypes, fam: family ID
fit = gwas2(y=pheno, gen=imputed_gen, fam=family_vec)
# Plot results
plot(fit)
```

### 3. Genomic Prediction (Whole Genome Regression)
The `wgr` function implements various Bayesian regressions (BayesA, BayesB, BayesC, BLASSO, etc.) for genomic selection.

```R
# Genomic prediction using BayesB
# it: iterations, bi: burn-in
pred = wgr(y=pheno, gen=imputed_gen, it=1500, bi=500, iv=FALSE)
# Access estimated marker effects
marker_effects = pred$b
```

### 4. Mixed Models and Variance Components
Use `reml` for Restricted Maximum Likelihood or `gibbs` for Bayesian estimation of variance components.

```R
# Solving a mixed model via REML
# K: Kinship matrix
model = reml(y=pheno, K=kinship_matrix)
print(model$VC) # Variance components
```

## Tips for Success
- **Population Structure**: Always provide the `fam` argument in `gwas2` to account for the nested structure of NAM populations.
- **Memory Management**: For very large datasets, ensure genotypes are stored as matrices and consider using the `bWGR` package if `wgr` performance is a bottleneck.
- **Kinship**: Use the `kin` function to generate additive or dominance relationship matrices from SNP data.

## Reference documentation
- [NAM Home Page](./references/home_page.md)
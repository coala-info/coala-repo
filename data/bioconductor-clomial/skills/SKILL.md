---
name: bioconductor-clomial
description: Clomial infers the clonal structure of a cancer by performing clonal decomposition on allele counts from multiple tumor samples using a binomial distribution model. Use when user asks to infer clonal composition, perform clonal deconvolution of NGS data, or estimate clonal genotypes and frequencies across multiple tumor samples.
homepage: https://bioconductor.org/packages/release/bioc/html/Clomial.html
---


# bioconductor-clomial

name: bioconductor-clomial
description: Infer the clonal structure of a cancer using multiple tumor samples with the Clomial R package. Use this skill when you need to perform clonal decomposition of next-generation sequencing (NGS) data by modeling alternative allele counts with binomial distributions. It is specifically designed for datasets with multiple sub-sections or samples from the same tumor to increase statistical power.

# bioconductor-clomial

## Overview

Clomial is a statistical framework for deconvolving the clonal composition of a tumor using allele counts from multiple samples. It uses an Expectation-Maximization (EM) algorithm to estimate two primary components:
1. **Mu ($\mu$):** The genotypes of the inferred clones (genomic loci by clones).
2. **P:** The relative frequencies of these clones across different samples (clones by samples).

The package is particularly effective when multiple spatial or temporal samples are available, allowing for a more robust inference of clonal evolution.

## Core Workflow

### 1. Data Preparation
Clomial requires two matrices as input:
- `Dt`: Counts of the alternative (mutant) allele.
- `Dc`: Total number of processed reads (depth) at each locus.

Rows must represent genomic loci, and columns must represent the different tumor samples.

```r
library(Clomial)
# Example using built-in breast cancer data
data(breastCancer)
Dc <- breastCancer$Dc
Dt <- breastCancer$Dt
```

### 2. Running the EM Algorithm
The `Clomial()` function performs the inference. Because the EM algorithm can get stuck in local optima, it is standard practice to run multiple trials with different initializations.

```r
# C: Assumed number of clones
# binomTryNum: Number of different initializations to attempt
# maxIt: Maximum iterations for the EM procedure
result <- Clomial(Dc=Dc, Dt=Dt, C=4, binomTryNum=5, maxIt=20)
```

### 3. Selecting the Best Model
After running multiple trials, use `choose.best()` to identify the model with the highest likelihood.

```r
# Extract the models list
models <- result$models
# Select the best one
best_fit <- choose.best(models=models, doTalk=TRUE)
best_model <- best_fit$bestModel
```

### 4. Interpreting Results
The results are stored in the `Mu` and `P` matrices of the chosen model.

```r
# Clonal Genotypes (0 or 1)
genotypes <- round(best_model$Mu)

# Clonal Frequencies (proportions per sample)
frequencies <- round(best_model$P, digits=2)
```

## Advanced Usage

### Estimating the Number of Clones
To determine the optimal number of clones ($C$), you should run Clomial across a range of values (e.g., $C=2$ to $C=6$) and compare them using the Bayesian Information Criterion (BIC).

```r
# Compute BIC for a specific model
# n: number of data points (usually loci * samples)
bic_value <- compute.bic(Dc=Dc, Dt=Dt, model=best_model)
```

### Practical Tips
- **Initialization:** In real-world applications, `binomTryNum` should be set significantly higher (e.g., 100 to 1000) to ensure the global optimum is found.
- **Data Filtering:** Before running Clomial, ensure that the input loci are high-confidence somatic mutations.
- **Convergence:** If the models are not converging, increase `maxIt`.

## Reference documentation

- [Clonal decomposition by Clomial](./references/Clonal_decomposition_by_Clomial.md)
---
name: bioconductor-ggpa
description: bioconductor-ggpa performs joint analysis of multiple GWAS datasets using a hidden Markov random field to investigate pleiotropy and prioritize genetic associations. Use when user asks to estimate pleiotropic architecture, perform association mapping across multiple phenotypes, or visualize phenotype graphs from GWAS p-value matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/GGPA.html
---

# bioconductor-ggpa

name: bioconductor-ggpa
description: Joint analysis of multiple GWAS datasets using a hidden Markov random field (graph-GPA). Use this skill to estimate pleiotropic architecture, perform association mapping across multiple phenotypes, and visualize phenotype graphs from GWAS p-value matrices.

# bioconductor-ggpa

## Overview

The `GGPA` package implements the graph-GPA framework, a graphical model designed to prioritize GWAS results and investigate the shared genetic architecture (pleiotropy) among multiple traits. It uses a hidden Markov random field (MRF) to model the relationship between phenotypes, allowing for the incorporation of prior knowledge about disease relationships.

## Workflow

### 1. Data Preparation
The primary input is a matrix of p-values where rows represent SNPs and columns represent different phenotypes/GWAS studies.

```R
library(GGPA)
data(simulation)

# Input should be a matrix of p-values
pmat <- simulation$pmat
head(pmat)
```

### 2. Model Fitting
Fit the graph-GPA model using the `GGPA` function. By default, it assumes an uninformative prior.

```R
# Fit the model
# Note: In real applications, use more iterations (e.g., burnin=10000, main=40000)
fit <- GGPA(pmat, steps=200, burnin=200)

# View summary (mu, sigma, and proportion of associated SNPs)
fit
```

### 3. Association Mapping
Identify SNPs associated with phenotypes using either global or local FDR control.

```R
# Global FDR control at 0.10
assoc.marg <- assoc(fit, FDR=0.10, fdrControl="global")

# Joint association: SNPs associated with both phenotype 1 and 2
assoc.joint <- assoc(fit, FDR=0.10, fdrControl="global", i=1, j=2)

# Get local FDR values
fdr.matrix <- fdr(fit)
```

### 4. Visualizing Phenotype Graphs
Visualize the estimated genetic relationship between phenotypes.

```R
# Plot the estimated phenotype graph
plot(fit)

# Extract parameter estimates (beta, mu, sigma, etc.)
est <- estimates(fit)
```

### 5. Incorporating Prior Knowledge
If you have a prior disease graph (e.g., from literature mining or the DDNet web tool), provide it as an adjacency matrix.

```R
# pgraph must be an adjacency matrix matching the columns of pmat
# fit <- GGPA(pmat, pgraph)
```

## Tips and Best Practices
- **Iterations**: For publication-quality results, use a high number of MCMC iterations (e.g., 10,000 burn-in and 40,000 main iterations).
- **FDR Control**: Use `fdrControl="global"` for general SNP discovery and `"local"` for more conservative, site-specific inference.
- **Prior Graphs**: Ensure the column names of your p-value matrix match the row/column names of your prior adjacency matrix.

## Reference documentation
- [Genetic Analysis and Investigating Pleiotropic Architecture with GGPA](./references/GGPA-example.md)
---
name: bioconductor-bags
description: This tool identifies differentially expressed gene sets across phenotypes or time points using a Bayesian Gibbs sampler. Use when user asks to identify differentially expressed gene sets, perform Bayesian gene set enrichment analysis, or analyze gene expression across multiple phenotypes or time points.
homepage: https://bioconductor.org/packages/release/bioc/html/BAGS.html
---

# bioconductor-bags

name: bioconductor-bags
description: Bayesian Approach for Geneset Selection (BAGS). Use this skill to identify gene functional classes (gene sets) that are differentially expressed between phenotypes (2 to 5 groups) or across time points (2 to 5 time points) using a Gibbs sampler.

## Overview

The `BAGS` package implements a Bayesian hierarchical model to identify significant gene sets (e.g., GO terms, pathways) in cross-sectional or time-series gene expression data. It treats genes within a set as repeated measures, providing a robust statistical framework for gene set enrichment analysis.

## Workflow

### 1. Data Preprocessing
The input data must be a gene expression matrix where rows are gene symbols and columns are samples. If multiple probes map to the same gene, it is recommended to select the one with the highest variability across phenotypes.

```r
library(BAGS)
# gene.expr: matrix with gene symbols as rownames
# gene.nams: vector of unique gene symbols
# phntp.list: list where each element contains indices of samples for a specific phenotype
# Example: phntp.list = list(group1_indices, group2_indices)
```

### 2. Preparing Gene Sets
Load functional annotations (e.g., GO Molecular Function) and filter for sets meeting a minimum size threshold (e.g., 5 genes).

```r
data(AnnotationMFGO, package="BAGS")
# Filter gene sets to include only those with at least 5 genes present in your data
data.gene.grps <- DataGeneSets(AnnotationMFGO, gene.nams, 5)
```

### 3. Creating the MCMC Data Set
Transform the expression data into the format required by the Gibbs sampler.

```r
data.mcmc <- MCMCDataSet(gene.expr, data.gene.grps$DataGeneSetsIds, phntp.list)
```

### 4. Executing the Gibbs Sampler
The `Gibbs2` function performs the MCMC sampling. You must define prior parameters and the number of iterations.

```r
noRow <- dim(data.mcmc$y.mu)[1]
noCol <- unlist(lapply(phntp.list, length))
iter <- 10000
GrpSzs <- data.gene.grps$Size
YMu <- data.mcmc$y.mu

# Prior parameters (standard defaults)
L0 <- rep(2, 2); V0 <- rep(4, 2)
L0A <- rep(3, 1); V0A <- rep(3, 1)
MM <- 0.55; AAPi <- 10
ApriDiffExp <- floor(noRow * 0.03)
results <- matrix(0, noRow, iter)

# Run Sampler
mcmc.chains <- Gibbs2(noRow, noCol, iter, GrpSzs, YMu, L0, V0, L0A, V0A, MM, AAPi, ApriDiffExp, results)
```

### 5. Interpreting Results
Calculate the posterior probability of differential expression for each gene set after discarding a burn-in period.

```r
burn.in <- 2000
# Calculate probabilities
alfa.pi <- apply(mcmc.chains[[1]][, burn.in:iter], 1, function(x) {
  length(which(x != 0)) / length(burn.in:iter)
})

# Identify significant processes (e.g., probability > 0.9)
significant.sets <- names(data.gene.grps$Size)[which(alfa.pi > 0.9)]

# Visualize
plot(alfa.pi, type="h", main="Probabilities of Gene Sets Differentially Expressed")
abline(h=0.9, col="red")
```

## Key Functions
- `DataGeneSets()`: Filters and organizes gene sets based on available genes in the expression matrix.
- `MCMCDataSet()`: Prepares the data structure for Bayesian analysis.
- `Gibbs2()`: The core function for cross-sectional designs (2-5 phenotypes).
- `GibbsTS()`: Used for time-series designs.

## Reference documentation
- [BAGS](./references/BAGS.md)
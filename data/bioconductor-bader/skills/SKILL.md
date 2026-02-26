---
name: bioconductor-bader
description: bioconductor-bader performs differential expression analysis on RNA-seq count data using a Bayesian hierarchical model to estimate posterior distributions of fold changes. Use when user asks to perform Bayesian differential expression analysis, estimate posterior probabilities of differential expression, or quantify uncertainty in RNA-seq log fold changes.
homepage: https://bioconductor.org/packages/release/bioc/html/BADER.html
---


# bioconductor-bader

name: bioconductor-bader
description: Bayesian Analysis of Differential Expression in RNA Sequencing Data. Use this skill to perform differential expression analysis on RNA-seq count tables using a fully Bayesian approach to quantify uncertainty in parameter estimation, log fold changes, and posterior probabilities of differential expression.

## Overview

The `BADER` package provides a Bayesian framework for analyzing RNA-seq count data. Unlike frequentist methods that provide point estimates, `BADER` uses a two-stage hierarchical model (Poisson-Log-Normal) to estimate the posterior distributions of log means, log dispersion, and log fold changes. This is particularly useful for small sample sizes where uncertainty quantification is critical.

## Core Workflow

### 1. Data Preparation
The input must be a count matrix (genes as rows, samples as columns) and a factor defining the experimental design (two groups, typically "A" and "B").

```r
library(BADER)

# Example: count_matrix is a matrix of integers
# design is a factor with two levels
design <- factor(c("A", "A", "B", "B"))
```

### 2. Running the MCMC Sampler
The primary function is `BADER()`. It requires specifying the number of burn-in iterations and the number of posterior samples to keep.

```r
# Basic execution
results <- BADER(count_matrix, design, burn = 1000, reps = 2000)
```

### 3. Output Modes
The `mode` parameter determines the richness of the returned data:
- `minimal`: Returns posterior means of logMeanA, logMeanB, logFoldChange, logDispA, logDispB, and diffProb (default).
- `full`: Adds `logFoldChangeDist`, containing the full posterior distribution of the log fold change for every gene.
- `extended`: Adds full posterior distributions for all parameters.

### 4. Interpreting Results
The results object is a list. The most common metric for ranking genes is `diffProb`, the posterior probability that a gene is differentially expressed.

```r
# Get top 10 differentially expressed genes
top_genes <- rownames(count_matrix)[order(results$diffProb, decreasing = TRUE)[1:10]]

# Access posterior mean of log fold change
lfc <- results$logFoldChange
```

## Advanced Analysis

### Uncertainty Visualization
If `mode="full"` is used, you can plot the posterior distribution of the log fold change to visualize uncertainty for specific genes.

```r
# Histogram of posterior log fold change for gene 1
hist(results$logFoldChangeDist[,1], breaks = 50, main = "Posterior LFC")
```

### Gene Set Enrichment
You can perform competitive null hypothesis testing on gene sets by applying logic across the posterior samples.

```r
# Example: Test if set S is more likely to be DE than the rest of the genome
S <- c(1, 2, 3, 10, 11) # Indices of genes in set
f <- function(sample, set) mean(sample[set] != 0) > mean(sample[-set] != 0)
enrichment_prob <- mean(apply(results$logFoldChangeDist, 1, f, set = S))
```

## Tips and Best Practices
- **Convergence**: For publication-quality results, increase `burn` and `reps` (e.g., 10,000 or more). Monitor convergence by checking if results are stable across different seeds.
- **Filtering**: Remove genes with zero counts across all samples before running `BADER` to improve computational efficiency.
- **Memory**: Using `mode="extended"` on large datasets (many genes) can consume significant RAM as it stores thousands of MCMC samples for every parameter.

## Reference documentation
- [BADER](./references/BADER.md)